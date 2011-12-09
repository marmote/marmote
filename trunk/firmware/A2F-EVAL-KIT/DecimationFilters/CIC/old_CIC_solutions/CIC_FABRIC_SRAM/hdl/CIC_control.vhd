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
        c_CIC_COMB_CYCLES       : integer := 4+6*c_CIC_ORDER;
        c_CIC_DECIMATION        : integer := pow2(c_CIC_ORDER);
        c_ADC_SAMPLING          : integer := 18; -- How many cycles does it take, to get one sample?
        c_CIC_INNER_WIDTH       : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER;
        c_CIC_REG_WIDTH         : integer := 27;
        c_CIC_REG_ADDR_WIDTH    : integer := 5;
        c_CIC_INPUT_CYCLE       : integer := 0  
    );

   	port (
		CLK       : in  std_logic;
		RST       : in  std_logic;


        WD          : out  unsigned(c_CIC_REG_WIDTH-1 downto 0);
        WADDR       : out  std_logic_vector(c_CIC_REG_ADDR_WIDTH-1 downto 0);
        RADDR       : out  std_logic_vector(c_CIC_REG_ADDR_WIDTH-1 downto 0);
        WEN         : out  std_logic;
        REN         : out  std_logic;

        RD          : in  unsigned(c_CIC_REG_WIDTH-1 downto 0);


		INPUT       : in  unsigned(c_CIC_WIDTH-1 downto 0);
        OUTPUT      : out std_logic_vector(46 downto 0)  
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

    type sample_vector is array ( natural range <> ) of unsigned(c_CIC_INNER_WIDTH-1 downto 0);

	-- Signals
    signal int              : unsigned(c_CIC_INNER_WIDTH-1 downto 0);   
    signal int_vec          : sample_vector(1 to c_CIC_ORDER);

    signal comb             : unsigned(c_CIC_INNER_WIDTH-1 downto 0);  

    signal clk_counter      : unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);  
    signal prog             : unsigned(log2_ceil(c_CIC_DECIMATION) downto 1); 
    signal oddeven          : std_logic;      
    signal clk_counter2     : unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);  


    signal add_timer        : unsigned(log2_ceil(c_ADC_SAMPLING) downto 2);  
    signal w_timer          : unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);
    signal r_timer          : unsigned(log2_ceil(c_ADC_SAMPLING) downto 2);
    signal addr_counter     : unsigned(c_CIC_REG_ADDR_WIDTH-1 downto 2);

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

    -- Clock counter 2
    process(rst, clk)
    begin
        if rst = '1' then
            clk_counter2 <= (others => '0');
        elsif rising_edge(clk) and (prog = 0 or clk_counter2 /= 0)then
            if clk_counter2 >= c_CIC_COMB_CYCLES-1 then
                clk_counter2 <= (others => '0');
            else
                clk_counter2 <= clk_counter2 + 1;
            end if;
        end if;
    end process;


    ----------------------------------------------------
    ----------------------------------------------------
    -- INTEGRATOR STAGE
    process (rst, clk)
        variable i      : integer :=0;          

    begin

        if rst = '1' then
            int <= (others => '0');
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


    ----------------------------------------------------
    ----------------------------------------------------
    -- DECIMATION
    process(rst, clk)
    begin
        if rst = '1' then
            prog <= (others => '0');
        elsif rising_edge(clk) and clk_counter = c_ADC_SAMPLING-1 then
            if prog >= c_CIC_DECIMATION-1 then
                prog <= (others => '0');
            else
                prog <= prog + 1;
            end if;
        end if;
    end process;


    ----------------------------------------------------
    ----------------------------------------------------
    -- COMB STAGE

    -- moving memory value to reg 
    process(rst, clk)
    begin
        if rst = '1' then
        elsif rising_edge(clk) then

            if clk_counter2(1) = '1' then

                --LOW part of data
                WD <= comb(c_CIC_REG_WIDTH-1 downto 0);

            else

                --HIGH part of data
                WD(c_CIC_REG_WIDTH-1 downto c_CIC_INNER_WIDTH - c_CIC_REG_WIDTH) <= (others => '0');
                WD(c_CIC_INNER_WIDTH - c_CIC_REG_WIDTH - 1 downto 0) <= comb(c_CIC_INNER_WIDTH-1 downto c_CIC_REG_WIDTH);

            end if;

        end if;
    end process;


    -- adding reg to next memory AND taking care of input
    process(rst, clk)
    begin
        if rst = '1' then
            
            add_timer <= (2 => '1', 3 => '1', others => '0'); -- that's 3 right there
            comb <= (others => '0');

        elsif rising_edge(clk) then
        
            if (prog = 0 or clk_counter2 /= 0) then
        
                -- Get the newest sample form integrator
                if clk_counter2 = c_CIC_INPUT_CYCLE then

                    comb <= int;

                end if;

            end if;

            if clk_counter2(log2_ceil(c_ADC_SAMPLING) downto 2) = add_timer then
                if  clk_counter2(1) = '0' then
                    --LOW 
                    comb <= comb + RD;
                else
                    --HIGH
                    comb(c_CIC_INNER_WIDTH - 1 downto c_CIC_REG_WIDTH) <= comb(c_CIC_INNER_WIDTH - 1 downto c_CIC_REG_WIDTH) + RD(c_CIC_INNER_WIDTH - c_CIC_REG_WIDTH - 1 downto 0);

                    add_timer <= add_timer + 3;
                end if;
            end if;

        end if;

    end process;


    process(rst, clk)
    begin
        if rst = '1' then
            oddeven <= '0';
        elsif rising_edge(clk) and prog = c_CIC_DECIMATION-1 and clk_counter = c_ADC_SAMPLING-1 then
            oddeven <= not oddeven;
        end if;

    end process;


    -- reading and writing memory
    process(rst, clk)
    begin
        if rst = '1' then

            r_timer <= (2 => '0', 3 => '1', others => '0'); -- that's 2 right there
            w_timer <= (1 => '1', others => '0'); -- that's 1 right there
            addr_counter <= (others => '0');

        elsif rising_edge(clk) and clk_counter2 /= 0 then

            -- reading
            REN <= '0';

            if clk_counter2(log2_ceil(c_ADC_SAMPLING) downto 2) = r_timer then

                REN     <= '1';
                RADDR   <= std_logic_vector(addr_counter) & not oddeven & clk_counter2(1);

                if  clk_counter2(1) = '1' then
                    addr_counter <= addr_counter + 1;
                    r_timer <= r_timer + 3;
                end if;

            end if;  


            -- writing
            WEN <= '0';
            
            if clk_counter2 = w_timer then

                WEN     <= '1';
                WADDR   <= std_logic_vector(addr_counter) & oddeven & not clk_counter2(1);

                if  clk_counter2(1) = '1' then
                        --LOW
                        w_timer <= w_timer + 1;
                else
                        --HIGH
--                        w_addr_counter <= w_addr_counter + 1;
                        w_timer <= w_timer + 5;
                end if;

            end if;            

        end if;

    end process;

	-- Assign output signal
    output(c_CIC_INNER_WIDTH-1 downto 0)  <= std_logic_vector(comb);  

end Behavioral;
