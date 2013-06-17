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
-- Description: DSSS BPSK modulator with APB interface.
--
------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

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

         TX_DONE_IRQ : out std_logic;

         TX_EN      : out std_logic;
         TX_I       : out std_logic_vector(10 downto 0);
         TX_Q       : out std_logic_vector(10 downto 0)
     );

end entity;

architecture Behavioral of TX_APB_IF is

    -- Components

    component FIFO_512x8 is
    generic (
        g_AFULL     : integer := 496;
        g_AEMPTY    : integer := 16
    );
    port (
        DATA    : in  std_logic_vector(7 downto 0);
        Q       : out std_logic_vector(7 downto 0);
        WE      : in  std_logic;
        RE      : in  std_logic;
        WCLOCK  : in  std_logic;
        RCLOCK  : in  std_logic;
        FULL    : out std_logic;
        EMPTY   : out std_logic;
        RESET   : in  std_logic;
        AEMPTY : out   std_logic;
        AFULL  : out   std_logic
    );
    end component;

    -- Constants
    constant c_PREAMBLE         : std_logic_vector(7 downto 0) := x"00";
    constant c_PREAMBLE_LENGTH  : integer := 2; -- in bytes
    constant c_PAYLOAD_LENGTH   : integer := 2; -- in bytes

    constant c_CHIP_DIV         : integer := 10; -- Chip length in clock cycles
    constant c_SF               : integer := 4;  -- Spread factor
    constant c_SEED             : std_logic_vector(31 downto 0) := x"00000400";
    constant c_MASK             : std_logic_vector(31 downto 0) := x"00000402";

    constant c_TX_HIGH          : std_logic_vector(10 downto 0) := "010" & x"00";
    constant c_TX_LOW           : std_logic_vector(10 downto 0) := "110" & x"00";

	-- Addresses
	constant c_ADDR_CTRL        : std_logic_vector(7 downto 0) := x"00"; -- W (START)
	constant c_ADDR_FIFO        : std_logic_vector(7 downto 0) := x"04"; -- W
	constant c_ADDR_PREAMBLE    : std_logic_vector(7 downto 0) := x"08"; -- R/W
	constant c_ADDR_MOD_MUX     : std_logic_vector(7 downto 0) := x"0C"; -- R/W

	-- Default values


	-- Registers
	signal s_status      : std_logic_vector(31 downto 0);

    -- Arbiter SM
    type tx_state_t is (
        st_IDLE,
        st_PREAMBLE,
        st_PAYLOAD,
        st_WAIT
    );

	-- Signals

    signal rst              : std_logic;
    alias  clk              : std_logic is PCLK;

    signal s_tx_state       : tx_state_t; --:= st_IDLE;
    signal s_tx_state_next  : tx_state_t;

    signal s_test           : std_logic_vector(7 downto 0);

	signal s_oct_ctr        : unsigned(7 downto 0);
	signal s_oct_ctr_next   : unsigned(7 downto 0);
	signal s_bit_ctr        : unsigned(3 downto 0);
	signal s_bit_ctr_next   : unsigned(3 downto 0);

    signal s_tx_fifo_in     : std_logic_vector(7 downto 0);
    signal s_tx_fifo_out    : std_logic_vector(7 downto 0);
    signal s_tx_fifo_wr     : std_logic;
    signal s_tx_fifo_rd     : std_logic;
    signal s_tx_fifo_full   : std_logic;
    signal s_tx_fifo_empty  : std_logic;
    signal s_tx_fifo_aempty : std_logic;

	signal s_buffer         : std_logic_vector(7 downto 0);
	signal s_buffer_next    : std_logic_vector(7 downto 0);

	signal s_start          : std_logic;
    signal s_tx_done        : std_logic;
	signal s_chip_ctr       : unsigned(15 downto 0);
	signal s_chip_end       : std_logic;
	signal s_sym_ctr        : unsigned(15 downto 0);
	signal s_sym_end        : std_logic;
	signal s_tx_en          : std_logic;
	signal s_tx_en_next     : std_logic;

    signal s_mod_in_mux     : std_logic_vector(1 downto 0);
    signal s_busy           : std_logic;

    signal s_lfsr           : std_logic_vector(31 downto 0);
    signal s_pn_seq         : std_logic;

    signal s_tx_i           : std_logic_vector(10 downto 0);
    signal s_tx_q           : std_logic_vector(10 downto 0);

	signal s_dout           : std_logic_vector(31 downto 0);


