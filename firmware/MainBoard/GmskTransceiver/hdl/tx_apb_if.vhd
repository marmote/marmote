-- TX_APB_IF.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.1 SP2
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
--
-- Description: APB interface to test the Marmote platform TX path.
--
------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.common.all;

entity TX_APB_IF is
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

         TX_STROBE  : out std_logic;
         TX_I       : out std_logic_vector(9 downto 0);
         TX_Q       : out std_logic_vector(9 downto 0);
    
         -- Debug interface
         LED_H   : out std_logic;
         LED_L   : out std_logic
		 );
end entity;

architecture Behavioral of TX_APB_IF is

    -- Constants
    constant c_DATA_LENGTH : integer := 8;

	-- Addresses
	constant c_ADDR_CTRL : std_logic_vector(7 downto 0) := x"00"; -- W (START)
	constant c_ADDR_DATA : std_logic_vector(7 downto 0) := x"04"; -- W

	-- Default values


	-- Registers
	signal s_status      : std_logic_vector(31 downto 0);
	signal s_data        : std_logic_vector(31 downto 0);


	-- Signals
	signal s_bit_ctr        : std_logic_vector(c_DATA_LENGTH-1 downto 0);
	signal s_bit_ctr_next   : std_logic_vector(c_DATA_LENGTH-1 downto 0);
	signal s_data_buffer    : std_logic_vector(c_DATA_LENGTH-1 downto 0);
	signal s_data_buffer_next : std_logic_vector(c_DATA_LENGTH-1 downto 0);

	signal s_busy           : std_logic;
	signal s_tx_fifo_full   : std_logic;

	signal s_symbol_ctr     : unsigned(31 downto 0);
	signal s_symbol_end     : std_logic;

begin

	-- Register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_start <= '0';
		elsif rising_edge(PCLK) then

			-- Default values
			s_start <= '0';

			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Initiate FSK transmission
						s_start <= PWDATA(0);
					when c_ADDR_DATA =>
						s_data <= PWDATA;
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
					when c_ADDR_CTRL => 
						s_dout <= s_status;
					when c_ADDR_DATA =>
						s_dout <= s_data;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;

	s_status <= x"0000000" & "00" & s_tx_fifo_full & s_busy;

	-----------------------------------------------------------------------------
	-- Symbol timer
	-----------------------------------------------------------------------------
	p_baud_timer : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_symbol_ctr <= (others => '0');
			s_symbol_end <= '0';
		elsif rising_edge(PCLK) then
			s_symbol_end <= '0';
			if s_busy = '1' then
				if s_symbol_ctr < unsigned(s_baud) then
					s_symbol_ctr <= s_symbol_ctr + 1;
				else
					s_symbol_ctr <= (others => '0');
					s_symbol_end <= '1';
				end if;
			end if;
		end if;
	end process p_baud_timer;


	-----------------------------------------------------------------------------
	-- One-hot encoded FSM coordinating FSK transmission (combinational)
	-----------------------------------------------------------------------------
	p_FSK_TRANSMIT_FSM_COMB : process (
		s_bit_ctr,
		s_busy,
		s_symbol_end,
		s_data,
		s_data_buffer,
		s_start
	)
	begin
		-- Default values
		s_busy <= '0';
		s_bit_ctr_next <= s_bit_ctr;
		s_data_buffer_next <= s_data_buffer;

		if s_bit_ctr /= std_logic_vector(to_unsigned(0,s_bit_ctr'length)) then
			s_busy <= '1';
		end if;

		if s_busy /= '1' then
			-- Start transmission on 's_start'
			if s_start = '1' then
				s_bit_ctr_next(0) <= '1'; -- Load LSB with '1'
				s_data_buffer_next <= s_data(c_DATA_LENGTH-1 downto 0);
			end if;
		else
			-- Step bits based on baud timing
			if s_symbol_end = '1' then
				if s_bit_ctr(c_DATA_LENGTH-1) = '1' then
					s_bit_ctr_next <= (others => '0');
					s_data_buffer_next <= (others => '0');
				else
					s_bit_ctr_next <= s_bit_ctr(s_bit_ctr'high-1 downto 0) & '0';
					s_data_buffer_next <= s_data_buffer(s_data_buffer'high-1 downto 0) & '0';
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
			s_bit_ctr <= (others => '0');
			s_data_buffer <= (others => '0');
            s_txd <= (others => '0');
			s_txd_en <= '0';
		elsif rising_edge(PCLK) then
			s_bit_ctr <= s_bit_ctr_next;
			s_data_buffer <= s_data_buffer_next;
            s_txd <= s_txd_next;
			s_txd_en <= s_busy; -- Delay-adjusted to 'led_low/led_high'
		end if;
	end process p_FSK_TRANSMIT_FSM_SYNC;

	p_LED_MUX : process (
		s_busy,
		s_data_buffer
	)
	begin
		-- Default values
		s_led_high <= '0';
		s_led_low  <= '0';

		if s_busy = '1' then
			-- Use s_data_buffer MSB as MUX input
			if s_data_buffer(s_data_buffer'high) = '1' then
				s_txd_next <= c_TXD_HIGH;
                s_led_high <= '1';
			else
				s_txd_next <= c_TXD_LOW;
                s_led_low  <= '1';
			end if;
		end if;
	end process p_LED_MUX;


    -- Output assignment

	PRDATA <= s_dout;
	PREADY <= '1'; -- WR
	PSLVERR <= '0';

    LED_H <= s_led_high;
    LED_L <= s_led_low;

end Behavioral;
