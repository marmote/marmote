-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;



entity PHASE_GEN_tb is
end;

architecture bench of PHASE_GEN_tb is

  component PHASE_GEN
  	port (
  		CLK       : in  std_logic;
  		RST       : in  std_logic;
  		DPHASE    : in  std_logic_vector(15 downto 0);
  		DPHASE_EN : in  std_logic;
  		MAGNITUDE : out std_logic_vector(15 downto 0);
  		PHASE     : out std_logic_vector(15 downto 0);
--        PHASE_CORR: out std_logic_vector(17 downto 0);
  		PHASE_EN  : out std_logic;
        INV_EN    : out std_logic
  	);
  end component;

  signal CLK:       std_logic;
  signal RST:       std_logic;
  signal DPHASE:    std_logic_vector(15 downto 0);
  signal DPHASE_EN: std_logic;
  signal MAGNITUDE: std_logic_vector(15 downto 0);
  signal PHASE:     std_logic_vector(15 downto 0);
--  signal PHASE_CORR:std_logic_vector(15 downto 0);
  signal PHASE_EN:  std_logic;
  signal INV_EN:    std_logic;

-- BB begin

  constant clock_period: time := 20 ns;
-- BB end

  signal stop_the_clock: boolean;

begin

  uut: PHASE_GEN port map ( CLK       => CLK,
                            RST       => RST,
                            DPHASE    => DPHASE,
                            DPHASE_EN => DPHASE_EN,
                            MAGNITUDE => MAGNITUDE,
                            PHASE     => PHASE,
--                            PHASE_CORR=> PHASE_CORR,
                            PHASE_EN  => PHASE_EN,
                            INV_EN    => INV_EN );

  stimulus: process
  begin
  
    -- Put initialisation code here

-- BB begin
    DPHASE <= x"0811";
  	DPHASE_EN <= '1';
-- BB end

    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

-- BB begin
    wait for 10000 ns;    
-- BB end

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


-- BB begin
    
--    process(PRESETn, PCLK)
--    begin
--        if PRESETn = '0' then
--            prog <=  x"0001";
--        elsif falling_edge(PCLK) then
--            if CSn = '0' or sample_rdy = '1' then
--                prog <= prog(0) & prog(15 downto 1);
--            end if;
--        end if;
--    end process;
--
--
--
--    OUTPUTS: for i in 1 to 2 generate
--        -- Sampling
--        process(PRESETn, PCLK)
--        begin
--            if PRESETn = '0' then
--                SDATA(i) <= '0';
--            elsif falling_edge(PCLK) then
--                if CSn = '0' then
--                    SDATA(i) <= prog(0);
--                end if;
--            end if;
--        end process;
--    end generate;
--
-- BB end


end;
