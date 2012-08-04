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
-------------------------------------------------------------------------------
-- Revisions     :
-- Date            Version  Author			Description
-- 2012-07-17      1.1      Sandor Szilvasi	Added support for streaming two
--                                          16-bit channels with framing
-- 2012-xx-xx      1.0      Sandor Szilvasi	Created
-------------------------------------------------------------------------------
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
-- Known issues: The post place-and-route timing has not been checked
--               properly yet. There may be timing issues on the USB
--               interface.
--
-- TODO:
--  - Add a control channel
--  - Add a flush mechanism to the TX FIFO SM
--  - Make FIFO AFULL, AEMPTY parameters accessible from this module
--    (might work easily, but had issues with simulations)
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
        RESET   : in  std_logic;
        AFULL   : out std_logic;
        AEMPTY  : out std_logic
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
    constant c_SOF : std_logic_vector(15 downto 0) := x"BEEF";

    constant c_FRAME_LENGTH : std_logic_vector(11 downto 0) :=
        std_logic_vector(to_unsigned(g_FRAME_LENGTH, 12));

    -- Signals


    -- Arbiter SM
    type arb_sm_t is (
        st_ARB_IDLE,
        st_ARB_RX,
        st_ARB_TX_CTRL,
        st_ARB_TX_DATA
    );

    signal s_arbiter_sm_state : arb_sm_t;
    signal s_arbiter_sm_state_next : arb_sm_t;
    signal s_rx_sm_start : std_logic;
    signal s_rx_sm_start_next : std_logic;
    signal s_tx_ctrl_sm_start : std_logic;
    signal s_tx_ctrl_sm_start_next : std_logic;
    signal s_tx_data_sm_start : std_logic;
    signal s_tx_data_sm_start_next : std_logic;

    signal s_rx_sm_done : std_logic;
    signal s_tx_ctrl_sm_done : std_logic;
    signal s_tx_data_sm_done : std_logic;

    signal s_ctrl_data : std_logic_vector(7 downto 0);
    signal s_tx_ctrl_fifo_out : std_logic_vector(7 downto 0);
    signal s_tx_ctrl_fifo_we : std_logic;
    signal s_tx_ctrl_fifo_rd : std_logic;
    signal s_tx_ctrl_fifo_aempty : std_logic;
    signal s_tx_ctrl_fifo_afull : std_logic;

    signal s_rx_ctrl_fifo_we : std_logic;
    signal s_rx_ctrl_fifo_rd : std_logic;
    signal s_rx_ctrl_fifo_empty : std_logic;
    signal s_rx_ctrl_fifo_afull : std_logic;

    type tx_sm_t is (
        st_IDLE,
        st_SOF_1,
        st_SOF_2,
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
    signal s_obuf_next   : std_logic_vector(7 downto 0);
    signal s_ibuf   : std_logic_vector(7 downto 0);

    signal s_txe_n  : std_logic;
    signal s_fifo_fetched : std_logic;
    signal s_fifo_fetched_next : std_logic;
    signal s_last_sample   : std_logic;
    signal s_last_sample_next   : std_logic;

    signal s_wr_n : std_logic;
    signal s_tx_i_fifo_re : std_logic;
    signal s_tx_i_fifo_re_next : std_logic;
    signal s_tx_q_fifo_re : std_logic;
    signal s_tx_q_fifo_re_next : std_logic;
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

        
    -- Control FIFOs
    u_TX_CTRL_FIFO : FIFO_512x8
    port map (
        RESET   => RST,
        DATA    => s_ctrl_data, -- FIXME: loopback for testing only
        Q       => s_tx_ctrl_fifo_out,
        WCLOCK  => usb_clk,
        WE      => s_tx_ctrl_fifo_we,
        RCLOCK  => CLK,
        RE      => s_tx_ctrl_fifo_rd,
        FULL    => open,
        EMPTY  => open,
        AFULL   => s_tx_ctrl_fifo_afull,
        AEMPTY  => s_tx_ctrl_fifo_aempty
    );

    u_RX_CTRL_FIFO : FIFO_512x8
    port map (
        RESET   => RST,
        DATA    => s_ibuf,
        Q       => s_ctrl_data, -- FIXME: loopback for testing only
        WCLOCK  => usb_clk,
        WE      => s_rx_ctrl_fifo_we,
        RCLOCK  => CLK,
        RE      => s_rx_ctrl_fifo_rd,
        FULL    => open,
        EMPTY   => s_rx_ctrl_fifo_empty,
        AFULL   => s_rx_ctrl_fifo_afull,
        AEMPTY  => open
    );

    -- NOTE: Port mapping and testing of this FIFO is not finished.
--    u_RX_I_FIFO : FIFO_512x8
--    port map (
--        RESET   => RST,
--        DATA    => s_ibuf,
--        Q       => RXD,
--        WCLOCK  => usb_clk,
--        WE      => s_rx_fifo_we,
--        RCLOCK  => CLK,
--        RE      => s_rx_strobe,
--        FULL    => open,
--        EMPTY   => RX_STROBE,
--        AFULL   => open,
--        AEMPTY  => open
--    );

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
        RE      => s_tx_i_fifo_re,
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
        RE      => s_tx_i_fifo_re,
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
        RE      => s_tx_q_fifo_re,
        FULL    => open,
        EMPTY   => open,
        AFULL   => open,
        AEMPTY  => open
    );


    -----------------------------------
    -- TX FIFO write                 --
    -----------------------------------
    s_tx_fifo_we <= TX_STROBE and not (s_tx_i_fifo_full); -- FIXME: should use SEQ FIFO instead


    -- Processes

    ----------------------------------------------------
    -- Arbiter state machine                          --
    ----------------------------------------------------
    -- The arbiter handles access to the DATA_pin lines.
    --
    -- Priorities:
    --
    --  1. Control/Data RX
    --  2. Control TX
    --  3. Data TX
    --
    ----------------------------------------------------
    p_arbiter_sm_sync : process (rst, usb_clk)
    begin
        if rst = '1' then
            s_arbiter_sm_state <= st_ARB_IDLE;
            s_rx_sm_start <= '0';
            s_tx_ctrl_sm_start <= '0';
            s_tx_data_sm_start <= '0';
        elsif rising_edge(usb_clk) then
            s_arbiter_sm_state <= s_arbiter_sm_state_next;
            s_rx_sm_start <= s_rx_sm_start_next;
            s_tx_ctrl_sm_start <= s_tx_ctrl_sm_start_next;
            s_tx_data_sm_start <= s_tx_data_sm_start_next;
        end if;
    end process p_arbiter_sm_sync;

    p_arbiter_sm_comb : process (
        s_arbiter_sm_state,
        RXF_n_pin,
        s_tx_ctrl_fifo_aempty,
        s_rx_sm_done,
        s_tx_ctrl_sm_done,
        s_tx_data_sm_done
    )
    begin
        -- Default values
        s_arbiter_sm_state_next <= s_arbiter_sm_state;
        
        s_rx_sm_start_next <= '0';
        s_tx_ctrl_sm_start_next <= '0';
        s_tx_data_sm_start_next <= '0';

        -- Next state logic
        case s_arbiter_sm_state is

            when st_ARB_IDLE => 
                -- RX control/data
                if RXF_n_pin = '0' then
                    s_rx_sm_start_next <= '1';
                    s_arbiter_sm_state_next <= st_ARB_RX;
                -- TX
                elsif TXE_n_pin = '0' then
                    -- TX control
                    if s_tx_ctrl_fifo_aempty = '0' then
                        s_tx_ctrl_sm_start_next <= '1';
                        s_arbiter_sm_state_next <= st_ARB_TX_CTRL;
                    -- TX data
