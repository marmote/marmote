-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity top is

    port( MSS_RESET_N : in    std_logic;
          MAINXIN     : in    std_logic;
          IO_8_PADOUT : out   std_logic;
          IO_7_PADIN  : in    std_logic;
          IO_6_PADIN  : in    std_logic;
          IO_5_PADOUT : out   std_logic;
          OUTPUT_0    : out   std_logic_vector(37 downto 0);
          OUTPUT_1    : out   std_logic_vector(37 downto 0);
          CH1         : out   std_logic_vector(13 downto 0);
          CH2         : out   std_logic_vector(13 downto 0)
        );

end top;

architecture DEF_ARCH of top is 

  component DDC
    port( RST      : in    std_logic := 'U';
          CLK      : in    std_logic := 'U';
          SCLK     : out   std_logic;
          CSn      : out   std_logic;
          SDATA    : in    std_logic_vector(1 to 2) := (others => 'U');
          OUTPUT_0 : out   std_logic_vector(37 downto 0);
          OUTPUT_1 : out   std_logic_vector(37 downto 0);
          CH1      : out   std_logic_vector(13 downto 0);
          CH2      : out   std_logic_vector(13 downto 0)
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component uC
    port( MSS_RESET_N : in    std_logic := 'U';
          FAB_CLK     : out   std_logic;
          MAINXIN     : in    std_logic := 'U';
          M2F_RESET_N : out   std_logic;
          IO_8_PADOUT : out   std_logic;
          IO_8_D      : in    std_logic := 'U';
          IO_7_PADIN  : in    std_logic := 'U';
          IO_7_Y      : out   std_logic;
          IO_6_PADIN  : in    std_logic := 'U';
          IO_6_Y      : out   std_logic;
          IO_5_PADOUT : out   std_logic;
          IO_5_D      : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal DDC_0_CSn, DDC_0_SCLK, uC_0_FAB_CLK, uC_0_IO_6_Y, 
        uC_0_IO_7_Y, uC_0_M2F_RESET_N, GND_net, VCC_net
         : std_logic;

begin 


    DDC_0 : DDC
      port map(RST => uC_0_M2F_RESET_N, CLK => uC_0_FAB_CLK, SCLK
         => DDC_0_SCLK, CSn => DDC_0_CSn, SDATA(1) => uC_0_IO_7_Y, 
        SDATA(2) => uC_0_IO_6_Y, OUTPUT_0(37) => OUTPUT_0(37), 
        OUTPUT_0(36) => OUTPUT_0(36), OUTPUT_0(35) => 
        OUTPUT_0(35), OUTPUT_0(34) => OUTPUT_0(34), OUTPUT_0(33)
         => OUTPUT_0(33), OUTPUT_0(32) => OUTPUT_0(32), 
        OUTPUT_0(31) => OUTPUT_0(31), OUTPUT_0(30) => 
        OUTPUT_0(30), OUTPUT_0(29) => OUTPUT_0(29), OUTPUT_0(28)
         => OUTPUT_0(28), OUTPUT_0(27) => OUTPUT_0(27), 
        OUTPUT_0(26) => OUTPUT_0(26), OUTPUT_0(25) => 
        OUTPUT_0(25), OUTPUT_0(24) => OUTPUT_0(24), OUTPUT_0(23)
         => OUTPUT_0(23), OUTPUT_0(22) => OUTPUT_0(22), 
        OUTPUT_0(21) => OUTPUT_0(21), OUTPUT_0(20) => 
        OUTPUT_0(20), OUTPUT_0(19) => OUTPUT_0(19), OUTPUT_0(18)
         => OUTPUT_0(18), OUTPUT_0(17) => OUTPUT_0(17), 
        OUTPUT_0(16) => OUTPUT_0(16), OUTPUT_0(15) => 
        OUTPUT_0(15), OUTPUT_0(14) => OUTPUT_0(14), OUTPUT_0(13)
         => OUTPUT_0(13), OUTPUT_0(12) => OUTPUT_0(12), 
        OUTPUT_0(11) => OUTPUT_0(11), OUTPUT_0(10) => 
        OUTPUT_0(10), OUTPUT_0(9) => OUTPUT_0(9), OUTPUT_0(8) => 
        OUTPUT_0(8), OUTPUT_0(7) => OUTPUT_0(7), OUTPUT_0(6) => 
        OUTPUT_0(6), OUTPUT_0(5) => OUTPUT_0(5), OUTPUT_0(4) => 
        OUTPUT_0(4), OUTPUT_0(3) => OUTPUT_0(3), OUTPUT_0(2) => 
        OUTPUT_0(2), OUTPUT_0(1) => OUTPUT_0(1), OUTPUT_0(0) => 
        OUTPUT_0(0), OUTPUT_1(37) => OUTPUT_1(37), OUTPUT_1(36)
         => OUTPUT_1(36), OUTPUT_1(35) => OUTPUT_1(35), 
        OUTPUT_1(34) => OUTPUT_1(34), OUTPUT_1(33) => 
        OUTPUT_1(33), OUTPUT_1(32) => OUTPUT_1(32), OUTPUT_1(31)
         => OUTPUT_1(31), OUTPUT_1(30) => OUTPUT_1(30), 
        OUTPUT_1(29) => OUTPUT_1(29), OUTPUT_1(28) => 
        OUTPUT_1(28), OUTPUT_1(27) => OUTPUT_1(27), OUTPUT_1(26)
         => OUTPUT_1(26), OUTPUT_1(25) => OUTPUT_1(25), 
        OUTPUT_1(24) => OUTPUT_1(24), OUTPUT_1(23) => 
        OUTPUT_1(23), OUTPUT_1(22) => OUTPUT_1(22), OUTPUT_1(21)
         => OUTPUT_1(21), OUTPUT_1(20) => OUTPUT_1(20), 
        OUTPUT_1(19) => OUTPUT_1(19), OUTPUT_1(18) => 
        OUTPUT_1(18), OUTPUT_1(17) => OUTPUT_1(17), OUTPUT_1(16)
         => OUTPUT_1(16), OUTPUT_1(15) => OUTPUT_1(15), 
        OUTPUT_1(14) => OUTPUT_1(14), OUTPUT_1(13) => 
        OUTPUT_1(13), OUTPUT_1(12) => OUTPUT_1(12), OUTPUT_1(11)
         => OUTPUT_1(11), OUTPUT_1(10) => OUTPUT_1(10), 
        OUTPUT_1(9) => OUTPUT_1(9), OUTPUT_1(8) => OUTPUT_1(8), 
        OUTPUT_1(7) => OUTPUT_1(7), OUTPUT_1(6) => OUTPUT_1(6), 
        OUTPUT_1(5) => OUTPUT_1(5), OUTPUT_1(4) => OUTPUT_1(4), 
        OUTPUT_1(3) => OUTPUT_1(3), OUTPUT_1(2) => OUTPUT_1(2), 
        OUTPUT_1(1) => OUTPUT_1(1), OUTPUT_1(0) => OUTPUT_1(0), 
        CH1(13) => CH1(13), CH1(12) => CH1(12), CH1(11) => 
        CH1(11), CH1(10) => CH1(10), CH1(9) => CH1(9), CH1(8) => 
        CH1(8), CH1(7) => CH1(7), CH1(6) => CH1(6), CH1(5) => 
        CH1(5), CH1(4) => CH1(4), CH1(3) => CH1(3), CH1(2) => 
        CH1(2), CH1(1) => CH1(1), CH1(0) => CH1(0), CH2(13) => 
        CH2(13), CH2(12) => CH2(12), CH2(11) => CH2(11), CH2(10)
         => CH2(10), CH2(9) => CH2(9), CH2(8) => CH2(8), CH2(7)
         => CH2(7), CH2(6) => CH2(6), CH2(5) => CH2(5), CH2(4)
         => CH2(4), CH2(3) => CH2(3), CH2(2) => CH2(2), CH2(1)
         => CH2(1), CH2(0) => CH2(0));
    
    \VCC\ : VCC
      port map(Y => VCC_net);
    
    uC_0 : uC
      port map(MSS_RESET_N => MSS_RESET_N, FAB_CLK => 
        uC_0_FAB_CLK, MAINXIN => MAINXIN, M2F_RESET_N => 
        uC_0_M2F_RESET_N, IO_8_PADOUT => IO_8_PADOUT, IO_8_D => 
        DDC_0_CSn, IO_7_PADIN => IO_7_PADIN, IO_7_Y => 
        uC_0_IO_7_Y, IO_6_PADIN => IO_6_PADIN, IO_6_Y => 
        uC_0_IO_6_Y, IO_5_PADOUT => IO_5_PADOUT, IO_5_D => 
        DDC_0_SCLK);
    
    \GND\ : GND
      port map(Y => GND_net);
    

end DEF_ARCH; 
