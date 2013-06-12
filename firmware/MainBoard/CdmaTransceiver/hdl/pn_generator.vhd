-- PN_GENERATOR.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.1 SP3
-- TARGET DEVICE: A2F500M3G (256 FBGA)
--   
-- Copyright (c) 2006-2013, Vanderbilt University
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

------------------------------------------------------------------------------
-- Description: Pseudo random sequence generator for spectrum spreading.
--
------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Revisions     :
-- Date            Version  Author			Description
-- 2013-06-12      1.0      Sandor Szilvasi Created (fixed function x^5+x^3+1)
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PN_GENERATOR is
	port (
         CLK        : in  std_logic;
         RST        : in  std_logic;
         EN         : in  std_logic;

         -- External MASK and SEED control is not implemented yet
         MASK       : in  std_logic_vector(31 downto 0);
         SEED       : in  std_logic_vector(31 downto 0);

         SEQ        : out std_logic_vector(1 downto 0)
		 );
end entity;

architecture Behavioral of PN_GENERATOR is

	-- Constants

    constant c_HIGH     : std_logic_vector(1 downto 0) := "01"; -- +1
    constant c_LOW      : std_logic_vector(1 downto 0) := "11"; -- -1

	-- Signals

    signal s_lfsr       : std_logic_vector(4 downto 0);
    signal s_seq        : std_logic_vector(1 downto 0);

begin

    p_pn_generator : process (rst, clk)
    begin
        if rst = '1' then
            s_seq <= (others => '0');
            s_lfsr <= SEED(4 downto 0);
        elsif rising_edge(clk) then
            if EN = '1' then
                s_lfsr(4 downto 0) <= s_lfsr(0) & s_lfsr(4 downto 1); -- x^5
                s_lfsr(2) <= s_lfsr(0) xor s_lfsr(3); -- x^3
            end if;
        end if;

    end process p_pn_generator;

    with s_lfsr(0) select
        SEQ <= c_HIGH when '1',
               c_LOW when others;

end Behavioral;