begin

    rst <= not PRESETn;

    assert c_PAYLOAD_LENGTH >= 2
    report "ERROR: payload length should be at least 2"
    severity failure;

    -- Port maps

    u_TX_FIFO : FIFO_512x8
    generic map (
        g_AFULL  => 496,
        g_AEMPTY => 2
    )
    port map (
    	RESET   => rst,
    	DATA    => s_tx_fifo_in,
    	Q       => s_tx_fifo_out,
	    WCLOCK  => clk,
    	WE      => s_tx_fifo_wr,
    	RCLOCK  => clk,
    	RE      => s_tx_fifo_rd,
    	FULL    => s_tx_fifo_full,
    	EMPTY   => s_tx_fifo_empty,
        AFULL   => open,
        AEMPTY  => s_tx_fifo_aempty
	);

    
    -- Processes

	-- Register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_start <= '0';
            s_tx_fifo_in <= (others => '0');
            s_tx_fifo_wr <= '0';
            s_test <= (others => '0');
            s_mod_in_mux <= (others => '0');
		elsif rising_edge(PCLK) then

			-- Default values
			s_start <= '0';
            s_tx_fifo_wr <= '0';

			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Initiate transmission
                        s_start <= PWDATA(0);
					when c_ADDR_FIFO =>
						s_tx_fifo_in <= PWDATA(7 downto 0);
                        s_tx_fifo_wr <= '1';
					when c_ADDR_PREAMBLE =>
                        s_test <= PWDATA(7 downto 0);
					when c_ADDR_MOD_MUX =>
                        s_mod_in_mux <= PWDATA(1 downto 0);
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
                    -- Status
					when c_ADDR_CTRL => 
						s_dout <= s_status;
					when c_ADDR_PREAMBLE => 
						s_dout(7 downto 0) <= s_test;
					when c_ADDR_MOD_MUX =>
						s_dout(1 downto 0) <= s_mod_in_mux;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;

	s_status <= x"0000000" & s_tx_fifo_full & s_tx_fifo_aempty & s_tx_fifo_empty & s_busy;
    s_busy <= '0' when s_tx_state = st_IDLE else '1';


	-----------------------------------------------------------------------------
	-- FSM coordinating the transmission (synchronous)
	-----------------------------------------------------------------------------
	p_TRANSMIT_FSM_SYNC : process (rst, clk)
	begin
		if rst = '1' then
            s_tx_state <= st_IDLE;
            s_tx_en <= '0';
			s_oct_ctr <= (others => '0');
			s_bit_ctr <= (others => '0');
			s_buffer <= (others => '0');
            s_tx_i <= (others => '0');
            s_tx_q <= (others => '0');
		elsif rising_edge(clk) then
            s_tx_state <= s_tx_state_next;
            s_tx_en <= s_tx_en_next;
			s_oct_ctr <= s_oct_ctr_next;
			s_bit_ctr <= s_bit_ctr_next;
			s_buffer <= s_buffer_next;

            if s_tx_en = '1' then
                if (s_buffer(s_buffer'high) xor s_pn_seq) = '1' then
                    s_tx_i <= c_TX_HIGH;
                else
                    s_tx_i <= c_TX_LOW;
                end if;
            else
                s_tx_i <= (others => '0');
            end if;
            s_tx_q <= (others => '0'); -- not used for BPSK
		end if;
	end process p_TRANSMIT_FSM_SYNC;



	-----------------------------------------------------------------------------
	-- FSM coordinating the transmission (combinational)
	-----------------------------------------------------------------------------
	p_TRANSMIT_FSM_COMB : process (
		s_tx_state,
		s_oct_ctr,
		s_bit_ctr,
        s_tx_en,
		s_buffer,

		s_sym_end,
        s_tx_fifo_out,
        s_tx_fifo_empty,
		s_start
	)
	begin
		-- Default values
        s_tx_state_next <= s_tx_state;
        s_tx_fifo_rd <= '0';
        s_tx_en_next <= s_tx_en;
		s_bit_ctr_next <= s_bit_ctr;
		s_oct_ctr_next <= s_oct_ctr;
		s_buffer_next <= s_buffer;

        s_tx_done <= '0';

		case (s_tx_state) is
			
				when st_IDLE =>
					if s_start = '1' and s_tx_fifo_aempty = '0' then
                        s_tx_en_next <= '1';
                        s_bit_ctr_next <= (others => '0');
                        s_oct_ctr_next <= (others => '0');
                        s_tx_fifo_rd <= '1'; -- Fetch FIFO data
                        s_buffer_next <= c_PREAMBLE;
						s_tx_state_next <= st_PREAMBLE;
					end if;

				when st_PREAMBLE =>
                    if s_sym_end = '1' then
                        if s_bit_ctr < 7 then
                            s_bit_ctr_next <= s_bit_ctr + 1;
                            s_buffer_next <= s_buffer(s_buffer'high-1 downto 0) & '0';
                        else
                            s_bit_ctr_next <= (others => '0');
                            if s_oct_ctr < c_PREAMBLE_LENGTH-1 then
                                s_oct_ctr_next <= s_oct_ctr + 1;
                                s_buffer_next <= c_PREAMBLE;
                            else
                                s_tx_fifo_rd <= '1'; -- Fetch FIFO data
                                s_oct_ctr_next <= (others => '0');
                                s_buffer_next <= s_tx_fifo_out;
                                s_tx_state_next <= st_PAYLOAD;
                            end if;
                        end if;
                    end if;

				when st_PAYLOAD =>
                    if s_sym_end = '1' then
                        if s_bit_ctr < 7 then
                            s_buffer_next <= s_buffer(s_buffer'high-1 downto 0) & '0';
                            s_bit_ctr_next <= s_bit_ctr + 1;
                        else
                            s_bit_ctr_next <= (others => '0');
                            if s_oct_ctr < c_payload_length-2 then
                                s_tx_fifo_rd <= '1'; -- Fetch FIFO data
                            end if;
                            if s_oct_ctr < c_payload_length-1 then
                                s_buffer_next <= s_tx_fifo_out;
                                s_oct_ctr_next <= s_oct_ctr + 1;
                            else
                                s_tx_state_next <= st_WAIT;
                            end if;
                        end if;
                    end if;

				when st_WAIT => 
                    -- TODO: implement st_CRC instead of st_WAIT
                    s_oct_ctr_next <= (others => '0');
                    if s_sym_end = '1' then -- Wait for one additional symbol
                        s_tx_en_next <= '0';
                        s_tx_state_next <= st_IDLE;
                        s_tx_done <= '1';
                    end if;
			
				when others =>
			
			end case ;	

	end process p_TRANSMIT_FSM_COMB;

	-----------------------------------------------------------------------------
	-- Chip timer
    --
    -- - chip time = FPGA clock period * c_CHIP_DIV
    -- - symbol time = chip time * c_SF
	-----------------------------------------------------------------------------
	p_CHIP_TIMER : process (rst, clk)
	begin
		if rst = '1' then
			s_chip_ctr <= (others => '0');
			s_chip_end <= '0';
            s_sym_ctr <= (others => '0');
            s_sym_end <= '0';
		elsif rising_edge(clk) then
            -- Chip
            s_chip_ctr <= (others => '0');
			s_chip_end <= '0';
            if s_tx_en = '1' then
                if s_chip_ctr < to_unsigned(c_CHIP_DIV-1, s_chip_ctr'length) then
                    s_chip_ctr <= s_chip_ctr + 1;
                else
                    s_chip_ctr <= (others => '0');
                    s_chip_end <= '1';
                end if;
            end if;

            -- Symbol
            s_sym_end <= '0';
            if s_tx_en = '0' then
                s_sym_ctr <= (others => '0');
            elsif s_chip_end = '1' then
                if s_sym_ctr < to_unsigned(c_SF-1, s_sym_ctr'length) then
                    s_sym_ctr <= s_sym_ctr + 1;
                else
                    s_sym_ctr <= (others => '0');
                    s_sym_end <= '1';
                end if;
            end if;
		end if;
	end process p_CHIP_TIMER;


	-----------------------------------------------------------------------------
	-- PN sequence generator
	-----------------------------------------------------------------------------
    p_PN_GENERATOR : process (rst, clk)
    begin
        if rst = '1' then
            s_lfsr <= c_SEED;
            s_pn_seq <= '0';
        elsif rising_edge(clk) then
            if s_tx_en = '0' then
                s_lfsr <= c_SEED;
            elsif s_chip_end = '1' then
                if s_lfsr(0) = '1' then
                    s_lfsr <= '0' & s_lfsr(s_lfsr'high downto 1);
                else
                    s_lfsr <= '0' & s_lfsr(s_lfsr'high downto 1) xor c_MASK;
                end if;
            end if;
            s_pn_seq <= s_lfsr(0);
        end if;
    end process p_PN_GENERATOR;

    -- Output assignment

	PRDATA <= s_dout;
	PREADY <= '1'; -- WR
	PSLVERR <= '0';

    TX_EN <= s_tx_en;
    TX_I <= s_tx_i;
    TX_Q <= s_tx_q;

    TX_DONE_IRQ <= s_tx_done;

end Behavioral;
