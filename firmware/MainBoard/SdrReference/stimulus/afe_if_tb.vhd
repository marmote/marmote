-- afe_if_tb.vhd


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AFE_IF_tb is
end;

architecture bench of AFE_IF_tb is

    component AFE_IF
    port (
         CLK        : in  std_logic;
         RST        : in  std_logic;
         ENABLE     : in  std_logic;
         TX_RXn     : in  std_logic;
         READY      : out std_logic;
         RX_STROBE  : out std_logic;
         RX_I       : out std_logic_vector(9 downto 0);
         RX_Q       : out std_logic_vector(9 downto 0);
         TX_STROBE  : in  std_logic;
         TX_I       : in  std_logic_vector(9 downto 0);
         TX_Q       : in  std_logic_vector(9 downto 0);
         CLKOUT     : out std_logic;
         SHDN_n     : out std_logic;
         TR_n       : out std_logic;
         DATA       : inout std_logic_vector(9 downto 0)
     );
    end component;

    signal CLK: std_logic;
    signal RST: std_logic;
    signal ENABLE: std_logic;
    signal TX_RXn: std_logic;
    signal READY: std_logic;
    signal RX_STROBE: std_logic;
    signal RX_I: std_logic_vector(9 downto 0);
    signal RX_Q: std_logic_vector(9 downto 0);
    signal TX_STROBE: std_logic;
    signal TX_I: std_logic_vector(9 downto 0);
    signal TX_Q: std_logic_vector(9 downto 0);
    signal CLKOUT: std_logic;
    signal SHDN_n: std_logic;
    signal TR_n: std_logic;
    signal DATA: std_logic_vector(9 downto 0) ;

    -- AFE STUB signals
    signal s_afe_ctr    : unsigned(9 downto 0);
    signal s_afe_txd    : unsigned(9 downto 0);

    constant clock_period: time := 100 ns; -- 10 MHz
    signal stop_the_clock: boolean;

begin

    uut: AFE_IF
    port map (
         CLK       => CLK,
         RST       => RST,
         ENABLE    => ENABLE,
         TX_RXn    => TX_RXn,
         READY     => READY,
         RX_STROBE => RX_STROBE,
         RX_I      => RX_I,
         RX_Q      => RX_Q,
         TX_STROBE => TX_STROBE,
         TX_I      => TX_I,
         TX_Q      => TX_Q,
         CLKOUT    => CLKOUT,
         SHDN_n    => SHDN_n,
         TR_n      => TR_n,
         DATA      => DATA
     );


    -- Processes

    p_AFE_STUB : process (CLKOUT)
    begin
        if SHDN_n = '0' then
            s_afe_ctr <= '0';
        elsif rising_edge(CLKOUT) then
            s_afe_ctr <= s_afe_ctr + 1;
            if TR_n = '1' then
                s_afe_txd <= DATA;
            else
                DATA <= s_afe_ctr;
            end if;
        end if;
    end process p_AFE_STUB;


    stimulus: process
    begin

        ENABLE <= '0';
        SHDN_n <= '0';
        TX_RXn <= '0';
        TX_I <= (others => '0');
        TX_Q <= (others => '0');

        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        wait for 500 ns;
        SHDN_n <= '1';

        -- Test RX

        wait for 50000 ns;

        -- Test TX

        TX_I <= to_unsigned(TX_I'length, 10);
        TX_Q <= to_unsigned(TX_Q'length, 10);

        wait for 500 ns;
        TX_RXn <= '0';

        wait for 500 ns;

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

