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
entity CIC_control is
    generic (
        c_CIC_DECIMATION        : integer := pow2(c_CIC_ORDER)
    );

   	port (
		CLK             : in    std_logic;
		RST             : in    std_logic;

        clk_counter_out : out   unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);  
        dec_counter_out : out   unsigned(log2_ceil(c_CIC_DECIMATION) downto 1)

	);
end entity; 


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of CIC_control is

	-- Signals
    signal clk_counter      : unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);  
    signal dec_counter      : unsigned(log2_ceil(c_CIC_DECIMATION) downto 1);

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
            dec_counter <= (others => '0');
        elsif rising_edge(clk) and clk_counter = c_ADC_SAMPLING-1 then
            if dec_counter >= c_CIC_DECIMATION-1 then
                dec_counter <= (others => '0');
            else
                dec_counter <= dec_counter + 1;
            end if;
        end if;
    end process;

    clk_counter_out <= clk_counter;
    dec_counter_out <= dec_counter;

end Behavioral;
