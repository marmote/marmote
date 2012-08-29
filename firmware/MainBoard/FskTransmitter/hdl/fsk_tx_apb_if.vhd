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
	constant c_ADDR_STAT : std_logic_vector(7 downto 0) := x"04"; -- R (BUSY)
	constant c_ADDR_BAUD : std_logic_vector(7 downto 0) := x"08"; -- R/W
	constant c_ADDR_DPLO : std_logic_vector(7 downto 0) := x"0C"; -- R/W
	constant c_ADDR_DPHI : std_logic_vector(7 downto 0) := x"10"; -- R/W
	constant c_ADDR_AMPL : std_logic_vector(7 downto 0) := x"14"; -- R/W !

	constant c_ADDR_I    : std_logic_vector(7 downto 0) := x"20"; -- R/W !
	constant c_ADDR_Q    : std_logic_vector(7 downto 0) := x"24"; -- R/W !
	constant c_ADDR_MUX  : std_logic_vector(7 downto 0) := x"28"; -- R/W !

	constant c_ADDR_DATA : std_logic_vector(7 downto 0) := x"30"; -- R/W

	-- Default values
	constant c_DEFAULT_BAUD : unsigned(31 downto 0) := x"00000209"; -- 76.8 kBAUD
	constant c_DEFAULT_DPLO : unsigned(31 downto 0) := x"008b4396"; -- 85 kHz
	constant c_DEFAULT_DPHI : unsigned(31 downto 0) := x"01604189"; -- 215 kHz
	constant c_DEFAULT_DATA : unsigned(31 downto 0) := x"F0F0F0F1";
	constant c_DEFAULT_AMPL : unsigned(31 downto 0) := x"0000007F"; -- TBD

     -- Debug registers
    constant c_DEFAULT_MUX  : unsigned(31 downto 0) := x"00000001"; -- 
	constant c_DEFAULT_I    : unsigned(31 downto 0) := x"00000000";
	constant c_DEFAULT_Q    : unsigned(31 downto 0) := x"00000000";
    

	-- Registers
	signal s_status      : std_logic_vector(31 downto 0);
	signal s_baud        : std_logic_vector(31 downto 0);
	signal s_dphase_low  : std_logic_vector(31 downto 0);
	signal s_dphase_high : std_logic_vector(31 downto 0);
	signal s_data        : std_logic_vector(31 downto 0);

	signal s_dout        : std_logic_vector(31 downto 0);

	-- Signals
	signal s_state       : std_logic_vector(c_DATA_LENGTH-1 downto 0);
	signal s_state_next  : std_logic_vector(c_DATA_LENGTH-1 downto 0);
	signal s_data_buffer : std_logic_vector(c_DATA_LENGTH-1 downto 0);
	signal s_data_buffer_next : std_logic_vector(c_DATA_LENGTH-1 downto 0);

	signal s_busy        : std_logic;
	signal s_dphase_en   : std_logic;
	signal s_dphase      : std_logic_vector(c_DCO_PHASE_WIDTH-1 downto 0);
	signal s_dphase_next : std_logic_vector(c_DCO_PHASE_WIDTH-1 downto 0);
	signal s_start       : std_logic;
	signal s_counter     : unsigned(31 downto 0);
	signal s_symbol_end  : std_logic;

	signal s_ampl        : std_logic_vector(31 downto 0);
	signal s_i           : std_logic_vector(9 downto 0);
	signal s_q           : std_logic_vector(9 downto 0);
	signal s_mux         : std_logic_vector(31 downto 0);

