-- Version: 9.1 SP1 9.1.1.7

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity top is

    port( MSS_RESET_N : in    std_logic;
          MAINXIN     : in    std_logic
        );

end top;

architecture DEF_ARCH of top is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component uC
    port( MSS_RESET_N : in    std_logic := 'U';
          FAB_CLK     : out   std_logic;
          MAINXIN     : in    std_logic := 'U';
          M2F_RESET_N : out   std_logic
        );
  end component;

  component sincos_gen
    port( CLK       : in    std_logic := 'U';
          RST       : in    std_logic := 'U';
          DPHASE_EN : in    std_logic := 'U';
          DPHASE    : in    std_logic_vector(15 downto 0) := (others => 'U');
          COS_OUT   : out   std_logic_vector(15 downto 0);
          SIN_OUT   : out   std_logic_vector(15 downto 0);
          RDYOUT    : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal uC_0_FAB_CLK, uC_0_M2F_RESET_N, GND_net, VCC_net
         : std_logic;
    signal nc24, nc1, nc8, nc13, nc30, nc16, nc19, nc32, nc25, 
        nc20, nc27, nc9, nc31, nc22, nc28, nc14, nc5, nc21, nc15, 
        nc3, nc10, nc7, nc17, nc4, nc12, nc2, nc23, nc18, nc26, 
        nc6, nc29, nc11 : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net);
    
    uC_0 : uC
      port map(MSS_RESET_N => MSS_RESET_N, FAB_CLK => 
        uC_0_FAB_CLK, MAINXIN => MAINXIN, M2F_RESET_N => 
        uC_0_M2F_RESET_N);
    
    sincos_gen_0 : sincos_gen
      port map(CLK => uC_0_FAB_CLK, RST => uC_0_M2F_RESET_N, 
        DPHASE_EN => VCC_net, DPHASE(15) => GND_net, DPHASE(14)
         => GND_net, DPHASE(13) => GND_net, DPHASE(12) => GND_net, 
        DPHASE(11) => GND_net, DPHASE(10) => GND_net, DPHASE(9)
         => GND_net, DPHASE(8) => GND_net, DPHASE(7) => GND_net, 
        DPHASE(6) => GND_net, DPHASE(5) => GND_net, DPHASE(4) => 
        VCC_net, DPHASE(3) => GND_net, DPHASE(2) => GND_net, 
        DPHASE(1) => GND_net, DPHASE(0) => GND_net, COS_OUT(15)
         => nc24, COS_OUT(14) => nc1, COS_OUT(13) => nc8, 
        COS_OUT(12) => nc13, COS_OUT(11) => nc30, COS_OUT(10) => 
        nc16, COS_OUT(9) => nc19, COS_OUT(8) => nc32, COS_OUT(7)
         => nc25, COS_OUT(6) => nc20, COS_OUT(5) => nc27, 
        COS_OUT(4) => nc9, COS_OUT(3) => nc31, COS_OUT(2) => nc22, 
        COS_OUT(1) => nc28, COS_OUT(0) => nc14, SIN_OUT(15) => 
        nc5, SIN_OUT(14) => nc21, SIN_OUT(13) => nc15, 
        SIN_OUT(12) => nc3, SIN_OUT(11) => nc10, SIN_OUT(10) => 
        nc7, SIN_OUT(9) => nc17, SIN_OUT(8) => nc4, SIN_OUT(7)
         => nc12, SIN_OUT(6) => nc2, SIN_OUT(5) => nc23, 
        SIN_OUT(4) => nc18, SIN_OUT(3) => nc26, SIN_OUT(2) => nc6, 
        SIN_OUT(1) => nc29, SIN_OUT(0) => nc11, RDYOUT => OPEN);
    
    \GND\ : GND
      port map(Y => GND_net);
    

end DEF_ARCH; 
