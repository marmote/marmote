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
--  NEW FIFO
--    signal int              : unsigned(c_CIC_INNER_WIDTH-1 downto 0);   
--    signal int_vec          : sample_vector(1 to c_CIC_ORDER);
    signal int_vec          : sample_vector(0 to c_CIC_ORDER);
--  NEW FIFO END

    signal comb             : unsigned(c_CIC_INNER_WIDTH-1 downto 0);  

    signal clk_counter      : unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);  
    signal prog             : unsigned(log2_ceil(c_CIC_DECIMATION) downto 1); 
    signal oddeven          : std_logic;      
    signal clk_counter2     : unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);  

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

--  NEW FIFO
--        if rst = '1' then
--            int <= (others => '0');
--        elsif rising_edge(clk) then
--
--            if clk_counter = c_CIC_INPUT_CYCLE then
--
--                -- Get the newest sample form input
--                int(c_CIC_INNER_WIDTH-1 downto c_CIC_WIDTH) <= (others => '0');
--                int(c_CIC_WIDTH-1 downto 0) <= INPUT;
--            
--            elsif clk_counter <= 2*c_CIC_ORDER then
--
--                if clk_counter(1) = '1' then
--
--                    int_vec(1) <= int_vec(1) + int;
--
--                else
--                    
--                    int <= int_vec(1);
--
--                    --i := 0;
--                    for i in 2 to c_CIC_ORDER loop
--
--                        int_vec(i-1) <= int_vec(i);
--
--                    end loop;
--
--                    int_vec(c_CIC_ORDER) <= int_vec(1);
--
--                end if;
--                   
--            end if;
--
--        end if;
   
        if rst = '1' then

        elsif rising_edge(clk) then

            if clk_counter = c_CIC_INPUT_CYCLE then

                -- Get the newest sample form input
                int_vec(c_CIC_ORDER)(c_CIC_INNER_WIDTH-1 downto c_CIC_WIDTH) <= (others => '0');
                int_vec(c_CIC_ORDER)(c_CIC_WIDTH-1 downto 0) <= INPUT;
            
            elsif clk_counter <= c_CIC_ORDER + 1 then

                int_vec(c_CIC_ORDER) <= int_vec(c_CIC_ORDER) + int_vec(0);

                for i in 1 to c_CIC_ORDER loop

                    int_vec(i-1) <= int_vec(i);

                end loop;
                   
            end if;

        end if;
--  NEW FIFO END   
        
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
        variable i      : integer :=0;

    begin
        if rst = '1' then

            comb <= (others => '0');

        elsif rising_edge(clk) and (prog = (prog'range => '0') or clk_counter2 /= 0) then

            -- Get the newest sample form integrator
            if clk_counter2 = c_CIC_INPUT_CYCLE then

--  NEW FIFO
--                comb <= int;
                comb <= int_vec(c_CIC_ORDER-1);
--  NEW FIFO END

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
        elsif rising_edge(clk) and prog = c_CIC_DECIMATION-1 and clk_counter = c_ADC_SAMPLING-1 then
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
