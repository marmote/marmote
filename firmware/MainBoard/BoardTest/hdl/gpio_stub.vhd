-- GPIO_STUB.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 9101 SP3
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


------------------------------------------------------------------------------
-- Notes: This is a placeholder stub for the connector, LED and enable GPIO
--        pins.
------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GPIO_STUB is
	port (
		 -- APB3 interface
		 PCLK    : in  std_logic;
		 PRESETn : in  std_logic;
		 PADDR	 : in  std_logic_vector(31 downto 0);
		 PSEL	 : in  std_logic;
		 PENABLE : in  std_logic;
		 PWRITE  : in  std_logic;
		 PWDATA  : in  std_logic_vector(31 downto 0);

		 PREADY  : out std_logic;
		 PRDATA  : out std_logic_vector(31 downto 0);
		 PSLVERR : out std_logic;

		 -- GPIO interface
         LED        : out std_logic_vector(1 downto 0);

         NGPIO      : out std_logic_vector(3 downto 0);
         SGPIO      : out std_logic_vector(5 downto 0);

         MAC_EN     : out std_logic
		 );
end entity;

architecture Behavioral of GPIO_STUB is

	-- Addresses
	constant c_ADDR_DUMMY       : std_logic_vector(7 downto 0) := x"00"; -- R/W

	-- Default values
	constant c_DEFAULT_DUMMY : unsigned(31 downto 0) := x"00000000";

	-- Signals
    signal s_dummy              : std_logic_vector(31 downto 0 ); -- all bits stuffed in one register
    signal s_dout               : std_logic_vector(31 downto 0 );

begin

	-- APB register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_dummy  <= (others => '0');
		elsif rising_edge(PCLK) then

			-- Default values

			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_DUMMY =>
						s_dummy <= PWDATA;
					when others =>
						null; 
				end case;
			end if;
		end if;
	end process;


	-- APB register read
	p_REG_READ : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_dout <= (others => '0');
		elsif rising_edge(PCLK) then

			-- Default output
			s_dout <= (others => '0');

			-- Register reads
			if PWRITE = '0' and PSEL = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_DUMMY => 
						s_dout <= s_dummy;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;


	-- Output assignments
	PRDATA <= s_dout;
	PREADY <= '1';
	PSLVERR <= '0';

    LED    <= s_dummy(1 downto 0);
    SGPIO  <= s_dummy(7 downto 2);
    NGPIO  <= s_dummy(11 downto 8);
    MAC_EN <= s_dummy(12);

end Behavioral;



