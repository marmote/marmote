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

         -- FIXME: clean up this interface
         EN_DIV10    : out std_logic;
         EN_DIV20    : out std_logic;
         TX_STROBE  : out std_logic;

--         TX_D       : out std_logic_vector(1 downto 0);

         TX_D       : out std_logic;

         TX_EN      : out std_logic
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

    type SFD_t is array (0 to 2) of std_logic_vector(7 downto 0);
    constant c_SFD  : SFD_t := (x"70", x"EE", x"D2");

    constant c_PREAMBLE  : std_logic_vector(7 downto 0) := x"FF"; -- Preamble
    constant c_PREAMBLE_LENGTH  : integer := 4; -- in bytes

    constant c_PAYLOAD_LENGTH   : integer := 4; -- bytes -- FIXME

--    constant c_DEC_DIV  : integer := 10;    
    constant c_DEC_DIV  : integer := 20;    
    constant c_BAUD_DIV : integer := 1*c_DEC_DIV/2;     -- Samples per symbol in the modulator 

    constant c_TX_ZERO  : std_logic_vector(9 downto 0)  := "00" & x"00";    --  0
--    constant c_TXD_HIGH : std_logic_vector(1 downto 0) := "01"; -- +1
--    constant c_TXD_LOW  : std_logic_vector(1 downto 0) := "11"; -- -1
    constant c_TXD_HIGH : std_logic := '1';
    constant c_TXD_LOW  : std_logic := '0';

	-- Addresses
	constant c_ADDR_CTRL : std_logic_vector(7 downto 0) := x"00"; -- W (START)
	constant c_ADDR_FIFO : std_logic_vector(7 downto 0) := x"04"; -- W
	constant c_ADDR_PREAMBLE : std_logic_vector(7 downto 0) := x"08"; -- R/W
	constant c_ADDR_MOD_MUX : std_logic_vector(7 downto 0) := x"0C"; -- R/W

	-- Default values


	-- Registers
	signal s_status      : std_logic_vector(31 downto 0);

    -- Arbiter SM
    type tx_state_t is (
        st_IDLE,
        st_PREAMBLE,
        st_SFD,
        st_PAYLOAD,
        st_CRC
    );

	-- Signals

    signal rst              : std_logic;
    alias  clk              : std_logic is PCLK;

    signal s_tx_state       : tx_state_t; --:= st_IDLE;
    signal s_tx_state_next  : tx_state_t;

    signal s_test           : std_logic_vector(7 downto 0);

--    signal s_mod_rst    : std_logic;

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

	signal s_buffer        : std_logic_vector(7 downto 0);
	signal s_buffer_next   : std_logic_vector(7 downto 0);

	signal s_payload_length        : unsigned(7 downto 0);
	signal s_payload_length_next   : unsigned(7 downto 0);

	signal s_start          : std_logic;
	signal s_busy           : std_logic;
--    signal s_mod_in         : std_logic_vector(1 downto 0);
    signal s_mod_in         : std_logic;
--    signal s_txd            : std_logic_vector(1 downto 0);
    signal s_txd            : std_logic;
    signal s_mod_en         : std_logic;
    signal s_tx_en          : std_logic;
    signal s_tx_en_prev    : std_logic; -- For an additional tx_strobe
    signal s_mod_en_next    : std_logic;
    signal s_tmp            : std_logic;
    signal s_tx_done        : std_logic;

    signal s_tx_i           : std_logic_vector(9 downto 0);
    signal s_tx_q           : std_logic_vector(9 downto 0);

	signal s_dout           : std_logic_vector(31 downto 0);

	signal s_baud_ctr       : unsigned(15 downto 0);
	signal s_dec_ctr        : unsigned(15 downto 0);
	signal s_symbol_end     : std_logic;
	signal s_en_div_10      : std_logic;
	signal s_en_div_20      : std_logic;

    signal s_mod_in_mux     : std_logic_vector(1 downto 0);
    signal s_lfsr           : std_logic_vector(9 downto 0);
--    signal s_rnd            : std_logic_vector(15 downto 0);
    signal s_rnd            : std_logic;


