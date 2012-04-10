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
    component FIFO_256x8 is
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

    signal USB_CLK  : std_logic;

    signal s_oe     : std_logic;
    signal s_obuf   : std_logic_vector(7 downto 0);
    signal s_ibuf   : std_logic_vector(7 downto 0);

    signal s_tx_fifo_re : std_logic;

    signal s_rx_fifo_we : std_logic;
    signal s_rx_strobe  : std_logic;
    signal s_rx_fifo_empty : std_logic;

begin

    -- Port maps

    u_USB_CLKBUF : CLKBUF
      port map(PAD => USB_CLK_pin, Y => USB_CLK);

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
    u_RX_FIFO : FIFO_256x8
    port map (
        RESET   => RST,
        DATA    => s_ibuf,
        Q       => RXD,
        WCLOCK  => USB_CLK,
        WE      => s_rx_fifo_we,
        RCLOCK  => CLK,
        RE      => s_rx_strobe,
        FULL    => open,
        EMPTY   => RX_STROBE
    );

    s_rx_fifo_we <= '0'; -- FIXME
    s_rx_strobe <= '0'; -- FIXME

    -- NOTE: Port mapping and testing of this FIFO is not finished.
    -- TODO: Remove AEMPTY and AFULL signals.
    u_TX_FIFO : FIFO_256x8
    port map (
        RESET   => RST,
        DATA    => TXD,
        Q       => s_obuf,
        WCLOCK  => CLK,
        WE      => TX_STROBE,
        RCLOCK  => USB_CLK,
        RE      => s_tx_fifo_re,
        FULL    => open,
        EMPTY   => s_rx_fifo_empty
    );

    s_tx_fifo_re <= '0'; -- FIXME

    -- Processes

    p_rx_fifo_read : process (rst, clk)
    begin
        if rst = '1' then

        elsif rising_edge(clk) then
        end if;
    end process p_rx_fifo_read;


    s_oe <= '0'; -- FIXME
    OE_n_pin <= not s_oe;
    RD_n_pin <= '1'; -- FIXME
    WR_n_pin <= '1'; -- FIXME
    SIWU_n_pin <= '0'; -- FIXME

    -- Output assignments

    RX_STROBE <= s_rx_strobe;


end Behavioral;
