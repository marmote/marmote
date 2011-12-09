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
        c_CIC_DECIMATION        : integer := pow2(c_CIC_ORDER);
        c_ADC_SAMPLING          : integer := 18; -- How many cycles does it take, to get one sample?
        c_CIC_INNER_WIDTH       : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER;
        c_CIC_REG_WIDTH         : integer := 47;
        c_CIC_REG_ADDR_WIDTH    : integer := 4;
--        c_CIC_GYOGYKONSTANS     : integer := 3; -- This constant comes from the fact that itt takes 3 cycles from reading memory until writing
        c_CIC_INPUT_CYCLE       : integer := 0

    );

    port (
        CLK         : in  std_logic;
        RST         : in  std_logic;

        DINA        : out  unsigned(c_CIC_REG_WIDTH-1 downto 0);
        DINB        : out  unsigned(c_CIC_REG_WIDTH-1 downto 0);
        ADDRA       : out  std_logic_vector(c_CIC_REG_ADDR_WIDTH-1 downto 0);
        ADDRB       : out  std_logic_vector(c_CIC_REG_ADDR_WIDTH-1 downto 0);
        RWA         : out  std_logic;
        RWB         : out  std_logic;
        BLKA        : out  std_logic;
        BLKB        : out  std_logic;

        DOUTA       : in  unsigned(c_CIC_REG_WIDTH-1 downto 0);
        DOUTB       : in  unsigned(c_CIC_REG_WIDTH-1 downto 0);


-- DEBUG
        --OUTDEBUG  : out std_logic_vector(c_CIC_WIDTH-1 downto 0);

        INPUT     : in  unsigned(c_CIC_WIDTH-1 downto 0);
        OUTPUT    : out std_logic_vector(c_CIC_INNER_WIDTH-1 downto 0)
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

    signal int              : unsigned(c_CIC_INNER_WIDTH-1 downto 0);
    signal comb             : unsigned(c_CIC_INNER_WIDTH-1 downto 0);

    signal clk_counter      : unsigned(1 to log2_ceil(c_ADC_SAMPLING));
    signal prog             : unsigned(1 to log2_ceil(c_CIC_DECIMATION));
    signal oddeven          : std_logic;

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
    -- INTEGRATOR STAGE

    -- moving memory value to reg 
    process(rst, clk)
    begin
        if rst = '1' then
        elsif rising_edge(clk) then

            DINA(c_CIC_REG_WIDTH-1 downto c_CIC_INNER_WIDTH) <= (others => '0');
            DINA(c_CIC_INNER_WIDTH-1 downto 0) <= int;

        end if;
    end process;


    -- adding reg to next memory AND taking care of input
    process(rst, clk)
        variable i      : integer :=0;
        variable j      : integer :=0;

    begin
        if rst = '1' then
            int <= (others => '0');
        elsif rising_edge(clk) then

            -- Get the newest sample form input
            if clk_counter = c_CIC_INPUT_CYCLE then

                int(c_CIC_INNER_WIDTH-1 downto c_CIC_WIDTH) <= (others => '0');
                int(c_CIC_WIDTH-1 downto 0) <= INPUT;

            end if;


            -- Take care of the addition            
            j := 0;
--            while j <= c_CIC_GYOGYKONSTANS-1 loop
            while j <= 2 loop

                i := j + 1;
                while i <= c_CIC_ORDER loop

                    if clk_counter = 2*(i-j)+j +2 then

                        int <= int + DOUTA(c_CIC_INNER_WIDTH-1 downto 0);
                    
                    end if;

--                    i := i + c_CIC_GYOGYKONSTANS;
                    i := i + 3;

                end loop;

                j := j + 1;

            end loop;

        end if;

    end process;


    -- reading and writing memory
    process(rst, clk)
        variable i      : integer :=0;
        variable j      : integer :=0;

    begin
        if rst = '1' then
        elsif rising_edge(clk) then

            BLKA    <= '1';

            j := 0;
--            while j <= c_CIC_GYOGYKONSTANS-1 loop
            while j <= 2 loop

                i := j + 1;
                while i <= c_CIC_ORDER loop

                    if clk_counter = 2*(i-j)+j-2 +2 then

                        -- reading
                        RWA     <= '1';
                        BLKA    <= '0';
                        ADDRA   <= std_logic_vector(to_unsigned(i -1, c_CIC_REG_ADDR_WIDTH));
                    
                    elsif clk_counter = 2*(i-j)+j+1 +2 then

                        -- writing
                        RWA     <= '0';
                        BLKA    <= '0';
                        ADDRA   <= std_logic_vector(to_unsigned(i -1, c_CIC_REG_ADDR_WIDTH));

                    end if;

--                    i := i + c_CIC_GYOGYKONSTANS;
                    i := i + 3;

                end loop;

                j := j + 1;

            end loop;

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

    -- moving value from register to memory input
    process(rst, clk)
    begin
        if rst = '1' then
        elsif rising_edge(clk) and prog = (prog'range => '0') then

            DINB(c_CIC_REG_WIDTH-1 downto c_CIC_INNER_WIDTH) <= (others => '0');
            DINB(c_CIC_INNER_WIDTH-1 downto 0) <= comb;

        end if;
    end process;


    -- adding reg to next memory AND taking care of input
    process(rst, clk)
        variable i      : integer :=0;
        variable j      : integer :=0;

    begin
        if rst = '1' then

            comb <= (others => '0');

        elsif rising_edge(clk) and prog = (prog'range => '0') then

            -- Get the newest sample form integrator
            if clk_counter = c_CIC_INPUT_CYCLE then

                comb <= int;

            end if;


            -- Take care of the addition            
            j := 0;
--            while j <= c_CIC_GYOGYKONSTANS-1 loop
            while j <= 2 loop

                i := j + 1;
                while i <= c_CIC_ORDER loop

                    if clk_counter = 2*(i-j)+j +2 then

                        comb <= comb + DOUTB(c_CIC_INNER_WIDTH-1 downto 0);
                    
                    end if;

--                    i := i + c_CIC_GYOGYKONSTANS;
                    i := i + 3;

                end loop;

                j := j + 1;

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
        variable j      : integer :=0;
        variable k      : integer :=0;


    begin
        if rst = '1' then

--            oddeven <= '0';

        elsif rising_edge(clk) and prog = (prog'range => '0') then
            
            BLKB    <= '1';  
            
            
            if oddeven = '0' then
                k := 0;
            else
                k := 1;
            end if;


            -- reading
            j := 0;
--            while j <= c_CIC_GYOGYKONSTANS-1 loop
            while j <= 2 loop

                i := j + 1;
                while i <= c_CIC_ORDER loop

                    if clk_counter = 2*(i-j)+j-2 +2 then

                        RWB     <= '1';
                        BLKB    <= '0';
                        ADDRB   <= std_logic_vector(to_unsigned(2*i + c_CIC_ORDER - k -1, c_CIC_REG_ADDR_WIDTH));
                    
                    end if;

--                    i := i + c_CIC_GYOGYKONSTANS;
                    i := i + 3;

                end loop;

                j := j + 1;

            end loop;


            -- writing
            j := 0;
--            while j <= c_CIC_GYOGYKONSTANS-1 loop
            while j <= 2 loop

                i := j + 1;
                while i < c_CIC_ORDER loop

                    if clk_counter = 2*(i-j)+j+1 +2 then

                        -- writing
                        RWB     <= '0';
                        BLKB    <= '0';
                        ADDRB   <= std_logic_vector(to_unsigned(2*i + c_CIC_ORDER + 1 + k -1, c_CIC_REG_ADDR_WIDTH));

                    end if;

--                    i := i + c_CIC_GYOGYKONSTANS;
                    i := i + 3;

                end loop;

                j := j + 1;

            end loop;


            -- writing first value
            if clk_counter = c_CIC_INPUT_CYCLE+1 then

                RWB     <= '0';
                BLKB    <= '0';
                ADDRB   <= std_logic_vector(to_unsigned(c_CIC_ORDER + 1 + k -1, c_CIC_REG_ADDR_WIDTH));

            end if;

        end if;

    end process;


    -- Writing output
    process(rst, clk)
    begin
        if rst = '1' then
        elsif rising_edge(clk) and clk_counter = c_ADC_SAMPLING-1 then

            OUTPUT <= std_logic_vector(comb);

        end if;
    end process;

end Behavioral;
