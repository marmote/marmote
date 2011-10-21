-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.common.all;


entity CIC_COMB_tb is

    generic (
        c_CIC_DECIMATION        : integer := pow2(c_CIC_ORDER);
        c_CIC_INNER_WIDTH       : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER
    );

end;

architecture bench of CIC_COMB_tb is

  component CIC_COMB
  	port (
		CLK         : in    std_logic;
		RST         : in    std_logic;

        clk_counter : in    std_logic_vector(log2_ceil(c_ADC_SAMPLING) downto 1);
        dec_counter : in    std_logic_vector(log2_ceil(c_CIC_DECIMATION) downto 1);  

		INPUT       : in    std_logic_vector(c_CIC_INNER_WIDTH-1 downto 0);
        OUTPUT      : out   std_logic_vector(c_CIC_INNER_WIDTH-1 downto 0)
  	);
  end component;


    signal CLK          : std_logic;
	signal RST          : std_logic;

    signal clk_counter  : unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);
    signal dec_counter  : unsigned(log2_ceil(c_CIC_DECIMATION) downto 1);  

	signal INPUT        : unsigned(c_CIC_INNER_WIDTH-1 downto 0);
    signal OUTPUT       : std_logic_vector(c_CIC_INNER_WIDTH-1 downto 0);


-- BB begin

  constant clock_period: time := 20 ns;
-- BB end

  signal stop_the_clock: boolean;

begin

  uut: CIC_COMB port map ( CLK      => CLK,
                      RST           => RST,
                      clk_counter   => std_logic_vector(clk_counter),
                      dec_counter   => std_logic_vector(dec_counter),
                      INPUT         => std_logic_vector(INPUT),
                      OUTPUT        => OUTPUT );

  stimulus: process
  begin
  
    -- Put initialisation code here

-- BB begin
    INPUT <= to_unsigned(1, c_CIC_INNER_WIDTH);
-- BB end

    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

-- BB begin
    wait for 20000 ns;    
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
    process(rst, clk)
    begin
        if rst = '1' then
            clk_counter <= (others => '0');
        elsif rising_edge(clk) then
            if clk_counter >= c_ADC_SAMPLING-1 then
                clk_counter <= (others => '0');
            else
                clk_counter <= clk_counter + 1;
            end if;
        end if;
    end process;

    ----------------------------------------------------
    ----------------------------------------------------
    -- DECIMATION
    process(rst, clk)
    begin
        if rst = '1' then
            dec_counter <= (others => '0');
        elsif rising_edge(clk) and clk_counter = c_ADC_SAMPLING-1 then
            if dec_counter >= c_CIC_DECIMATION-1 then
                dec_counter <= (others => '0');
            else
                dec_counter <= dec_counter + 1;
            end if;
        end if;
    end process;

-- BB end


end;
