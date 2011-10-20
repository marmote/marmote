-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.common.all;


entity SAMPLE_APB3_tb is

--    generic (
--        c_CIC_INNER_WIDTH       : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER
--    );

end;

architecture bench of SAMPLE_APB3_tb is

  component SAMPLE_APB3
  	port (
        PCLK        : in    std_logic;
        PRESETn     : in    std_logic;


-- APB3 interface
        PADDR       : in    std_logic_vector(31 downto 0);
        PSEL        : in    std_logic;
        PENABLE     : in    std_logic;
        PWRITE      : in    std_logic;
        PWDATA      : in    std_logic_vector(31 downto 0);

        PREADY      : out   std_logic;
        PRDATA      : out   std_logic_vector(31 downto 0);
        PSLVERR     : out   std_logic;


-- DDC interface
        INPUT       : in    std_logic_vector(2*c_APB3_WIDTH-1 downto 0);

        SMPL_RDY_IN : in    std_logic_vector(1 to 2);

-- Misc
        SMPL_RDY    : out   std_logic
  	);
  end component;


        signal PCLK        : std_logic;
        signal PRESETn     : std_logic;


-- APB3 interface
        signal PADDR       : std_logic_vector(31 downto 0);
        signal PSEL        : std_logic;
        signal PENABLE     : std_logic;
        signal PWRITE      : std_logic;
        signal PWDATA      : std_logic_vector(31 downto 0);

        signal PREADY      : std_logic;
        signal PRDATA      : std_logic_vector(31 downto 0);
        signal PSLVERR     : std_logic;


-- DDC interface
        signal INPUT       : std_logic_vector(2*c_APB3_WIDTH-1 downto 0);

        signal SMPL_RDY_IN : std_logic_vector(1 to 2);

-- Misc
        signal SMPL_RDY    : std_logic;


-- BB begin
    constant c_ADDR_DATA    : std_logic_vector(7 downto 0) := x"00"; -- Read only

    signal clk_counter  : unsigned(log2_ceil(8*c_ADC_SAMPLING) downto 1);

  constant clock_period: time := 20 ns;
-- BB end

  signal stop_the_clock: boolean;

begin

  uut: SAMPLE_APB3 port map ( 
                        
        PCLK        =>  PCLK,
        PRESETn     =>  PRESETn,
        PADDR       =>  PADDR,
        PSEL        =>  PSEL,
        PENABLE     =>  PENABLE,
        PWRITE      =>  PWRITE,
        PWDATA      =>  PWDATA,
        PREADY      =>  PREADY,
        PRDATA      =>  PRDATA,
        PSLVERR     =>  PSLVERR,
        INPUT       =>  INPUT,
        SMPL_RDY_IN =>  SMPL_RDY_IN,
        SMPL_RDY    =>  SMPL_RDY
                      
                      );

  stimulus: process
  begin
  
    -- Put initialisation code here

-- BB begin
--    INPUT <= (others => '0');

-- BB end

    PRESETn <= '0';
    wait for 5 ns;
    PRESETn <= '1';
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
      PCLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;


-- BB begin
    
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            clk_counter <= (others => '0');
            INPUT <= (others => '0');
        elsif rising_edge(PCLK) then
            if clk_counter >= 8*c_ADC_SAMPLING-1 then
                clk_counter <= (others => '0');
            else
                clk_counter <= clk_counter + 1;
            end if;

            SMPL_RDY_IN(1) <= '0';
            SMPL_RDY_IN(2) <= '0';

            if clk_counter = 0 then
                SMPL_RDY_IN(1) <= '1';
                SMPL_RDY_IN(2) <= '1';
                INPUT(c_APB3_WIDTH-1 downto 0) <= std_logic_vector(unsigned(INPUT(c_APB3_WIDTH-1 downto 0)) + 1);
                INPUT(2*c_APB3_WIDTH-1 downto c_APB3_WIDTH) <= std_logic_vector(unsigned(INPUT(2*c_APB3_WIDTH-1 downto c_APB3_WIDTH)) + 3);
            end if;

        end if;
    end process;


    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
        elsif rising_edge(PCLK) then

            PSEL    <= '0';
            PWRITE  <= '0';

            PADDR(7 downto 0)   <= c_ADDR_DATA;

            if SMPL_RDY = '1' then

                PSEL    <= '1';

            end if;

        end if;
    end process;



-- BB end


end;
