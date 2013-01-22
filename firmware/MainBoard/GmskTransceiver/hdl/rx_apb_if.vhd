-- RX_APB_IF.VHD
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

entity RX_APB_IF is
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

         RX_STROBE  : in  std_logic;
         RX_I       : in  std_logic_vector(9 downto 0);
         RX_Q       : in  std_logic_vector(9 downto 0);

         SFD_IRQ    : out std_logic
     );

end entity;

architecture Behavioral of RX_APB_IF is

    -- Components

    component gmsk_rx is
    port (
      clk : in std_logic;
      GlobalReset : in std_logic;
      GlobalEnable1 : in std_logic;
      RX_Q : in std_logic_vector(9 downto 0); -- sfix10_En9
      RX_I : in std_logic_vector(9 downto 0); -- sfix10_En9
      Port_Out : out std_logic -- ufix1
    );
    end component;

    component gmsk_sync is
    port (
      clkDiv8 : in std_logic;
      clk : in std_logic;
      GlobalReset : in std_logic;
      GlobalEnable8 : in std_logic;
      GlobalEnable1 : in std_logic;
      sync_rst : in std_logic; -- ufix1
      bit_valid_reg : out std_logic; -- ufix1
      bit_out_reg : out std_logic; -- ufix1
      bit_in_reg : in std_logic -- ufix1
    );
    end component;
    
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
        AEMPTY  : out std_logic;
        AFULL   : out std_logic
    );
    end component;


    -- Constants

    constant c_PAYLOAD_LENGTH   : integer := 4; -- bytes
    constant c_DATA_LENGTH      : integer := 8;

    constant c_BAUD_DIV : integer := 8;     -- Samples per symbol in the modulator 
    constant c_TICK_DIV : integer := 12;   -- Length of the symbol in ticks


	-- Addresses
	constant c_ADDR_CTRL : std_logic_vector(7 downto 0) := x"00"; -- R
	constant c_ADDR_FIFO : std_logic_vector(7 downto 0) := x"04"; -- R


	-- Signals

    signal rst              : std_logic;
    alias  clk              : std_logic is PCLK;

    signal s_dout           : std_logic_vector(7 downto 0);
    signal s_pready         : std_logic;

    signal s_data_buffer    : std_logic_vector(c_DATA_LENGTH-1 downto 0);
    signal s_bit_ctr        : unsigned(5 downto 0);
    signal s_rx_byte_valid  : std_logic;

    signal s_payload_ctr    : unsigned(5 downto 0);
    signal s_payload_ctr_next    : unsigned(5 downto 0);

    signal s_rx_fifo_in     : std_logic_vector(7 downto 0);
    signal s_rx_fifo_out    : std_logic_vector(7 downto 0);
    signal s_rx_fifo_wr     : std_logic;
    signal s_rx_fifo_rd     : std_logic;
    signal s_rx_fifo_fetch  : std_logic;
    signal s_rx_fifo_fetch_prev : std_logic;
    signal s_rx_fifo_full   : std_logic;
    signal s_rx_fifo_empty  : std_logic;

    signal s_sync_rst           : std_logic;
    signal s_sync_rst_next      : std_logic;
    signal s_gmsk_rx_out        : std_logic;
    signal s_rx_symbol          : std_logic;
    signal s_rx_symbol_valid    : std_logic;
    signal s_rx_symbol_valid_prev    : std_logic;
    signal s_tick_ctr           : unsigned(3 downto 0);
    signal s_rx_strobe          : std_logic;
    signal s_rx_strobe_ctr      : unsigned(3 downto 0);
    signal s_rx_strobe_div8     : std_logic;

    type rx_state_t is (
        st_IDLE,
        st_RX_PAYLOAD,
        st_RX_CRC,
        st_CHECK_CRC
    );

    signal s_rx_state      : rx_state_t := st_IDLE;
    signal s_rx_state_next : rx_state_t;

    signal s_sfd_irq        : std_logic;


