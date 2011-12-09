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
entity CIC_COMB_control is
    generic (
        c_CIC_DECIMATION        : integer := pow2(c_CIC_ORDER);
        c_CIC_INNER_WIDTH       : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER;
        c_CIC_REG_WIDTH         : integer := 36;
        c_CIC_REG_ADDR_WIDTH    : integer := 2;
        c_CIC_INPUT_CYCLE       : integer := 0  
    );

   	port (
		CLK         : in    std_logic;
		RST         : in    std_logic;


        clk_counter : in    unsigned(log2_ceil(c_ADC_SAMPLING) downto 1);  
        dec_counter : in    unsigned(log2_ceil(c_CIC_DECIMATION) downto 1);

        WD          : out   std_logic_vector(c_CIC_REG_WIDTH-1 downto 0);
        WADDR       : out   std_logic_vector(c_CIC_REG_ADDR_WIDTH-1 downto 0);
        RADDR       : out   std_logic_vector(c_CIC_REG_ADDR_WIDTH-1 downto 0);
        WEN         : out   std_logic;
        REN         : out   std_logic;

        RD          : in    std_logic_vector(c_CIC_REG_WIDTH-1 downto 0);


		INPUT       : in    std_logic_vector(c_CIC_INNER_WIDTH-1 downto 0);
        OUTPUT      : out   std_logic_vector(c_CIC_INNER_WIDTH-1 downto 0);  

        SMPL_RDY    : out   std_logic
	);
end entity; 


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of CIC_COMB_control is

--    type sample_vector is array ( natural range <> ) of unsigned(c_CIC_INNER_WIDTH-1 downto 0);

	-- Signals
    signal comb             : signed(c_CIC_INNER_WIDTH-1 downto 0);  

    signal oddeven          : std_logic;      


begin

    ----------------------------------------------------
    ----------------------------------------------------
    -- COMB STAGE

    -- moving value from register to memory input
    process(rst, clk)
    begin
        if rst = '1' then
        elsif rising_edge(clk) and dec_counter = 0 then

            WD(c_CIC_REG_WIDTH-1 downto c_CIC_INNER_WIDTH) <= (others => comb(comb'high));
            WD(c_CIC_INNER_WIDTH-1 downto 0) <= std_logic_vector(comb);

        end if;
    end process;


    -- adding reg to next memory AND taking care of input
    process(rst, clk)
        variable i      : integer :=0;
        variable j      : integer :=0;

    begin
        if rst = '1' then

            comb <= (others => '0');

        elsif rising_edge(clk) and dec_counter = 0 then

            -- Get the newest sample form integrator
            if clk_counter = c_CIC_INPUT_CYCLE then

                comb <= signed(INPUT);

            end if;


            -- Take care of the addition            
            j := 0;
            while j <= 2 loop

                i := j + 1;
                while i <= c_CIC_ORDER loop

                    if clk_counter = 2*(i-j)+j +2 then

                        comb <= comb - signed(RD(c_CIC_INNER_WIDTH-1 downto 0));
                    
                    end if;

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
        elsif rising_edge(clk) and dec_counter = c_CIC_DECIMATION-1 and clk_counter = c_ADC_SAMPLING-1 then
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
        elsif rising_edge(clk) and dec_counter = 0 then
            
            if oddeven = '0' then
                k := 0;
            else
                k := 1;
            end if;


            -- reading
            REN <= '0';  

            j := 0;
            while j <= 2 loop

                i := j + 1;
                while i <= c_CIC_ORDER loop

                    if clk_counter = 2*(i-j)+j-2 +2 then

                        REN     <= '1';
                        RADDR   <= std_logic_vector(to_unsigned(2*i - k -1, c_CIC_REG_ADDR_WIDTH));
                    
                    end if;

                    i := i + 3;

                end loop;

                j := j + 1;

            end loop;


            -- writing
            WEN <= '0'; 

            j := 0;
            while j <= 2 loop

                i := j + 1;
                while i < c_CIC_ORDER loop

                    if clk_counter = 2*(i-j)+j+1 +2 then

                        WEN     <= '1';
                        WADDR   <= std_logic_vector(to_unsigned(2*i + 1 + k -1, c_CIC_REG_ADDR_WIDTH));

                    end if;

                    i := i + 3;

                end loop;

                j := j + 1;

            end loop;


            -- writing first value
            if clk_counter = c_CIC_INPUT_CYCLE+1 then

                WEN     <= '1';
                WADDR   <= std_logic_vector(to_unsigned(1 + k -1, c_CIC_REG_ADDR_WIDTH));

            end if;

        end if;

    end process;


    -- Writing output
    process(rst, clk)
    begin
        if rst = '1' then
            SMPL_RDY <= '0';
        elsif rising_edge(clk) then
        
            SMPL_RDY <= '0';

            if clk_counter = c_ADC_SAMPLING-1 and dec_counter = 0 then
            
                SMPL_RDY <= '1';

                OUTPUT <= std_logic_vector(comb);

            end if;

        end if;
    end process;



end Behavioral;
