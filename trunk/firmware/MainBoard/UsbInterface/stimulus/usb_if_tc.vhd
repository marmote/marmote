-- USB_IF_TC.VHD

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
-- Description: FTDI FT232H USB chip FT245 synchronous FIFO interface timing
--              checker module.
--
-- Todo:        Add functional checking.
--
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library smartfusion;
use smartfusion.all;

entity USB_IF_TC is
--    generic (
--        VERBOSE     : string := "NO"
--    );
    port (
        -- USB (FTDI) interface
        USB_CLK_pin : in std_logic;

        DATA_pin    : in std_logic_vector(7 downto 0); -- ADBUS

        RXF_n_pin   : in  std_logic;
        TXE_n_pin   : in  std_logic;

        RD_n_pin    : in std_logic;
        WR_n_pin    : in std_logic;

        SIWU_n_pin  : in std_logic;
        OE_n_pin    : in std_logic;

        ACBUS8_pin  : in  std_logic;
        ACBUS9_pin  : in  std_logic
    );
end entity;


architecture Behavioral of USB_IF_TC is

    -- Signals

    -- Constants

    constant t1     : time := 16.67 ns; -- CLKOUT period
    constant t2_min : time :=  7.50 ns; -- CLKOUT high period
    constant t2     : time :=  8.33 ns; -- CLKOUT high period
    constant t2_max : time :=  9.17 ns; -- CLKOUT high period
    constant t3_min : time :=  7.50 ns; -- CLKOUT low period
    constant t3     : time :=  8.33 ns; -- CLKOUT low period
    constant t3_max : time :=  9.17 ns; -- CLKOUT low period
    constant t4_min : time :=  0.00 ns; -- CLKOUT to RXF#
    constant t4     : time :=  9.00 ns; -- CLKOUT to RXF#
    constant t5_min : time :=  0.00 ns; -- CLKOUT to read DATA valid
    constant t5     : time :=  9.00 ns; -- CLKOUT to read DATA valid
    constant t6_min : time :=  0.00 ns; -- OE# to read DATA valid
    constant t6     : time :=  9.00 ns; -- OE# to read DATA valid
    constant t7_min : time :=  7.50 ns; -- OE# setup time
    constant t8_min : time :=  0.00 ns; -- OE# hold time
    constant t9_min : time :=  7.50 ns; -- RD# setup time to CLKOUT (RD# low after OE# low)
    constant t10    : time :=  0.00 ns; -- RD# hold time
    constant t11_min: time :=  0.00 ns; -- CLKOUT to TXE#
    constant t11    : time :=  9.00 ns; -- CLKOUT to TXE#
    constant t12_min: time :=  7.50 ns; -- Write DATA setup time
    constant t13_min: time :=  0.00 ns; -- Write DATA hold time
    constant t14_min: time :=  7.50 ns; -- WR# setup time to CLKOUT (WR# low after TXE# low)
    constant t15_min: time :=  0.00 ns; -- WR# hold time

begin

    -- Processes

    -- p_usb_clock_check
    -- Process to check the USB interface clock signal
    p_usb_clock_check : process
        variable pre : time := 0 ns; -- previous rising edge
        variable pfe : time := 0 ns; -- previous falling edge
    begin

        wait until rising_edge(USB_CLK_pin);

        assert t2_min < now-pfe and now-pfe < t2_max
        report "USB: CLKOUT high period requirement not met (" &
        time'image(t2_min) & " < " & time'image(now-pfe) & " < " & time'image(t2_max) & ")"
        severity warning;

        pre := now;


        wait until falling_edge(USB_CLK_pin);

        assert t3_min < now-pre and now-pre < t3_max
        report "USB: CLKOUT low period requirement not met (" &
        time'image(t3_min) & " < " & time'image(now-pre) & " < " & time'image(t3_max) & ")"
        severity warning;

        pfe := now;

    end process p_usb_clock_check;


    -- p_usb_read_check
    -- Process to check the USB interface against the following timing
    -- requirements:
    --  - OE# setup time (t7)
    --  - RD# setup time (t9)
    p_usb_read_check : process(USB_CLK_pin)
    begin
        if rising_edge(USB_CLK_pin) then
            
            if OE_n_pin = '0' then

                assert RXF_n_pin = '0' -- FIXME: might not work for last cycle
                report "USB: OE# is pulled low without RXF# being asserted"
                severity error;

                assert OE_n_pin'stable(t7_min)
                report "USB: OE# setup time (t7) violated"
                severity error;

            end if;

            if RD_n_pin = '0' then

                assert OE_n_pin = '0'
                report "USB: RD# is pulled low without OE# being asserted"
                severity error;

                assert RD_n_pin'stable(t9_min)
                report "USB: RD# setup time to CLKOUT (t9) violated"
                severity error;

            end if;

        end if;
    end process p_usb_read_check;


    -- p_usb_write_check
    -- Process to check the USB interface against the following timing
    -- requirements:
    --  - Write DATA setup time (t12)
    --  - WR# setup time to CLKOUT (t14)
    p_usb_write_check : process(USB_CLK_pin)
    begin
        if rising_edge(USB_CLK_pin) then
            
            if WR_n_pin = '0' then

                assert DATA_pin'stable(t12_min)
                report "USB: Write DATA setup time (t12) violated"
                severity error;

                assert WR_n_pin'stable(t14_min)
                report "USB: WR# setup time to CLKOUT (t14) violated"
                severity error;

            end if;

        end if;
    end process p_usb_write_check;

    -- p_usb_write_check
    -- Process to check the USB interface against the following timing
    -- requirements:
    --  - Write DATA setup time (t12)
    --  - WR# setup time to CLKOUT (t14)
    p_usb_txe_wr_check : process(WR_n_pin)
    begin
        if falling_edge(WR_n_pin) then
            assert TXE_n_pin = '0'
            report "USB: WR# is pulled low without TXE# being asserted"
            severity error;
        end if;
    end process p_usb_txe_wr_check;

end Behavioral;

