-- TX_APB_IF.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 11.1 SP1
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
-- Description: Simple OFDM-based tone-generator using 32-point IFFT.
--
------------------------------------------------------------------------------

-- TODO: Adjustable TX GAIN (TX_NEG/TX_POS)

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TX_APB_IF is
    generic (
         -- Default values
         g_PTRN : integer := 16#01660166#;  -- subcarrier pattern FIXME: check pattern PAPR
         g_MASK : integer := 16#7FFE7FFE#;  -- subcarrier mask
         g_GAIN : integer := 0          -- amplitude gain = 2^g_GAIN
    );
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
         TX_I       : out std_logic_vector(9 downto 0);
         TX_Q       : out std_logic_vector(9 downto 0)
     );

end entity;

architecture Behavioral of TX_APB_IF is

    -- Constants

    constant c_FFT_OUT_WL   : integer := 13;
    constant c_FFT_IN_WL    : integer := 4;

    constant c_TX_POS       : std_logic_vector(c_FFT_IN_WL-1 downto 0) := "0111"; -- ~ +1
    constant c_TX_NEG       : std_logic_vector(c_FFT_IN_WL-1 downto 0) := "1001"; -- ~ -1


    -- Components
    
    component ifft_32 is
    port (
         clk : in std_logic;
         GlobalReset : in std_logic;
         VLD : out std_logic;
         RST : in std_logic;
         RDY : out std_logic;
         I_OUT : out std_logic_vector(c_FFT_OUT_WL-1 downto 0);
         Q_OUT : out std_logic_vector(c_FFT_OUT_WL-1 downto 0);
         I_IN : in std_logic_vector(c_FFT_IN_WL-1 downto 0);
         Q_IN : in std_logic_vector(c_FFT_IN_WL-1 downto 0);
         EN : in std_logic -- ufix1
    );
    end component ifft_32;

	-- Addresses

	constant c_ADDR_CTRL    : std_logic_vector(7 downto 0) := x"00"; -- W (EN)

	constant c_ADDR_PTRN    : std_logic_vector(7 downto 0) := x"10"; -- R/W
	constant c_ADDR_MASK    : std_logic_vector(7 downto 0) := x"14"; -- R/W
	constant c_ADDR_GAIN    : std_logic_vector(7 downto 0) := x"18"; -- R/W

	-- Registers

	signal s_tx_en      : std_logic;
    signal s_ptrn       : std_logic_vector(31 downto 0);
    signal s_ptrn_buf   : std_logic_vector(31 downto 0);
    signal s_mask       : std_logic_vector(31 downto 0);
    signal s_gain       : std_logic_vector(3 downto 0);

	-- Signals

    signal rst          : std_logic;
    alias  clk          : std_logic is PCLK;

    signal s_dout       : std_logic_vector(31 downto 0);
    signal s_state      : std_logic_vector(31 downto 0) := x"80000000";

    signal s_ifft_rst   : std_logic;
    signal s_ifft_en     : std_logic;
    signal s_i_in       : std_logic_vector(c_FFT_IN_WL-1 downto 0);
    signal s_q_in       : std_logic_vector(c_FFT_IN_WL-1 downto 0);
    signal s_vld        : std_logic;
    signal s_rdy        : std_logic;
    signal s_i_out      : std_logic_vector(c_FFT_OUT_WL-1 downto 0);
    signal s_q_out      : std_logic_vector(c_FFT_OUT_WL-1 downto 0);

	signal s_tx_en_out  : std_logic;
    signal s_tx_i_out   : std_logic_vector(9 downto 0);
    signal s_tx_q_out   : std_logic_vector(9 downto 0);

