-- AGC.VHD
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
-- Description: Automatic gain control for Marmote SDR based on the design
--              of Ye-Sheng Kuo.
--
------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AGC is
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

         -- Gain control inteface
--         AGC_EN     : in  std_logic;

         RX_I       : in  std_logic_vector(9 downto 0);
         RX_Q       : in  std_logic_vector(9 downto 0);
         RX_STROBE  : in  std_logic;

--         VGA_GAIN : out std_logic_vector(5 downto 0);

         AGC_IRQ : out std_logic
     );

end entity;

architecture Behavioral of AGC is

    -- Components

    -- Constants

    constant c_THRESHOLD_HIGH   : unsigned(7 downto 0) := to_unsigned(155, 8);
    constant c_THRESHOLD_LOW    : unsigned(7 downto 0) := to_unsigned( 50, 8);
    constant c_RSSI_CTR_MAX     : unsigned(4 downto 0) := to_unsigned( 31, 8);

	-- Addresses
	constant c_ADDR_CTRL : std_logic_vector(7 downto 0) := x"00"; -- W (START)

	-- Default values


    -- Gain control SM
    type agc_state_t is (
        st_IDLE,
        st_RSSI_SUM,
        st_GAIN_UPDATE
    );

    type agc_table_t is array (0 to 7) of std_logic_vector(6 downto 0);

	-- Signals

    signal rst              : std_logic;
    alias  clk              : std_logic is PCLK;

    signal s_agc_state      : agc_state_t := st_IDLE;
    signal s_agc_state_next : agc_state_t;

    signal s_agc_en         : std_logic;

    signal s_agc_table      : agc_table_t :=
    (
        "01" & "00100",
        "01" & "01000",
        "01" & "01100",
        "01" & "10000",
        "01" & "10100",
        "01" & "11000",
        "01" & "11100",
        "01" & "11111"
    );

    signal s_agc_irq        : std_logic;
    signal s_agc_irq_next   : std_logic;
    signal s_dout           : std_logic_vector(31 downto 0);
    signal s_rssi           : signed(19 downto 0);
    signal s_gain_idx       : unsigned(2 downto 0);
    signal s_gain_idx_next  : unsigned(2 downto 0);
    signal s_rssi_ctr       : unsigned(5 downto 0);
    signal s_rssi_ctr_next  : unsigned(5 downto 0);
    signal s_rssi_sum       : unsigned(15 downto 0); -- Revise widths
    signal s_rssi_sum_next  : unsigned(15 downto 0); -- Revise widths

begin

    rst <= not PRESETn;

    -- Processes

	-- Register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_agc_en <= '0';
		elsif rising_edge(PCLK) then

			-- Default values
			s_agc_en <= '0';

			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
                        s_agc_en <= PWDATA(0);
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
						s_dout(0) <= s_agc_en;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;

    p_RSSI : process (rst, clk)
    begin
        if rst = '1' then
            s_rssi <= (others => '0');
        elsif rising_edge(clk) then
            if RX_STROBE = '1' then
                s_rssi <= signed(RX_I) * signed(RX_Q);
            end if;
        end if;
    end process p_RSSI;


	-----------------------------------------------------------------------------
	-- FSM coordinating the receiver gain control (synchronous)
	-----------------------------------------------------------------------------
	p_AGC_FSM_SYNC : process (rst, clk)
	begin
		if rst = '1' then
            s_agc_state <= st_IDLE;
		elsif rising_edge(clk) then
            s_agc_state <= s_agc_state_next;
		end if;
	end process p_AGC_FSM_SYNC;


	-----------------------------------------------------------------------------
	-- FSM coordinating the receiver gain control (combinational)
	-----------------------------------------------------------------------------
	p_AGC_FSM_COMB : process (
		s_agc_state,
        s_agc_en,
        s_rssi_ctr,
        s_rssi_sum,
        s_gain_idx
	)
	begin
		-- Default values
        s_agc_state_next <= s_agc_state;
        s_gain_idx_next <= s_gain_idx;
        s_rssi_ctr_next <= s_rssi_ctr;
        s_rssi_sum_next <= s_rssi_sum;
        s_agc_irq_next <= '0';

		case( s_agc_state ) is
			
				when st_IDLE =>
                    s_rssi_sum_next <= (others => '0');
                    s_rssi_ctr_next <= (others => '0');
                    if s_agc_en = '1' then
                        s_agc_state_next <= st_RSSI_SUM;
                    end if;

				when st_RSSI_SUM =>
                    if RX_STROBE = '1' then
                        s_rssi_sum_next <= s_rssi_sum + unsigned(s_rssi);
                        s_rssi_ctr_next <= s_rssi_ctr + 1;
                    end if;
                    if s_rssi_ctr = c_RSSI_CTR_MAX then
                        s_agc_state_next <= st_GAIN_UPDATE;
                    end if;

				when st_GAIN_UPDATE => 
                    s_agc_state_next <= st_IDLE;

                    -- Increase gain
                    if s_rssi_sum < c_THRESHOLD_LOW and s_gain_idx < 7 then
                        s_agc_irq_next <= '1';
                        s_gain_idx_next <= s_gain_idx + 1;
                        s_agc_state_next <= st_IDLE;
                    end if;

                    -- Decrease gain
                    if s_rssi_sum > c_THRESHOLD_HIGH and s_gain_idx > 0 then
                        s_agc_irq_next <= '1';
                        s_gain_idx_next <= s_gain_idx - 1;
                        s_agc_state_next <= st_IDLE;
                    end if;
			
				when others =>
			
			end case ;	

	end process p_AGC_FSM_COMB;


    -- Output assignment

	PRDATA <= s_dout;
	PREADY <= '1'; -- WR
	PSLVERR <= '0';

    AGC_IRQ <= s_agc_irq;

end Behavioral;

