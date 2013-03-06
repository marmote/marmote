-- IQ_COMPENSATION.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.1
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


------------------------------------------------------------------------------
-- Description: I/Q compensation block for debuggint the transmit path. 
--
-- Design considerations:
--    -The I/Q offset should be set in the AFEs through SPI.
--
------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library smartfusion;
use smartfusion.all;

entity IQ_COMPENSATION is
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

	     IN_I        : in  std_logic_vector(9 downto 0); -- signed
	     IN_Q        : in  std_logic_vector(9 downto 0);
         IN_STROBE   : in  std_logic;

	     OUT_I       : out std_logic_vector(9 downto 0); -- signed
	     OUT_Q       : out std_logic_vector(9 downto 0);
         OUT_STROBE  : out std_logic
		 );
end entity;

architecture Behavioral of IQ_COMPENSATION is

    -- Components

    component RAM_512x10 is
    port (
          WDATA : in    std_logic_vector(9 downto 0);
          RDATA : out   std_logic_vector(9 downto 0);
          WEN   : in    std_logic;
          REN   : in    std_logic;
          WADDR : in    std_logic_vector(8 downto 0);
          RADDR : in    std_logic_vector(8 downto 0);
          CLK   : in    std_logic;
          RST   : in    std_logic
    );
    end component;
    
    -- Addresses

	constant c_ADDR_AMPL_I : std_logic_vector(7 downto 0)  := x"00"; -- R/W
	constant c_ADDR_AMPL_Q : std_logic_vector(7 downto 0)  := x"04"; -- R/W
	constant c_ADDR_DELAY_I : std_logic_vector(7 downto 0) := x"08"; -- R/W
	constant c_ADDR_DELAY_Q : std_logic_vector(7 downto 0) := x"0C"; -- R/W

    -- Default values
	constant c_DEFAULT_AMPL_I   : signed(31 downto 0)    := x"00000800"; -- sfix(11,9)
	constant c_DEFAULT_AMPL_Q   : signed(31 downto 0)    := x"00000800"; -- sfix(11,9)
	constant c_DEFAULT_DELAY_I  : unsigned(31 downto 0) := x"0000000F";
	constant c_DEFAULT_DELAY_Q  : unsigned(31 downto 0) := x"00000000";
    

	-- Signals
    signal RST           : std_logic;
    alias  CLK is PCLK;

    signal s_dout        : std_logic_vector(31 downto 0);

	signal s_ampl_i      : std_logic_vector(10 downto 0); -- sfix(10,8)
	signal s_ampl_q      : std_logic_vector(10 downto 0);
	signal s_delay_i     : std_logic_vector(8 downto 0); -- ufix(9,0)
	signal s_delay_q     : std_logic_vector(8 downto 0);
    
    signal s_rd_en      : std_logic;
    signal s_wr_en      : std_logic;
    signal s_wr_addr    : std_logic_vector(8 downto 0);
    signal s_rd_addr_i  : std_logic_vector(8 downto 0);
    signal s_rd_addr_q  : std_logic_vector(8 downto 0);

    signal s_en_d       : std_logic;
    signal s_strobe     : std_logic;

    signal s_i_delayed  : std_logic_vector(9 downto 0);
    signal s_q_delayed  : std_logic_vector(9 downto 0);

    signal s_i_scaled   : std_logic_vector(20 downto 0);
    signal s_q_scaled   : std_logic_vector(20 downto 0);

begin

    rst <= not PRESETn;

    -- Port maps

    u_DELAY_I_FIFO : RAM_512x10
    port map (
        RST => rst,
        CLK => clk,
        WEN => s_wr_en,
        WADDR => s_wr_addr,
        WDATA => IN_I,
        REN => s_rd_en,
        RADDR => s_rd_addr_i,
        RDATA => s_i_delayed
    );
        
    u_DELAY_Q_FIFO : RAM_512x10
    port map (
        RST => rst,
        CLK => clk,
        WEN => s_wr_en,
        WADDR => s_wr_addr,
        WDATA => IN_Q,
        REN => s_rd_en,
        RADDR => s_rd_addr_q,
        RDATA => s_q_delayed
    );

	-- Register write
	p_REG_WRITE : process (PRESETn, PCLK)
	begin
		if PRESETn = '0' then
            s_ampl_i <= (others => '0');
            s_ampl_q <= (others => '0');
            s_delay_i <= (others => '0');
            s_delay_q <= (others => '0');
		elsif rising_edge(PCLK) then
			-- Default values
			-- Register writes
			if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
				case PADDR(7 downto 0) is
					when c_ADDR_AMPL_I =>
						s_ampl_i <= PWDATA(10 downto 0);
					when c_ADDR_AMPL_Q =>
						s_ampl_q <= PWDATA(10 downto 0);
					when c_ADDR_DELAY_I =>
						s_delay_i <= PWDATA(8 downto 0);
					when c_ADDR_DELAY_Q =>
						s_delay_q <= PWDATA(8 downto 0);
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
					when c_ADDR_AMPL_I =>
--                        s_dout <= (others => '1');
                        s_dout(10 downto 0) <= s_ampl_i;
					when c_ADDR_AMPL_Q =>
--                        s_dout <= (others => '1');
                        s_dout(10 downto 0) <= s_ampl_q;
					when c_ADDR_DELAY_I =>
                        s_dout(8 downto 0) <= s_delay_i;
					when c_ADDR_DELAY_Q =>
                        s_dout(8 downto 0) <= s_delay_q;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process p_REG_READ;

    -- p_delay_ram_address_logic process
    --
    -- Generates the block RAM addresses to delay the I/Q samples.
    p_delay_ram_address_logic : process (rst, clk)
    begin
        if rst = '1' then
            s_wr_addr <= (others => '0');
            s_rd_addr_i <= (others => '0');
            s_rd_addr_q <= (others => '0');
        elsif rising_edge(clk) then
            if IN_STROBE = '1' then
                s_wr_addr <= std_logic_vector(unsigned(s_wr_addr) + 1);
                s_rd_addr_i <= std_logic_vector(unsigned(s_wr_addr) - unsigned(s_delay_i));
                s_rd_addr_q <= std_logic_vector(unsigned(s_wr_addr) - unsigned(s_delay_q));
            end if;
            s_en_d <= IN_STROBE;
            s_strobe <= s_en_d; -- FIXME
        end if;
    end process p_delay_ram_address_logic;

    s_rd_en <= IN_STROBE;
    s_wr_en <= IN_STROBE;

    -- p_iq_scale process
    --
    -- Scales the delayed I/Q samples by AMPL_x.
    p_iq_scale : process (rst, clk)
    begin
        if rst = '1' then
            s_i_scaled <= (others => '0');
            s_q_scaled <= (others => '0');
        elsif rising_edge(clk) then
            if s_en_d = '1' then
                s_i_scaled <= std_logic_vector(signed(s_i_delayed) * signed(s_ampl_i) / 2);
                s_q_scaled <= std_logic_vector(signed(s_q_delayed) * signed(s_ampl_q) / 2);
            end if;
        end if;
    end process p_iq_scale;

    -- Output assignment
    
	PRDATA <= s_dout;
	PREADY <= '1';
	PSLVERR <= '0';

    OUT_STROBE   <= s_strobe;
    OUT_I        <= s_i_scaled(s_i_scaled'high-1 downto s_i_scaled'high-OUT_I'length);
    OUT_Q        <= s_q_scaled(s_q_scaled'high-1 downto s_q_scaled'high-OUT_I'length);


end Behavioral;

