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
entity SPI_APB_ADC is
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
        CSn         : out   std_logic;                          -- Common A/D chip select
        SDATA       : in    std_logic_vector(1 to 2);           -- A/D data inputs

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
architecture Behavioral of SPI_APB_ADC is


-- APB3 interface
    -- Addresses
    constant c_ADDR_DATA    : std_logic_vector(7 downto 0) := x"00"; -- Read only
    constant c_ADDR_COUNTER : std_logic_vector(7 downto 0) := x"04"; -- Read only

    -- Default values (based on the Matlab simulation results)
    constant c_DEFAULT_DATA      : unsigned(31 downto 0) := x"00000000"; 
    constant c_WRONGADDRESS_DATA : unsigned(31 downto 0) := x"55555555";


-- SPI inteface
    signal samples      : sample_vector(1 to 2);    -- Parallel sample data out


    type byte_vector is array ( natural range <> ) of std_logic_vector(15 downto 0);

    signal prog         : std_logic_vector(19 downto 0);
    signal shift_regs   : byte_vector(samples'range);
    signal shift_en     : std_logic;

    signal counter      : std_logic_vector(15 downto 0);

begin

--------------------------------------
--          APB3 interface          --
--------------------------------------

    -- APB register write
    p_REG_WRITE : process (PRESETn, PCLK)
    begin
        if PRESETn = '0' then
    --        s_start <= '0';
    --        s_correlation_delay  <= std_logic_vector(c_DEFAULT_CORD);
        elsif rising_edge(PCLK) then

            -- Default values
    --         s_start <= '0';

            -- Register writes
            -- FIXME: allow writes only when no transmission is in progress
            if PWRITE = '1' and PSEL = '1' and PENABLE = '1' then
                case PADDR(7 downto 0) is
    --                when c_ADDR_CTRL =>
    --                    s_start <= PWDATA(0);
    --                when c_ADDR_BAUD =>
    --                    s_baud <= PWDATA;
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
                    when c_ADDR_DATA =>
                        PRDATA <= samples(1) & samples(2);
                    when c_ADDR_COUNTER =>
                        PRDATA <= counter & reverse_vector(counter);
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

    -- Clock
    SCLK <= PCLK;


    -- Program stepping
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            prog <=  x"00001";
        elsif falling_edge(PCLK) then
            prog <= prog(18 downto 0) & prog(19);
        end if;
    end process;


    -- Generate /CS from the prog
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            CSn <= '1';
            --shift_en <= '0';
        elsif rising_edge(PCLK) then
            if prog(19) = '1' then
                CSn <= '1';
                --shift_en <= '0';
            elsif prog(3) = '1' then
                CSn <= '0';
                --shift_en <= '1';
            end if;
        end if;
    end process;


    -- Generate EN signal for the shift register
    shift_en <= prog(4) or prog(5) or prog(6) or prog(7) or prog(8) or prog(9) or prog(10) or prog(11) or prog(12) or prog(13) or prog(14) or prog(15) or prog(16) or prog(17) or prog(18) or prog(19);


    -- Generate RDY signal when sampling is done - Not really used anywhere
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            sample_rdy <= '0';
        elsif rising_edge(PCLK) then
            sample_rdy <= prog(19);
        end if;
    end process;


    INPUTS: for i in 1 to 2 generate
        -- Sampling
        process(PCLK)
        begin
            if rising_edge(PCLK) then
                if shift_en = '1' then
                    shift_regs(i) <= shift_regs(i)(14 downto 0) & SDATA(i);
                end if;
            end if;
        end process;

        samples(i) <= shift_regs(i) when prog(0) = '1';
    end generate;


    -- Counter stepping
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            counter <=  x"0001";
        elsif falling_edge(PCLK) and sample_rdy = '1' then
            counter <= counter(14 downto 0) & counter(15);
        end if;
    end process;

end Behavioral;
