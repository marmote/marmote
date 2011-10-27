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
entity ADC_SPI is
    port (

        PCLK        : in    std_logic;
        PRESETn     : in    std_logic;


-- parallel output
        CH1         : out   std_logic_vector(SAMPLE_WIDTH-1 downto 0);
        CH2         : out   std_logic_vector(SAMPLE_WIDTH-1 downto 0);


-- SPI interface
        SCLK        : out   std_logic;                          -- Common A/D clock signal
        CSn         : out   std_logic;                          -- Common A/D chip select
        SDATA       : in    std_logic_vector(1 to 2);           -- A/D data inputs

        --Debug
        --samples_out : out   sample_vector(1 to 2);              -- Parallel sample data out debug
        
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
architecture Behavioral of ADC_SPI is

    type sample_vector  is array ( natural range <> ) of std_logic_vector(SAMPLE_WIDTH-1 downto 0);
    type byte_vector    is array ( natural range <> ) of std_logic_vector(15 downto 0);


-- Parallel out
    signal samples          : sample_vector(1 to 2);    -- Parallel sample data out


-- SPI inteface
    signal prog             : std_logic_vector(17 downto 0);
--    signal shift_regs   : byte_vector(samples'range);
    signal shift_regs       : byte_vector(1 to 2);
    signal shift_en         : std_logic;

    signal counter          : std_logic_vector(15 downto 0);
    signal rev_counter      : std_logic_vector(15 downto 0);


    signal sample_rdy_int   : std_logic;


begin

   CH1 <= samples(1);
   CH2 <= samples(2);
--   CH1 <= counter;
--   CH2 <= reverse_vector(counter);


----------------------------------
--          SPI interface       --
----------------------------------

    -- Clock
    SCLK <= PCLK;


    -- Program stepping
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            prog <=  '0' & '0' & x"0001";
        elsif rising_edge(PCLK) then
            prog <= prog(16 downto 0) & prog(17);
        end if;
    end process;


    -- Generate /CS from the prog
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            CSn <= '1';
            --shift_en <= '0';
        elsif rising_edge(PCLK) then
            if prog(17) = '1' then
                CSn <= '1';
                --shift_en <= '0';
            elsif prog(1) = '1' then
                CSn <= '0';
                --shift_en <= '1';
            end if;
        end if;
    end process;


    -- Generate EN signal for the shift register
    shift_en <= prog(2) or prog(3) or prog(4) or prog(5) or prog(6) or prog(7) or prog(8) or prog(9) or prog(10) or prog(11) or prog(12) or prog(13) or prog(14) or prog(15) or prog(16) or prog(17);


    -- Generate samples
    INPUTS: for i in 1 to 2 generate
        -- Sampling
        process(PCLK)
        begin
            if falling_edge(PCLK) then
                if shift_en = '1' then
                    shift_regs(i) <= shift_regs(i)(14 downto 0) & SDATA(i);
                end if;


            end if;

            if rising_edge(PCLK) then
                if prog(0) = '1' then

                    -- WARNING!!! ADC GENERATES UNSIGNED NUMBERS WHEREAS WE NEED SIGNED NUMBERS, THUS THE MSB BIT IS INVERTED!
                    samples(i) <= (not shift_regs(i)(SAMPLE_WIDTH-1)) & shift_regs(i)(SAMPLE_WIDTH-2 downto 0);

                end if;
            end if;
        end process;
    end generate;


    --Debug
    --samples_out <= samples;


    -- Generate RDY signal when sampling is done
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            sample_rdy_int <= '0';
        elsif rising_edge(PCLK) then
            sample_rdy_int <= prog(0);
        end if;
    end process;


    sample_rdy <= sample_rdy_int;


    -- Counter stepping
    process(PRESETn, PCLK)
    begin
        if PRESETn = '0' then
            counter <=  x"0001";
        elsif rising_edge(PCLK) and prog(0) = '1' then
            counter <= counter(14 downto 0) & counter(15);
        end if;
    end process;

    rev_counter <= reverse_vector(counter);

end Behavioral;
