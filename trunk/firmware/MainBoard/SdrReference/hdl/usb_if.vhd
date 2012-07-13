-- USB_IF.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.0
-- TARGET DEVICE: A2F500M3G (256 FBGA)
--   
-- Copyright (c) 2006-2012, Vanderbilt University
-- All rights reserved.
--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose, without fee, and without written agreement is
-- hereby granted, provided that the above copyright notice, the following
-- two paragraphs and the author appear in all copies of this software.
--
-- IN NO EVENT SHALL THE VANDERBILT UNIVERSITY BE LIABLE TO ANY PARTY FOR
-- DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
-- OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE VANDERBILT
-- UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-- THE VANDERBILT UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
-- INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
-- AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
-- ON AN "AS IS" BASIS, AND THE VANDERBILT UNIVERSITY HAS NO OBLIGATION TO
-- PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
------------------------------------------------------------------------------
--
-- Description: Interface module for the FT232H USB (FTDI) chip operating in
--              synchronous FIFO mode.
--
--              The module transmits 16-bit data to the FTDI chip on 2
--              channels.
--
-- Note: All state machines run in the USB clock domain to simplify the
--       interface in the other side. The trade-off is the larger number of
--       FIFOs used.
--
-- TODO:
--  - Add a control channel
--  - Add a flush mechanism to the TX FIFO SM
--  - Make FIFO AFULL, AEMPTY accessible from this module (might work easily,
--    but had issues with simulations)
--
--  - Add logic to sense USB (FTDI) chip presence
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library smartfusion;
use smartfusion.all;

entity USB_IF is
    generic (
         g_NUMBER_OF_CHANNELS : integer := 2;
         g_FRAME_LENGTH : integer := 16
    );
    port (
        -- Internal interface
        CLK         : in  std_logic;
        RST         : in  std_logic;

        TX_STROBE   : in  std_logic;
        TXD_I       : in  std_logic_vector(15 downto 0);
        TXD_Q       : in  std_logic_vector(15 downto 0);
        RX_STROBE   : out std_logic;
        RXD         : out std_logic_vector(7 downto 0);

        -- USB (FTDI) interface
        USB_CLK_pin : in std_logic;

        DATA_pin    : inout std_logic_vector(7 downto 0);
        OE_n_pin    : out std_logic;
        RD_n_pin    : out std_logic;
        WR_n_pin    : out std_logic;

        RXF_n_pin   : in  std_logic;
        TXE_n_pin   : in  std_logic;

        SIWU_n_pin  : out std_logic;
        ACBUS8_pin  : in  std_logic;
        ACBUS9_pin  : in  std_logic
    );
end entity;


