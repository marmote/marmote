-- noise_gen.vhd
------------------------------------------------------------------------------
-- MODULE: Phase Accumulator (Marmote Platform - Teton Board)
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
-- High-frequency noise generator to test the MAX2830 low-pass filters.
--

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity NOISE_GEN is
	port (
		CLK       : in  std_logic;
		RST       : in  std_logic;

        XN        : out std_logic_vector(9 downto 0);
        YN        : out std_logic_vector(9 downto 0)
	);
end entity;

architecture Behavioral of NOISE_GEN is

	-- Signals

    signal s_x     : std_logic_vector(9 downto 0);

begin

    p_toggle : process (rst, clk)
    begin
        if rst = '1' then
            s_x <= (others => '0');
        elsif rising_edge(clk) then
            s_x <= not s_x;
        end if;
    end process p_toggle;

    XN <= s_x;
    YN <= not s_x;

end Behavioral;