begin

    assert c_FFT_OUT_WL >= TX_I'length + 3
    report "c_FFT_OUT_WL >= TX_I'length + 3 condition was not met"
    severity failure;

    -- Port maps

    u_IFFT_32 : ifft_32
    port map (
         clk => clk,
         GlobalReset => rst,
         VLD => s_vld,
         RST => s_ifft_rst,
         RDY => s_rdy,
         I_IN => s_i_in,
         Q_IN => s_q_in,
         I_OUT => s_i_out,
         Q_OUT => s_q_out,
         EN => s_ifft_en
    );
    
    rst <= NOT PRESETn;
    s_ifft_rst <= rst OR NOT s_tx_en;

    -- Processes

    --------------------------------------------------------------------------
	-- Register write
    --------------------------------------------------------------------------
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_tx_en <= '0';
            s_ptrn <= std_logic_vector(to_unsigned(g_PTRN, s_ptrn'length));
            s_mask <= std_logic_vector(to_unsigned(g_MASK, s_mask'length));
            s_gain <= std_logic_vector(to_unsigned(g_GAIN, s_gain'length));
		elsif rising_edge(PCLK) then
			-- Default values
			
			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Initiate transmission
                        s_tx_en <= PWDATA(0);
					when c_ADDR_PTRN =>
                        s_ptrn <= PWDATA(31 downto 0);
					when c_ADDR_MASK =>
                        s_mask <= PWDATA(31 downto 0);
					when c_ADDR_GAIN =>
                        s_gain <= PWDATA(3 downto 0);
					when others =>
						null;
				end case;
			end if;
		end if;
	end process;

    --------------------------------------------------------------------------
	-- Register read
    --------------------------------------------------------------------------
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
						s_dout(0) <= s_tx_en;
					when c_ADDR_PTRN =>
						s_dout(31 downto 0) <= s_ptrn;
					when c_ADDR_MASK =>
						s_dout(31 downto 0) <= s_mask;
					when c_ADDR_GAIN =>
						s_dout(3 downto 0) <= s_gain;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;

    --------------------------------------------------------------------------
    -- Process indexing the subcarriers
    --------------------------------------------------------------------------
    p_TX_STATE : process (rst, clk)
    begin
        if rst = '1' then
            s_state <= x"00008000";
        elsif rising_edge(clk) then
            if s_tx_en = '1' then
                s_state <= s_state(0) & s_state(s_state'high downto 1);
            else 
                s_state <= x"00008000";
            end if;
        end if;
    end process p_TX_STATE;

    --------------------------------------------------------------------------
    -- Process updating s_ptrn_buf on IFFT boundaries
    --------------------------------------------------------------------------
    p_PTRN_UPDATE : process (rst, clk)
    begin
        if rst = '1' then
            s_ptrn_buf <= (others => '0');
        elsif rising_edge(clk) then
            if s_tx_en = '0' or s_state = x"00010000" then
                s_ptrn_buf <= s_ptrn;
            end if;
        end if;
    end process p_PTRN_UPDATE;

    --------------------------------------------------------------------------
    -- Process feeding the IFFT block
    --------------------------------------------------------------------------
    p_IFFT_FEED : process (rst, clk)
    begin
        if rst = '1' then
            s_ifft_en <= '0';
            s_i_in <= (others => '0');
        elsif rising_edge(clk) then
            if s_tx_en = '0' then
                s_ifft_en <= '0';
                s_i_in <= (others => '0');
            else 
                s_ifft_en <= '1';
                if (s_state AND s_mask) = x"00000000" then
                    s_i_in <= (others => '0');
                else
                    if (s_state AND s_ptrn_buf) = x"00000000" then
                        s_i_in <= c_TX_NEG;
                    else
                        s_i_in <= c_TX_POS;
                    end if;
                end if;
            end if;
        end if;
    end process p_IFFT_FEED;

    s_q_in <= (others => '0');

    --------------------------------------------------------------------------
    -- Process multiplexing the IFFT block output based on s_gain
    -- TODO: consider scaling the FFT input instead
    --------------------------------------------------------------------------
    p_IFFT_GAIN : process (rst, clk)
    begin
        if rst = '1' then
            s_tx_en_out <= '0';
            s_tx_i_out <= (others => '0');
            s_tx_q_out <= (others => '0');
        elsif rising_edge(clk) then
            s_tx_en_out <= '0';

            if s_vld = '1' and s_tx_en = '1' then
                s_tx_en_out <= '1';
            end if;

            s_tx_i_out <= (others => '0');
            s_tx_q_out <= (others => '0');

            if s_tx_en = '1' then

                case s_gain is

                    -- x8
                    when x"3" =>
                        s_tx_i_out <= s_i_out(c_FFT_OUT_WL-4 downto c_FFT_OUT_WL-TX_I'length-3);
                        s_tx_q_out <= s_q_out(c_FFT_OUT_WL-4 downto c_FFT_OUT_WL-TX_Q'length-3);

                    -- x4
                    when x"2" =>
                        s_tx_i_out <= s_i_out(c_FFT_OUT_WL-3 downto c_FFT_OUT_WL-TX_I'length-2);
                        s_tx_q_out <= s_q_out(c_FFT_OUT_WL-3 downto c_FFT_OUT_WL-TX_Q'length-2);

                    -- x2
                    when x"1" =>
                        s_tx_i_out <= s_i_out(c_FFT_OUT_WL-2 downto c_FFT_OUT_WL-TX_I'length-1);
                        s_tx_q_out <= s_q_out(c_FFT_OUT_WL-2 downto c_FFT_OUT_WL-TX_Q'length-1);

                    -- x1
                    when others =>
                        s_tx_i_out <= s_i_out(c_FFT_OUT_WL-1 downto c_FFT_OUT_WL-TX_I'length);
                        s_tx_q_out <= s_q_out(c_FFT_OUT_WL-1 downto c_FFT_OUT_WL-TX_Q'length);

                end case;
            end if;

        end if;
    end process p_IFFT_GAIN;


    -- Output assignment

	PRDATA <= s_dout;
	PREADY <= '1'; -- WR
	PSLVERR <= '0';

    TX_EN <= s_tx_en_out;
    TX_I <= s_tx_i_out;
    TX_Q <= s_tx_q_out;

    TX_DONE_IRQ <= '0';

end Behavioral;
