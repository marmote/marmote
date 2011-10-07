library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.common.all;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Entity definition
--
------------------------------------------------------------------------------
entity FIR_core is
    generic (
        c_MULT_WIDTH         : integer := c_SAMPLE_WIDTH + c_COEF_WIDTH;
        c_ACC_WIDTH         : integer := c_SAMPLE_WIDTH + c_COEF_WIDTH + log2_ceil(c_COEF_NUMBER);
        c_DECIMATION         : integer := 32
    );

   	port (
		CLK         : in  std_logic;
		RST         : in  std_logic;


        INPUT       : in unsigned(c_MULT_WIDTH-1 downto 0);

        OUTPUT      : out std_logic_vector(c_ACC_WIDTH-1 downto 0);

        
        GET_NEXT    : out std_logic  
	);
end entity; 


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of FIR_core is

    signal acc              : unsigned(c_ACC_WIDTH-1 downto 0);

    signal clk_counter      : unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);   
    signal prog             : unsigned(log2_ceil(c_DECIMATION) downto 1);
    signal fir_counter      : unsigned(log2_ceil(c_COEF_NUMBER) downto 1);

    signal WORK             : std_logic;

begin

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
            prog <= (others => '0');
        elsif rising_edge(clk) then
            if clk_counter = c_ADC_SAMPLING-1 then
            if prog >= c_DECIMATION-1 then
                prog <= (others => '0');
            else
                prog <= prog + 1;
            end if;
            end if;
        end if;
    end process;



    process(rst, clk)
    begin

        if rst = '1' then
            acc <= (others => '0'); 
            fir_counter <= (others => '0');
            WORK <= '0'; 

            OUTPUT <= (others => '0');
                   
        elsif rising_edge(clk) then
            
            if clk_counter = c_ADC_SAMPLING-1 and prog >= c_DECIMATION-1 and fir_counter = 0 then

                WORK <= '1';
                acc <= (others => '0');

            end if;


            if WORK = '1' then

                if fir_counter >= c_COEF_NUMBER-1 then
                    fir_counter <= (others => '0');

                    WORK <= '0';
                else
                    fir_counter <= fir_counter + 1;
                end if;

            end if;

            if WORK'LAST_VALUE = '1' then
                acc <= acc + INPUT;
            end if;

            if WORK'LAST_VALUE = '0' and WORK = '0' then
                OUTPUT <= std_logic_vector(acc);
            end if;

        end if;

    end process;

    GET_NEXT <= WORK;
    

end Behavioral;