begin

    rst <= not PRESETn;

    -- Port maps

    u_GMSK_RX : gmsk_rx
    port map (
      clk => clk,
      GlobalReset => rst,
      GlobalEnable1 => RX_STROBE,
      RX_Q =>  RX_Q,
      RX_I =>  RX_I,
      Port_Out => s_gmsk_rx_out
    );

    u_GMSK_SYNC : gmsk_sync
    port map (
      clkDiv8 => clk,
      clk => clk,
      GlobalReset => rst,
      GlobalEnable8 => s_rx_strobe_div8,
      GlobalEnable1 => RX_STROBE,
      sync_rst => s_sync_rst,
      bit_valid_reg => s_rx_symbol_valid,
      bit_out_reg => s_rx_symbol,
      bit_in_reg => s_gmsk_rx_out
    );

    u_RX_FIFO : FIFO_512x8
    generic map (
        g_AFULL  => 8, -- FIXME: value set for debugging only
    	g_AEMPTY => 4  -- FIXME: value set for debugging only
    )
    port map (
    	RESET   => rst,
    	DATA    => s_rx_fifo_in,
    	Q       => s_rx_fifo_out,
    	WCLOCK  => clk,
    	WE      => s_rx_fifo_wr,
    	RCLOCK  => clk,
    	RE      => s_rx_fifo_rd,
    	FULL    => s_rx_fifo_full,
    	EMPTY   => s_rx_fifo_empty,
        AFULL   => open,
        AEMPTY  => open
	);

    
    -- Processes


	-- Register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
		elsif rising_edge(PCLK) then

			-- Default values

			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
                        -- TODO: clear interrupts
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
            s_pready <= '0';
            s_rx_fifo_fetch <= '0';
			s_dout <= (others => '0');
		elsif rising_edge(PCLK) then

			-- Default output
            s_pready <= '0';
            s_rx_fifo_fetch <= '0';
			s_dout <= (others => '0');

			-- Register reads
			if PWRITE = '0' and PSEL = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL => 
						s_dout <= (others => '0'); -- TODO: Define status bits
					when c_ADDR_FIFO => 
						s_dout(7 downto 0) <= s_rx_fifo_out;
                        s_rx_fifo_fetch <= '1';
                        if s_rx_fifo_fetch = '1' and s_rx_fifo_fetch_prev = '0' then
                            s_pready <= '1';
                        end if;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;

    p_FIFO_FETCH : process (rst, clk)
    begin
        if rst = '1' then
            s_rx_fifo_fetch_prev <= '0';
        elsif rising_edge(clk) then
            s_rx_fifo_fetch_prev <= s_rx_fifo_fetch;
        end if;
    end process p_FIFO_FETCH;

    s_rx_fifo_rd <= '1' when s_rx_fifo_fetch = '1' and s_rx_fifo_fetch_prev =
                    '0' else '0';


    p_BAUD_TIMER : process (rst, clk)
    begin
        if rst = '1' then
            s_rx_strobe <= '0';
            s_rx_strobe_div8 <= '0';
            s_tick_ctr <= (others => '0');
            s_rx_strobe_ctr <= (others => '0');
        elsif rising_edge(clk) then
            s_rx_strobe <= '0';
            s_rx_strobe_div8 <= '0';
            if s_tick_ctr < to_unsigned(c_TICK_DIV-1, s_tick_ctr'length) then
                s_tick_ctr <= s_tick_ctr + 1;
            else
                s_tick_ctr <= (others => '0');
                s_rx_strobe <= '1';
            end if;
            if s_rx_strobe = '1' then
                if s_rx_strobe_ctr < to_unsigned(c_BAUD_DIV-1, s_rx_strobe_ctr'length) then
                    s_rx_strobe_ctr <= s_rx_strobe_ctr + 1;
                else
                    s_rx_strobe_ctr <= (others => '0');
                    s_rx_strobe_div8 <= '1';
                end if;
            end if;
        end if;
    end process p_BAUD_TIMER;

    ---------------------------------------------------------------------------
    -- Process deserializing the incoming data stream
    -- NOTE: Time and frame synchronization is performed by the preceeding
    --       block
    ---------------------------------------------------------------------------
    p_DESERIALIZE : process (rst, clk)
    begin
        if rst = '1' then
            s_data_buffer <= (others => '0');
            s_rx_byte_valid <= '0';
            s_bit_ctr <= (others => '0');
        elsif rising_edge(clk) then
            s_rx_byte_valid <= '0';
            if s_rx_symbol_valid = '1' then
                if s_rx_strobe_div8 = '1' then
                    s_data_buffer <= s_data_buffer(s_data_buffer'high-1 downto 0)
                                     & s_rx_symbol;
                    if s_bit_ctr < c_DATA_LENGTH-1 then
                        s_bit_ctr <= s_bit_ctr + 1;
                    else
                        s_rx_byte_valid <= '1';
                        s_bit_ctr <= (others => '0');
                    end if;
                end if;
            else
                s_bit_ctr <= (others => '0');
            end if;
        end if;
    end process p_DESERIALIZE;

    s_rx_fifo_in <= s_data_buffer;

    p_RECEIVE_SYNC_RST : process (rst, clk)
    begin
        if rst = '1' then
            s_sync_rst <= '1';
        elsif rising_edge(clk) then
            if s_sync_rst_next = '1' then
                s_sync_rst <= '1';
            end if;
            if s_rx_strobe_div8 = '1' then
                s_sync_rst <= '0';
            end if;
        end if;
    end process p_RECEIVE_SYNC_RST;


    p_RECEIVE_FSM_SYNC : process (rst, clk)
    begin
        if rst = '1' then
            s_rx_state <= st_IDLE;
            s_payload_ctr <= (others => '0');
            s_rx_symbol_valid_prev <= '0';
        elsif rising_edge(clk) then
            s_rx_state <= s_rx_state_next;
            s_payload_ctr <= s_payload_ctr_next;
            s_rx_symbol_valid_prev <= s_rx_symbol_valid;
        end if;
    end process p_RECEIVE_FSM_SYNC;




    p_RECEIVE_FSM_COMB : process (
        s_rx_state,
        s_rx_byte_valid,
        s_payload_ctr
    )
    begin
        -- Default assignments
        s_rx_state_next <= s_rx_state;
        s_rx_fifo_wr <= '0'; -- FIXME: add register
        s_sync_rst_next <= '0';

        -- Next state and output logic
        case s_rx_state is

            when st_IDLE =>
                s_payload_ctr_next <= (others => '0');
                if s_rx_byte_valid = '1' then
                    s_rx_fifo_wr <= '1';
                    s_payload_ctr_next <= to_unsigned(1, s_payload_ctr_next'length);
                    s_rx_state_next <= st_RX_PAYLOAD;
                end if;

            when st_RX_PAYLOAD =>
                if s_rx_byte_valid = '1' then
                    s_rx_fifo_wr <= '1';
                    if s_payload_ctr < c_PAYLOAD_LENGTH-1 then
                        s_payload_ctr_next <= s_payload_ctr + 1;
                    else
                        s_rx_state_next <= st_RX_CRC;
                        s_payload_ctr_next <= (others => '0');
                    end if;
                end if;

            when st_RX_CRC =>
                -- NOTE: Receive CRC state is not implemented yet
                s_sync_rst_next <= '1';
                s_rx_state_next <= st_CHECK_CRC;

            when st_CHECK_CRC =>
                -- NOTE: CHECK CRC state is not implemented yet
                s_rx_state_next <= st_IDLE;

            when others =>
                null;

        end case;

    end process P_RECEIVE_FSM_COMB;


    -- Output assignment

    s_sfd_irq <= '1' when s_rx_symbol_valid_prev = '0' and s_rx_symbol_valid = '1' else '0';

	PRDATA <= x"000000" & s_dout;
	PREADY <= s_pready;
	PSLVERR <= '0';

end Behavioral;
