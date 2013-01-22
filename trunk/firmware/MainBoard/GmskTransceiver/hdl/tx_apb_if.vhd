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

--use work.common.all;

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

         TXD         : out std_logic_vector(1 downto 0);
         TXD_STROBE  : out std_logic;

         TX_DONE_IRQ : out std_logic;

         TX_STROBE  : out std_logic;
         TX_I       : out std_logic_vector(9 downto 0);
         TX_Q       : out std_logic_vector(9 downto 0)
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

    component gmsk_tx is
    port (
        clk : in std_logic;
        GlobalReset : in std_logic;
        GlobalEnable1 : in std_logic;
        TX_Q : out std_logic_vector(9 downto 0); -- sfix10_En8
        TX_I : out std_logic_vector(9 downto 0); -- sfix10_En8
        TX_D : in std_logic_vector(15 downto 0) -- sfix16_En14
    );
    end component;


    -- Constants

    constant c_SFD  : std_logic_vector(23 downto 0) := x"70EED2";
    constant c_PAYLOAD_LENGTH   : integer := 4; -- bytes

    constant c_DATA_LENGTH : integer := 8;

    constant c_BAUD_DIV : integer := 8;     -- Samples per symbol in the modulator 
    constant c_TICK_DIV : integer := 12;   -- Length of the symbol in ticks
    constant c_TXD_HIGH : std_logic_vector(15 downto 0) := "0100" & x"000"; -- +1
    constant c_TXD_LOW  : std_logic_vector(15 downto 0) := "1100" & x"000"; -- -1

    constant c_TXD_EN_DELAY : integer := 12;

	-- Addresses
	constant c_ADDR_CTRL : std_logic_vector(7 downto 0) := x"00"; -- W (START)
	constant c_ADDR_FIFO : std_logic_vector(7 downto 0) := x"04"; -- W

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

    signal s_tx_state       : tx_state_t := st_IDLE;
    signal s_tx_state_next  : tx_state_t;

    signal s_gmsk_tx_rst    : std_logic;
    signal s_gmsk_tx_rst_next : std_logic;

	signal s_bit_ctr        : unsigned(5 downto 0);
	signal s_bit_ctr_next   : unsigned(5 downto 0);
	signal s_payload_ctr        : unsigned(c_PAYLOAD_LENGTH-1 downto 0);
	signal s_payload_ctr_next   : unsigned(c_PAYLOAD_LENGTH-1 downto 0);

    signal s_tx_fifo_in     : std_logic_vector(7 downto 0);
    signal s_tx_fifo_out    : std_logic_vector(7 downto 0);
    signal s_tx_fifo_wr     : std_logic;
    signal s_tx_fifo_rd     : std_logic;
    signal s_tx_fifo_full   : std_logic;
    signal s_tx_fifo_empty  : std_logic;
    signal s_tx_fifo_aempty : std_logic;

	signal s_buffer        : std_logic_vector(23 downto 0);
	signal s_buffer_next   : std_logic_vector(23 downto 0);

	signal s_start          : std_logic;
	signal s_busy           : std_logic;
    signal s_txd            : std_logic_vector(15 downto 0);
    signal s_txd_next       : std_logic_vector(15 downto 0);
    signal s_txd_en         : std_logic_vector(c_TXD_EN_DELAY-1 downto 0);
    signal s_mod_en         : std_logic;
    signal s_tx_done        : std_logic;

	signal s_dout           : std_logic_vector(31 downto 0);

	signal s_tick_ctr       : unsigned(15 downto 0);
	signal s_baud_ctr       : unsigned(15 downto 0);
	signal s_tx_strobe       : std_logic;
	signal s_symbol_end     : std_logic;


