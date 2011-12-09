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
entity mem_sample_control is
    generic (
        c_MEM_ADDR_WIDTH    : integer := 9;
        c_MEM_WIDTH         : integer := 22
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


        OUTPUT      : out std_logic_vector(c_SAMPLE_WIDTH-1 downto 0);
        INPUT       : in std_logic_vector(c_SAMPLE_WIDTH-1 downto 0);

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
architecture Behavioral of mem_sample_control is

    signal addr             : unsigned(log2_ceil(c_SAMPLE_NUMBER)-1 downto 0);
    signal write_addr       : unsigned(log2_ceil(c_SAMPLE_NUMBER)-1 downto 0);
    signal read_addr        : unsigned(log2_ceil(c_SAMPLE_NUMBER)-1 downto 0);


    signal clk_counter      : unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);   

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


    process(rst, clk)
    begin

        if rst = '1' then
            WEN <= '0';

            addr        <= (0 => '1', others => '0'); 
            read_addr   <= (0 => '1', others => '0'); 
            write_addr  <= (others => '0');
            WADDR       <= (others => '0');             
                   
        elsif rising_edge(clk) then

            --ADDR
            if clk_counter = c_ADC_SAMPLING-2 then

                if addr >= c_SAMPLE_NUMBER-1 then
                    addr <= (others => '0');
                else
                    addr <= addr + 1;
                end if;

            end if;


--READING
            --READ ADDR
            if GET_NEXT'LAST_VALUE = '1' and GET_NEXT = '0' then

                read_addr <= addr;

            elsif GET_NEXT = '1' or clk_counter = c_ADC_SAMPLING-1 then

                if read_addr >= c_SAMPLE_NUMBER-1 then
                    read_addr <= (others => '0');
                else
                    read_addr <= read_addr + 1;
                end if;

            end if;



--WRITING
            --WRITE ADDR
            if clk_counter = c_ADC_SAMPLING-2 then

                write_addr <= addr;

            end if;
            
            WADDR   <= std_logic_vector(write_addr);

            --WRITE ENABLED
            WEN <= '0';

            if clk_counter = c_ADC_SAMPLING-1 then

                WEN <= '1';

            end if;

        end if;
        
    end process;


    REN <= '1';
    RADDR   <= std_logic_vector(read_addr);
--    WADDR   <= std_logic_vector(write_addr);
    OUTPUT  <= RD(c_SAMPLE_WIDTH-1 downto 0);
    WD(c_SAMPLE_WIDTH-1 downto 0) <= INPUT;
--    WD(c_MEM_WIDTH-1 downto c_SAMPLE_WIDTH) <= (others => '0');

end Behavioral;
