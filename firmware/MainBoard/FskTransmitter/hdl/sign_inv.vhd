-- sign_inv.vhd
------------------------------------------------------------------------------
-- MODULE: Sign Inverter (Marmote Platform - Teton Board)
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.0 SP1
-- TARGET DEVICE: A2F500M3G
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
-- Description: This module inverts the sign of the incoming signals to
--              compensate for the reduced (-pi/2;pi/2) operating range for
--              the CORDICCORE.
--

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.common.all;

entity SIGN_INV is
	port (
        CLK       : in  std_logic;
        RST       : in  std_logic;

        INVERT    : in  std_logic;
        X0        : in  std_logic_vector(9 downto 0);
        Y0        : in  std_logic_vector(9 downto 0);
        EN0       : in  std_logic;

        XN        : out  std_logic_vector(9 downto 0);
        YN        : out  std_logic_vector(9 downto 0);
        ENN       : out  std_logic
	);
end entity;

architecture Behavioral of SIGN_INV is

	-- Signals

    signal s_invert : std_logic_vector(c_CORDIC_WIDTH-1 downto 0);

    signal s_x  : std_logic_vector(c_CORDIC_WIDTH-1 downto 0);
    signal s_y  : std_logic_vector(c_CORDIC_WIDTH-1 downto 0);
    signal s_xo  : std_logic_vector(c_CORDIC_WIDTH-1 downto 0);
    signal s_yo  : std_logic_vector(c_CORDIC_WIDTH-1 downto 0);

    signal s_en : std_logic;

begin

    -- Processes

    p_invert_delay : process (rst, clk)
    begin
        if rst = '1' then
            s_invert <= (others => '0');
        elsif rising_edge(clk) then
            s_invert <= s_invert(s_invert'high-1 downto 0) & INVERT;
        end if;
    end process p_invert_delay;


    p_signal_negate : process (rst, clk)
    begin
        if rst = '1' then
            s_x <= (others => '0');
            s_y <= (others => '0');
            s_en <= '0';
        elsif rising_edge(clk) then
            if EN0 = '1' then
                if s_invert(s_invert'high) = '1' then
                    s_x <= not X0;
                    s_y <= not Y0;
                else
                    s_x <= X0;
                    s_y <= Y0;
                end if;
                s_xo <= X0;
                s_yo <= Y0;
            end if;
            s_en <= EN0;
        end if;
    end process p_signal_negate;

	-- Output assignment

    XN  <= s_x;
    YN  <= s_y;
    ENN <= s_en;

end Behavioral;