begin

	-- Register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_start <= '0';
			s_baud <= std_logic_vector(c_DEFAULT_BAUD);
			s_dphase_low <= std_logic_vector(c_DEFAULT_DPLO);
			s_dphase_high <= std_logic_vector(c_DEFAULT_DPHI);
            s_ampl <= std_logic_vector(c_DEFAULT_AMPL);
            s_i <= std_logic_vector(c_DEFAULT_I(9 downto 0));
            s_q <= std_logic_vector(c_DEFAULT_Q(9 downto 0));
            s_mux <= std_logic_vector(c_DEFAULT_MUX);
			s_data <= std_logic_vector(c_DEFAULT_DATA);
		elsif rising_edge(PCLK) then

			-- Default values
			s_start <= '0';

			-- Register writes
			-- FIXME: allow writes only when no transmission is in progress
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Initiate FSK transmission
						s_start <= PWDATA(0);
					when c_ADDR_DATA =>
						s_data <= PWDATA;
					when c_ADDR_BAUD =>
						s_baud <= PWDATA;
					when c_ADDR_DPLO =>
						s_dphase_low <= PWDATA;
					when c_ADDR_DPHI =>
						s_dphase_high <= PWDATA;
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
					when c_ADDR_STAT => 
						s_dout <= s_status;
					when c_ADDR_DATA =>
						s_dout <= s_data;
					when c_ADDR_BAUD =>
						s_dout <= s_baud;
					when c_ADDR_DPLO =>
						s_dout <= s_dphase_low;
					when c_ADDR_DPHI =>
						s_dout <= s_dphase_high;
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

	s_status <= x"0000000" & "000" & s_busy;

	-----------------------------------------------------------------------------
	-- Baud timer
	-----------------------------------------------------------------------------
	p_baud_timer : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_counter <= (others => '0');
			s_symbol_end <= '0';
		elsif rising_edge(PCLK) then
			s_symbol_end <= '0';
			if s_busy = '1' then
				if s_counter < unsigned(s_baud) then
					s_counter <= s_counter+1;
				else
					s_counter <= (others => '0');
					s_symbol_end <= '1';
				end if;
			end if;
		end if;
	end process p_baud_timer;


	-----------------------------------------------------------------------------
	-- One-hot encoded FSM coordinating FSK transmission (combinational)
	-----------------------------------------------------------------------------
	p_FSK_TRANSMIT_FSM_COMB : process (
		s_state,
		s_busy,
		s_symbol_end,
		s_data,
		s_data_buffer,
		s_start
	)
	begin
		-- Default values
		s_busy <= '0';
		s_state_next <= s_state;
		s_data_buffer_next <= s_data_buffer;

		if s_state /= std_logic_vector(to_unsigned(0,s_state'length)) then
			s_busy <= '1';
		end if;

		if s_busy /= '1' then
			-- Start transmission on 's_start'
			if s_start = '1' then
				s_state_next(0) <= '1'; -- Load LSB with '1'
				s_data_buffer_next <= s_data(c_DATA_LENGTH-1 downto 0);
			end if;
		else
			-- Step bits based on baud timing
			if s_symbol_end = '1' then
				if s_state(c_DATA_LENGTH-1) = '1' then
					s_state_next <= (others => '0');
					s_data_buffer_next <= (others => '0');
				else
					s_state_next <= s_state(s_state'high-1 downto 0) & '0';
					s_data_buffer_next <=
						s_data_buffer(s_data_buffer'high-1 downto 0) & '0';
				end if;
			end if;
		end if;
	end process p_FSK_TRANSMIT_FSM_COMB;


	-----------------------------------------------------------------------------
	-- One-hot encoded FSM coordinating FSK transmission (synchronous)
	-----------------------------------------------------------------------------
	p_FSK_TRANSMIT_FSM_SYNC : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_state <= (others => '0');
			s_data_buffer <= (others => '0');
			s_dphase <= (others => '0');
			s_dphase_en <= '0';
		elsif rising_edge(PCLK) then
			s_state <= s_state_next;
			s_data_buffer <= s_data_buffer_next;
			s_dphase <= s_dphase_next;
			s_dphase_en <= s_busy; -- Delay-adjusted to 'dphase'
		end if;
	end process p_FSK_TRANSMIT_FSM_SYNC;

	p_DPHASE_MUX : process (
		s_busy,
		s_data_buffer,
		s_dphase_high,
		s_dphase_low
	)
	begin
		-- Default value
		s_dphase_next <= (others => '0');

		if s_busy = '1' then
			-- Use s_data_buffer LSB as MUX input
			if s_data_buffer(s_data_buffer'high) = '1' then
				s_dphase_next <= s_dphase_high;
			else
				s_dphase_next <= s_dphase_low;
			end if;
		end if;
	end process p_DPHASE_MUX;


    -- Output assignment
    
	DPHASE_EN <= s_dphase_en;
	DPHASE <= s_dphase;
    AMPLITUDE <= s_ampl(9 downto 0);

	PRDATA <= s_dout;
	PREADY <= '1';
	PSLVERR <= '0';

    I <= s_i;
    Q <= s_q;
    MUX_SEL <= s_mux(1 downto 0);

end Behavioral;


------------------------------------------------------------------------------
--                            Register description                          --
------------------------------------------------------------------------------
--
-- Control register (CTRL)
-- Address offset: 0x00
-- 
-- 31                                                               1    0
-- +-------------------------------------------------------------------------+
-- |                             RESERVED                            | START |
-- +-------------------------------------------------------------------------+
-- |                                                                 |   W   |
-- +-------------------------------------------------------------------------+
--
-- Bits 31:1 Reserved
-- Bit     0 START bit - Setting this bit initiates a transmission
--
------------------------------------------------------------------------------
--
-- Status register (STAT)
-- Address offset: 0x04
-- 
-- 31                                                               1    0
-- +-------------------------------------------------------------------------+
-- |                             RESERVED                            | BUSY  |
-- +-------------------------------------------------------------------------+
-- |                                                                 |   W   |
-- +-------------------------------------------------------------------------+
--
-- Bits 31:1 Reserved
-- Bit     0 BUSY bit - This flag indicates if a transmission is in progress
--                      Register write operations should be performed only
--                      when this flag is cleared
--
------------------------------------------------------------------------------
--
-- Baud rate register (BAUD)
-- Address offset: 0x08
-- 
-- 31                                                                        0
-- +-------------------------------------------------------------------------+
-- |                                 BAUD                                    |
-- +-------------------------------------------------------------------------+
-- |                                  R/W                                    |
-- +-------------------------------------------------------------------------+
--
-- Bits 31:0 BAUD bits - The value of this register determines the baud rate
--                     - Calculation:
--                                       F_FAB_CLK
--                               BAUD = -----------
--                                        F_BAUD
-- 
------------------------------------------------------------------------------
--
-- Delta-phase low register (DPLO)
-- Address offset: 0x0C
-- 
-- 31                                                                        0
-- +-------------------------------------------------------------------------+
-- |                                 DPLO                                    |
-- +-------------------------------------------------------------------------+
-- |                                  R/W                                    |
-- +-------------------------------------------------------------------------+
--
-- Bits 31:0 DPLO bits - The value of the delta-phase low register determines
--                       the low-side transit frequency (e.g. frequency
--                       corresponding to '0' bits in the DATA register)
--                     - Calculation:
--                                                     F_LOW
--                       DPLO = 2^DCO_PHASE_WIDTH x -----------
--                                                   F_FAB_CLK
-- 
------------------------------------------------------------------------------
--
-- Delta-phase low register (DPHI)
-- Address offset: 0x10
-- 
-- 31                                                                        0
-- +-------------------------------------------------------------------------+
-- |                                 DPHI                                    |
-- +-------------------------------------------------------------------------+
-- |                                  R/W                                    |
-- +-------------------------------------------------------------------------+
--
-- Bits 31:0 DPLO bits - The value of the delta-phase high register determines
--                       the high-side transit frequency (e.g. frequency
--                       corresponding to '1' bits in the DATA register)
--                     - Calculation:
--                                                     F_HIGH
--                       DPHI = 2^DCO_PHASE_WIDTH x -----------
--                                                   F_FAB_CLK
-- 
------------------------------------------------------------------------------
--
-- Data register (DATA)
-- Address offset: 0x30
-- 
-- 31                                                                        0
-- +-------------------------------------------------------------------------+
-- |                                 DATA                                    |
-- +-------------------------------------------------------------------------+
-- |                                  R/W                                    |
-- +-------------------------------------------------------------------------+
--
-- Bits 31:0 DPLO bits - The [DATA_LENGTH]-bit data to be transmitted using FSK
--
------------------------------------------------------------------------------

