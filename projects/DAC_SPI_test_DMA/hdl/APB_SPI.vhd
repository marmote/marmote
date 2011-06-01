library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.common.all;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Entity definition
--
------------------------------------------------------------------------------
entity SPI_APB_DAC is
    port (

        PCLK        : in    std_logic;
        PRESETn     : in    std_logic;


-- APB3 interface
        PADDR       : in    std_logic_vector(31 downto 0);
        PSEL        : in    std_logic;
        PENABLE     : in    std_logic;
        PWRITE      : in    std_logic;
        PWDATA      : in    std_logic_vector(31 downto 0);

        PREADY      : out   std_logic;
        PRDATA      : out   std_logic_vector(31 downto 0);
        PSLVERR     : out   std_logic;


-- SPI interface
        SCLK        : out   std_logic;                          -- Common A/D clock signal
        SYNCn       : out   std_logic;                          -- Common A/D chip select
        SDIN        : out   std_logic;                          -- D/A data output

        --Debug
--        samples_out : out   std_logic_vector(31 downto 0);      -- Parallel sample data out debug
        
        sample_rdy  : out   std_logic                           -- Sample ready output signal

         );
end entity;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Architecture definition
--
------------------------------------------------------------------------------
architecture Behavioral of SPI_APB_DAC is


-- APB3 interface
    -- Addresses
    constant c_ADDR_DATA    : std_logic_vector(7 downto 0) := x"00"; -- Write only
    constant c_ADDR_CONTROL : std_logic_vector(7 downto 0) := x"04"; -- Write only

    -- Default values 
    constant c_DEFAULT_DATA      : unsigned(31 downto 0) := x"00000000"; 
    constant c_WRONGADDRESS_DATA : unsigned(31 downto 0) := x"55555555";


-- SPI inteface
    signal div_clk      : std_logic; -- Clock signal divided by 2

    signal samples      : std_logic_vector(31 downto 0);    

    signal prog         : std_logic_vector(35 downto 0);
    signal shift_reg    : std_logic_vector(31 downto 0);
    signal shift_en     : std_logic;

    signal sample_rdy_int   : std_logic;


begin

--------------------------------------
--          APB3 interface          --
--------------------------------------

    -- APB register write
    p_REG_WRITE : process (PRESETn, PCLK)
    begin
        if PRESETn = '0' then
    --        s_start <= '0';
            samples  <= std_logic_vector(c_DEFAULT_DATA);
        elsif rising_edge(PCLK) then

            -- Default values
    --         s_start <= '0';
    --        samples  <= std_logic_vector(c_DEFAULT_DATA);

            -- Register writes
            -- FIXME: allow writes only when no transmission is in progress
            if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
                case PADDR(7 downto 0) is
                    when c_ADDR_DATA =>
                        samples <= x"1" & PWDATA(27 downto 16) & x"4" & PWDATA(11 downto 0) ;
                    when c_ADDR_CONTROL =>
                        samples <= PWDATA;
                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process;


    -- APB register read
    p_REG_READ : process (PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            PRDATA <= std_logic_vector(c_DEFAULT_DATA);
        elsif rising_edge(PCLK) then

            -- Default output
            PRDATA <= std_logic_vector(c_DEFAULT_DATA);

            -- Register reads
            if PWRITE = '0' and PSEL = '1' then
                case PADDR(7 downto 0) is
--                    when c_ADDR_DATA =>
--                        PRDATA <= samples(1) & samples(2);
--                        PRDATA <= samples(1)(7 downto 0) & samples(1)(15 downto 8) & samples(2)(7 downto 0) & samples(2)(15 downto 8);
--                    when c_ADDR_COUNTER =>
--                        PRDATA <= counter & reverse_vector(counter);
                    when others =>
                        PRDATA <= std_logic_vector(c_WRONGADDRESS_DATA);
                end case;
            end if;
        end if;
    end process p_REG_READ;


    -- APB misc
    PREADY <= '1';
    PSLVERR <= '0';


----------------------------------
--          SPI interface       --
----------------------------------

    -- Program clock stepping
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            div_clk <=  '0';
        elsif rising_edge(PCLK) then
            div_clk <= not div_clk;
        end if;
    end process;


    -- Clock
    SCLK <= div_clk;


    -- Program stepping
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            prog <=  x"0" & x"0000" & x"0001";
        elsif (rising_edge(PCLK) and div_clk = '0') then
            prog <= prog(34 downto 0) & prog(35);
        end if;
    end process;


    -- Generate /CS from the prog
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            SYNCn <= '1';
            --shift_en <= '0';
        elsif rising_edge(PCLK) then
            if (prog(17) = '1' and div_clk = '0') then
                SYNCn <= '1';
            elsif (prog(19) = '1' and div_clk = '1') then
                SYNCn <= '0';
            elsif (prog(35) = '1' and div_clk = '0') then
                SYNCn <= '1';
            elsif (prog(1) = '1' and div_clk = '1') then
                SYNCn <= '0';
            end if;
        end if;
    end process;

    -- Generate EN signal for the shift register
    shift_en <= prog(2) or prog(3) or prog(4) or prog(5) or 
                prog(6) or prog(7) or prog(8) or prog(9) or 
                prog(10) or prog(11) or prog(12) or prog(13) or 
                prog(14) or prog(15) or prog(16) or prog(17) or
                prog(20) or prog(21) or prog(22) or prog(23) or 
                prog(24) or prog(25) or prog(26) or prog(27) or 
                prog(28) or prog(29) or prog(30) or prog(31) or 
                prog(32) or prog(33) or prog(34) or prog(35);


    -- Generate samples
    -- Sampling
    process(PCLK)
    begin
        if (rising_edge(PCLK) and div_clk = '0') then
            if prog(35) = '1' then
                shift_reg <= samples;
            elsif shift_en = '1' then
                shift_reg <= shift_reg(30 downto 0) & shift_reg(31);
            end if;
        end if;

         SDIN <= shift_reg(31);   
    end process;


    --Debug
--    samples_out <= samples;

    -- Generate RDY signal when sampling is done
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            sample_rdy_int <= '0';
        elsif rising_edge(PCLK) then
            if (div_clk = '0' and prog(0) = '1') then
                sample_rdy_int <= '1';
            elsif (div_clk = '1') then
                sample_rdy_int <= '0';
            end if;
        end if;
    end process;


    sample_rdy <= sample_rdy_int;


end Behavioral;
