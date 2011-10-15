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
        OUTPUT      : out std_logic_vector(c_CIC_INNER_WIDTH-1 downto 0)  
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
--    signal int              : unsigned(c_CIC_INNER_WIDTH-1 downto 0);   
    signal int_vec          : sample_vector(0 to c_CIC_ORDER);
    signal int_en           : std_logic;

    signal comb             : unsigned(c_CIC_INNER_WIDTH-1 downto 0);  

    signal clk_counter      : std_logic_vector(c_ADC_SAMPLING - 1 downto 0);  
    signal prog             : std_logic_vector(c_CIC_DECIMATION - 1 downto 0); 
    signal oddeven          : std_logic;      
    signal clk_counter2     : unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);  

begin

    -- Clock counter
    process(rst, clk)
    begin
        if rst = '1' then
            clk_counter <= (0 => '1', others => '0');
        elsif rising_edge(clk) then
            clk_counter <= clk_counter(c_ADC_SAMPLING - 2 downto 0) & clk_counter(c_ADC_SAMPLING - 1);
        end if;
    end process;

    -- Clock counter 2
    process(rst, clk)
    begin
        if rst = '1' then
            clk_counter2 <= (others => '0');
        elsif rising_edge(clk) and (prog = (prog'range => '0') or clk_counter2 /= 0)then
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

        elsif rising_edge(clk) then

--            int_en <= OR_signal(clk_counter(c_CIC_ORDER downto 0));

            if clk_counter(c_CIC_INPUT_CYCLE) = '1' then

                -- Get the newest sample form input
                int_vec(c_CIC_ORDER)(c_CIC_INNER_WIDTH-1 downto c_CIC_WIDTH) <= (others => '0');
                int_vec(c_CIC_ORDER)(c_CIC_WIDTH-1 downto 0) <= INPUT;
            
--            elsif int_en = '1' then
            elsif OR_signal(clk_counter(c_CIC_ORDER+1 downto 1)) = '1' then

                int_vec(c_CIC_ORDER) <= int_vec(c_CIC_ORDER) + int_vec(0);

                for i in 1 to c_CIC_ORDER loop

                    int_vec(i-1) <= int_vec(i);

                end loop;
                   
            end if;

        end if;
        
    end process;


    ----------------------------------------------------
    ----------------------------------------------------
    -- DECIMATION
    process(rst, clk)
    begin
        if rst = '1' then
            prog <= (0 => '1', others => '0');
        elsif rising_edge(clk) and clk_counter(c_ADC_SAMPLING-1) = '1' then
            prog <= prog(c_CIC_DECIMATION - 2 downto 0) & prog(c_CIC_DECIMATION - 1);
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
        variable i      : integer :=0;

    begin
        if rst = '1' then

            comb <= (others => '0');

        elsif rising_edge(clk) and (prog = (prog'range => '0') or clk_counter2 /= 0) then

            -- Get the newest sample form integrator
            if clk_counter2 = c_CIC_INPUT_CYCLE then

                comb <= int_vec(c_CIC_ORDER-1);

            end if;


            -- Take care of the addition
            for i in 1 to c_CIC_ORDER loop

                if clk_counter2 = 6*i then

                    --LOW 
                    comb <= comb + RD;

                elsif clk_counter2 = 6*i + 1 then

                    --HIGH
                    comb(c_CIC_INNER_WIDTH - 1 downto c_CIC_REG_WIDTH) <= comb(c_CIC_INNER_WIDTH - 1 downto c_CIC_REG_WIDTH) + RD(c_CIC_INNER_WIDTH - c_CIC_REG_WIDTH - 1 downto 0);

                end if;

            end loop;

        end if;

    end process;


    process(rst, clk)
    begin
        if rst = '1' then
            oddeven <= '0';
        elsif rising_edge(clk) and prog(c_CIC_DECIMATION-1) = '1' and clk_counter(c_ADC_SAMPLING-1) = '1' then
             oddeven <= not oddeven;
        end if;

    end process;


    -- reading and writing memory
    process(rst, clk)
        variable i      : integer :=0;
        variable k      : integer :=0;


    begin
        if rst = '1' then

        elsif rising_edge(clk) and (prog = (prog'range => '0') or clk_counter2 /= 0) then

            if oddeven = '0' then
                k := 1;
            else
                k := -1;
            end if;


            -- reading
            REN <= '0';

            for i in 1 to c_CIC_ORDER loop

                if clk_counter2 = 6*i-2 then

                    --LOW
                    REN     <= '1';
                    RADDR   <= std_logic_vector(to_unsigned(4*i - 3 + k, c_CIC_REG_ADDR_WIDTH));


                elsif clk_counter2 = 6*i-2 + 1 then

                    --HIGH
                    REN     <= '1';
                    RADDR   <= std_logic_vector(to_unsigned(4*i - 2 + k, c_CIC_REG_ADDR_WIDTH));

                end if;

            end loop;


            -- writing
            WEN <= '0';
            
            for i in 1 to c_CIC_ORDER loop

                if clk_counter2 = 6*i-5 then

                    --LOW
                    WEN     <= '1';
                    WADDR   <= std_logic_vector(to_unsigned(4*i - 3 - k, c_CIC_REG_ADDR_WIDTH));


                elsif clk_counter2 = 6*i-5 + 1 then

                    --HIGH
                    WEN     <= '1';
                    WADDR   <= std_logic_vector(to_unsigned(4*i - 2 - k, c_CIC_REG_ADDR_WIDTH));

                end if;

            end loop;

        end if;

    end process;



	-- Assign output signal
    output  <= std_logic_vector(comb);  



end Behavioral;
