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
--              The module receives/transmits 8-bit data only (e.g.
--              multiplexing should be solved outside this block)
--
-- Todo:
--  - TXE# and WE# monitoring
--  - Add block ram/register FIFOs for clock region passing
--  - Add state machine to control data path
--  - Add logic to sense USB (FTDI) chip presence
--  - Determine the maximum system clock frequency (<60MHz?)
--  - Support bit widhts of larger than 8
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library smartfusion;
use smartfusion.all;

entity USB_IF is
    port (
        -- Internal interface
        CLK         : in  std_logic;
        RST         : in  std_logic;

        -- FIXME: replace with a 16-bit I/O
        TX_STROBE   : in  std_logic;
        TXD         : in  std_logic_vector(7 downto 0);
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

    -- FIXME: replace with a 16-bit fifo
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


    -- Signals
    alias sys_clk is clk;

    signal usb_clk  : std_logic;

    signal s_oe     : std_logic;
    signal s_oe_next : std_logic;
    signal s_obuf   : std_logic_vector(7 downto 0);
    signal s_ibuf   : std_logic_vector(7 downto 0);

    type tx_sm_t is (st_IDLE, st_LOADED);

    signal s_tx_sm_state : tx_sm_t;
    signal s_tx_sm_state_next : tx_sm_t;
    signal s_wr_n : std_logic;
    signal s_wr_n_next : std_logic;
--    signal s_tx_fifo_re : std_logic;
    signal s_tx_fifo_re_next : std_logic;
    signal s_tx_fifo_we : std_logic;
--    signal s_tx_fifo_re_d : std_logic;
    signal s_tx_fifo_full : std_logic;
    signal s_tx_fifo_empty : std_logic;
--    signal s_tx_fifo_empty_d : std_logic;
--    signal s_tx_idle    : std_logic;

    signal s_rx_fifo_we : std_logic;
    signal s_rx_strobe  : std_logic;

begin

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


    u_TX_FIFO : FIFO_512x8
    port map (
        RESET   => RST,
        DATA    => TXD,
        Q       => s_obuf,
        WCLOCK  => CLK,
        WE      => s_tx_fifo_we,
        RCLOCK  => usb_clk,
        RE      => s_tx_fifo_re_next,
        FULL    => s_tx_fifo_full,
        EMPTY   => s_tx_fifo_empty
    );

--    s_tx_fifo_we <= TX_STROBE and not s_tx_fifo_full;
    s_tx_fifo_we <= TX_STROBE;


    -- Processes

    p_rx_fifo_read : process (rst, clk)
    begin
        if rst = '1' then

        elsif rising_edge(clk) then
        end if;
    end process p_rx_fifo_read;


    p_tx_fifo_read_sm_sync : process (rst, usb_clk)
    begin
        if rst = '1' then
            s_wr_n <= '1';
            s_oe <= '0';
            s_tx_sm_state <= st_IDLE;
        elsif rising_edge(usb_clk) then
            -- Register updates
            s_wr_n <= s_wr_n_next;
            s_oe <= s_oe_next;
--            s_tx_fifo_re <= s_tx_fifo_re_next;
            s_tx_sm_state <= s_tx_sm_state_next;
        end if;
    end process p_tx_fifo_read_sm_sync;

    p_tx_fifo_read_sm_comb : process (
        s_tx_sm_state,
        s_tx_fifo_empty,
        TXE_n_pin,
        s_wr_n
    )
    begin

        -- Default states
        s_tx_fifo_re_next <= '0';
        s_wr_n_next <= '1';
        s_oe_next <= '0';
        s_tx_sm_state_next <= s_tx_sm_state;

        -- Next state logic
        case s_tx_sm_state is

            -- State st_LOADED
            -- Waiting for the FIFO to become non-empty
            when st_IDLE =>

                if s_tx_fifo_empty = '0' then
                    s_tx_fifo_re_next <= '1';
                    s_tx_sm_state_next <= st_LOADED;
                end if;

            -- State st_LOADED
            -- The FIFO register is loaded, waiting for TXE# = 0 and WR# = 0
            -- that is for the data to be accepted.
            when st_LOADED =>

                if TXE_n_pin = '0' then
                    s_oe_next <= '1';
                    s_wr_n_next <= '0';
                end if;

                -- Check if data has been accepted
                if s_wr_n = '0' and txe_n_pin = '0' then
                    s_tx_fifo_re_next <= '1';
                    if s_tx_fifo_empty = '1' then
                        -- Move to IDLE state if nothing more is to be transmitted
                        s_wr_n_next <= '1';
                        s_tx_sm_state_next <= st_IDLE;
                    end if;
                end if;


            when others =>
                null;

        end case;

    end process p_tx_fifo_read_sm_comb;


    OE_n_pin <= '1';
    RD_n_pin <= '1'; -- FIXME
    WR_n_pin <= s_wr_n;

    SIWU_n_pin <= '1'; -- Send only full packets

    -- Output assignments

    RX_STROBE <= s_rx_strobe;


end Behavioral;
