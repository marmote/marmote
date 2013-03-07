-- phase_acc.vhd
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

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity PHASE_ACC is
	port (
		CLK       : in  std_logic;
		RST       : in  std_logic;

		EN        : in  std_logic;
		DPHASE    : in  std_logic_vector(63 downto 0);

		PHASE     : out std_logic_vector(11 downto 0)
	);
end entity;

architecture Behavioral of PHASE_ACC is

	-- Signals

	signal s_phase_acc  : signed(63 downto 0);
	signal s_phase_out  : std_logic_vector(11 downto 0);

begin

	p_phase_acc : process (rst, clk)
	begin
		if rst = '1' then
			s_phase_acc <= (others => '0');
		elsif rising_edge(clk) then
			if EN = '1' then
				s_phase_acc <= s_phase_acc + signed(DPHASE);
			else
				s_phase_acc <= (others => '0');
			end if;
		end if;
	end process p_phase_acc;

    s_phase_out <= std_logic_vector(s_phase_acc(s_phase_acc'high downto s_phase_acc'high-11));

	-- Assign the output signals
	PHASE <= s_phase_out;

end Behavioral;


