-- LED_PWM.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.0
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
-- Description: PWM led control for to detect lock loss.
--
------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LED_PWM is
	port (
         -- Internal interface
         CLK        : in  std_logic;
         RST        : in  std_logic;

         LOCK_DET   : in  std_logic;
         LED        : out std_logic
		 );
end entity;

architecture Behavioral of LED_PWM is

	-- Constants

    constant c_DECAY_TIMEOUT  : integer := 2**21;
    constant c_PWM_LEN        : integer := 1024;

	-- Signals

    signal s_brightness : unsigned(21 downto 0);
    signal s_decay_ctr : unsigned(21 downto 0);

    signal s_pwm_ctr    : unsigned(7 downto 0);
    signal s_pwm_out    : std_logic;

begin

    p_brightenss_control : process (rst, clk)
    begin
        if rst = '1' then
            s_brightness <= (others => '0');
            s_decay_ctr <= (others => '0');
        elsif rising_edge(clk) then
            -- Set and decay
            if LOCK_DET = '0' then
                s_brightness <= (others => '1');
            else
                if s_decay_ctr < c_DECAY_TIMEOUT-1 then
                    s_decay_ctr <= s_decay_ctr + 1;
                else
                    s_brightness <= '0' & s_brightness(s_brightness'high downto 1);
                    s_decay_ctr <= (others => '0');
                end if;
            end if;
        end if;
    end process p_brightenss_control;

    p_pwm : process (rst, clk)
    begin
        if rst = '1' then
            s_pwm_ctr <= (others => '0');
            s_pwm_out <= '0';
        elsif rising_edge(clk) then
            if s_pwm_ctr < c_PWM_LEN-1 then
                s_pwm_ctr <= s_pwm_ctr + 1;
            else
                s_pwm_ctr <= (others => '0');
            end if;
            if s_pwm_ctr < s_brightness(s_brightness'high downto s_brightness'high-9) then
                s_pwm_out <= '1';
            else
                s_pwm_out <= '0';
            end if;
        end if;
    end process p_pwm;

    LED <= s_pwm_out;


end Behavioral;

