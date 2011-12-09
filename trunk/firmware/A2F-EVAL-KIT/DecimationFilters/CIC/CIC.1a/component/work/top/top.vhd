-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity top is

    port( MSS_RESET_N : in    std_logic;
          MAINXIN     : in    std_logic;
          INPUT       : in    std_logic_vector(21 downto 0);
          OUTPUT      : out   std_logic_vector(30 downto 0)
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

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CIC
    port( CLK    : in    std_logic := 'U';
          RST    : in    std_logic := 'U';
          INPUT  : in    std_logic_vector(21 downto 0) := (others => 'U');
          OUTPUT : out   std_logic_vector(30 downto 0)
        );
  end component;

    signal uC_0_FAB_CLK, uC_0_M2F_RESET_N, GND_net, VCC_net
         : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net);
    
    uC_0 : uC
      port map(MSS_RESET_N => MSS_RESET_N, FAB_CLK => 
        uC_0_FAB_CLK, MAINXIN => MAINXIN, M2F_RESET_N => 
        uC_0_M2F_RESET_N);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    CIC_0 : CIC
      port map(CLK => uC_0_FAB_CLK, RST => uC_0_M2F_RESET_N, 
        INPUT(21) => INPUT(21), INPUT(20) => INPUT(20), INPUT(19)
         => INPUT(19), INPUT(18) => INPUT(18), INPUT(17) => 
        INPUT(17), INPUT(16) => INPUT(16), INPUT(15) => INPUT(15), 
        INPUT(14) => INPUT(14), INPUT(13) => INPUT(13), INPUT(12)
         => INPUT(12), INPUT(11) => INPUT(11), INPUT(10) => 
        INPUT(10), INPUT(9) => INPUT(9), INPUT(8) => INPUT(8), 
        INPUT(7) => INPUT(7), INPUT(6) => INPUT(6), INPUT(5) => 
        INPUT(5), INPUT(4) => INPUT(4), INPUT(3) => INPUT(3), 
        INPUT(2) => INPUT(2), INPUT(1) => INPUT(1), INPUT(0) => 
        INPUT(0), OUTPUT(30) => OUTPUT(30), OUTPUT(29) => 
        OUTPUT(29), OUTPUT(28) => OUTPUT(28), OUTPUT(27) => 
        OUTPUT(27), OUTPUT(26) => OUTPUT(26), OUTPUT(25) => 
        OUTPUT(25), OUTPUT(24) => OUTPUT(24), OUTPUT(23) => 
        OUTPUT(23), OUTPUT(22) => OUTPUT(22), OUTPUT(21) => 
        OUTPUT(21), OUTPUT(20) => OUTPUT(20), OUTPUT(19) => 
        OUTPUT(19), OUTPUT(18) => OUTPUT(18), OUTPUT(17) => 
        OUTPUT(17), OUTPUT(16) => OUTPUT(16), OUTPUT(15) => 
        OUTPUT(15), OUTPUT(14) => OUTPUT(14), OUTPUT(13) => 
        OUTPUT(13), OUTPUT(12) => OUTPUT(12), OUTPUT(11) => 
        OUTPUT(11), OUTPUT(10) => OUTPUT(10), OUTPUT(9) => 
        OUTPUT(9), OUTPUT(8) => OUTPUT(8), OUTPUT(7) => OUTPUT(7), 
        OUTPUT(6) => OUTPUT(6), OUTPUT(5) => OUTPUT(5), OUTPUT(4)
         => OUTPUT(4), OUTPUT(3) => OUTPUT(3), OUTPUT(2) => 
        OUTPUT(2), OUTPUT(1) => OUTPUT(1), OUTPUT(0) => OUTPUT(0));
    

end DEF_ARCH; 
