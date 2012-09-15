-- CTRL_IF_APB.VHD
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
-- Description: Control module to bridge commands from the USB to the MSS
--              through the APB interface.
--
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CTRL_IF_APB is
    port (
        -- USB interface
        USB_CONN    : in  std_logic;
        USB_RST   : in  std_logic;
        RXC_EMPTY   : in  std_logic;
        RXC_DATA    : in  std_logic_vector(7 downto 0);
        RXC_RD      : out std_logic;

        TXC_FULL    : in  std_logic;
        TXC_DATA    : out std_logic_vector(7 downto 0);
        TXC_WR      : out std_logic;

        TEST        : out std_logic_vector(7 downto 0);

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


architecture Behavioral of CTRL_IF_APB is

	-- Addresses
	constant c_ADDR_STAT : std_logic_vector(7 downto 0) := x"00"; -- R
	constant c_ADDR_TXC  : std_logic_vector(7 downto 0) := x"04"; -- W
	constant c_ADDR_RXC  : std_logic_vector(7 downto 0) := x"08"; -- R
	constant c_ADDR_TEST : std_logic_vector(7 downto 0) := x"0C"; -- R

	-- Default values

    -- Signals

    signal s_txc_data       : std_logic_vector(7 downto 0);
    signal s_txc_wr         : std_logic;
    signal s_txc_wr_prev    : std_logic;
    signal s_rxc_rd         : std_logic;
    signal s_rxc_rd_prev    : std_logic;
    signal s_dout           : std_logic_vector(15 downto 0);
    signal s_pready         : std_logic;

    signal s_test           : std_logic_vector(7 downto 0);


begin

    -- Processes

    -- APB register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then

			s_txc_data <= (others => '0');
            s_txc_wr <= '0';
            s_txc_wr_prev <= '0';
            s_test <= x"01";

		elsif rising_edge(PCLK) then

			s_txc_data <= (others => '0');
            s_txc_wr <= '0';
            s_txc_wr_prev <= s_txc_wr;

			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_TXC =>
						s_txc_data <= PWDATA(7 downto 0);
                        s_txc_wr <= '1';
                    when c_ADDR_TEST => 
						s_test <= PWDATA(7 downto 0);
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
            s_rxc_rd <= '0';
            s_rxc_rd_prev <= '0';
            s_pready <= '0';
		elsif rising_edge(PCLK) then

			s_dout <= (others => '0');
            s_rxc_rd <= '0';
            s_rxc_rd_prev <= s_rxc_rd;
            s_pready <= '1';

			if PWRITE = '0' and PSEL = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_STAT => 
						s_dout(3 downto 0) <= TXC_FULL & RXC_EMPTY & USB_RST & USB_CONN;
					when c_ADDR_RXC => 
						s_dout(7 downto 0) <= RXC_DATA;
                        s_rxc_rd <= '1';
                        s_pready <= '0';
                        if s_rxc_rd_prev = '1' then
                            s_pready <= '1';
                        end if;
                    when c_ADDR_TEST => 
                        s_dout(7 downto 0) <= s_test;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;

    -- FIXME: make sure the rx fifo is already read
    -- FIFO read
--    p_RX_FIFO_read : process (PRESETn, PCLK)
--    begin
--        if PRESETn = '0' then
--        elsif rising_edge(PCLK) then
--        end if;
--    end process p_RX_FIFO_read;


    -- Output assignments

    TXC_DATA <= s_txc_data;
    TXC_WR <= s_txc_wr and not s_txc_wr_prev;
    RXC_RD <= s_rxc_rd and not s_rxc_rd_prev;

	PRDATA <= s_dout;
	PREADY <= s_pready;
	PSLVERR <= '0';

    TEST <= s_test;

end Behavioral;
