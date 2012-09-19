-- COUNTER_STUB.VHD
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
-- Description: Datapath stub with counter to test the USB interface.
--
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity COUNTER_STUB is
    port (
        CLK         : in  std_logic;
        RST         : in  std_logic;

        TX_STROBE   : out std_logic;
        TXD_I       : out std_logic_vector(15 downto 0);
        TXD_Q       : out std_logic_vector(15 downto 0)
    );
end entity;


architecture Behavioral of COUNTER_STUB is

    -- Signals
    signal s_txd_ctr    : unsigned(15 downto 0);
    signal s_en_ctr     : unsigned(15 downto 0);
    signal s_en         : std_logic;

	signal s_tx_strobe  : std_logic;

begin

    -- Processes

    p_txd_counter_en : process (rst, clk)
    begin
        if rst = '1' then
            s_en_ctr <= (others => '0');
            s_en <= '0';
        elsif rising_edge(clk) then
            s_en_ctr <= s_en_ctr + 1;
            s_en <= '0';
            if s_en_ctr = 3 then
                s_en_ctr <= (others => '0');
                s_en <= '1';
            end if;
        end if;
    end process p_txd_counter_en;


    p_txd_counter : process (rst, clk)
    begin
        if rst = '1' then
            s_tx_strobe <= '0';
            s_txd_ctr <= (15 => '1', others => '0');
        elsif rising_edge(clk) then
            s_tx_strobe <= '0';
            if s_en = '1' then
                s_tx_strobe <= '1';
                s_txd_ctr <= s_txd_ctr + 1;
            end if;
        end if;
    end process p_txd_counter;


    -- Output assignments

    TXD_I <= std_logic_vector(s_txd_ctr(15 downto 0));
    TXD_Q <= std_logic_vector(s_txd_ctr(15 downto 0) + 16);
    TX_STROBE <= s_tx_strobe;


end Behavioral;