begin

    rst <= not PRESETn;

    -- Port maps

    u_TX_FIFO : FIFO_512x8
    generic map (
        g_AFULL  => 496,
        g_AEMPTY => c_PAYLOAD_LENGTH-1
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

    u_GMSK_TX : gmsk_tx
    port map (
        clk	            =>	clk,
        GlobalReset	    =>	s_gmsk_tx_rst,
        GlobalEnable1	=>	s_tx_strobe,
        TX_Q	        =>	TX_Q,
        TX_I	        =>	TX_I,
        TX_D	        =>	s_txd
    );

    
    -- Processes

	-- Register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_start <= '0';
            s_tx_fifo_in <= (others => '0');
            s_tx_fifo_wr <= '0';
		elsif rising_edge(PCLK) then

			-- Default values
			s_start <= '0';
            s_tx_fifo_wr <= '0';

			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Initiate transmission
                        s_start <= PWDATA(0); -- TODO: check if s_start strobe is 1 clock cycle long
					when c_ADDR_FIFO =>
						s_tx_fifo_in <= PWDATA(7 downto 0);
                        s_tx_fifo_wr <= '1';
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
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;

	s_status <= x"0000000" & "00" & s_tx_fifo_empty & s_busy;



	-----------------------------------------------------------------------------
	-- Baud timer
    -- Symbol time = T_FPGA_CKL * c_TICK_DIV * c_BAUD_DIV
	-----------------------------------------------------------------------------
	p_SYMBOL_TIMER : process (rst, clk)
	begin
		if rst = '1' then
			s_tick_ctr <= (others => '0');
			s_baud_ctr <= (others => '0');
            s_tx_strobe <= '0';
			s_symbol_end <= '0';
		elsif rising_edge(clk) then
            s_tx_strobe <= '0';
			s_symbol_end <= '0';
            if s_tx_state /= st_IDLE then -- FIXME
				if s_tick_ctr < to_unsigned(c_TICK_DIV-1, s_tick_ctr'length) then
					s_tick_ctr <= s_tick_ctr + 1;
				else
					s_tick_ctr <= (others => '0');
                    s_tx_strobe <= '1';
				end if;
			end if;
            if s_tx_strobe = '1' then
                if s_baud_ctr < to_unsigned(c_BAUD_DIV-1, s_baud_ctr'length) then
                    s_baud_ctr <= s_baud_ctr + 1;
                else
                    s_baud_ctr <= (others => '0');
                    s_symbol_end <= '1';
                end if;
            end if;
		end if;
	end process p_SYMBOL_TIMER;


	-----------------------------------------------------------------------------
	-- FSM coordinating the transmission (synchronous)
	-----------------------------------------------------------------------------
	p_TRANSMIT_FSM_SYNC : process (rst, clk)
	begin
		if rst = '1' then
			s_bit_ctr <= (others => '0');
			s_buffer <= (others => '0');
            s_txd <= (others => '0');
			s_txd_en <= (others => '0');
            s_mod_en <= '0';
            s_tx_state <= st_IDLE;
            s_payload_ctr <= (others => '0');
            s_gmsk_tx_rst <= '1';
		elsif rising_edge(clk) then
			s_bit_ctr <= s_bit_ctr_next;
			s_buffer <= s_buffer_next;
            s_txd <= s_txd_next;
			s_txd_en <= s_txd_en(s_txd_en'high-1 downto 0) & s_busy; -- Delay-adjusted to 's_txd'
            s_tx_state <= s_tx_state_next;
            s_payload_ctr <= s_payload_ctr_next;
            s_gmsk_tx_rst <= s_gmsk_tx_rst_next;
            if unsigned(s_txd_en) > 0 then
                s_mod_en <= '1';
            else
                s_mod_en <= '0';
            end if;
		end if;
	end process p_TRANSMIT_FSM_SYNC;



	-----------------------------------------------------------------------------
	-- FSM coordinating the transmission (combinational)
	-----------------------------------------------------------------------------
	p_TRANSMIT_FSM_COMB : process (
		s_tx_state,
		s_bit_ctr,
        s_payload_ctr,
		s_symbol_end,
		s_buffer,
        s_tx_fifo_out,
        s_tx_fifo_aempty,
		s_start
	)
	begin
		-- Default values
        s_payload_ctr_next <= s_payload_ctr;
        s_tx_fifo_rd <= '0';
		s_bit_ctr_next <= s_bit_ctr;
		s_buffer_next <= s_buffer;
        s_gmsk_tx_rst_next <= '0';
        s_tx_done <= '0';

		case( s_tx_state ) is
			
				when st_IDLE =>
					if s_start = '1' and s_tx_fifo_aempty = '0' then
						s_tx_state_next <= st_PREAMBLE;
                        s_tx_fifo_rd <= '1'; -- Fetch FIFO data
					end if;

				when st_PREAMBLE =>
                    -- NOTE: st_PREAMPLE not implemented yet
                    s_tx_state_next <= st_SFD;
                    s_buffer_next <= c_SFD;
                    s_bit_ctr_next <= (others => '0');

				when st_SFD =>
                    if s_symbol_end = '1' then
                        if s_bit_ctr < to_unsigned(c_SFD'length-1, s_bit_ctr'length) then
                            s_buffer_next <= s_buffer(s_buffer'high-1 downto 0) & '0';
                            s_bit_ctr_next <= s_bit_ctr + 1;
                        else
                            s_buffer_next <= (others => '0');
                            s_buffer_next(23 downto 16) <= s_tx_fifo_out;
                            s_tx_fifo_rd <= '1';
                            s_bit_ctr_next <= (others => '0');
                            s_tx_state_next <= st_PAYLOAD;
--                            s_tx_state_next <= st_CRC;
                        end if;
                    end if;

				when st_PAYLOAD =>
                    if s_symbol_end = '1' then
                        if s_bit_ctr < 7 then
                            s_buffer_next <= s_buffer(s_buffer'high-1 downto 0) & '0';
                            s_bit_ctr_next <= s_bit_ctr + 1;
                        else
                            s_bit_ctr_next <= (others => '0');
                            if s_payload_ctr < c_PAYLOAD_LENGTH-2 then
                                s_tx_fifo_rd <= '1';
                            end if;
                            if s_payload_ctr < c_PAYLOAD_LENGTH-1 then
                                s_buffer_next(23 downto 16) <= s_tx_fifo_out;
                                s_payload_ctr_next <= s_payload_ctr + 1;
                            else
                                s_tx_state_next <= st_CRC;
                            end if;
                        end if;
                    end if;

				when st_CRC => 
                    -- NOTE: st_CRC not implemented yet
                    s_payload_ctr_next <= (others => '0');
                    s_tx_state_next <= st_IDLE;
                    s_tx_done <= '1';
--                    s_gmsk_tx_rst_next <= '1';
			
				when others =>
			
			end case ;	

	end process p_TRANSMIT_FSM_COMB;


    s_busy <= '0' when s_tx_state = st_IDLE else '1';


	p_TXD_MUX : process (
		s_busy,
		s_buffer
	)
	begin
        s_txd_next <= (others => '0');
		if s_busy = '1' then
			-- Use s_buffer MSB as MUX input
			if s_buffer(s_buffer'high) = '1' then
				s_txd_next <= c_TXD_HIGH;
			else
				s_txd_next <= c_TXD_LOW;
			end if;
		end if;
	end process p_TXD_MUX;

    TXD_STROBE <= s_symbol_end;
    TXD <= s_txd(s_txd'high downto s_txd'high-1);

    -- Output assignment

	PRDATA <= s_dout;
	PREADY <= '1'; -- WR
	PSLVERR <= '0';

--    TX_STROBE <= s_txd_en(s_txd_en'high);
    TX_STROBE <= s_mod_en;

end Behavioral;