architecture Behavioral of USB_IF is

    -- Components

    component CLKBUF
        port( PAD : in    std_logic := 'U';
              Y   : out   std_logic
          );
    end component;

    component BIBUF_LVCMOS33
        port( PAD : inout   std_logic;
              D   : in    std_logic := 'U';
              E   : in    std_logic := 'U';
              Y   : out   std_logic
          );
    end component;

    component FIFO_512x8 is
    port (
        DATA    : in  std_logic_vector(7 downto 0);
        Q       : out std_logic_vector(7 downto 0);
        WE      : in  std_logic;
        RE      : in  std_logic;
        WCLOCK  : in  std_logic;
        RCLOCK  : in  std_logic;
        FULL    : out std_logic;
        EMPTY   : out std_logic;
        RESET   : in  std_logic
    );
    end component;

    component FIFO_256x16 is
    port (
        DATA    : in  std_logic_vector(15 downto 0);
        Q       : out std_logic_vector(15 downto 0);
        WE      : in  std_logic;
        RE      : in  std_logic;
        WCLOCK  : in  std_logic;
        RCLOCK  : in  std_logic;
        FULL    : out std_logic;
        EMPTY   : out std_logic;
        AFULL   : out std_logic;
        AEMPTY  : out std_logic;
        RESET   : in  std_logic
    );
    end component;

    -- Constants

    -- Frame fields
    constant c_SOF : std_logic_vector(31 downto 0) := x"DEADBEEF";

    constant c_FRAME_LENGTH : std_logic_vector(11 downto 0) :=
        std_logic_vector(to_unsigned(g_FRAME_LENGTH, 12));

    -- Signals

    type tx_sm_t is (
        st_IDLE,
        st_SOF_1,
        st_SOF_2,
        st_SOF_3,
        st_SOF_4,
        st_SEQ_MSB,
        st_SEQ_LSB,
        st_DATA_I_MSB,
        st_DATA_I_LSB,
        st_DATA_Q_MSB,
        st_DATA_Q_LSB
    );

    signal s_tx_sm_state : tx_sm_t;
    signal s_tx_sm_state_next : tx_sm_t;

    alias sys_clk is clk;
    signal usb_clk  : std_logic;
    
    signal s_seq_num_ctr : unsigned(15 downto 0);
    signal s_seq_fifo_out : std_logic_vector(15 downto 0);

    signal s_oe     : std_logic;
    signal s_obuf   : std_logic_vector(7 downto 0);
    signal s_ibuf   : std_logic_vector(7 downto 0);

    signal s_wr_n : std_logic;
    signal s_tx_fifo_re : std_logic;
    signal s_tx_fifo_re_next : std_logic;
    signal s_tx_fifo_we : std_logic;
    signal s_tx_i_fifo_full : std_logic;
    signal s_tx_i_fifo_empty : std_logic;
    signal s_tx_i_fifo_afull : std_logic;
    signal s_tx_i_fifo_aempty : std_logic;
    signal s_tx_i_fifo_out : std_logic_vector(15 downto 0);
    signal s_tx_q_fifo_out : std_logic_vector(15 downto 0);

    signal s_tx_sample_ctr : unsigned(15 downto 0);
    signal s_tx_sample_ctr_next : unsigned(15 downto 0);

    signal s_rx_fifo_we : std_logic;
    signal s_rx_strobe  : std_logic;

