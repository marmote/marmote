-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.common.all;


entity complex_mult_tb is

--    generic (
--        c_CIC_INNER_WIDTH       : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER
--    );

end;

architecture bench of complex_mult_tb is

  component complex_mult
  	port (
        CLK             : in    std_logic;
        RST             : in    std_logic;

        sample_rdy_in   : in    std_logic;

        I_A             : in    std_logic_vector(13 downto 0);
        Q_A             : in    std_logic_vector(13 downto 0);
        I_B             : in    std_logic_vector(7 downto 0);
        Q_B             : in    std_logic_vector(7 downto 0);

        I               : out   std_logic_vector(22 downto 0);
        Q               : out   std_logic_vector(22 downto 0)
  	);
  end component;


        signal  CLK             : std_logic;
        signal  RST             : std_logic;

        signal  sample_rdy_in   : std_logic;

        signal  I_A             : std_logic_vector(13 downto 0);
        signal  Q_A             : std_logic_vector(13 downto 0);
        signal  I_B             : std_logic_vector(7 downto 0);
        signal  Q_B             : std_logic_vector(7 downto 0);

        signal  I               : std_logic_vector(22 downto 0);
        signal  Q               : std_logic_vector(22 downto 0);


-- BB begin
--    constant c_ADDR_DATA    : std_logic_vector(7 downto 0) := x"00"; -- Read only

    signal clk_counter  : unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);

    

  constant clock_period: time := 20 ns;
-- BB end

  signal stop_the_clock: boolean;

begin

  uut: complex_mult port map ( 
                        
        CLK             =>  CLK,
        RST             =>  RST,
        sample_rdy_in   =>  sample_rdy_in,
        I_A             =>  I_A,
        Q_A             =>  Q_A,
        I_B             =>  I_B,
        Q_B             =>  Q_B,
        I               =>  I,
        Q               =>  Q
                      
                      );

  stimulus: process
  begin
  
    -- Put initialisation code here

-- BB begin
--    INPUT <= (others => '0');

-- BB end

    RST <= '1';
    wait for 5 ns;
    RST <= '0';
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
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;


-- BB begin
    
    process(RST, CLK)
    begin
        if RST = '1' then
            clk_counter <= (others => '0');

            I_A <= (others => '0');
            Q_A <= (others => '0');
            I_B <= (others => '0');
            Q_B <= (others => '0');
        elsif rising_edge(CLK) then
            if clk_counter >= c_ADC_SAMPLING-1 then
                clk_counter <= (others => '0');
            else
                clk_counter <= clk_counter + 1;
            end if;

            sample_rdy_in <= '0';

            if clk_counter = 0 then
                sample_rdy_in <= '1';

                I_A <= std_logic_vector(unsigned(I_A) + 1);
                Q_A <= std_logic_vector(unsigned(Q_A) + 2);
                I_B <= std_logic_vector(unsigned(I_B) + 3);
                Q_B <= std_logic_vector(unsigned(Q_B) + 4);
            end if;

        end if;
    end process;

-- BB end


end;
