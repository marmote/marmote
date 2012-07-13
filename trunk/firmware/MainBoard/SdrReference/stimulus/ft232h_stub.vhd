-- FT232H_STUB.VHD
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
-- Description: Stub module for the FT232H USB (FTDI) chip operating in
--              synchronous FIFO mode as slave.
--
--              The module receives/transmits 8-bit data only and displays its
--              value in (e.g.
--              multiplexing should be solved outside this block)
--
--  - TXE# and WE# signal generation
--  - Received value display
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library smartfusion;
use smartfusion.all;

entity FT232H_STUB is
    port (
        -- Internal interface
        RST         : in  std_logic;

        -- USB (FTDI) interface
        USB_CLK_pin : out std_logic;

        DATA_pin    : inout std_logic_vector(7 downto 0);
        OE_n_pin    : in  std_logic;
        RD_n_pin    : in  std_logic;
        WR_n_pin    : in  std_logic;

        RXF_n_pin   : out std_logic;
        TXE_n_pin   : out std_logic;

        SIWU_n_pin  : in  std_logic;
        ACBUS8_pin  : out std_logic;
        ACBUS9_pin  : out std_logic
    );
end entity;


architecture Behavioral of FT232H_STUB is

    -- Constants

    constant c_USB_CLOCK_PERIOD: time := (real(1000)/real(60)) * 1 ns; -- 60 MHz

    -- Signals

    signal s_usb_clk    : std_logic;
    signal s_txe_n      : std_logic;


begin

    -- Processes

    p_rx_display : process (rst, s_usb_clk)
    begin
        if rst = '1' then
            null;
        elsif rising_edge(s_usb_clk) then
            if s_txe_n = '1' and WR_n_pin = '0' then
                report "USB_DB: " & integer'image(to_integer(unsigned(DATA_pin)));
            end if;
        end if;
    end process p_rx_display;


    -- p_usb_clock_gen
    -- Generates the USB clock
    p_usb_clock_gen : process
    begin
        s_usb_clk <= '0', '1' after c_USB_CLOCK_PERIOD / 2;
        wait for c_USB_CLOCK_PERIOD;
    end process p_usb_clock_gen;


    s_txe_n <= '0';

    -- Output assignments

    DATA_pin <= (others => 'Z');

    RXF_n_pin <= '0';
    TXE_n_pin <= s_txe_n;
    USB_CLK_pin <= s_usb_clk;

    ACBUS8_pin <= '0';
    ACBUS9_pin <= '1';

end Behavioral;