begin

    assert 1 <= g_NUMBER_OF_CHANNELS and g_NUMBER_OF_CHANNELS <= 4
    report "Number of channels must be between 1 and 4."
    severity failure;

    -- Port maps

    u_USB_CLKBUF : CLKBUF
      port map(PAD => USB_CLK_pin, Y => usb_clk);


    g_USB_SYNC_FIFO_DATA : for i in 0 to 7 generate

        u_BIBUF_LVCMOS33 : BIBUF_LVCMOS33
        port map (
            PAD => DATA_pin(i),
            D   => s_obuf(i),
            E   => s_oe,
            Y   => s_ibuf(i)
        );

    end generate g_USB_SYNC_FIFO_DATA;

        
    -- NOTE: Port mapping and testing of this FIFO is not finished.
    u_RX_FIFO : FIFO_512x8
    port map (
        RESET   => RST,
        DATA    => s_ibuf,
        Q       => RXD,
        WCLOCK  => usb_clk,
        WE      => s_rx_fifo_we,
        RCLOCK  => CLK,
        RE      => s_rx_strobe,
        FULL    => open,
        EMPTY   => RX_STROBE
    );

    s_rx_fifo_we <= '0'; -- FIXME
    s_rx_strobe <= '0'; -- FIXME


    u_SEQ_FIFO : FIFO_256x16
    port map (
        RESET   => RST,
        DATA    => std_logic_vector(s_seq_num_ctr),
        Q       => s_seq_fifo_out,
        WCLOCK  => CLK,
        WE      => s_tx_fifo_we,
        RCLOCK  => usb_clk,
        RE      => s_tx_fifo_re,
        FULL    => open,
        EMPTY   => open,
        AFULL   => open,
        AEMPTY  => open
    );

    u_TX_I_FIFO : FIFO_256x16
    port map (
        RESET   => RST,
        DATA    => TXD_I,
        Q       => s_tx_i_fifo_out,
        WCLOCK  => CLK,
        WE      => s_tx_fifo_we,
        RCLOCK  => usb_clk,
        RE      => s_tx_fifo_re,
        FULL    => s_tx_i_fifo_full,
        EMPTY   => s_tx_i_fifo_empty,
        AFULL   => s_tx_i_fifo_afull,
        AEMPTY  => s_tx_i_fifo_aempty
    );

    u_TX_Q_FIFO : FIFO_256x16
    port map (
        RESET   => RST,
        DATA    => TXD_Q,
        Q       => s_tx_q_fifo_out,
        WCLOCK  => CLK,
        WE      => s_tx_fifo_we,
        RCLOCK  => usb_clk,
        RE      => s_tx_fifo_re,
        FULL    => open,
        EMPTY   => open,
        AFULL   => open,
        AEMPTY  => open
    );


    -- Processes

    -----------------------------------
    -- Sequence number generator     --
    -----------------------------------
    p_seq_num_gen : process (rst, clk)
    begin
        if rst = '1' then
            s_seq_num_ctr <= (others => '0');
        elsif rising_edge(clk) then
            if TX_STROBE = '1' then
                s_seq_num_ctr <= s_seq_num_ctr + 1;
            end if;
        end if;
    end process p_seq_num_gen;


    -----------------------------------
    -- TX FIFO write                 --
    -----------------------------------
    s_tx_fifo_we <= TX_STROBE and not (s_tx_i_fifo_full); -- FIXME: could useSEQ FIFO instead


    -----------------------------------
    -- TX FIFO read and USB transmit --
    -----------------------------------
    p_tx_fifo_read_sm_sync : process (rst, usb_clk)
    begin
        if rst = '1' then
            s_tx_sm_state <= st_IDLE;
            s_tx_sample_ctr <= (others => '0');
            s_tx_fifo_re <= '0';
        elsif rising_edge(usb_clk) then
            s_tx_sm_state <= s_tx_sm_state_next;
            s_tx_sample_ctr <= s_tx_sample_ctr_next;
            s_tx_fifo_re <= s_tx_fifo_re_next;
        end if;
    end process p_tx_fifo_read_sm_sync;

    p_tx_fifo_read_sm_comb : process (
        s_tx_sm_state,
        s_tx_sample_ctr,
        s_tx_i_fifo_out,
        s_tx_q_fifo_out,
        s_seq_fifo_out,
        TXE_n_pin,
        s_tx_i_fifo_aempty
    )
    begin
       -- Default states
        s_tx_sm_state_next <= s_tx_sm_state;
        s_tx_sample_ctr_next <= s_tx_sample_ctr;
        s_tx_fifo_re_next <= '0';

        s_wr_n <= '1';
        s_oe <= '0';

        s_obuf <= (others => '0');

        -- Next state logic
        case s_tx_sm_state is

            -- Wait for the FIFO to have at least one frame of data
            when st_IDLE => 

                s_tx_sample_ctr_next <= (others => '0');

                if TXE_n_pin = '0' and s_tx_i_fifo_aempty = '0' then
                    s_tx_sm_state_next <= st_SOF_1;
                end if;
                
            -- Transmit SOF
            when st_SOF_1 => 

                s_tx_fifo_re_next <= '1';
                s_obuf <= c_SOF(31 downto 24);

                if TXE_n_pin = '0' then
                    s_wr_n <= '0';
                    s_oe <= '1';
                    s_tx_sm_state_next <= st_SOF_2;
                end if;

            when st_SOF_2 => 

                s_obuf <= c_SOF(23 downto 16);

                if TXE_n_pin = '0' then
                    s_wr_n <= '0';
                    s_oe <= '1';
                    s_tx_sm_state_next <= st_SOF_3;
                end if;

            when st_SOF_3 => 

                s_obuf <= c_SOF(15 downto 8);

                if TXE_n_pin = '0' then
                    s_wr_n <= '0';
                    s_oe <= '1';
                    s_tx_sm_state_next <= st_SOF_4;
                end if;

            when st_SOF_4 => 

                s_tx_sample_ctr_next <= s_tx_sample_ctr + 1;
                s_obuf <= c_SOF(7 downto 0);

                if TXE_n_pin = '0' then
                    s_wr_n <= '0';
                    s_oe <= '1';
                    s_tx_sm_state_next <= st_SEQ_LSB;
                end if;

            when st_SEQ_LSB => 

                s_obuf <= s_seq_fifo_out(7 downto 0);

                if TXE_n_pin = '0' then
                    s_wr_n <= '0';
                    s_oe <= '1';
                    s_tx_sm_state_next <= st_SEQ_MSB;
                end if;

            when st_SEQ_MSB => 

                s_obuf <= s_seq_fifo_out(15 downto 8);

                if TXE_n_pin = '0' then
                    s_wr_n <= '0';
                    s_oe <= '1';
                    s_tx_sm_state_next <= st_DATA_I_LSB;
                end if;

            when st_DATA_I_LSB => 

                s_obuf <= s_tx_i_fifo_out(7 downto 0);

                if TXE_n_pin = '0' then
                    s_wr_n <= '0';
                    s_oe <= '1';
                    s_tx_sm_state_next <= st_DATA_I_MSB;
                end if;

            when st_DATA_I_MSB => 

                s_obuf <= s_tx_i_fifo_out(15 downto 8);

                if TXE_n_pin = '0' then
                    s_wr_n <= '0';
                    s_oe <= '1';
                    s_tx_sm_state_next <= st_DATA_Q_LSB;

                    -- Fetch new value
                    if s_tx_sample_ctr /= unsigned(c_FRAME_LENGTH) then
                        s_tx_fifo_re_next <= '1';
                    end if;
                end if;

            when st_DATA_Q_LSB => 

                s_obuf <= s_tx_q_fifo_out(7 downto 0);

                if TXE_n_pin = '0' then
                    s_wr_n <= '0';
                    s_oe <= '1';
                    s_tx_sm_state_next <= st_DATA_Q_MSB;
                end if;

            when st_DATA_Q_MSB => 

                s_obuf <= s_tx_q_fifo_out(15 downto 8);

                if TXE_n_pin = '0' then
                    s_wr_n <= '0';
                    s_oe <= '1';
                    if s_tx_sample_ctr = unsigned(c_FRAME_LENGTH) then
                        s_tx_sample_ctr_next <= (others => '0');
                        s_tx_sm_state_next <= st_IDLE;
                    else
                        s_tx_sample_ctr_next <= s_tx_sample_ctr + 1;
                        s_tx_sm_state_next <= st_DATA_I_LSB;
                    end if;
                end if;

            when others => 
                null;

        end case;

    end process p_tx_fifo_read_sm_comb;


    -------------------------------------
    -- 8-bit single channel no framing --
    -------------------------------------
--    p_tx_fifo_read : process (rst, usb_clk)
--    begin
--        if rst = '1' then
--            s_wr_n <= '1';
--            s_oe <= '0';
--        elsif rising_edge(usb_clk) then
--            s_oe <= '0';
--            s_wr_n <= '1';
--            if TXE_n_pin = '0' and s_tx_i_fifo_empty = '0' then
--                s_oe <= '1';
--                s_wr_n <= '0';
--            end if;
--        end if;
--    end process p_tx_fifo_read;
--
--    s_tx_fifo_re <= '1' when TXE_n_pin = '0' and s_tx_i_fifo_empty = '0' else '0';
    -------------------------------------


    -- Output assignments

    OE_n_pin <= '1';
    RD_n_pin <= '1'; -- FIXME
    WR_n_pin <= s_wr_n;

    SIWU_n_pin <= '1'; -- Send only full packets

    RX_STROBE <= s_rx_strobe;


end Behavioral;
