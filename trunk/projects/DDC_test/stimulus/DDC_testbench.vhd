-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.common.all;


entity DDC_tb is

--    generic (
--        c_CIC_INNER_WIDTH       : integer := c_CIC_WIDTH + c_CIC_ORDER * c_CIC_ORDER
--    );

end;

architecture bench of DDC_tb is

  component DDC
    port (
        RST             : in    std_logic;
        CLK             : in    std_logic;

        sample_rdy_in   : in    std_logic;
        I_in            : in    std_logic_vector(13 downto 0);
        Q_in            : in    std_logic_vector(13 downto 0);

        DPHASE          : in    std_logic_vector(15 downto 0);

        I_SMPL_RDY      : out   std_logic;
        Q_SMPL_RDY      : out   std_logic;

        I_out           : out   std_logic_vector(31 downto 0);
        Q_out           : out   std_logic_vector(31 downto 0)

    );
  end component;


        signal  RST             : std_logic;
        signal  CLK             : std_logic;

        signal  sample_rdy_in   : std_logic;
        signal  I_in            : std_logic_vector(13 downto 0);
        signal  Q_in            : std_logic_vector(13 downto 0);

        signal  DPHASE          : std_logic_vector(15 downto 0);

        signal  I_SMPL_RDY      : std_logic;
        signal  Q_SMPL_RDY      : std_logic;

        signal  I_out           : std_logic_vector(31 downto 0);
        signal  Q_out           : std_logic_vector(31 downto 0);


-- BB begin
--    constant c_ADDR_DATA    : std_logic_vector(7 downto 0) := x"00"; -- Read only

    signal clk_counter  : unsigned(log2_ceil(8*c_ADC_SAMPLING) downto 1);

  constant clock_period: time := 20 ns;
-- BB end

  signal stop_the_clock: boolean;

begin

  uut: DDC port map (
                        
        RST             =>  RST,
        CLK             =>  CLK,
        sample_rdy_in   =>  sample_rdy_in,
        I_in            =>  I_in,
        Q_in            =>  Q_in,
        DPHASE          =>  DPHASE,
        I_SMPL_RDY      =>  I_SMPL_RDY,
        Q_SMPL_RDY      =>  Q_SMPL_RDY,
        I_out           =>  I_out,
        Q_out           =>  Q_out
                      
                      );

  stimulus: process
  begin
  
    -- Put initialisation code here

-- BB begin
--    INPUT <= (others => '0');

-- BB end

    RST <= '1';
    wait for 5 ns;
    RST <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

-- BB begin
    wait for 10000 ns;    
-- BB end

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;


-- BB begin
    
--    process(PRESETn, PCLK)
--    begin
--        if PRESETn = '0' then
--            clk_counter <= (others => '0');
--            INPUT <= (others => '0');
--        elsif rising_edge(PCLK) then
--            if clk_counter >= 8*c_ADC_SAMPLING-1 then
--                clk_counter <= (others => '0');
--            else
--                clk_counter <= clk_counter + 1;
--            end if;
--
--            SMPL_RDY_IN(1) <= '0';
--            SMPL_RDY_IN(2) <= '0';
--
--            if clk_counter = 0 then
--                SMPL_RDY_IN(1) <= '1';
--                SMPL_RDY_IN(2) <= '1';
--                INPUT(c_APB3_WIDTH-1 downto 0) <= std_logic_vector(unsigned(INPUT(c_APB3_WIDTH-1 downto 0)) + 1);
--                INPUT(2*c_APB3_WIDTH-1 downto c_APB3_WIDTH) <= std_logic_vector(unsigned(INPUT(2*c_APB3_WIDTH-1 downto c_APB3_WIDTH)) + 3);
--            end if;
--
--        end if;
--    end process;
--
--
--    process(PRESETn, PCLK)
--    begin
--        if PRESETn = '0' then
--        elsif rising_edge(PCLK) then
--
--            PSEL    <= '0';
--            PWRITE  <= '0';
--
--            PADDR(7 downto 0)   <= c_ADDR_DATA;
--
--            if SMPL_RDY = '1' then
--
--                PSEL    <= '1';
--
--            end if;
--
--        end if;
--    end process;
--
--
--
-- BB end


end;
