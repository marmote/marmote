library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity DATA_FRAMER_tb is
end;

architecture bench of DATA_FRAMER_tb is

  component DATA_FRAMER
      port (
          CLK         : in  std_logic;
          RST         : in  std_logic;
          TX_I        : in  std_logic_vector(15 downto 0);
          TX_Q        : in  std_logic_vector(15 downto 0);
          TX_STROBE   : in  std_logic;
          USB_CLK     : in  std_logic;
          TXD_REQ     : out std_logic;
          TXD_RD      : in  std_logic;
          TXD         : out std_logic_vector(7 downto 0)
      );
  end component;

  signal CLK: std_logic;
  signal RST: std_logic;
  signal TX_I: std_logic_vector(15 downto 0);
  signal TX_Q: std_logic_vector(15 downto 0);
  signal TX_STROBE: std_logic;
  signal USB_CLK: std_logic;
  signal TXD_REQ: std_logic;
  signal TXD_RD: std_logic;
  signal TXD: std_logic_vector(7 downto 0) ;

  constant clock_period: time := 16.667 ns;
  signal stop_the_clock: boolean;

begin

  uut: DATA_FRAMER port map ( CLK       => CLK,
                              RST       => RST,
                              TX_I      => TX_I,
                              TX_Q      => TX_Q,
                              TX_STROBE => TX_STROBE,
                              USB_CLK   => USB_CLK,
                              TXD_REQ   => TXD_REQ,
                              TXD_RD    => TXD_RD,
                              TXD       => TXD );

  stimulus: process
  begin

    CLK <= '0';
    TX_I <= (others => '0');
    TX_Q <= (others => '0');
    TX_STROBE <= '0';

    TXD_RD <= '0';
  
    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    wait for 5 ns;


    wait for 50 ns;
    wait until falling_edge(usb_clk);
    
    -- Uninterrupted transfer
    TXD_RD <= '1';
    wait for clock_period * 10;
    TXD_RD <= '0';
    wait for clock_period * 10;
    TXD_RD <= '1';

    -- Interrupted transfer
    wait for 50 ns;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      usb_clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
  

