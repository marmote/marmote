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
entity CIC_INT is
    generic (
        c_CIC_INNER_WIDTH       : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER;
        c_CIC_INPUT_CYCLE       : integer := 0  
    );

   	port (
		CLK         : in    std_logic;
		RST         : in    std_logic;

        clk_counter : in    unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);  

		INPUT       : in    unsigned(c_CIC_WIDTH-1 downto 0);
        OUTPUT      : out   std_logic_vector(c_CIC_INNER_WIDTH-1 downto 0)
	);
end entity; 


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of CIC_INT is

    type sample_vector is array ( natural range <> ) of unsigned(c_CIC_INNER_WIDTH-1 downto 0);

	-- Signals
    signal int              : unsigned(c_CIC_INNER_WIDTH-1 downto 0);   
    signal int_vec          : sample_vector(1 to c_CIC_ORDER);

begin

    ----------------------------------------------------
    ----------------------------------------------------
    -- INTEGRATOR STAGE
    process (rst, clk)
        variable i      : integer :=0;          

    begin

        if rst = '1' then
            int <= (others => '0');

            for i in 1 to c_CIC_ORDER loop
                int_vec(i) <= (others => '0');
            end loop;
        elsif rising_edge(clk) then

            if clk_counter = c_CIC_INPUT_CYCLE then

                -- Get the newest sample form input
                int(c_CIC_INNER_WIDTH-1 downto c_CIC_WIDTH) <= (others => '0');
                int(c_CIC_WIDTH-1 downto 0) <= INPUT;
            
            elsif clk_counter <= 2*c_CIC_ORDER then

                if clk_counter(1) = '1' then

                    int_vec(1) <= int_vec(1) + int;

                else
                    
                    int <= int_vec(1);

                    --i := 0;
                    for i in 2 to c_CIC_ORDER loop

                        int_vec(i-1) <= int_vec(i);

                    end loop;

                    int_vec(c_CIC_ORDER) <= int_vec(1);

                end if;
                   
            end if;

        end if;
   
        
    end process;

	-- Assign output signal
    output  <= std_logic_vector(int);  

end Behavioral;
