--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: LED_BLINK.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::SmartFusion> <Die::A2F500M3G> <Package::256 FBGA>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LED_BLINK is
port (
    clk : in std_logic;
    rst : in std_logic;

--    led : out std_logic_vector(1 to 2)
--    ctr : out std_logic_vector(31 downto 0)
    led : out std_logic
);
end LED_BLINK;

architecture Behavioral of LED_BLINK is

    -- Signals

    signal s_ctr : unsigned(31 downto 0);
--    signal s_led : std_logic;

begin

    -- Processes

--    p_blink_counter : process (rst, clk)
    p_blink_counter : process (clk)
    begin
--        if rst = '1' then
--            s_ctr <= (others => '0');
--        elsif rising_edge(clk) then
--            s_ctr <= s_ctr + 1;
--        end if;
        if rising_edge(clk) then
            s_ctr <= s_ctr + 1;
        end if;
    end process p_blink_counter;


    -- Output assignments

--    led(1) <= s_ctr(24);
--    led(2) <= s_ctr(19);
    led <= s_ctr(22);

--    s_led <= '0';
--    led <= s_led;
--    ctr <= std_logic_vector(s_ctr);

end Behavioral;