begin

    rst <= not PRESETn;

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
	-- Baud timer
    -- Symbol time = T_FPGA_CKL * c_BAUD_DIV
	-----------------------------------------------------------------------------
	p_BAUD_TIMER : process (rst, clk)
	begin
		if rst = '1' then
			s_baud_ctr <= (others => '0');
			s_symbol_end <= '0';
            s_en_div_10 <= '0';
            s_en_div_20 <= '0';
		elsif rising_edge(clk) then
			s_symbol_end <= '0';
            s_en_div_10 <= '0';
            s_en_div_20 <= '0';

--            if s_mod_en = '1' then
            if s_mod_en = '1' or s_mod_in_mux /= "00" then -- FIXME
                -- Enable signal for the decimator
                if s_dec_ctr < to_unsigned(c_DEC_DIV-1, s_dec_ctr'length) then
                    s_dec_ctr <= s_dec_ctr + 1;
                else
                    s_dec_ctr <= (others => '0');
                end if;
--                if s_dec_ctr = to_unsigned(1, s_dec_ctr'length) then
                if s_dec_ctr mod 10 = 1 then
                    s_en_div_10 <= '1';
                end if;

                if s_dec_ctr mod 20 = 1 then
                    s_en_div_20 <= '1';
                end if;

                if s_baud_ctr < to_unsigned(c_BAUD_DIV-1, s_baud_ctr'length) then
                    s_baud_ctr <= s_baud_ctr + 1;
                else
                    s_baud_ctr <= (others => '0');
                    s_symbol_end <= '1';
                end if;
            else
                s_dec_ctr <= (others => '0');
                s_baud_ctr <= (others => '0');
            end if;
		end if;
	end process p_BAUD_TIMER;


	-----------------------------------------------------------------------------
	-- FSM coordinating the transmission (synchronous)
	-----------------------------------------------------------------------------
	p_TRANSMIT_FSM_SYNC : process (rst, clk)
	begin
		if rst = '1' then
            s_tx_state <= st_IDLE;
			s_oct_ctr <= (others => '0');
			s_bit_ctr <= (others => '0');
			s_buffer <= (others => '0');
			s_payload_length <= (others => '0');

--            s_txd <= (others => '0');
            s_txd <= '0';
            s_mod_en <= '0';
            s_tx_en_prev <= '0';
		elsif rising_edge(clk) then
            s_tx_state <= s_tx_state_next;
			s_oct_ctr <= s_oct_ctr_next;
			s_bit_ctr <= s_bit_ctr_next;
			s_buffer <= s_buffer_next;
            s_payload_length <= s_payload_length_next;

            if s_mod_en = '1' then
                if s_buffer(s_buffer'high) = '1' then
                    s_txd <= c_TXD_HIGH;
                else
                    s_txd <= c_TXD_LOW;
                end if;
            else
--                s_txd <= (others => '0');
                s_txd <= '0';
            end if;
            s_mod_en <= s_mod_en_next;
            s_tx_en_prev <= s_tx_en;
		end if;
	end process p_TRANSMIT_FSM_SYNC;



	-----------------------------------------------------------------------------
	-- FSM coordinating the transmission (combinational)
	-----------------------------------------------------------------------------
	p_TRANSMIT_FSM_COMB : process (
		s_tx_state,
		s_oct_ctr,
		s_bit_ctr,
		s_buffer,
        s_payload_length,

		s_symbol_end,
        s_tx_fifo_out,
        s_tx_fifo_empty,
        s_mod_en,
		s_start
	)
	begin
		-- Default values
        s_tx_state_next <= s_tx_state;
        s_tx_fifo_rd <= '0';
		s_bit_ctr_next <= s_bit_ctr;
		s_oct_ctr_next <= s_oct_ctr;
		s_buffer_next <= s_buffer;
        s_payload_length_next <= s_payload_length;

        s_tx_done <= '0';
        s_mod_en_next <= s_mod_en;

		case( s_tx_state ) is
			
				when st_IDLE =>
					if s_start = '1' and s_tx_fifo_aempty = '0' then
                        s_bit_ctr_next <= (others => '0');
                        s_oct_ctr_next <= (others => '0');
                        s_mod_en_next <= '1';
                        s_buffer_next <= c_PREAMBLE;
						s_tx_state_next <= st_PREAMBLE;
					end if;

				when st_PREAMBLE =>
                    if s_symbol_end = '1' then
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
                                s_bit_ctr_next <= (others => '0');
                                s_buffer_next <= c_SFD(0);
                                s_tx_state_next <= st_SFD;
                            end if;
                        end if;
                    end if;

				when st_SFD =>
                    if s_symbol_end = '1' then
                        if s_bit_ctr < 7 then
                            s_buffer_next <= s_buffer(s_buffer'high-1 downto 0) & '0';
                            s_bit_ctr_next <= s_bit_ctr + 1;
                        else
                            s_bit_ctr_next <= (others => '0');
                            if s_oct_ctr < c_SFD'length-1 then
                                s_oct_ctr_next <= s_oct_ctr + 1;
                                s_buffer_next <= c_SFD(to_integer(s_oct_ctr+1));
                            else
                                s_buffer_next <= s_tx_fifo_out;
                                s_payload_length_next <= unsigned(s_tx_fifo_out);
                                s_oct_ctr_next <= (others => '0');
                                s_tx_fifo_rd <= '1';
                                s_bit_ctr_next <= (others => '0');
                                s_tx_state_next <= st_PAYLOAD;
                            end if;
                        end if;
                    end if;

				when st_PAYLOAD =>
                    if s_symbol_end = '1' then
                        if s_bit_ctr < 7 then
                            s_buffer_next <= s_buffer(s_buffer'high-1 downto 0) & '0';
                            s_bit_ctr_next <= s_bit_ctr + 1;
                        else
                            s_bit_ctr_next <= (others => '0');
                            if s_oct_ctr < s_payload_length-1 then
                                s_tx_fifo_rd <= '1';
                            end if;
                            if s_oct_ctr < s_payload_length then
                                s_buffer_next <= s_tx_fifo_out;
                                s_oct_ctr_next <= s_oct_ctr + 1;
                            else
                                s_tx_state_next <= st_CRC;
                            end if;
                        end if;
                    end if;

				when st_CRC => 
                    -- NOTE: st_CRC not implemented yet
                    s_oct_ctr_next <= (others => '0');
                    if s_symbol_end = '1' then -- Wait for an additional symbol
                        s_tx_state_next <= st_IDLE;
                        s_tx_done <= '1';
                        s_mod_en_next <= '0';
                    end if;
			
				when others =>
			
			end case ;	

	end process p_TRANSMIT_FSM_COMB;


    p_PSEUDO_RANDOM_GENERATOR : process (rst, clk)
    begin
        if rst = '1' then
--            s_rnd <= (others => '0');
            s_rnd <= '0';
            s_lfsr <= (1 => '1', others => '0');
        elsif rising_edge(clk) then
            if s_symbol_end = '1' then
                s_lfsr <= s_lfsr(s_lfsr'high-1 downto 0) & s_lfsr(s_lfsr'high);
    --            s_lfsr(0) <= s_lfsr(s_lfsr'high) xor '0'; -- 1
                s_lfsr(5) <= s_lfsr(s_lfsr'high) xor s_lfsr(4); -- x^5
                s_lfsr(9) <= s_lfsr(s_lfsr'high) xor s_lfsr(8); -- x^9
            end if;
            if s_lfsr(9) = '1' then
                s_rnd <= c_TXD_HIGH;
            else
                s_rnd <= c_TXD_LOW;
            end if;
        end if;
    end process p_PSEUDO_RANDOM_GENERATOR;

    -- Modulator input multiplexers
    with s_mod_in_mux select
        s_mod_in <= s_txd       when "00",
                    c_TXD_LOW   when "01",
                    c_TXD_HIGH  when "10",
                    s_rnd       when others;

    with s_mod_in_mux select
        s_tx_en <= s_mod_en when "00",
                    '1'     when "01",
                    '1'     when "10",
                    '1'     when others;


    -- Output assignment

	PRDATA <= s_dout;
	PREADY <= '1'; -- WR
	PSLVERR <= '0';

    EN_DIV10  <= s_en_div_10;
    EN_DIV20  <= s_en_div_20;
    TX_STROBE <= s_tx_en or s_tx_en_prev;

    TX_EN <= s_tx_en;
    TX_D <= s_mod_in;

    TX_DONE_IRQ <= s_tx_done;

end Behavioral;
