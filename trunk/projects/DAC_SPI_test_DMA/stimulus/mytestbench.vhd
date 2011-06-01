-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.common.all;

entity SPI_APB_DAC_tb is
end;

architecture bench of SPI_APB_DAC_tb is

  component SPI_APB_DAC
      port (
          PCLK        : in    std_logic;
          PRESETn     : in    std_logic;
          PADDR       : in    std_logic_vector(31 downto 0);
          PSEL        : in    std_logic;
          PENABLE     : in    std_logic;
          PWRITE      : in    std_logic;
          PWDATA      : in    std_logic_vector(31 downto 0);
          PREADY      : out   std_logic;
          PRDATA      : out   std_logic_vector(31 downto 0);
          PSLVERR     : out   std_logic;
          SCLK        : out   std_logic;
          SYNCn       : out   std_logic;
          SDIN        : out   std_logic;
          --Debug
          samples_out : out   std_logic_vector(31 downto 0);
          sample_rdy  : out   std_logic
           );
  end component;

  signal PCLK: std_logic;
  signal PRESETn: std_logic;
  signal PADDR: std_logic_vector(31 downto 0);
  signal PSEL: std_logic;
  signal PENABLE: std_logic;
  signal PWRITE: std_logic;
  signal PWDATA: std_logic_vector(31 downto 0);
  signal PREADY: std_logic;
  signal PRDATA: std_logic_vector(31 downto 0);
  signal PSLVERR: std_logic;
  signal SCLK: std_logic;
  signal SYNCn: std_logic;
  signal SDIN: std_logic;
  --Debug
  signal samples_out: std_logic_vector(31 downto 0);
  signal sample_rdy: std_logic ;

-- BB begin
  constant clock_period: time := 10 ns; -- 100 MHz
-- BB end

  signal stop_the_clock: boolean;

begin

  uut: SPI_APB_DAC port map ( PCLK       => PCLK,
                              PRESETn    => PRESETn,
                              PADDR      => PADDR,
                              PSEL       => PSEL,
                              PENABLE    => PENABLE,
                              PWRITE     => PWRITE,
                              PWDATA     => PWDATA,
                              PREADY     => PREADY,
                              PRDATA     => PRDATA,
                              PSLVERR    => PSLVERR,
                              SCLK       => SCLK,
                              SYNCn      => SYNCn,
                              SDIN       => SDIN,
                              --Debug
                              samples_out => samples_out,
                              sample_rdy => sample_rdy );

  stimulus: process
  begin
  
    -- Put initialisation code here

    PRESETn <= '0';
    wait for 5 ns;
    PRESETn <= '1';
    wait for 5 ns;

    -- Put test bench stimulus code here

-- BB begin
    wait for 2 us;    
-- BB end

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      PCLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;


-- BB begin
    -- Sampling
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            PADDR <= x"00000000";
            PWDATA <= x"00000000";
            PSEL <= '0';
            PENABLE <= '0';
            PWRITE <= '0';
        elsif rising_edge(PCLK) then
            if sample_rdy = '1' then
                PADDR <= x"00000000";
                PWRITE <= '1';
                PSEL <= '1';
                PENABLE <= '0';
                PWDATA <= x"A5A5A5A5";
            end if;

            if PSEL = '1' then
                PENABLE <= '1';
            end if;

            if PENABLE = '1' then
                PADDR <= x"00000000";
                PWRITE <= '0';
                PSEL <= '0';
                PENABLE <= '0';
                PWDATA <= x"00000000";
            end if;
        end if;
    end process;


-- BB end

end;