library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity LED_PWM_tb is
    end;

architecture bench of LED_PWM_tb is

    component LED_PWM
        port (
                 CLK        : in  std_logic;
                 RST        : in  std_logic;
                 LOCK_DET   : in  std_logic;
                 LED        : out std_logic
             );
    end component;

    signal CLK: std_logic;
    signal RST: std_logic;
    signal LOCK_DET: std_logic;
    signal LED: std_logic ;

    constant clock_period: time := 50 ns;
    signal stop_the_clock: boolean;

begin

    uut: LED_PWM
    port map (
        CLK      => CLK,
        RST      => RST,
        LOCK_DET => LOCK_DET,
        LED      => LED
    );

    stimulus: process
    begin

        rst <= '1';
        wait for 5 ns;
        rst <= '0';
        wait for 5 ns;
        LOCK_DET <= '1';


        wait for 10 us;
        LOCK_DET <= '0';
        wait for 10 * clock_period;
        LOCK_DET <= '1';

        wait for 2 ms;

        stop_the_clock <= true;
        wait;
    end process;

    clocking: process
    begin
        while not stop_the_clock loop
            clk <= '0', '1' after clock_period / 2;
            wait for clock_period;
        end loop;
        wait;
    end process;

end;

