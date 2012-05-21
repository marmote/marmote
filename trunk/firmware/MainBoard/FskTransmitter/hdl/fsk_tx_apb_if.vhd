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
		 --DPHASE    : out  std_logic_vector(c_DCO_PHASE_WIDTH-1 downto 0)
		 DPHASE    : out  std_logic_vector(c_DCO_PHASE_WIDTH-1 downto 0)
		 );
end entity;

architecture Behavioral of FSK_TX_APB_IF is

	-- Addresses
	constant c_ADDR_CTRL : std_logic_vector(7 downto 0) := x"00"; -- W (ENABLE)
	constant c_ADDR_STAT : std_logic_vector(7 downto 0) := x"00"; -- R (ENABLE)
	constant c_ADDR_DPHA : std_logic_vector(7 downto 0) := x"04"; -- R/W

	-- Default values
	constant c_DEFAULT_DPHA : unsigned(31 downto 0) := x"01604189"; -- 215 kHz

	-- Registers
--	signal s_status      : std_logic_vector(31 downto 0);
	signal s_dphase      : std_logic_vector(31 downto 0);

	signal s_dout        : std_logic_vector(31 downto 0);

	-- Signals
	signal s_state       : std_logic_vector(c_DATA_LENGTH-1 downto 0);

	signal s_dphase_en   : std_logic;
	signal s_start       : std_logic;


begin

	assert c_FAB_CLK = 20000000 -- 20 MHz
	report "Default baud rate and frequency values are calculated based on" &
	    " 20 MHz clock speed. FPGA clock speed should be " &
		integer'image(c_FAB_CLK) & " Hz"
	severity error;

	-- Register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_dphase_en <= '0';
			s_dphase <= std_logic_vector(c_DEFAULT_DPHA);
		elsif rising_edge(PCLK) then

			-- Default values
			s_dphase_en <= '0';

			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Initiate FSK transmission
						s_dphase_en <= PWDATA(0);
					when c_ADDR_DPHA =>
						s_dphase <= PWDATA;
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
					when c_ADDR_STAT => 
						s_dout(0) <= s_dphase_en;
					when c_ADDR_DPHA =>
						s_dout <= s_dphase;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;

	DPHASE_EN <= s_dphase_en;
	DPHASE <= s_dphase(c_DCO_PHASE_WIDTH-1 downto 0);

	PRDATA <= s_dout;
	PREADY <= '1';
	PSLVERR <= '0';

end Behavioral;


------------------------------------------------------------------------------
--                            Register description                          --
------------------------------------------------------------------------------
--
-- Control register (CTRL/STATUS)
-- Address offset: 0x00
-- 
-- 31                                                              1    0
-- +-------------------------------------------------------------------------+
-- |                             RESERVED                           | ENABLE |
-- +-------------------------------------------------------------------------+
-- |                                                                |    W   |
-- +-------------------------------------------------------------------------+
--
-- Bits 31:1 Reserved
-- Bit     0 START bit - Setting this bit initiates a transmission
--
------------------------------------------------------------------------------
--
-- Delta-phase register (DPHA)
-- Address offset: 0x04
-- 
-- 31                                                                        0
-- +-------------------------------------------------------------------------+
-- |                                 DPHA                                    |
-- +-------------------------------------------------------------------------+
-- |                                  R/W                                    |
-- +-------------------------------------------------------------------------+
--
-- Bits 31:0 DPHA bits - The value of the delta-phase register directly
--                       determines the actual transmit frequency
--                     - Calculation:
--                                                       F
--                       DPHA = 2^DCO_PHASE_WIDTH x -----------
--                                                   F_FAB_CLK
-- 
------------------------------------------------------------------------------

