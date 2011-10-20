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
        c_CIC_OUT_WIDTH       : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER
    );

end;

architecture bench of CIC_tb is

  component CIC
  	port (
		CLK         : in    std_logic;
		RST         : in    std_logic;

		INPUT       : in    std_logic_vector(c_CIC_WIDTH-1 downto 0);

		SMPL_RDY    : out   std_logic;
        OUTPUT      : out   std_logic_vector(c_CIC_OUT_WIDTH-1 downto 0)
  	);
  end component;


    signal CLK          : std_logic;
	signal RST          : std_logic;

	signal INPUT        : std_logic_vector(c_CIC_WIDTH-1 downto 0);

    signal SMPL_RDY     : std_logic;
    signal OUTPUT       : std_logic_vector(c_CIC_OUT_WIDTH-1 downto 0);


-- BB begin

  constant clock_period: time := 20 ns;
-- BB end

  signal stop_the_clock: boolean;

begin

  uut: CIC port map ( CLK       => CLK,
                      RST           => RST,
                      INPUT         => INPUT,
                      SMPL_RDY      => SMPL_RDY,
                      OUTPUT        => OUTPUT );

  stimulus: process
  begin
  
    -- Put initialisation code here

-- BB begin
--    INPUT <= to_unsigned(1, c_CIC_WIDTH);
    INPUT <= (others => '0');
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
    
    -- Clock counter
--    process(rst, clk)
--    begin
--        if rst = '1' then
--            clk_counter <= (others => '0');
--        elsif rising_edge(clk) then
--            if clk_counter >= c_ADC_SAMPLING-1 then
--                clk_counter <= (others => '0');
--            else
--                clk_counter <= clk_counter + 1;
--            end if;
--        end if;
--    end process;
--
-- BB end


end;
