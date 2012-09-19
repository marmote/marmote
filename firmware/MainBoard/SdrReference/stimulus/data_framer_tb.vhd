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

  signal s_tx_i : unsigned(15 downto 0);
  signal s_tx_q : unsigned(15 downto 0);

  constant usb_clk_period: time := 16.667 ns;
  constant sys_clk_period: time := 50 ns;
  signal stop_the_clock: boolean;

begin

    uut: DATA_FRAMER
    port map (
       CLK       => CLK,
       RST       => RST,
       TX_I      => TX_I,
       TX_Q      => TX_Q,
       TX_STROBE => TX_STROBE,
       USB_CLK   => USB_CLK,
       TXD_REQ   => TXD_REQ,
       TXD_RD    => TXD_RD,
       TXD       => TXD
    );

  stimulus: process
  begin


    TXD_RD <= '0';
  
    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    wait for 5 ns;

    wait for sys_clk_period * 200;
    wait until falling_edge(usb_clk);
    
    -- Uninterrupted transfer
    TXD_RD <= '1';
    wait for usb_clk_period * 700;
    TXD_RD <= '0';

    -- Interrupted transfer
    wait for 5000 ns;

    stop_the_clock <= true;
    wait;
  end process;

  fifo_wr : process 
  begin
      TX_STROBE <= '0';
      s_tx_i <= x"1234";
      s_tx_q <= x"5678";
      wait until rising_edge(clk);
      wait for 1 ns;
      while not stop_the_clock loop
          TX_STROBE <= '1';
          wait for sys_clk_period * 1;
          TX_STROBE <= '0';
          wait for sys_clk_period * 1;
          s_tx_i <= s_tx_i+1;
          s_tx_q <= s_tx_q+1;
      end loop;
  end process fifo_wr;

  TX_I <= std_logic_vector(s_tx_i);
  TX_Q <= std_logic_vector(s_tx_q);


  sys_clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after sys_clk_period / 2;
      wait for sys_clk_period;
    end loop;
    wait;
  end process;

  usb_clocking: process
  begin
    while not stop_the_clock loop
      usb_clk <= '0', '1' after usb_clk_period / 2;
      wait for usb_clk_period;
    end loop;
    wait;
  end process;

end;
  

