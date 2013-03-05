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
         -- Internal interface
         CLK        : in  std_logic;
         RST        : in  std_logic;

	     IN_I        : in  std_logic_vector(9 downto 0); -- signed
	     IN_Q        : in  std_logic_vector(9 downto 0);
         IN_STROBE   : in  std_logic;

	     OUT_I       : out std_logic_vector(9 downto 0); -- signed
	     OUT_Q       : out std_logic_vector(9 downto 0);
         OUT_STROBE  : out std_logic;

         -- Parameters
         AMPL_I     : in  std_logic_vector(9 downto 0);
         AMPL_Q     : in  std_logic_vector(9 downto 0);

         DELAY_I    : in  std_logic_vector(8 downto 0);
         DELAY_Q    : in  std_logic_vector(8 downto 0)
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
    

	-- Signals

    signal s_rd_en      : std_logic;
    signal s_wr_en      : std_logic;
    signal s_wr_addr    : std_logic_vector(8 downto 0);
    signal s_rd_addr_i  : std_logic_vector(8 downto 0);
    signal s_rd_addr_q  : std_logic_vector(8 downto 0);

    signal s_en_d       : std_logic;
    signal s_strobe     : std_logic;

    signal s_i_delayed  : std_logic_vector(9 downto 0);
    signal s_q_delayed  : std_logic_vector(9 downto 0);

    signal s_i_scaled   : std_logic_vector(9 downto 0);
    signal s_q_scaled   : std_logic_vector(9 downto 0);

begin

    -- Port maps

    u_DELAY_I_FIFO : RAM_512x10
    port map (
        RST => RST,
        CLK => CLK,
        WEN => s_wr_en,
        WADDR => s_wr_addr,
        WDATA => IN_I,
        REN => s_rd_en,
        RADDR => s_rd_addr_i,
        RDATA => s_i_delayed
    );
        
    u_DELAY_Q_FIFO : RAM_512x10
    port map (
        RST => RST,
        CLK => CLK,
        WEN => s_wr_en,
        WADDR => s_wr_addr,
        WDATA => IN_Q,
        REN => s_rd_en,
        RADDR => s_rd_addr_q,
        RDATA => s_q_delayed
    );


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
                s_rd_addr_i <= std_logic_vector(unsigned(s_wr_addr) - unsigned(DELAY_I) - 1);
                s_rd_addr_q <= std_logic_vector(unsigned(s_wr_addr) - unsigned(DELAY_Q) - 1);
            end if;
            s_en_d <= IN_STROBE;
        end if;
    end process p_delay_ram_address_logic;

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
                s_i_scaled <= std_logic_vector(signed(s_i_delayed) * signed(AMPL_I));
                s_q_scaled <= std_logic_vector(signed(s_q_delayed) * signed(AMPL_Q));
            end if;
        end if;
    end process p_iq_scale;


    OUT_STROBE   <= s_strobe;
    OUT_I        <= s_i_scaled;
    OUT_Q        <= s_q_scaled;


end Behavioral;

