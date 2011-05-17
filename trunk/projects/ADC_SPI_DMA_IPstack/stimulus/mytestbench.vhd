-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.common.all;

entity SPI_APB_ADC_tb is
end;

architecture bench of SPI_APB_ADC_tb is

  component SPI_APB_ADC
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
          CSn         : out   std_logic;
          SDATA       : in    std_logic_vector(1 to 2);
          --samples_out : out   sample_vector(1 to 2); -- Parallel sample data out debug
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
  signal CSn: std_logic;
  signal SDATA: std_logic_vector(1 to 2);
  --signal samples_out: sample_vector(1 to 2); -- Parallel sample data out debug
  signal sample_rdy: std_logic ;

-- BB begin
  signal prog         : std_logic_vector(15 downto 0); 

  constant clock_period: time := 20 ns;
-- BB end

--  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: SPI_APB_ADC port map ( PCLK       => PCLK,
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
                              CSn        => CSn,
                              SDATA      => SDATA,
                              --Debug
                              --samples_out => samples_out,
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
    wait for 1 us;    
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

    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            prog <=  x"0001";
        elsif falling_edge(PCLK) then
            if CSn = '0' or sample_rdy = '1' then
                prog <= prog(0) & prog(15 downto 1);
            end if;
        end if;
    end process;



    OUTPUTS: for i in 1 to 2 generate
        -- Sampling
        process(PRESETn, PCLK)
        begin
            if PRESETn = '0' then
                SDATA(i) <= '0';
            elsif falling_edge(PCLK) then
                if CSn = '0' then
                    SDATA(i) <= prog(0);
                end if;
            end if;
        end process;

        -- resize
--        samples(i) <= not std_logic_vector(unsigned(shift_regs(i))) when mics_enable(i) = '1'
--                      else ADC_ZERO_LEVEL;
    end generate;

-- BB end

end;