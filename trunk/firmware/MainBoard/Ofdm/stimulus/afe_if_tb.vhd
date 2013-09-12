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
         CLK_SH90   : in  std_logic;
         RST        : in  std_logic;
         SHDN       : in  std_logic;
         TX_RX_n    : in  std_logic;
         RX_STROBE  : out std_logic;
         RX_I       : out std_logic_vector(9 downto 0);
         RX_Q       : out std_logic_vector(9 downto 0);
         TX_STROBE  : in  std_logic;
         TX_I       : in  std_logic_vector(9 downto 0);
         TX_Q       : in  std_logic_vector(9 downto 0);
         CLK_pin    : out std_logic;
         SHDN_n_pin : out std_logic;
         T_R_n_pin  : out std_logic;
         DATA_pin   : inout std_logic_vector(9 downto 0)
     );
    end component;

    signal CLK: std_logic;
    signal CLK_SH90: std_logic;
    signal RST: std_logic;
    signal SHDN: std_logic;
    signal TX_RX_n: std_logic;
    signal RX_STROBE: std_logic;
    signal RX_I: std_logic_vector(9 downto 0);
    signal RX_Q: std_logic_vector(9 downto 0);
    signal TX_STROBE: std_logic;
    signal TX_I: std_logic_vector(9 downto 0);
    signal TX_Q: std_logic_vector(9 downto 0);
    signal CLK_pin: std_logic;
    signal SHDN_n_pin: std_logic;
    signal T_R_n_pin: std_logic;
    signal DATA_pin: std_logic_vector(9 downto 0) := (others => '0');

    -- AFE STUB signals
    signal s_afe_ctr    : unsigned(9 downto 0);
    signal s_afe_txd    : unsigned(9 downto 0);

    constant clock_period: time := 50 ns; -- 20 MHz
    signal stop_the_clock: boolean;

    -- ADC timing
    signal  tCLK_rise  : time := 0 ns;
    signal  tCLK_fall  : time := 0 ns;
    constant tDOI_max   : time := 8.5 ns;
    constant tDOQ_max   : time := 11.1 ns;

    -- DAC timing
    constant tDSI_min   : time := 10 ns;
    constant tDSQ_min   : time := 10 ns;


    constant tD         : time := 5 ns; -- Delay value selected arbitrarily

begin

    uut: AFE_IF
    port map (
         CLK       => CLK,
         CLK_SH90  => CLK_SH90,
         RST       => RST,
         SHDN      => SHDN,
         TX_RX_n    => TX_RX_n,
         RX_STROBE => RX_STROBE,
         RX_I      => RX_I,
         RX_Q      => RX_Q,
         TX_STROBE => TX_STROBE,
         TX_I      => TX_I,
         TX_Q      => TX_Q,
         CLK_pin    => CLK_pin,
         SHDN_n_pin    => SHDN_n_pin,
         T_R_n_pin      => T_R_n_pin,
         DATA_pin      => DATA_pin
     );


    -- Processes

    p_AFE_STUB : process (CLK_pin)
    begin
        if SHDN_n_pin = '0' then
            s_afe_ctr <= (others => '0');
            s_afe_txd <= (others => '0');
        elsif rising_edge(CLK_pin) or falling_edge(CLK_pin) then
            s_afe_ctr <= s_afe_ctr + 1;
            if T_R_n_pin = '1' then
                s_afe_txd <= unsigned(DATA_pin);
                DATA_pin <= (others => 'Z');
            else
                DATA_pin <= std_logic_vector(s_afe_ctr);
            end if;
        end if;
    end process p_AFE_STUB;


    -- Process to check the RX (ADC DDR) data signals
    -- From MAX19706 datasheet:
    -- 
    --  CLK Rise to Channel-I Output Data Valid tDOI 4.8 6.6 8.5 ns
    --  CLK Fall to Channel-Q Output Data Valid tDOQ 6.6 8.8 11.1 ns
    --
    -- -> Make sure t_CLK / 2 > 11.1 ns + any delay on the databus lines
    -- -> t_CLK > 45 ns (22 MHz) should be a sufficient constraint
    p_AFE_ADC_TIMING_CHECK : process (clk)
    begin

        if rising_edge(clk) then
            tCLK_rise <= now;
            if tCLK_fall /= 0 ns then
                assert (now - tCLK_fall) > (tDOI_max + tD)
                report "CLK Rise to Channel-I Output Data Valid tDOI violated (" &
                time'image(now - tCLK_fall) & " < " & time'image(tDOI_max + tD) & ")"
                severity error;
            end if;
        end if;

        if falling_edge(clk) then
            tCLK_fall <= now;
            if tCLK_rise /= 0 ns then
                assert (now - tCLK_rise) > (tDOQ_max + tD)
                report "CLK Rise to Channel-Q Output Data Valid tDOQ violated (" &
                time'image(now - tCLK_rise) & " < " & time'image(tDOQ_max + tD) & ")"
                severity error;
            end if;
        end if;

    end process p_AFE_ADC_TIMING_CHECK;


    -- Process to check the TX (DAC DDR) data signals
    -- From MAX19706 datasheet:
    -- 
    -- I-DAC DATA_pin to CLK Fall Setup Time tDSI 10 ns
    -- Q-DAC DATA_pin to CLK Rise Setup Time tDSQ 10 ns
    -- CLK Fall to I-DAC Data Hold Time tDHI 0 ns
    -- CLK Rise to Q-DAC Data Hold Time tDHQ 0 ns
    --
    p_AFE_DAC_TIMING_CHECK : process (clk)
    begin

        if falling_edge(clk) then
            assert DATA_pin'stable(tDSI_min)
            report "I-DAC DATA_pin to CLK Fall Setup Time violated (" & 
            time'image(DATA_pin'last_event) & " < tDSI_min)"
            severity error;
        end if;

        if rising_edge(clk) then
            assert DATA_pin'stable(tDSQ_min)
            report "Q-DAC DATA_pin to CLK Rise Setup Time violated (" &
            time'image(DATA_pin'last_event) & " < tDSQ_min)"
            severity error;
        end if;

    end process p_AFE_DAC_TIMING_CHECK;


    stimulus: process
    begin

        SHDN    <= '1';
        TX_RX_n <= '0';
        TX_STROBE <= '0';
        TX_I <= (others => '0');
        TX_Q <= (others => '0');

        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        wait for 500 ns;
        SHDN <= '0';

        -- Test RX

        wait for 5000 ns;

        -- Test TX

        TX_I <= std_logic_vector(to_unsigned(5, TX_I'length));
        TX_Q <= std_logic_vector(to_unsigned(10, TX_Q'length));

        wait for 500 ns;
        TX_RX_n <= '1';
        wait for 500 ns;
        TX_STROBE <= '1';

        wait for 5000 ns;

        stop_the_clock <= true;
        wait;
    end process;


    clocking: process
    begin
        while not stop_the_clock loop
            CLK <= '0', '1' after clock_period / 2;
            wait for clock_period;
        end loop;
        wait;
    end process;

    CLK_SH90 <= CLK after clock_period / 4;

end;

