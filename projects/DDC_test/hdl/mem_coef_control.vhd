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
entity mem_coef_control is
    generic (
--        c_ADC_SAMPLING          : integer := 18; -- How many cycles does it take, to get one sample?
--        c_CIC_INNER_WIDTH       : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER;
--        c_CIC_REG_WIDTH         : integer := 27;
        c_MEM_ADDR_WIDTH    : integer := 9;
        c_MEM_WIDTH         : integer := 18
    );

   	port (
		CLK       : in  std_logic;
		RST       : in  std_logic;


        WD          : out  std_logic_vector(c_MEM_WIDTH-1 downto 0);
        WADDR       : out  std_logic_vector(c_MEM_ADDR_WIDTH-1 downto 0);
        RADDR       : out  std_logic_vector(c_MEM_ADDR_WIDTH-1 downto 0);
        WEN         : out  std_logic;
        REN         : out  std_logic;

        RD          : in  std_logic_vector(c_MEM_WIDTH-1 downto 0);


        OUTPUT      : out std_logic_vector(c_COEF_WIDTH-1 downto 0);
        GET_NEXT    : in std_logic  
	);
end entity; 


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of mem_coef_control is

    signal read_addr        : unsigned(log2_ceil(c_COEF_NUMBER)-1 downto 0);

begin

    process(rst, clk)
    begin

        if rst = '1' then
            read_addr <= (others => '0'); 
                   
        elsif rising_edge(clk) then

--            REN <= '1';

            if GET_NEXT = '1' then
--                REN <= '1';
                
                if read_addr >= c_COEF_NUMBER-1 then
                    read_addr <= (others => '0');
                else
                    read_addr <= read_addr + 1;
                end if;
                                
            end if;

        end if;

    end process;

    WEN <= '0';
    WADDR <= (others => '0');
    WD <= (others => '0');

    REN <= '1';
    RADDR <= std_logic_vector(read_addr);
    OUTPUT <= RD(c_COEF_WIDTH-1 downto 0);

end Behavioral;
