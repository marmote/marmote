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
          IO_5_PADOUT : out   std_logic
        );

end top;

architecture DEF_ARCH of top is 

  component DDC
    port( RST   : in    std_logic := 'U';
          CLK   : in    std_logic := 'U';
          SCLK  : out   std_logic;
          CSn   : out   std_logic;
          SDATA : in    std_logic_vector(1 to 2) := (others => 'U')
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
        SDATA(2) => uC_0_IO_6_Y);
    
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
