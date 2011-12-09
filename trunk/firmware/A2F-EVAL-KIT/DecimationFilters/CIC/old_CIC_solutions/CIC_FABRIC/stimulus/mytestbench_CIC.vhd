-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.common.all;


entity CIC_tb is

    generic (
        c_CIC_DECIMATION   : integer := pow2(c_CIC_ORDER);
        c_CIC_INNER_WIDTH  : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER
    );

end;

architecture bench of CIC_tb is

  component CIC
  	port (
  		CLK       : in  std_logic;
  		RST       : in  std_logic;
        --OUTDEBUG  : out std_logic_vector(c_CIC_WIDTH-1 downto 0);
  		INPUT     : in  std_logic_vector(c_CIC_WIDTH-1 downto 0);
        OUTPUT    : out std_logic_vector(c_CIC_WIDTH-1 downto 0)
  	);
  end component;

  signal CLK        : std_logic;
  signal RST        : std_logic;
  --signal OUTDEBUG   : std_logic_vector(c_CIC_WIDTH-1 downto 0);
  signal INPUT      : std_logic_vector(c_CIC_WIDTH-1 downto 0);
  signal OUTPUT     : std_logic_vector(c_CIC_WIDTH-1 downto 0);

-- BB begin

  constant clock_period: time := 20 ns;
-- BB end

  signal stop_the_clock: boolean;

begin

  uut: CIC port map ( CLK      => CLK,
                      RST      => RST,
                      --OUTDEBUG => OUTDEBUG,
                      INPUT    => INPUT,
                      OUTPUT   => OUTPUT );

  stimulus: process
  begin
  
    -- Put initialisation code here

-- BB begin
    INPUT <= x"0001";
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
