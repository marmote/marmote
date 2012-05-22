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

use work.common.all;

entity PHASE_ACC is
	port (
		CLK       : in  std_logic;
		RST       : in  std_logic;

		DPHASE_EN : in  std_logic;
--		DPHASE    : in  std_logic_vector(c_DCO_PHASE_WIDTH-1 downto 0);
		DPHASE    : in  std_logic_vector(32-1 downto 0);

		PHASE_EN  : out std_logic;
--		MAGNITUDE : out std_logic_vector(c_CORDIC_WIDTH-1 downto 0);
--		PHASE     : out std_logic_vector(c_CORDIC_WIDTH-1 downto 0)
		MAGNITUDE : out std_logic_vector(10-1 downto 0);
		PHASE     : out std_logic_vector(10-1 downto 0);
    
        INVERT    : out std_logic
	);
end entity;

architecture Behavioral of PHASE_ACC is

	-- Constants

	constant c_MAGNITUDE : unsigned(c_DCO_PHASE_WIDTH-1 downto 0) :=
		to_unsigned(2**(c_DCO_PHASE_WIDTH-3)-1, c_DCO_PHASE_WIDTH);
	constant c_MIN : signed(c_CORDIC_WIDTH-1 downto 0) :=
		to_signed(2**(c_CORDIC_WIDTH-1), c_CORDIC_WIDTH);

	-- Signals

	signal s_phase_acc    : signed(c_DCO_PHASE_WIDTH-1 downto 0);
	signal s_phase_rolled : std_logic_vector(c_CORDIC_WIDTH-1 downto 0);
	signal s_phase_en_ctr : unsigned(4 downto 0); -- FIXME: make '4' generic
	signal s_phase_en     : std_logic;

    signal s_invert       : std_logic;

begin

	assert c_DCO_PHASE_WIDTH > c_CORDIC_WIDTH
	report "Phase accumulator width is smaller than CORDIC input width"
	severity failure;

	p_phase_acc : process (rst, clk)
	begin
		if rst = '1' then
			s_phase_acc <= (others => '0');
		elsif rising_edge(clk) then
			if dphase_en = '1' then
				s_phase_acc <= s_phase_acc + signed(dphase);
			else
				s_phase_acc <= (others => '0'); -- FIXME: check if it introduces
				                                --        glitches
			end if;
		end if;
	end process p_phase_acc;

--    s_phase_rolled <= std_logic(s_phase_acc(s_phase_acc'high)) &
--                      std_logic_vector(s_phase_acc(s_phase_acc'high downto
--                      s_phase_acc'high-c_CORDIC_WIDTH+2));
    s_phase_rolled <= std_logic(s_phase_acc(s_phase_acc'high-1)) &
                      std_logic_vector(s_phase_acc(s_phase_acc'high-1 downto
                      s_phase_acc'high-c_CORDIC_WIDTH+1));

	-- Adjust the output phase to the [-pi/2;pi/2] CORDIC input range
	p_phase_mix : process (s_phase_acc)
	begin
--        s_phase_rolled <= s_phase_acc(s_phase_acc'high) & s_phase_acc(s_phase_acc'high downto
--                          s_phase_acc'high-c_CORDIC_WIDTH+1);

--		if s_phase_acc(s_phase_acc'high) = s_phase_acc(s_phase_acc'high-1) then
----			s_phase_rolled <= std_logic_vector(s_phase_acc(c_DCO_PHASE_WIDTH-1 downto
----					 c_DCO_PHASE_WIDTH-c_CORDIC_WIDTH));
--			s_phase_rolled <= std_logic_vector(s_phase_acc(c_DCO_PHASE_WIDTH-1 downto
--					 c_DCO_PHASE_WIDTH-c_CORDIC_WIDTH));
--		else
----			s_phase_rolled <=
----		   std_logic_vector(signed(c_MIN)-s_phase_acc(c_DCO_PHASE_WIDTH-1 downto
----		   c_DCO_PHASE_WIDTH-c_CORDIC_WIDTH));
--			s_phase_rolled <=
--		   std_logic_vector(signed(c_MIN)-s_phase_acc(c_DCO_PHASE_WIDTH-1 downto
--		   c_DCO_PHASE_WIDTH-c_CORDIC_WIDTH));

        if s_phase_acc(s_phase_acc'high) = s_phase_acc(s_phase_acc'high-1) then
--        if s_phase_acc(s_phase_acc'high) = '0' then
            s_invert <= '0';
        else
            s_invert <= '1';
        end if;
	end process p_phase_mix;

	-- Generate phase_en periodically
	p_phase_en : process (rst, clk)
	begin
		if rst = '1' then
			s_phase_en_ctr <= (others => '0');
		elsif rising_edge(clk) then
			s_phase_en <= '0';
			if s_phase_en_ctr < c_CORDIC_WIDTH + 1 then
				s_phase_en_ctr <= s_phase_en_ctr + 1;
			else
				s_phase_en <= '1';
				s_phase_en_ctr <= (others => '0');
			end if;
		end if;
	end process p_phase_en;


	-- Assign the output signals
	PHASE <= s_phase_rolled;
	PHASE_EN <= s_phase_en;
	MAGNITUDE <= std_logic_vector(c_MAGNITUDE(c_DCO_PHASE_WIDTH-1 downto
				 c_DCO_PHASE_WIDTH-c_CORDIC_WIDTH));

    INVERT <= s_invert;

end Behavioral;


