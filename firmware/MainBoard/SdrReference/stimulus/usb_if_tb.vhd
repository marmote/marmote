-- usb_if_tb.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity USB_IF_tb is
    end;

architecture bench of USB_IF_tb is

    component USB_IF
    port (
         CLK         : in  std_logic;
         RST         : in  std_logic;
         TX_STROBE   : in  std_logic;
         TXD         : in  std_logic_vector(7 downto 0);
         RX_STROBE   : out std_logic;
         RXD         : out std_logic_vector(7 downto 0);
         USB_CLK_pin : in std_logic;
         DATA_pin    : inout std_logic_vector(7 downto 0);
         OE_n_pin    : out std_logic;
         RD_n_pin    : out std_logic;
         WR_n_pin    : out std_logic;
         RXF_n_pin   : in  std_logic;
         TXE_n_pin   : in  std_logic;
         SIWU_n_pin  : out std_logic;
         ACBUS8_pin  : in  std_logic;
         ACBUS9_pin  : in  std_logic
     );
    end component;

    component USB_IF_TC is
    port (
        USB_CLK_pin  : in   std_logic;
        DATA_pin     : in   std_logic_vector(7 downto 0);
        RXF_n_pin    : in   std_logic;
        TXE_n_pin    : in   std_logic;
        RD_n_pin     : in   std_logic;
        WR_n_pin     : in   std_logic;
        SIWU_n_pin   : in   std_logic;
        OE_n_pin     : in   std_logic;
        ACBUS8_pin   : in   std_logic;
        ACBUS9_pin   : in   std_logic
    );
    end component;

    signal CLK: std_logic;
    signal RST: std_logic;
    signal TX_STROBE: std_logic;
    signal TXD: std_logic_vector(7 downto 0);
    signal RX_STROBE: std_logic;
    signal RXD: std_logic_vector(7 downto 0);
    signal USB_CLK_pin: std_logic;
    signal DATA_pin: std_logic_vector(7 downto 0);
    signal OE_n_pin: std_logic;
    signal RD_n_pin: std_logic;
    signal WR_n_pin: std_logic;
    signal RXF_n_pin: std_logic;
    signal TXE_n_pin: std_logic;
    signal SIWU_n_pin: std_logic;
    signal ACBUS8_pin: std_logic;
    signal ACBUS9_pin: std_logic ;

    alias usb_clk is USB_CLK_pin;
    alias sys_clk is clk;

    --constant sys_clock_period: time := 1000/20 ns; -- 20 MHz
    --constant sys_clock_period: time := (1000/20) * 1 ns; -- 20 MHz
    constant sys_clock_period: time := 50 ns; -- 20 MHz
    constant usb_clock_period: time := (real(1000)/real(60)) * 1 ns; -- 60 MHz
    signal stop_the_clock: boolean;

begin

    uut: USB_IF
    port map (
        CLK         => CLK,
        RST         => RST,
        TX_STROBE   => TX_STROBE,
        TXD         => TXD,
        RX_STROBE   => RX_STROBE,
        RXD         => RXD,
        USB_CLK_pin => usb_clk,
        DATA_pin    => DATA_pin,
        OE_n_pin    => OE_n_pin,
        RD_n_pin    => RD_n_pin,
        WR_n_pin    => WR_n_pin,
        RXF_n_pin   => RXF_n_pin,
        TXE_n_pin   => TXE_n_pin,
        SIWU_n_pin  => SIWU_n_pin,
        ACBUS8_pin  => ACBUS8_pin,
        ACBUS9_pin  => ACBUS9_pin
    );

    u_USB_IF_TC : USB_IF_TC
    port map (
         USB_CLK_pin =>  USB_CLK_pin,
         DATA_pin    =>  DATA_pin,
         RXF_n_pin   =>  RXF_n_pin,
         TXE_n_pin   =>  TXE_n_pin,
         RD_n_pin    =>  RD_n_pin,
         WR_n_pin    =>  WR_n_pin,
         SIWU_n_pin  =>  SIWU_n_pin,
         OE_n_pin    =>  OE_n_pin,
         ACBUS8_pin  =>  ACBUS8_pin,
         ACBUS9_pin  =>  ACBUS9_pin
    );

    ----------------------------------------------------------------
    stimulus: process
    begin

      -- Initialization

        -- Internal
        TX_STROBE <= '0';
        TXD <= (others => '0');

        -- External
        RXF_n_pin <= '1';
        TXE_n_pin <= '1';

        ACBUS8_pin <= '0';
        ACBUS9_pin <= '0';

        rst <= '1';
        wait for 5 ns;
        rst <= '0';
        wait for 5 ns;


        -- Stimulus

        -- Test single cycle usb transmission
        -- TODO

        -- Test usb transmission w/o overflow
        -- TODO

        -- Test usb transmission w/ overflow
        -- TODO

        -- Test single cycle usb reception
        -- TODO

        -- Test usb reception w/o overflow
        -- TODO

        -- Test usb reception w/ overflow
        -- TODO

        wait for 10 us;

        stop_the_clock <= true;
        wait;
    end process;
    ----------------------------------------------------------------


    -- p_sys_clock_gen
    -- Generates the SYS clock
    p_sys_clock_gen : process
    begin
        while not stop_the_clock loop
            sys_clk <= '0', '1' after sys_clock_period / 2;
            wait for sys_clock_period;
        end loop;
        wait;
    end process;

    -- p_tx_data_gen
    -- Generates data to be transmitted through the USB interface
    -- Operates in the SYS clock domain
--    p_tx_data_gen : process (rst, sys_clk)
--    begin
--        if rst = '1' then
--        elsif rising_edge(sys_clk) then
--        end if;
--    end process p_tx_data_gen;


    -- p_usb_clock_gen
    -- Generates the USB clock
    p_usb_clock_gen : process
    begin
        while not stop_the_clock loop
            usb_clk <= '0', '1' after usb_clock_period / 2;
            wait for usb_clock_period;
        end loop;
        wait;
    end process;

    -- p_rx_data_gen
    -- Generates data to be received on the USB interface
    -- Operates in the USB clock domain
--    p_tx_data_gen : process (rst, usb_clk)
--    begin
--        if rst = '1' then
--        elsif rising_edge(usb_clk) then
--        end if;
--    end process p_tx_data_gen;

end;

