-- FSK_TX_APB_IF.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.0 SP1
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
-- Description: APB interface to test the Marmote platform TX path by
--              implementing an FSK transmitter project.
--
------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.common.all;

entity FSK_TX_APB_IF is
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

		 -- FSK interface
		 DPHASE_EN : out  std_logic;
		 DPHASE    : out  std_logic_vector(31 downto 0);
         AMPLITUDE : out  std_logic_vector(9 downto 0);

         -- Debug interface
         MUX_SEL   : out std_logic_vector(1 downto 0);
         I         : out std_logic_vector(9 downto 0);
         Q         : out std_logic_vector(9 downto 0)
		 );
end entity;

architecture Behavioral of FSK_TX_APB_IF is

	-- Addresses
	constant c_ADDR_CTRL : std_logic_vector(7 downto 0) := x"00"; -- W (START)
	constant c_ADDR_DPHA : std_logic_vector(7 downto 0) := x"04"; -- R/W
	constant c_ADDR_AMPL : std_logic_vector(7 downto 0) := x"08"; -- R/W !

	constant c_ADDR_I    : std_logic_vector(7 downto 0) := x"10"; -- R/W !
	constant c_ADDR_Q    : std_logic_vector(7 downto 0) := x"14"; -- R/W !
	constant c_ADDR_MUX  : std_logic_vector(7 downto 0) := x"18"; -- R/W !

	-- Default values
	constant c_DEFAULT_AMPL     : signed(31 downto 0)    := x"00000130";

	constant c_DEFAULT_DPHA     : unsigned(31 downto 0) := x"01604189";

     -- Debug registers
    constant c_DEFAULT_MUX  : unsigned(31 downto 0) := x"00000000"; -- 
	constant c_DEFAULT_I    : unsigned(31 downto 0) := x"00000000";
	constant c_DEFAULT_Q    : unsigned(31 downto 0) := x"00000000";
    

	-- Registers
	signal s_dout        : std_logic_vector(31 downto 0);

	-- Signals

	signal s_dphase      : std_logic_vector(c_DCO_PHASE_WIDTH-1 downto 0);


	signal s_ampl        : std_logic_vector(31 downto 0);
	signal s_i           : std_logic_vector(9 downto 0);
	signal s_q           : std_logic_vector(9 downto 0);
	signal s_mux         : std_logic_vector(31 downto 0);

begin

	-- Register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_dphase <= std_logic_vector(c_DEFAULT_DPHA);
            s_ampl <= std_logic_vector(c_DEFAULT_AMPL);
            s_i <= std_logic_vector(c_DEFAULT_I(9 downto 0));
            s_q <= std_logic_vector(c_DEFAULT_Q(9 downto 0));
            s_mux <= std_logic_vector(c_DEFAULT_MUX);
		elsif rising_edge(PCLK) then

			-- Default values

			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Initiate FSK transmission
					when c_ADDR_DPHA =>
						s_dphase <= PWDATA;
					when c_ADDR_AMPL =>
						s_ampl <= PWDATA;
					when c_ADDR_MUX =>
						s_mux <= PWDATA;
					when c_ADDR_I =>
						s_i <= PWDATA(9 downto 0);
					when c_ADDR_Q =>
						s_q <= PWDATA(9 downto 0);
					when others =>
						null;
				end case;
			end if;
		end if;
	end process;

	-- Register read
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
					when c_ADDR_DPHA =>
						s_dout <= s_dphase;
					when c_ADDR_AMPL =>
						s_dout <= s_ampl;
					when c_ADDR_I =>
						s_dout(9 downto 0) <= s_i;
					when c_ADDR_Q =>
						s_dout(9 downto 0) <= s_q;
					when c_ADDR_MUX =>
						s_dout <= s_mux;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;

    -- Output assignment
    
	DPHASE_EN <= '1';
	DPHASE <= s_dphase;
    AMPLITUDE <= s_ampl(9 downto 0);

	PRDATA <= s_dout;
	PREADY <= '1';
	PSLVERR <= '0';

    I <= s_i;
    Q <= s_q;
    MUX_SEL <= s_mux(1 downto 0);

end Behavioral;
