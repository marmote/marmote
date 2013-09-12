-- DATAPATH_STUB_APB.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.0
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
-- Description: Datapath stub with APB interface to test the AFE and USB
--              interfaces.
--
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DATAPATH_STUB_APB is
    port (
        AFE_EN      : out std_logic;

        TX_STROBE   : out std_logic;
        TXD_I       : out std_logic_vector(9 downto 0);
        TXD_Q       : out std_logic_vector(9 downto 0);

        MUX_SEL1	: out std_logic_vector(1 downto 0);
        MUX_SEL2	: out std_logic_vector(1 downto 0);

         -- APB3 inteface
        PCLK    : in  std_logic;
        PRESETn : in  std_logic;
        PADDR	 : in  std_logic_vector(31 downto 0);
        PSEL	 : in  std_logic;
        PENABLE : in  std_logic;
        PWRITE  : in  std_logic;
        PWDATA  : in  std_logic_vector(15 downto 0);

        PREADY  : out std_logic;
        PRDATA  : out std_logic_vector(15 downto 0);
        PSLVERR : out std_logic
    );
end entity;


architecture Behavioral of DATAPATH_STUB_APB is

	-- Addresses
	constant c_ADDR_CTRL : std_logic_vector(7 downto 0) := x"00"; -- R/W (AFE ENABLE)
	constant c_ADDR_I    : std_logic_vector(7 downto 0) := x"04"; -- R/W
	constant c_ADDR_Q    : std_logic_vector(7 downto 0) := x"08"; -- R/W
	constant c_ADDR_MUX1 : std_logic_vector(7 downto 0) := x"0C"; -- R/W
	constant c_ADDR_MUX2 : std_logic_vector(7 downto 0) := x"10"; -- R/W

	-- Default values
	constant c_DEFAULT_CTRL : unsigned(15 downto 0) := x"0000"; -- AFE off
	constant c_DEFAULT_I    : unsigned(15 downto 0) := x"0200"; -- Mid-scale
	constant c_DEFAULT_Q    : unsigned(15 downto 0) := x"0200"; -- Mid-scale
	constant c_DEFAULT_MUX1 : unsigned(1 downto 0) := "10";
	constant c_DEFAULT_MUX2 : unsigned(1 downto 0) := "10";

	-- Registers

	signal s_afe_en             : std_logic;
	signal s_afe_i              : std_logic_vector(15 downto 0);
	signal s_afe_q              : std_logic_vector(15 downto 0);

	signal s_mux_sel1			: std_logic_vector(1 downto 0) ;
	signal s_mux_sel2			: std_logic_vector(1 downto 0) ;

    -- Signals

    signal s_dout               : std_logic_vector(15 downto 0);


begin

    -- Processes

    -- APB register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then

			s_afe_en <= '0';
			s_afe_i  <= std_logic_vector(c_DEFAULT_I);
			s_afe_q  <= std_logic_vector(c_DEFAULT_Q);
			s_mux_sel1 <= std_logic_vector(c_DEFAULT_MUX1);
			s_mux_sel2 <= std_logic_vector(c_DEFAULT_MUX2);

		elsif rising_edge(PCLK) then

			-- Default values
			-- s_afe_en <= '0';

			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_CTRL =>
						-- Initiate FSK reception
						s_afe_en <= PWDATA(0);
					when c_ADDR_I =>
						s_afe_i <= PWDATA;
					when c_ADDR_Q =>
						s_afe_q <= PWDATA;
					when c_ADDR_MUX1 =>
						s_mux_sel1 <= PWDATA(1 downto 0);
					when c_ADDR_MUX2 =>
						s_mux_sel2 <= PWDATA(1 downto 0);
					when others =>
						null;
				end case;
			end if;
		end if;
	end process;

	-- APB register read
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
						s_dout <= (0 => s_afe_en, others => '0');
					when c_ADDR_I =>
						s_dout <= s_afe_i;
					when c_ADDR_Q =>
						s_dout <= s_afe_q;
					when c_ADDR_MUX1 =>
						s_dout(1 downto 0) <= s_mux_sel1;
					when c_ADDR_MUX2 =>
						s_dout(1 downto 0) <= s_mux_sel2;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;


--    p_STROBE : process (rst, clk)
--    begin
--        if rst = '1' then
--            s_strobe <= '0';
--        elsif rising_edge(clk) then
--            s_strobe <= '1';
--        end if;
--    end process p_STROBE;

    -- Output assignments

    AFE_EN  <= s_afe_en;

    MUX_SEL1 <= s_mux_sel1;
    MUX_SEL2 <= s_mux_sel2;

    PRDATA <= s_dout;
	PREADY <= '1'; -- WR
	PSLVERR <= '0';

    TXD_I <= s_afe_i(9 downto 0);
    TXD_Q <= s_afe_q(9 downto 0);
    TX_STROBE <= '1';


end Behavioral;
