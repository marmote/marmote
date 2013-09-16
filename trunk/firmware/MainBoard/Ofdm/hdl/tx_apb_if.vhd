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
-- Description: Simple OFDM-based tone-generator using 16-point IFFT.
--
------------------------------------------------------------------------------

-- TODO: Adjustable TX GAIN (TX_NEG/TX_POS)

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TX_APB_IF is
    generic (
         -- Default values
         --g_PTRN : integer := 16#0166#; -- subcarrier pattern
         --g_MASK : integer := 16#7FFE# -- subcarrier mask
         g_PTRN : integer := 16#FFFF#; -- subcarrier pattern
         g_MASK : integer := 16#5000# -- subcarrier mask
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

    -- Components
    
    component ifft_16 is
    port (
         clk : in std_logic;
         GlobalReset : in std_logic;
         VLD : out std_logic; -- ufix1
         RST : in std_logic; -- ufix1
         RDY : out std_logic; -- ufix1
         Q_OUT : out std_logic_vector(9 downto 0); -- sfix10_En9
         Q_IN : in std_logic_vector(15 downto 0); -- sfix16_En15
         I_OUT : out std_logic_vector(9 downto 0); -- sfix10_En9
         I_IN : in std_logic_vector(15 downto 0); -- sfix16_En15
         EN : in std_logic -- ufix1
    );
    end component ifft_16;


    -- Constants

    constant c_TX_POS       : std_logic_vector(15 downto 0) := "0110" & x"000"; -- +0.75
    constant c_TX_NEG       : std_logic_vector(15 downto 0) := "1010" & x"000"; -- -0.75


	-- Addresses

	constant c_ADDR_CTRL    : std_logic_vector(7 downto 0) := x"00"; -- W (EN)

	constant c_ADDR_PTRN    : std_logic_vector(7 downto 0) := x"10"; -- R/W
	constant c_ADDR_MASK    : std_logic_vector(7 downto 0) := x"14"; -- R/W


	-- Registers

	signal s_tx_en      : std_logic;
    signal s_ptrn       : std_logic_vector(15 downto 0);
    signal s_mask       : std_logic_vector(15 downto 0);


	-- Signals

    signal rst          : std_logic;
    alias  clk          : std_logic is PCLK;

    signal s_dout       : std_logic_vector(31 downto 0);
    signal s_state      : std_logic_vector(15 downto 0) := x"8000";

    signal s_ifft_rst   : std_logic;
    signal s_ifft_en     : std_logic;
    signal s_i_in       : std_logic_vector(15 downto 0);
    signal s_q_in       : std_logic_vector(15 downto 0);
    signal s_vld        : std_logic;
    signal s_rdy        : std_logic;
    signal s_i_out      : std_logic_vector(9 downto 0);
    signal s_q_out      : std_logic_vector(9 downto 0);

begin

    -- Port maps

    u_IFFT_16 : ifft_16
    port map (
         clk => clk,
         GlobalReset => '0',
         VLD => s_vld,
         RST => s_ifft_rst,
         RDY => s_rdy,
         Q_OUT => s_q_out,
         Q_IN => s_q_in,
         I_OUT => s_i_out,
         I_IN => s_i_in,
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
		elsif rising_edge(PCLK) then
			-- Default values
			
			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Initiate transmission
                        s_tx_en <= PWDATA(0);
					when c_ADDR_PTRN =>
                        s_ptrn <= PWDATA(15 downto 0);
					when c_ADDR_MASK =>
                        s_mask <= PWDATA(15 downto 0);
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
						s_dout(15 downto 0) <= s_ptrn;
					when c_ADDR_MASK =>
						s_dout(15 downto 0) <= s_mask;
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
            s_state <= x"8000";
        elsif rising_edge(clk) then
            if s_tx_en = '1' then
                s_state <= s_state(0) & s_state(s_state'high downto 1);
            else 
                s_state <= x"8000";
            end if;
        end if;
    end process p_TX_STATE;

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
                if (s_state AND s_mask) = x"0000" then
                    s_i_in <= (others => '0');
                else
                    if (s_state AND s_ptrn) = x"0000" then
                        s_i_in <= c_TX_NEG;
                    else
                        s_i_in <= c_TX_POS;
                    end if;
                end if;
            end if;
        end if;
    end process p_IFFT_FEED;

    s_q_in <= (others => '0');


    -- Output assignment

	PRDATA <= s_dout;
	PREADY <= '1'; -- WR
	PSLVERR <= '0';

    TX_EN <= s_vld AND s_tx_en;
    TX_I <= s_i_out when s_tx_en = '1' else (others => '0');
    TX_Q <= s_q_out when s_tx_en = '1' else (others => '0');

    TX_DONE_IRQ <= '0';

end Behavioral;
