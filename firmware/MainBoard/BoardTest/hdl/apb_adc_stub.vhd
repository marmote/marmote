-- APB_ADC_STUB.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 9101 SP3
-- TARGET DEVICE: A2F500M3G (256 FBGA)
--   
-- Copyright (c) 2006-2011, Vanderbilt University
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
-- Notes: This is a placeholder stub for the MAX19706 ADC inteface module.
--
------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity APB_ADC_STUB is
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

		 -- ADC interface
	     DIN_0   : in  std_logic_vector(9 downto 0);
	     DIN_1   : in  std_logic_vector(9 downto 0);
	     DOUT_0  : out std_logic_vector(9 downto 0);
	     DOUT_1  : out std_logic_vector(9 downto 0);
         DOE     : out std_logic;

         SHDN_n  : out std_logic; -- shutdown
         T_R_n   : out std_logic  -- T/R_n transmit/receive mode select
		 );
end entity;

architecture Behavioral of APB_ADC_STUB is

	-- Addresses
	constant c_ADDR_CTRL    : std_logic_vector(7 downto 0) := x"00"; -- R/W
	constant c_ADDR_DAC_DATA_0  : std_logic_vector(7 downto 0) := x"04"; -- R/W
	constant c_ADDR_DAC_DATA_1  : std_logic_vector(7 downto 0) := x"08"; -- R/W
	constant c_ADDR_ADC_DATA_0   : std_logic_vector(7 downto 0) := x"0C"; -- R/W
	constant c_ADDR_ADC_DATA_1    : std_logic_vector(7 downto 0) := x"10"; -- R/W

	-- Default values
	constant c_DEFAULT_CTRL : unsigned(31 downto 0) := x"00000000";
	constant c_DEFAULT_DATA_DAC : unsigned(31 downto 0) := x"00000000";
	constant c_DEFAULT_DATA_ADC : unsigned(31 downto 0) := x"00000000";

	-- Signals
    signal s_ctrl           : std_logic; -- 0: adc 1: dac
	signal s_adc_data_0     : std_logic_vector(9 downto 0);
	signal s_adc_data_1     : std_logic_vector(9 downto 0);
	signal s_dac_data_0     : std_logic_vector(9 downto 0);
	signal s_dac_data_1     : std_logic_vector(9 downto 0);
	signal s_dout           : std_logic_vector(31 downto 0);

begin

	-- APB register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			--s_ctr  <= std_logic_vector(c_DEFAULT_CTRL);
			s_ctrl  <= '0';
		elsif rising_edge(PCLK) then

			-- Default values

			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Control
						s_ctrl <= PWDATA(0);
					when c_ADDR_DAC_DATA_0 =>
						s_dac_data_0 <= PWDATA(9 downto 0);
					when c_ADDR_DAC_DATA_1 =>
						s_dac_data_1 <= PWDATA(9 downto 0);
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
					when c_ADDR_CTRL => 
						s_dout(0) <= s_ctrl;
					when c_ADDR_DAC_DATA_0 =>
						s_dout(9 downto 0) <= s_dac_data_0;
					when c_ADDR_DAC_DATA_1 =>
						s_dout(9 downto 0) <= s_dac_data_1;
					when c_ADDR_ADC_DATA_0 =>
						s_dout(9 downto 0) <= s_adc_data_0;
					when c_ADDR_ADC_DATA_1 =>
						s_dout(9 downto 0) <= s_adc_data_1;
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

    s_adc_data_0 <= DIN_0;
    s_adc_data_1 <= DIN_1;
    DOUT_0 <= s_dac_data_0;
    DOUT_1 <= s_dac_data_1;
    DOE <= s_ctrl;

    T_R_n <= s_ctrl;
    SHDN_n <= '1';

end Behavioral;

