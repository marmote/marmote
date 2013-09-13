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
-- Description: Simple OFDM-based tone-generator.
--
------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TX_APB_IF is
    generic (
         -- Default values
         g_PTRN : integer := 16#0166#; -- subcarrier pattern
         g_MASK : integer := 16#7FFE# -- subcarrier mask
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

--         LED     : out std_logic;

         TX_DONE_IRQ : out std_logic;

         TX_EN      : out std_logic;
         TX_I       : out std_logic_vector(9 downto 0);
         TX_Q       : out std_logic_vector(9 downto 0)
     );

end entity;

architecture Behavioral of TX_APB_IF is

    -- Components

    -- Constants

    -- FIXME: Scale TX_HIGH and TX_LOW properly
    constant c_TX_HIGH          : std_logic_vector(15 downto 0) := "0110" & x"000"; -- +0.75
    constant c_TX_LOW           : std_logic_vector(15 downto 0) := "1010" & x"000"; -- -0.75


	-- Addresses

	constant c_ADDR_CTRL        : std_logic_vector(7 downto 0) := x"00"; -- W (START)
	constant c_ADDR_TEST        : std_logic_vector(7 downto 0) := x"04"; -- R/W

	constant c_ADDR_PTRN        : std_logic_vector(7 downto 0) := x"10"; -- R/W
	constant c_ADDR_MASK        : std_logic_vector(7 downto 0) := x"14"; -- R/W


	-- Registers

	signal s_status      : std_logic_vector(31 downto 0);

	-- Signals

    signal rst              : std_logic;
    alias  clk              : std_logic is PCLK;

    signal s_dout           : std_logic_vector(31 downto 0);

    signal s_test           : std_logic_vector(7 downto 0);
	signal s_tx_en          : std_logic;
    signal s_ptrn           : std_logic_vector(31 downto 0);
    signal s_mask           : std_logic_vector(31 downto 0);

    signal s_tx_i           : std_logic_vector(9 downto 0);
    signal s_tx_q           : std_logic_vector(9 downto 0);
    signal s_tx_done        : std_logic;

begin

    rst <= not PRESETn;

    -- Port maps

    
    -- Processes

	-- Register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
			s_tx_en <= '0';
            s_test <= (others => '0');
            s_ptrn <= std_logic_vector(to_unsigned(g_PTRN, s_ptrn'length));
            s_mask <= std_logic_vector(to_unsigned(g_MASK, s_mask'length));
		elsif rising_edge(PCLK) then
			-- Default values
			s_tx_en <= '0';
			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Initiate transmission
                        s_tx_en <= PWDATA(0);
					when c_ADDR_TEST =>
                        s_test <= PWDATA(7 downto 0);
					when c_ADDR_PTRN =>
                        s_ptrn <= PWDATA;
					when c_ADDR_MASK =>
                        s_mask <= PWDATA;
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
					when c_ADDR_TEST => 
						s_dout(7 downto 0) <= s_test;
					when c_ADDR_PTRN =>
						s_dout <= s_ptrn;
					when c_ADDR_MASK =>
						s_dout <= s_mask;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;


    -- Output assignment

	PRDATA <= s_dout;
	PREADY <= '1'; -- WR
	PSLVERR <= '0';

    TX_EN <= s_tx_en;
    TX_I <= s_tx_i;
    TX_Q <= s_tx_q;

    TX_DONE_IRQ <= s_tx_done;

--    LED <= s_test(0); -- FIXME: Temporary for APT-register interface test only

end Behavioral;
