-- USB_IF_STUB.VHD
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
-- Description: Stub for the interface module for the FT232H USB (FTDI) chip
--              operating in synchronous FIFO mode.
--
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library smartfusion;
use smartfusion.all;

entity USB_IF_STUB is
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


architecture Behavioral of USB_IF_STUB is

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


    -- Signals
    alias sys_clk is clk;

    signal usb_clk  : std_logic;

    signal s_oe     : std_logic;
    signal s_obuf   : std_logic_vector(7 downto 0);
    signal s_ibuf   : std_logic_vector(7 downto 0);

    signal s_wr_n : std_logic;

begin

    -- Port maps

    u_USB_CLKBUF : CLKBUF
      port map(PAD => USB_CLK_pin, Y => usb_clk);


    g_USB_SYNC_FIFO_DATA : for i in 0 to 7 generate

        u_BIBUF_LVCMOS33 : BIBUF_LVCMOS33
        port map (
            PAD => DATA_pin(i),
            D   => s_obuf(i),
--            E   => s_oe,
            E   => '1',
            Y   => s_ibuf(i)
        );

    end generate g_USB_SYNC_FIFO_DATA;


    -- Processes

    p_tx_fifo_read_sm_sync : process (rst, usb_clk)
    begin
        if rst = '1' then
            s_oe <= '0';
            s_wr_n <= '1';
        elsif rising_edge(usb_clk) then
            s_oe <= '0';
            s_wr_n <= '1';
            if TXE_n_pin = '0' then
                s_oe <= '1';
                s_wr_n <= '0';
            end if;
        end if;
    end process p_tx_fifo_read_sm_sync;


    -- Output assignments

    s_obuf <= x"F5";

    OE_n_pin <= '1';
    RD_n_pin <= '1';
--    WR_n_pin <= s_wr_n;
    WR_n_pin <= '0';
    SIWU_n_pin <= '1';

    RX_STROBE <= '0';
    RXD <= s_ibuf;


end Behavioral;