--                    elsif s_tx_data_fifo_aempty = '0' then
--                        s_tx_data_sm_start_next <= '1';
--                        s_arbiter_sm_state_next <= st_ARB_TX_DATA;
                    end if;
                end if;

            when st_ARB_RX => 
                if s_rx_sm_done = '1' then
                    s_arbiter_sm_state_next <= st_ARB_IDLE;
                end if;

            when st_ARB_TX_CTRL => 
                if s_tx_ctrl_sm_done = '1' then
                    s_arbiter_sm_state_next <= st_ARB_IDLE;
                end if;

            when st_ARB_TX_DATA => 
                if s_tx_data_sm_done = '1' then
                    s_arbiter_sm_state_next <= st_ARB_IDLE;
                end if;

            when others => 
                null;

        end case;
    end process p_arbiter_sm_comb;

    s_rx_sm_done <= '1';
    s_tx_ctrl_sm_done <= '1';
    s_tx_data_sm_done <= '1';


    -------------------------------------
    -- Control FIFO                    --
    -- To be extended to control TX data --
    -------------------------------------
--    p_ctrl_fifo_write : process (rst, usb_clk)
--    begin
--        if rst = '1' then
--        elsif rising_edge(usb_clk) then
----            s_oe <= '0';
--            OE_n_pin <= '1';
--            s_rd_n <= '1';
--            if RXF_n_pin = '0' and s_ctrl_fifo_full = '0' and s_rx_en then
----                s_oe <= '0';
--                OE_n_pin <= '0';
--                s_rd_n <= '0';
--            end if;
--        end if;
--    end process p_tx_fifo_read;
--
--    s_tx_fifo_re <= '1' when TXE_n_pin = '0' and s_tx_i_fifo_empty = '0' else '0';

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
    -- TX FIFO read and USB transmit --
    -----------------------------------
    p_tx_fifo_read_sm_sync : process (rst, usb_clk)
    begin
        if rst = '1' then
            s_tx_sm_state <= st_IDLE;
            s_tx_sample_ctr <= (others => '0');
            s_tx_i_fifo_re <= '0';
            s_tx_q_fifo_re <= '0';
            s_fifo_fetched <= '0';
            s_obuf <= (others => '0');
            s_last_sample <= '0';
            s_txe_n <= '1';
        elsif rising_edge(usb_clk) then
            s_tx_sm_state <= s_tx_sm_state_next;
            s_tx_sample_ctr <= s_tx_sample_ctr_next;
            s_tx_i_fifo_re <= s_tx_i_fifo_re_next;
            s_tx_q_fifo_re <= s_tx_q_fifo_re_next;
            s_fifo_fetched <= s_fifo_fetched_next;
            s_obuf <= s_obuf_next;
            s_last_sample <= s_last_sample_next;
            s_txe_n <= TXE_n_pin;
        end if;
    end process p_tx_fifo_read_sm_sync;

    p_tx_fifo_read_sm_comb : process (
        s_tx_sm_state,
        s_tx_sample_ctr,
        s_tx_i_fifo_out,
        s_tx_q_fifo_out,
        s_seq_fifo_out,
        s_obuf,
        s_txe_n,
        s_fifo_fetched,
        s_last_sample,
        s_tx_i_fifo_aempty
    )
    begin
       -- Default states
        s_tx_sm_state_next <= s_tx_sm_state;
        s_tx_sample_ctr_next <= s_tx_sample_ctr;
        s_tx_i_fifo_re_next <= '0';
        s_tx_q_fifo_re_next <= '0';
        s_fifo_fetched_next <= s_fifo_fetched;

        s_obuf_next <= s_obuf;
        s_last_sample_next <= s_last_sample;

        -- Next state logic
        case s_tx_sm_state is

            -- Wait for the FIFO to have at least one frame of data
            when st_IDLE => 

                s_tx_sample_ctr_next <= (others => '0');
                s_obuf_next <= c_SOF(15 downto 8);

                if s_tx_i_fifo_aempty = '0' then
                    s_tx_i_fifo_re_next <= '1';
                    s_tx_q_fifo_re_next <= '1';
                    s_fifo_fetched_next <= '1';
                    s_tx_sm_state_next <= st_SOF_1;
                    s_last_sample_next <= '0';
                end if;

            -- Transmit SOF
            when st_SOF_1 => 

                if s_txe_n = '0' then
                    s_obuf_next <= c_SOF(7 downto 0);
                    s_tx_sm_state_next <= st_SOF_2;
                end if;

            when st_SOF_2 => 

                s_tx_sample_ctr_next <= s_tx_sample_ctr + 1;

                if s_txe_n = '0' then
                    s_obuf_next <= s_seq_fifo_out(7 downto 0);
                    s_tx_sm_state_next <= st_SEQ_LSB;
                end if;

            when st_SEQ_LSB => 

                if s_txe_n = '0' then
                    s_obuf_next <= s_seq_fifo_out(15 downto 8);
                    s_tx_sm_state_next <= st_SEQ_MSB;
                end if;

            when st_SEQ_MSB => 

                if s_txe_n = '0' then
                    s_obuf_next <= s_tx_i_fifo_out(7 downto 0);
                    s_tx_sm_state_next <= st_DATA_I_LSB;
                end if;

            when st_DATA_I_LSB => 

                if s_txe_n = '0' then
                    -- Fetch new value
                    if s_tx_sample_ctr /= unsigned(c_FRAME_LENGTH) then
                        s_tx_i_fifo_re_next <= '1';
                    end if;

                    s_obuf_next <= s_tx_i_fifo_out(15 downto 8);
                    s_tx_sm_state_next <= st_DATA_I_MSB;
                end if;

            when st_DATA_I_MSB => 

                if s_txe_n = '0' then
                    s_obuf_next <= s_tx_q_fifo_out(7 downto 0);
                    s_tx_sm_state_next <= st_DATA_Q_LSB;
                end if;

            when st_DATA_Q_LSB => 

                if s_txe_n = '0' then
                    -- Fetch new value
                    if s_tx_sample_ctr = unsigned(c_FRAME_LENGTH) then
                        s_tx_sample_ctr_next <= (others => '0');
                        s_last_sample_next <= '1';
                    else
                        s_tx_sample_ctr_next <= s_tx_sample_ctr + 1;
                        s_tx_q_fifo_re_next <= '1';
                    end if;

                    s_obuf_next <= s_tx_q_fifo_out(15 downto 8);
                    s_tx_sm_state_next <= st_DATA_Q_MSB;
                end if;

            when st_DATA_Q_MSB => 

                if s_txe_n = '0' then
                    if s_last_sample = '1' then
                        s_fifo_fetched_next <= '0';
                        s_obuf_next <= (others => '0');
                        s_tx_sm_state_next <= st_IDLE;
                    else
                        s_fifo_fetched_next <= '1';
                        s_obuf_next <= s_tx_i_fifo_out(7 downto 0);
                        s_tx_sm_state_next <= st_DATA_I_LSB;
                    end if;
                end if;

            when others => 
                null;

        end case;

    end process p_tx_fifo_read_sm_comb;


    p_tx_fifo_read : process (s_txe_n, s_fifo_fetched)
    begin
        -- Default states
        s_oe <= '0';
        s_wr_n <= '1';
        if s_txe_n = '0' and s_fifo_fetched = '1' then
            s_oe <= '1';
            s_wr_n <= '0';
        end if;
    end process p_tx_fifo_read;


    -- Output assignments

    OE_n_pin <= '1';
    RD_n_pin <= '1'; -- FIXME
    WR_n_pin <= s_wr_n;

    SIWU_n_pin <= '1'; -- Send only full packets

    RX_STROBE <= s_rx_strobe;


end Behavioral;
