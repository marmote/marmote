-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;



entity SINCOS_GEN_tb is
end;

architecture bench of SINCOS_GEN_tb is

  component sincos_gen
  	port (
  		CLK         : in  std_logic;
  		RST         : in  std_logic;
  		DPHASE    : in  std_logic_vector(15 downto 0);
  		DPHASE_EN : in  std_logic;
  		COS_OUT     : out std_logic_vector(15 downto 0);
  		SIN_OUT     : out std_logic_vector(15 downto 0);
--        CCOS_OUT     : out std_logic_vector(15 downto 0);
--  		CSIN_OUT     : out std_logic_vector(15 downto 0);
--        A0          : out std_logic_vector(15 downto 0);
--  		LDDATA      : out std_logic;
--        INV_EN      : out std_logic;
--        CRDYOUT      : out std_logic;
  		RDYOUT      : out std_logic
  	);
  end component;

  signal CLK        : std_logic;
  signal RST        : std_logic;
  signal DPHASE:    std_logic_vector(15 downto 0);
  signal DPHASE_EN: std_logic;
  signal COS_OUT    : std_logic_vector(15 downto 0);
  signal SIN_OUT    : std_logic_vector(15 downto 0);
--  signal CCOS_OUT    : std_logic_vector(15 downto 0);
--  signal CSIN_OUT    : std_logic_vector(15 downto 0);
--  signal A0         : std_logic_vector(15 downto 0);
--  signal LDDATA     : std_logic;
--  signal INV_EN     : std_logic;
--  signal CRDYOUT     : std_logic;
  signal RDYOUT     : std_logic;

-- BB begin
  --signal prog         : std_logic_vector(15 downto 0); 

  constant clock_period: time := 20 ns;
-- BB end

  signal stop_the_clock: boolean;

begin

  uut: sincos_gen port map ( CLK        => CLK,
                        RST       => RST,
                        DPHASE    => DPHASE,
                        DPHASE_EN => DPHASE_EN,
                        COS_OUT   => COS_OUT,
                        SIN_OUT   => SIN_OUT,
--                            CCOS_OUT   => CCOS_OUT,
--                            CSIN_OUT   => CSIN_OUT,
--                            A0        => A0,
--                            LDDATA    => LDDATA,
--                            INV_EN    => INV_EN,
--                            CRDYOUT    => CRDYOUT,
                        RDYOUT    => RDYOUT );

  stimulus: process
  begin
  
    -- Put initialisation code here

-- BB begin
    DPHASE <= x"0010";
  	DPHASE_EN <= '1';
-- BB end

    rst <= '1';
    wait for 5 ns;
    rst <= '0';
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
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;


-- BB begin
    
--    process(PRESETn, PCLK)
--    begin
--        if PRESETn = '0' then
--            prog <=  x"0001";
--        elsif falling_edge(PCLK) then
--            if CSn = '0' or sample_rdy = '1' then
--                prog <= prog(0) & prog(15 downto 1);
--            end if;
--        end if;
--    end process;
--
--
--
--    OUTPUTS: for i in 1 to 2 generate
--        -- Sampling
--        process(PRESETn, PCLK)
--        begin
--            if PRESETn = '0' then
--                SDATA(i) <= '0';
--            elsif falling_edge(PCLK) then
--                if CSn = '0' then
--                    SDATA(i) <= prog(0);
--                end if;
--            end if;
--        end process;
--    end generate;
--
-- BB end


end;
