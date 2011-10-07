-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity CIC is

    port( CLK    : in    std_logic;
          RST    : in    std_logic;
          INPUT  : in    std_logic_vector(21 downto 0);
          OUTPUT : out   std_logic_vector(46 downto 0)
        );

end CIC;

architecture DEF_ARCH of CIC is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CIC_twoport_mem
    port( WEN   : in    std_logic := 'U';
          REN   : in    std_logic := 'U';
          RWCLK : in    std_logic := 'U';
          RESET : in    std_logic := 'U';
          WD    : in    std_logic_vector(26 downto 0) := (others => 'U');
          RD    : out   std_logic_vector(26 downto 0);
          WADDR : in    std_logic_vector(4 downto 0) := (others => 'U');
          RADDR : in    std_logic_vector(4 downto 0) := (others => 'U')
        );
  end component;

    signal \CIC_control_0_RADDR_[4]\, \CIC_control_0_RADDR_[3]\, 
        \CIC_control_0_RADDR_[2]\, \CIC_control_0_RADDR_[1]\, 
        \CIC_control_0_RADDR_[0]\, CIC_control_0_REN, 
        \CIC_control_0_WADDR_[4]\, \CIC_control_0_WADDR_[3]\, 
        \CIC_control_0_WADDR_[2]\, \CIC_control_0_WADDR_[1]\, 
        \CIC_control_0_WADDR_[0]\, \CIC_control_0_WD_[26]\, 
        \CIC_control_0_WD_[25]\, \CIC_control_0_WD_[24]\, 
        \CIC_control_0_WD_[23]\, \CIC_control_0_WD_[22]\, 
        \CIC_control_0_WD_[21]\, \CIC_control_0_WD_[20]\, 
        \CIC_control_0_WD_[19]\, \CIC_control_0_WD_[18]\, 
        \CIC_control_0_WD_[17]\, \CIC_control_0_WD_[16]\, 
        \CIC_control_0_WD_[15]\, \CIC_control_0_WD_[14]\, 
        \CIC_control_0_WD_[13]\, \CIC_control_0_WD_[12]\, 
        \CIC_control_0_WD_[11]\, \CIC_control_0_WD_[10]\, 
        \CIC_control_0_WD_[9]\, \CIC_control_0_WD_[8]\, 
        \CIC_control_0_WD_[7]\, \CIC_control_0_WD_[6]\, 
        \CIC_control_0_WD_[5]\, \CIC_control_0_WD_[4]\, 
        \CIC_control_0_WD_[3]\, \CIC_control_0_WD_[2]\, 
        \CIC_control_0_WD_[1]\, \CIC_control_0_WD_[0]\, 
        CIC_control_0_WEN, \CIC_twoport_mem_0_RD_[26]\, 
        \CIC_twoport_mem_0_RD_[25]\, \CIC_twoport_mem_0_RD_[24]\, 
        \CIC_twoport_mem_0_RD_[23]\, \CIC_twoport_mem_0_RD_[22]\, 
        \CIC_twoport_mem_0_RD_[21]\, \CIC_twoport_mem_0_RD_[20]\, 
        \CIC_twoport_mem_0_RD_[19]\, \CIC_twoport_mem_0_RD_[18]\, 
        \CIC_twoport_mem_0_RD_[17]\, \CIC_twoport_mem_0_RD_[16]\, 
        \CIC_twoport_mem_0_RD_[15]\, \CIC_twoport_mem_0_RD_[14]\, 
        \CIC_twoport_mem_0_RD_[13]\, \CIC_twoport_mem_0_RD_[12]\, 
        \CIC_twoport_mem_0_RD_[11]\, \CIC_twoport_mem_0_RD_[10]\, 
        \CIC_twoport_mem_0_RD_[9]\, \CIC_twoport_mem_0_RD_[8]\, 
        \CIC_twoport_mem_0_RD_[7]\, \CIC_twoport_mem_0_RD_[6]\, 
        \CIC_twoport_mem_0_RD_[5]\, \CIC_twoport_mem_0_RD_[4]\, 
        \CIC_twoport_mem_0_RD_[3]\, \CIC_twoport_mem_0_RD_[2]\, 
        \CIC_twoport_mem_0_RD_[1]\, \CIC_twoport_mem_0_RD_[0]\, 
        GND_net, VCC_net : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    CIC_control_0 : entity work.CIC_control
      port map(CLK => CLK, RST => RST, WEN => CIC_control_0_WEN, 
        REN => CIC_control_0_REN, WD(26) => 
        \CIC_control_0_WD_[26]\, WD(25) => 
        \CIC_control_0_WD_[25]\, WD(24) => 
        \CIC_control_0_WD_[24]\, WD(23) => 
        \CIC_control_0_WD_[23]\, WD(22) => 
        \CIC_control_0_WD_[22]\, WD(21) => 
        \CIC_control_0_WD_[21]\, WD(20) => 
        \CIC_control_0_WD_[20]\, WD(19) => 
        \CIC_control_0_WD_[19]\, WD(18) => 
        \CIC_control_0_WD_[18]\, WD(17) => 
        \CIC_control_0_WD_[17]\, WD(16) => 
        \CIC_control_0_WD_[16]\, WD(15) => 
        \CIC_control_0_WD_[15]\, WD(14) => 
        \CIC_control_0_WD_[14]\, WD(13) => 
        \CIC_control_0_WD_[13]\, WD(12) => 
        \CIC_control_0_WD_[12]\, WD(11) => 
        \CIC_control_0_WD_[11]\, WD(10) => 
        \CIC_control_0_WD_[10]\, WD(9) => \CIC_control_0_WD_[9]\, 
        WD(8) => \CIC_control_0_WD_[8]\, WD(7) => 
        \CIC_control_0_WD_[7]\, WD(6) => \CIC_control_0_WD_[6]\, 
        WD(5) => \CIC_control_0_WD_[5]\, WD(4) => 
        \CIC_control_0_WD_[4]\, WD(3) => \CIC_control_0_WD_[3]\, 
        WD(2) => \CIC_control_0_WD_[2]\, WD(1) => 
        \CIC_control_0_WD_[1]\, WD(0) => \CIC_control_0_WD_[0]\, 
        WADDR(4) => \CIC_control_0_WADDR_[4]\, WADDR(3) => 
        \CIC_control_0_WADDR_[3]\, WADDR(2) => 
        \CIC_control_0_WADDR_[2]\, WADDR(1) => 
        \CIC_control_0_WADDR_[1]\, WADDR(0) => 
        \CIC_control_0_WADDR_[0]\, RADDR(4) => 
        \CIC_control_0_RADDR_[4]\, RADDR(3) => 
        \CIC_control_0_RADDR_[3]\, RADDR(2) => 
        \CIC_control_0_RADDR_[2]\, RADDR(1) => 
        \CIC_control_0_RADDR_[1]\, RADDR(0) => 
        \CIC_control_0_RADDR_[0]\, RD(26) => 
        \CIC_twoport_mem_0_RD_[26]\, RD(25) => 
        \CIC_twoport_mem_0_RD_[25]\, RD(24) => 
        \CIC_twoport_mem_0_RD_[24]\, RD(23) => 
        \CIC_twoport_mem_0_RD_[23]\, RD(22) => 
        \CIC_twoport_mem_0_RD_[22]\, RD(21) => 
        \CIC_twoport_mem_0_RD_[21]\, RD(20) => 
        \CIC_twoport_mem_0_RD_[20]\, RD(19) => 
        \CIC_twoport_mem_0_RD_[19]\, RD(18) => 
        \CIC_twoport_mem_0_RD_[18]\, RD(17) => 
        \CIC_twoport_mem_0_RD_[17]\, RD(16) => 
        \CIC_twoport_mem_0_RD_[16]\, RD(15) => 
        \CIC_twoport_mem_0_RD_[15]\, RD(14) => 
        \CIC_twoport_mem_0_RD_[14]\, RD(13) => 
        \CIC_twoport_mem_0_RD_[13]\, RD(12) => 
        \CIC_twoport_mem_0_RD_[12]\, RD(11) => 
        \CIC_twoport_mem_0_RD_[11]\, RD(10) => 
        \CIC_twoport_mem_0_RD_[10]\, RD(9) => 
        \CIC_twoport_mem_0_RD_[9]\, RD(8) => 
        \CIC_twoport_mem_0_RD_[8]\, RD(7) => 
        \CIC_twoport_mem_0_RD_[7]\, RD(6) => 
        \CIC_twoport_mem_0_RD_[6]\, RD(5) => 
        \CIC_twoport_mem_0_RD_[5]\, RD(4) => 
        \CIC_twoport_mem_0_RD_[4]\, RD(3) => 
        \CIC_twoport_mem_0_RD_[3]\, RD(2) => 
        \CIC_twoport_mem_0_RD_[2]\, RD(1) => 
        \CIC_twoport_mem_0_RD_[1]\, RD(0) => 
        \CIC_twoport_mem_0_RD_[0]\, INPUT(21) => INPUT(21), 
        INPUT(20) => INPUT(20), INPUT(19) => INPUT(19), INPUT(18)
         => INPUT(18), INPUT(17) => INPUT(17), INPUT(16) => 
        INPUT(16), INPUT(15) => INPUT(15), INPUT(14) => INPUT(14), 
        INPUT(13) => INPUT(13), INPUT(12) => INPUT(12), INPUT(11)
         => INPUT(11), INPUT(10) => INPUT(10), INPUT(9) => 
        INPUT(9), INPUT(8) => INPUT(8), INPUT(7) => INPUT(7), 
        INPUT(6) => INPUT(6), INPUT(5) => INPUT(5), INPUT(4) => 
        INPUT(4), INPUT(3) => INPUT(3), INPUT(2) => INPUT(2), 
        INPUT(1) => INPUT(1), INPUT(0) => INPUT(0), OUTPUT(46)
         => OUTPUT(46), OUTPUT(45) => OUTPUT(45), OUTPUT(44) => 
        OUTPUT(44), OUTPUT(43) => OUTPUT(43), OUTPUT(42) => 
        OUTPUT(42), OUTPUT(41) => OUTPUT(41), OUTPUT(40) => 
        OUTPUT(40), OUTPUT(39) => OUTPUT(39), OUTPUT(38) => 
        OUTPUT(38), OUTPUT(37) => OUTPUT(37), OUTPUT(36) => 
        OUTPUT(36), OUTPUT(35) => OUTPUT(35), OUTPUT(34) => 
        OUTPUT(34), OUTPUT(33) => OUTPUT(33), OUTPUT(32) => 
        OUTPUT(32), OUTPUT(31) => OUTPUT(31), OUTPUT(30) => 
        OUTPUT(30), OUTPUT(29) => OUTPUT(29), OUTPUT(28) => 
        OUTPUT(28), OUTPUT(27) => OUTPUT(27), OUTPUT(26) => 
        OUTPUT(26), OUTPUT(25) => OUTPUT(25), OUTPUT(24) => 
        OUTPUT(24), OUTPUT(23) => OUTPUT(23), OUTPUT(22) => 
        OUTPUT(22), OUTPUT(21) => OUTPUT(21), OUTPUT(20) => 
        OUTPUT(20), OUTPUT(19) => OUTPUT(19), OUTPUT(18) => 
        OUTPUT(18), OUTPUT(17) => OUTPUT(17), OUTPUT(16) => 
        OUTPUT(16), OUTPUT(15) => OUTPUT(15), OUTPUT(14) => 
        OUTPUT(14), OUTPUT(13) => OUTPUT(13), OUTPUT(12) => 
        OUTPUT(12), OUTPUT(11) => OUTPUT(11), OUTPUT(10) => 
        OUTPUT(10), OUTPUT(9) => OUTPUT(9), OUTPUT(8) => 
        OUTPUT(8), OUTPUT(7) => OUTPUT(7), OUTPUT(6) => OUTPUT(6), 
        OUTPUT(5) => OUTPUT(5), OUTPUT(4) => OUTPUT(4), OUTPUT(3)
         => OUTPUT(3), OUTPUT(2) => OUTPUT(2), OUTPUT(1) => 
        OUTPUT(1), OUTPUT(0) => OUTPUT(0));
    
    CIC_twoport_mem_0 : CIC_twoport_mem
      port map(WEN => CIC_control_0_WEN, REN => CIC_control_0_REN, 
        RWCLK => CLK, RESET => RST, WD(26) => 
        \CIC_control_0_WD_[26]\, WD(25) => 
        \CIC_control_0_WD_[25]\, WD(24) => 
        \CIC_control_0_WD_[24]\, WD(23) => 
        \CIC_control_0_WD_[23]\, WD(22) => 
        \CIC_control_0_WD_[22]\, WD(21) => 
        \CIC_control_0_WD_[21]\, WD(20) => 
        \CIC_control_0_WD_[20]\, WD(19) => 
        \CIC_control_0_WD_[19]\, WD(18) => 
        \CIC_control_0_WD_[18]\, WD(17) => 
        \CIC_control_0_WD_[17]\, WD(16) => 
        \CIC_control_0_WD_[16]\, WD(15) => 
        \CIC_control_0_WD_[15]\, WD(14) => 
        \CIC_control_0_WD_[14]\, WD(13) => 
        \CIC_control_0_WD_[13]\, WD(12) => 
        \CIC_control_0_WD_[12]\, WD(11) => 
        \CIC_control_0_WD_[11]\, WD(10) => 
        \CIC_control_0_WD_[10]\, WD(9) => \CIC_control_0_WD_[9]\, 
        WD(8) => \CIC_control_0_WD_[8]\, WD(7) => 
        \CIC_control_0_WD_[7]\, WD(6) => \CIC_control_0_WD_[6]\, 
        WD(5) => \CIC_control_0_WD_[5]\, WD(4) => 
        \CIC_control_0_WD_[4]\, WD(3) => \CIC_control_0_WD_[3]\, 
        WD(2) => \CIC_control_0_WD_[2]\, WD(1) => 
        \CIC_control_0_WD_[1]\, WD(0) => \CIC_control_0_WD_[0]\, 
        RD(26) => \CIC_twoport_mem_0_RD_[26]\, RD(25) => 
        \CIC_twoport_mem_0_RD_[25]\, RD(24) => 
        \CIC_twoport_mem_0_RD_[24]\, RD(23) => 
        \CIC_twoport_mem_0_RD_[23]\, RD(22) => 
        \CIC_twoport_mem_0_RD_[22]\, RD(21) => 
        \CIC_twoport_mem_0_RD_[21]\, RD(20) => 
        \CIC_twoport_mem_0_RD_[20]\, RD(19) => 
        \CIC_twoport_mem_0_RD_[19]\, RD(18) => 
        \CIC_twoport_mem_0_RD_[18]\, RD(17) => 
        \CIC_twoport_mem_0_RD_[17]\, RD(16) => 
        \CIC_twoport_mem_0_RD_[16]\, RD(15) => 
        \CIC_twoport_mem_0_RD_[15]\, RD(14) => 
        \CIC_twoport_mem_0_RD_[14]\, RD(13) => 
        \CIC_twoport_mem_0_RD_[13]\, RD(12) => 
        \CIC_twoport_mem_0_RD_[12]\, RD(11) => 
        \CIC_twoport_mem_0_RD_[11]\, RD(10) => 
        \CIC_twoport_mem_0_RD_[10]\, RD(9) => 
        \CIC_twoport_mem_0_RD_[9]\, RD(8) => 
        \CIC_twoport_mem_0_RD_[8]\, RD(7) => 
        \CIC_twoport_mem_0_RD_[7]\, RD(6) => 
        \CIC_twoport_mem_0_RD_[6]\, RD(5) => 
        \CIC_twoport_mem_0_RD_[5]\, RD(4) => 
        \CIC_twoport_mem_0_RD_[4]\, RD(3) => 
        \CIC_twoport_mem_0_RD_[3]\, RD(2) => 
        \CIC_twoport_mem_0_RD_[2]\, RD(1) => 
        \CIC_twoport_mem_0_RD_[1]\, RD(0) => 
        \CIC_twoport_mem_0_RD_[0]\, WADDR(4) => 
        \CIC_control_0_WADDR_[4]\, WADDR(3) => 
        \CIC_control_0_WADDR_[3]\, WADDR(2) => 
        \CIC_control_0_WADDR_[2]\, WADDR(1) => 
        \CIC_control_0_WADDR_[1]\, WADDR(0) => 
        \CIC_control_0_WADDR_[0]\, RADDR(4) => 
        \CIC_control_0_RADDR_[4]\, RADDR(3) => 
        \CIC_control_0_RADDR_[3]\, RADDR(2) => 
        \CIC_control_0_RADDR_[2]\, RADDR(1) => 
        \CIC_control_0_RADDR_[1]\, RADDR(0) => 
        \CIC_control_0_RADDR_[0]\);
    

end DEF_ARCH; 
