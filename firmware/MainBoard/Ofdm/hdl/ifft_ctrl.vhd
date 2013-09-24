-- IFFT_CTRL.VHD
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
-- Description: Timing control module for the IFFT block in the OFDM design.
--
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IFFT_CTRL is
    port (
        RST         : in  std_logic;
        CLK         : in  std_logic;

        -- IFFT interface
        IFFT_RST    : out std_logic;
        IFFT_EN     : out std_logic;
        IFFT_I      : out std_logic_vector(3 downto 0); -- !
        IFFT_Q      : out std_logic_vector(3 downto 0); -- !

        -- FSM interface
        SYM         : in  std_logic_vector(31 downto 0);
        MASK        : in  std_logic_vector(31 downto 0);
        SYM_START   : in  std_logic;
        SYM_DONE    : out std_logic
    );
end entity;

architecture Behavioral of IFFT_CTRL is

    -- Constants

    constant c_FFT_IN_WL    : integer := 4;

    constant c_TX_POS       : std_logic_vector(c_FFT_IN_WL-1 downto 0) := "0111"; -- ~ +1
    constant c_TX_NEG       : std_logic_vector(c_FFT_IN_WL-1 downto 0) := "1001"; -- ~ -1

    constant c_IFFT_PATH_DELAY  : integer := 71;

	-- Registers
    signal s_state  : std_logic_vector(31 downto 0);
    signal s_tx_en  : std_logic;

    signal s_sym : std_logic_vector(31 downto 0);
    signal s_mask   : std_logic_vector(31 downto 0);

    signal s_ifft_en    : std_logic;
    signal s_ifft_en_hold : std_logic;
    signal s_ifft_i     : std_logic_vector(c_FFT_IN_WL-1 downto 0);
    signal s_ifft_q     : std_logic_vector(c_FFT_IN_WL-1 downto 0);

    signal s_sym_done   : std_logic;
    signal s_delay_ctr  : unsigned(6 downto 0);

begin

    -- Processes

    --------------------------------------------------------------------------
    -- Process indexing the subcarriers
    --------------------------------------------------------------------------
    p_SYM_STATE : process (rst, clk)
    begin
        if rst = '1' then
            s_tx_en <= '0';
            s_state <= x"00000000";
        elsif rising_edge(clk) then
            if SYM_START = '1' then
                s_state <= x"00008000";
                s_tx_en <= '1';
            elsif s_state = x"00010000" then
                s_tx_en <= '0';
            end if;

            if s_tx_en = '1' then
                s_state <= s_state(0) & s_state(s_state'high downto 1);
            end if;
        end if;
    end process p_SYM_STATE;

    s_sym_done <= s_state(16);

    --------------------------------------------------------------------------
    -- Process updating s_sym on IFFT boundaries
    --------------------------------------------------------------------------
    p_SYMBOL_BUFFER_UPDATE : process (rst, clk)
    begin
        if rst = '1' then
            s_sym <= (others => '0');
            s_mask <= (others => '0');
        elsif rising_edge(clk) then
            if SYM_START = '1' then
                s_sym <= SYM;
                s_mask <= MASK;
            end if;
        end if;
    end process p_SYMBOL_BUFFER_UPDATE;

    --------------------------------------------------------------------------
    -- Process feeding the IFFT block
    --------------------------------------------------------------------------
    p_IFFT_FEED : process (rst, clk)
    begin
        if rst = '1' then
            s_ifft_en <= '0';
            s_ifft_i <= (others => '0');
        elsif rising_edge(clk) then
            if s_tx_en = '0' then
                s_ifft_en <= '0';
                s_ifft_i <= (others => '0');
            else 
                s_ifft_en <= '1';
                if (s_state AND s_mask) = x"00000000" then
                    s_ifft_i <= (others => '0');
                else
                    if (s_state AND s_sym) = x"00000000" then
                        s_ifft_i <= c_TX_NEG;
                    else
                        s_ifft_i <= c_TX_POS;
                    end if;
                end if;
            end if;
        end if;
    end process p_IFFT_FEED;

    s_ifft_q <= (others => '0');

    p_DELAY_COUNTER : process (rst, clk)
    begin
        if rst = '1' then
            s_delay_ctr <= (others => '0');
            s_ifft_en_hold <= '0';
        elsif rising_edge(clk) then
            s_ifft_en_hold <= '0';
            if s_sym_done = '1' then
                s_delay_ctr <= to_unsigned(c_IFFT_PATH_DELAY, s_delay_ctr'length);
            elsif s_delay_ctr > 0 then
                s_delay_ctr <= s_delay_ctr - 1; 
                s_ifft_en_hold <= '1';
            end if;
        end if;
    end process p_DELAY_COUNTER;

    -- Output assignment

    IFFT_RST <= not (s_ifft_en or s_ifft_en_hold);
    IFFT_EN <= s_ifft_en or s_ifft_en_hold;
    IFFT_I  <= s_ifft_i;
    IFFT_Q  <= s_ifft_q;

    SYM_DONE <= s_state(17); -- NOTE: signal 'done' one clock cycle in advance

end Behavioral;
