-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity FIR is

    port( RST    : in    std_logic;
          CLK    : in    std_logic;
          INPUT  : in    std_logic_vector(21 downto 0);
          OUTPUT : out   std_logic_vector(46 downto 0)
        );

end FIR;

architecture DEF_ARCH of FIR is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component mem_coef
    port( WD    : in    std_logic_vector(17 downto 0) := (others => 'U');
          RD    : out   std_logic_vector(17 downto 0);
          WEN   : in    std_logic := 'U';
          REN   : in    std_logic := 'U';
          WADDR : in    std_logic_vector(8 downto 0) := (others => 'U');
          RADDR : in    std_logic_vector(8 downto 0) := (others => 'U');
          RWCLK : in    std_logic := 'U';
          RESET : in    std_logic := 'U'
        );
  end component;

  component mult
    port( DataA : in    std_logic_vector(21 downto 0) := (others => 'U');
          DataB : in    std_logic_vector(15 downto 0) := (others => 'U');
          Mult  : out   std_logic_vector(37 downto 0)
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component mem_sample
    port( WD    : in    std_logic_vector(21 downto 0) := (others => 'U');
          RD    : out   std_logic_vector(21 downto 0);
          WEN   : in    std_logic := 'U';
          REN   : in    std_logic := 'U';
          WADDR : in    std_logic_vector(8 downto 0) := (others => 'U');
          RADDR : in    std_logic_vector(8 downto 0) := (others => 'U');
          RWCLK : in    std_logic := 'U';
          RESET : in    std_logic := 'U'
        );
  end component;

    signal FIR_core_0_GET_NEXT, \mem_coef_0_RD_[17]\, 
        \mem_coef_0_RD_[16]\, \mem_coef_0_RD_[15]\, 
        \mem_coef_0_RD_[14]\, \mem_coef_0_RD_[13]\, 
        \mem_coef_0_RD_[12]\, \mem_coef_0_RD_[11]\, 
        \mem_coef_0_RD_[10]\, \mem_coef_0_RD_[9]\, 
        \mem_coef_0_RD_[8]\, \mem_coef_0_RD_[7]\, 
        \mem_coef_0_RD_[6]\, \mem_coef_0_RD_[5]\, 
        \mem_coef_0_RD_[4]\, \mem_coef_0_RD_[3]\, 
        \mem_coef_0_RD_[2]\, \mem_coef_0_RD_[1]\, 
        \mem_coef_0_RD_[0]\, \mem_coef_control_0_OUTPUT_[15]\, 
        \mem_coef_control_0_OUTPUT_[14]\, 
        \mem_coef_control_0_OUTPUT_[13]\, 
        \mem_coef_control_0_OUTPUT_[12]\, 
        \mem_coef_control_0_OUTPUT_[11]\, 
        \mem_coef_control_0_OUTPUT_[10]\, 
        \mem_coef_control_0_OUTPUT_[9]\, 
        \mem_coef_control_0_OUTPUT_[8]\, 
        \mem_coef_control_0_OUTPUT_[7]\, 
        \mem_coef_control_0_OUTPUT_[6]\, 
        \mem_coef_control_0_OUTPUT_[5]\, 
        \mem_coef_control_0_OUTPUT_[4]\, 
        \mem_coef_control_0_OUTPUT_[3]\, 
        \mem_coef_control_0_OUTPUT_[2]\, 
        \mem_coef_control_0_OUTPUT_[1]\, 
        \mem_coef_control_0_OUTPUT_[0]\, 
        \mem_coef_control_0_RADDR_[8]\, 
        \mem_coef_control_0_RADDR_[7]\, 
        \mem_coef_control_0_RADDR_[6]\, 
        \mem_coef_control_0_RADDR_[5]\, 
        \mem_coef_control_0_RADDR_[4]\, 
        \mem_coef_control_0_RADDR_[3]\, 
        \mem_coef_control_0_RADDR_[2]\, 
        \mem_coef_control_0_RADDR_[1]\, 
        \mem_coef_control_0_RADDR_[0]\, mem_coef_control_0_REN, 
        \mem_coef_control_0_WADDR_[8]\, 
        \mem_coef_control_0_WADDR_[7]\, 
        \mem_coef_control_0_WADDR_[6]\, 
        \mem_coef_control_0_WADDR_[5]\, 
        \mem_coef_control_0_WADDR_[4]\, 
        \mem_coef_control_0_WADDR_[3]\, 
        \mem_coef_control_0_WADDR_[2]\, 
        \mem_coef_control_0_WADDR_[1]\, 
        \mem_coef_control_0_WADDR_[0]\, 
        \mem_coef_control_0_WD_[17]\, 
        \mem_coef_control_0_WD_[16]\, 
        \mem_coef_control_0_WD_[15]\, 
        \mem_coef_control_0_WD_[14]\, 
        \mem_coef_control_0_WD_[13]\, 
        \mem_coef_control_0_WD_[12]\, 
        \mem_coef_control_0_WD_[11]\, 
        \mem_coef_control_0_WD_[10]\, \mem_coef_control_0_WD_[9]\, 
        \mem_coef_control_0_WD_[8]\, \mem_coef_control_0_WD_[7]\, 
        \mem_coef_control_0_WD_[6]\, \mem_coef_control_0_WD_[5]\, 
        \mem_coef_control_0_WD_[4]\, \mem_coef_control_0_WD_[3]\, 
        \mem_coef_control_0_WD_[2]\, \mem_coef_control_0_WD_[1]\, 
        \mem_coef_control_0_WD_[0]\, mem_coef_control_0_WEN, 
        \mem_sample_0_RD_[21]\, \mem_sample_0_RD_[20]\, 
        \mem_sample_0_RD_[19]\, \mem_sample_0_RD_[18]\, 
        \mem_sample_0_RD_[17]\, \mem_sample_0_RD_[16]\, 
        \mem_sample_0_RD_[15]\, \mem_sample_0_RD_[14]\, 
        \mem_sample_0_RD_[13]\, \mem_sample_0_RD_[12]\, 
        \mem_sample_0_RD_[11]\, \mem_sample_0_RD_[10]\, 
        \mem_sample_0_RD_[9]\, \mem_sample_0_RD_[8]\, 
        \mem_sample_0_RD_[7]\, \mem_sample_0_RD_[6]\, 
        \mem_sample_0_RD_[5]\, \mem_sample_0_RD_[4]\, 
        \mem_sample_0_RD_[3]\, \mem_sample_0_RD_[2]\, 
        \mem_sample_0_RD_[1]\, \mem_sample_0_RD_[0]\, 
        \mem_sample_control_0_OUTPUT_[21]\, 
        \mem_sample_control_0_OUTPUT_[20]\, 
        \mem_sample_control_0_OUTPUT_[19]\, 
        \mem_sample_control_0_OUTPUT_[18]\, 
        \mem_sample_control_0_OUTPUT_[17]\, 
        \mem_sample_control_0_OUTPUT_[16]\, 
        \mem_sample_control_0_OUTPUT_[15]\, 
        \mem_sample_control_0_OUTPUT_[14]\, 
        \mem_sample_control_0_OUTPUT_[13]\, 
        \mem_sample_control_0_OUTPUT_[12]\, 
        \mem_sample_control_0_OUTPUT_[11]\, 
        \mem_sample_control_0_OUTPUT_[10]\, 
        \mem_sample_control_0_OUTPUT_[9]\, 
        \mem_sample_control_0_OUTPUT_[8]\, 
        \mem_sample_control_0_OUTPUT_[7]\, 
        \mem_sample_control_0_OUTPUT_[6]\, 
        \mem_sample_control_0_OUTPUT_[5]\, 
        \mem_sample_control_0_OUTPUT_[4]\, 
        \mem_sample_control_0_OUTPUT_[3]\, 
        \mem_sample_control_0_OUTPUT_[2]\, 
        \mem_sample_control_0_OUTPUT_[1]\, 
        \mem_sample_control_0_OUTPUT_[0]\, 
        \mem_sample_control_0_RADDR_[8]\, 
        \mem_sample_control_0_RADDR_[7]\, 
        \mem_sample_control_0_RADDR_[6]\, 
        \mem_sample_control_0_RADDR_[5]\, 
        \mem_sample_control_0_RADDR_[4]\, 
        \mem_sample_control_0_RADDR_[3]\, 
        \mem_sample_control_0_RADDR_[2]\, 
        \mem_sample_control_0_RADDR_[1]\, 
        \mem_sample_control_0_RADDR_[0]\, 
        mem_sample_control_0_REN, 
        \mem_sample_control_0_WADDR_[8]\, 
        \mem_sample_control_0_WADDR_[7]\, 
        \mem_sample_control_0_WADDR_[6]\, 
        \mem_sample_control_0_WADDR_[5]\, 
        \mem_sample_control_0_WADDR_[4]\, 
        \mem_sample_control_0_WADDR_[3]\, 
        \mem_sample_control_0_WADDR_[2]\, 
        \mem_sample_control_0_WADDR_[1]\, 
        \mem_sample_control_0_WADDR_[0]\, 
        \mem_sample_control_0_WD_[21]\, 
        \mem_sample_control_0_WD_[20]\, 
        \mem_sample_control_0_WD_[19]\, 
        \mem_sample_control_0_WD_[18]\, 
        \mem_sample_control_0_WD_[17]\, 
        \mem_sample_control_0_WD_[16]\, 
        \mem_sample_control_0_WD_[15]\, 
        \mem_sample_control_0_WD_[14]\, 
        \mem_sample_control_0_WD_[13]\, 
        \mem_sample_control_0_WD_[12]\, 
        \mem_sample_control_0_WD_[11]\, 
        \mem_sample_control_0_WD_[10]\, 
        \mem_sample_control_0_WD_[9]\, 
        \mem_sample_control_0_WD_[8]\, 
        \mem_sample_control_0_WD_[7]\, 
        \mem_sample_control_0_WD_[6]\, 
        \mem_sample_control_0_WD_[5]\, 
        \mem_sample_control_0_WD_[4]\, 
        \mem_sample_control_0_WD_[3]\, 
        \mem_sample_control_0_WD_[2]\, 
        \mem_sample_control_0_WD_[1]\, 
        \mem_sample_control_0_WD_[0]\, mem_sample_control_0_WEN, 
        \mult_0_Mult_[37]\, \mult_0_Mult_[36]\, 
        \mult_0_Mult_[35]\, \mult_0_Mult_[34]\, 
        \mult_0_Mult_[33]\, \mult_0_Mult_[32]\, 
        \mult_0_Mult_[31]\, \mult_0_Mult_[30]\, 
        \mult_0_Mult_[29]\, \mult_0_Mult_[28]\, 
        \mult_0_Mult_[27]\, \mult_0_Mult_[26]\, 
        \mult_0_Mult_[25]\, \mult_0_Mult_[24]\, 
        \mult_0_Mult_[23]\, \mult_0_Mult_[22]\, 
        \mult_0_Mult_[21]\, \mult_0_Mult_[20]\, 
        \mult_0_Mult_[19]\, \mult_0_Mult_[18]\, 
        \mult_0_Mult_[17]\, \mult_0_Mult_[16]\, 
        \mult_0_Mult_[15]\, \mult_0_Mult_[14]\, 
        \mult_0_Mult_[13]\, \mult_0_Mult_[12]\, 
        \mult_0_Mult_[11]\, \mult_0_Mult_[10]\, \mult_0_Mult_[9]\, 
        \mult_0_Mult_[8]\, \mult_0_Mult_[7]\, \mult_0_Mult_[6]\, 
        \mult_0_Mult_[5]\, \mult_0_Mult_[4]\, \mult_0_Mult_[3]\, 
        \mult_0_Mult_[2]\, \mult_0_Mult_[1]\, \mult_0_Mult_[0]\, 
        GND_net, VCC_net : std_logic;

begin 


    FIR_core_0 : entity work.FIR_core
      port map(CLK => CLK, RST => RST, INPUT(37) => 
        \mult_0_Mult_[37]\, INPUT(36) => \mult_0_Mult_[36]\, 
        INPUT(35) => \mult_0_Mult_[35]\, INPUT(34) => 
        \mult_0_Mult_[34]\, INPUT(33) => \mult_0_Mult_[33]\, 
        INPUT(32) => \mult_0_Mult_[32]\, INPUT(31) => 
        \mult_0_Mult_[31]\, INPUT(30) => \mult_0_Mult_[30]\, 
        INPUT(29) => \mult_0_Mult_[29]\, INPUT(28) => 
        \mult_0_Mult_[28]\, INPUT(27) => \mult_0_Mult_[27]\, 
        INPUT(26) => \mult_0_Mult_[26]\, INPUT(25) => 
        \mult_0_Mult_[25]\, INPUT(24) => \mult_0_Mult_[24]\, 
        INPUT(23) => \mult_0_Mult_[23]\, INPUT(22) => 
        \mult_0_Mult_[22]\, INPUT(21) => \mult_0_Mult_[21]\, 
        INPUT(20) => \mult_0_Mult_[20]\, INPUT(19) => 
        \mult_0_Mult_[19]\, INPUT(18) => \mult_0_Mult_[18]\, 
        INPUT(17) => \mult_0_Mult_[17]\, INPUT(16) => 
        \mult_0_Mult_[16]\, INPUT(15) => \mult_0_Mult_[15]\, 
        INPUT(14) => \mult_0_Mult_[14]\, INPUT(13) => 
        \mult_0_Mult_[13]\, INPUT(12) => \mult_0_Mult_[12]\, 
        INPUT(11) => \mult_0_Mult_[11]\, INPUT(10) => 
        \mult_0_Mult_[10]\, INPUT(9) => \mult_0_Mult_[9]\, 
        INPUT(8) => \mult_0_Mult_[8]\, INPUT(7) => 
        \mult_0_Mult_[7]\, INPUT(6) => \mult_0_Mult_[6]\, 
        INPUT(5) => \mult_0_Mult_[5]\, INPUT(4) => 
        \mult_0_Mult_[4]\, INPUT(3) => \mult_0_Mult_[3]\, 
        INPUT(2) => \mult_0_Mult_[2]\, INPUT(1) => 
        \mult_0_Mult_[1]\, INPUT(0) => \mult_0_Mult_[0]\, 
        OUTPUT(46) => OUTPUT(46), OUTPUT(45) => OUTPUT(45), 
        OUTPUT(44) => OUTPUT(44), OUTPUT(43) => OUTPUT(43), 
        OUTPUT(42) => OUTPUT(42), OUTPUT(41) => OUTPUT(41), 
        OUTPUT(40) => OUTPUT(40), OUTPUT(39) => OUTPUT(39), 
        OUTPUT(38) => OUTPUT(38), OUTPUT(37) => OUTPUT(37), 
        OUTPUT(36) => OUTPUT(36), OUTPUT(35) => OUTPUT(35), 
        OUTPUT(34) => OUTPUT(34), OUTPUT(33) => OUTPUT(33), 
        OUTPUT(32) => OUTPUT(32), OUTPUT(31) => OUTPUT(31), 
        OUTPUT(30) => OUTPUT(30), OUTPUT(29) => OUTPUT(29), 
        OUTPUT(28) => OUTPUT(28), OUTPUT(27) => OUTPUT(27), 
        OUTPUT(26) => OUTPUT(26), OUTPUT(25) => OUTPUT(25), 
        OUTPUT(24) => OUTPUT(24), OUTPUT(23) => OUTPUT(23), 
        OUTPUT(22) => OUTPUT(22), OUTPUT(21) => OUTPUT(21), 
        OUTPUT(20) => OUTPUT(20), OUTPUT(19) => OUTPUT(19), 
        OUTPUT(18) => OUTPUT(18), OUTPUT(17) => OUTPUT(17), 
        OUTPUT(16) => OUTPUT(16), OUTPUT(15) => OUTPUT(15), 
        OUTPUT(14) => OUTPUT(14), OUTPUT(13) => OUTPUT(13), 
        OUTPUT(12) => OUTPUT(12), OUTPUT(11) => OUTPUT(11), 
        OUTPUT(10) => OUTPUT(10), OUTPUT(9) => OUTPUT(9), 
        OUTPUT(8) => OUTPUT(8), OUTPUT(7) => OUTPUT(7), OUTPUT(6)
         => OUTPUT(6), OUTPUT(5) => OUTPUT(5), OUTPUT(4) => 
        OUTPUT(4), OUTPUT(3) => OUTPUT(3), OUTPUT(2) => OUTPUT(2), 
        OUTPUT(1) => OUTPUT(1), OUTPUT(0) => OUTPUT(0), GET_NEXT
         => FIR_core_0_GET_NEXT);
    
    \VCC\ : VCC
      port map(Y => VCC_net);
    
    mem_sample_control_0 : entity work.mem_sample_control
      port map(CLK => CLK, RST => RST, WD(21) => 
        \mem_sample_control_0_WD_[21]\, WD(20) => 
        \mem_sample_control_0_WD_[20]\, WD(19) => 
        \mem_sample_control_0_WD_[19]\, WD(18) => 
        \mem_sample_control_0_WD_[18]\, WD(17) => 
        \mem_sample_control_0_WD_[17]\, WD(16) => 
        \mem_sample_control_0_WD_[16]\, WD(15) => 
        \mem_sample_control_0_WD_[15]\, WD(14) => 
        \mem_sample_control_0_WD_[14]\, WD(13) => 
        \mem_sample_control_0_WD_[13]\, WD(12) => 
        \mem_sample_control_0_WD_[12]\, WD(11) => 
        \mem_sample_control_0_WD_[11]\, WD(10) => 
        \mem_sample_control_0_WD_[10]\, WD(9) => 
        \mem_sample_control_0_WD_[9]\, WD(8) => 
        \mem_sample_control_0_WD_[8]\, WD(7) => 
        \mem_sample_control_0_WD_[7]\, WD(6) => 
        \mem_sample_control_0_WD_[6]\, WD(5) => 
        \mem_sample_control_0_WD_[5]\, WD(4) => 
        \mem_sample_control_0_WD_[4]\, WD(3) => 
        \mem_sample_control_0_WD_[3]\, WD(2) => 
        \mem_sample_control_0_WD_[2]\, WD(1) => 
        \mem_sample_control_0_WD_[1]\, WD(0) => 
        \mem_sample_control_0_WD_[0]\, WADDR(8) => 
        \mem_sample_control_0_WADDR_[8]\, WADDR(7) => 
        \mem_sample_control_0_WADDR_[7]\, WADDR(6) => 
        \mem_sample_control_0_WADDR_[6]\, WADDR(5) => 
        \mem_sample_control_0_WADDR_[5]\, WADDR(4) => 
        \mem_sample_control_0_WADDR_[4]\, WADDR(3) => 
        \mem_sample_control_0_WADDR_[3]\, WADDR(2) => 
        \mem_sample_control_0_WADDR_[2]\, WADDR(1) => 
        \mem_sample_control_0_WADDR_[1]\, WADDR(0) => 
        \mem_sample_control_0_WADDR_[0]\, RADDR(8) => 
        \mem_sample_control_0_RADDR_[8]\, RADDR(7) => 
        \mem_sample_control_0_RADDR_[7]\, RADDR(6) => 
        \mem_sample_control_0_RADDR_[6]\, RADDR(5) => 
        \mem_sample_control_0_RADDR_[5]\, RADDR(4) => 
        \mem_sample_control_0_RADDR_[4]\, RADDR(3) => 
        \mem_sample_control_0_RADDR_[3]\, RADDR(2) => 
        \mem_sample_control_0_RADDR_[2]\, RADDR(1) => 
        \mem_sample_control_0_RADDR_[1]\, RADDR(0) => 
        \mem_sample_control_0_RADDR_[0]\, WEN => 
        mem_sample_control_0_WEN, REN => mem_sample_control_0_REN, 
        RD(21) => \mem_sample_0_RD_[21]\, RD(20) => 
        \mem_sample_0_RD_[20]\, RD(19) => \mem_sample_0_RD_[19]\, 
        RD(18) => \mem_sample_0_RD_[18]\, RD(17) => 
        \mem_sample_0_RD_[17]\, RD(16) => \mem_sample_0_RD_[16]\, 
        RD(15) => \mem_sample_0_RD_[15]\, RD(14) => 
        \mem_sample_0_RD_[14]\, RD(13) => \mem_sample_0_RD_[13]\, 
        RD(12) => \mem_sample_0_RD_[12]\, RD(11) => 
        \mem_sample_0_RD_[11]\, RD(10) => \mem_sample_0_RD_[10]\, 
        RD(9) => \mem_sample_0_RD_[9]\, RD(8) => 
        \mem_sample_0_RD_[8]\, RD(7) => \mem_sample_0_RD_[7]\, 
        RD(6) => \mem_sample_0_RD_[6]\, RD(5) => 
        \mem_sample_0_RD_[5]\, RD(4) => \mem_sample_0_RD_[4]\, 
        RD(3) => \mem_sample_0_RD_[3]\, RD(2) => 
        \mem_sample_0_RD_[2]\, RD(1) => \mem_sample_0_RD_[1]\, 
        RD(0) => \mem_sample_0_RD_[0]\, OUTPUT(21) => 
        \mem_sample_control_0_OUTPUT_[21]\, OUTPUT(20) => 
        \mem_sample_control_0_OUTPUT_[20]\, OUTPUT(19) => 
        \mem_sample_control_0_OUTPUT_[19]\, OUTPUT(18) => 
        \mem_sample_control_0_OUTPUT_[18]\, OUTPUT(17) => 
        \mem_sample_control_0_OUTPUT_[17]\, OUTPUT(16) => 
        \mem_sample_control_0_OUTPUT_[16]\, OUTPUT(15) => 
        \mem_sample_control_0_OUTPUT_[15]\, OUTPUT(14) => 
        \mem_sample_control_0_OUTPUT_[14]\, OUTPUT(13) => 
        \mem_sample_control_0_OUTPUT_[13]\, OUTPUT(12) => 
        \mem_sample_control_0_OUTPUT_[12]\, OUTPUT(11) => 
        \mem_sample_control_0_OUTPUT_[11]\, OUTPUT(10) => 
        \mem_sample_control_0_OUTPUT_[10]\, OUTPUT(9) => 
        \mem_sample_control_0_OUTPUT_[9]\, OUTPUT(8) => 
        \mem_sample_control_0_OUTPUT_[8]\, OUTPUT(7) => 
        \mem_sample_control_0_OUTPUT_[7]\, OUTPUT(6) => 
        \mem_sample_control_0_OUTPUT_[6]\, OUTPUT(5) => 
        \mem_sample_control_0_OUTPUT_[5]\, OUTPUT(4) => 
        \mem_sample_control_0_OUTPUT_[4]\, OUTPUT(3) => 
        \mem_sample_control_0_OUTPUT_[3]\, OUTPUT(2) => 
        \mem_sample_control_0_OUTPUT_[2]\, OUTPUT(1) => 
        \mem_sample_control_0_OUTPUT_[1]\, OUTPUT(0) => 
        \mem_sample_control_0_OUTPUT_[0]\, INPUT(21) => INPUT(21), 
        INPUT(20) => INPUT(20), INPUT(19) => INPUT(19), INPUT(18)
         => INPUT(18), INPUT(17) => INPUT(17), INPUT(16) => 
        INPUT(16), INPUT(15) => INPUT(15), INPUT(14) => INPUT(14), 
        INPUT(13) => INPUT(13), INPUT(12) => INPUT(12), INPUT(11)
         => INPUT(11), INPUT(10) => INPUT(10), INPUT(9) => 
        INPUT(9), INPUT(8) => INPUT(8), INPUT(7) => INPUT(7), 
        INPUT(6) => INPUT(6), INPUT(5) => INPUT(5), INPUT(4) => 
        INPUT(4), INPUT(3) => INPUT(3), INPUT(2) => INPUT(2), 
        INPUT(1) => INPUT(1), INPUT(0) => INPUT(0), GET_NEXT => 
        FIR_core_0_GET_NEXT);
    
    mem_coef_0 : mem_coef
      port map(WD(17) => \mem_coef_control_0_WD_[17]\, WD(16) => 
        \mem_coef_control_0_WD_[16]\, WD(15) => 
        \mem_coef_control_0_WD_[15]\, WD(14) => 
        \mem_coef_control_0_WD_[14]\, WD(13) => 
        \mem_coef_control_0_WD_[13]\, WD(12) => 
        \mem_coef_control_0_WD_[12]\, WD(11) => 
        \mem_coef_control_0_WD_[11]\, WD(10) => 
        \mem_coef_control_0_WD_[10]\, WD(9) => 
        \mem_coef_control_0_WD_[9]\, WD(8) => 
        \mem_coef_control_0_WD_[8]\, WD(7) => 
        \mem_coef_control_0_WD_[7]\, WD(6) => 
        \mem_coef_control_0_WD_[6]\, WD(5) => 
        \mem_coef_control_0_WD_[5]\, WD(4) => 
        \mem_coef_control_0_WD_[4]\, WD(3) => 
        \mem_coef_control_0_WD_[3]\, WD(2) => 
        \mem_coef_control_0_WD_[2]\, WD(1) => 
        \mem_coef_control_0_WD_[1]\, WD(0) => 
        \mem_coef_control_0_WD_[0]\, RD(17) => 
        \mem_coef_0_RD_[17]\, RD(16) => \mem_coef_0_RD_[16]\, 
        RD(15) => \mem_coef_0_RD_[15]\, RD(14) => 
        \mem_coef_0_RD_[14]\, RD(13) => \mem_coef_0_RD_[13]\, 
        RD(12) => \mem_coef_0_RD_[12]\, RD(11) => 
        \mem_coef_0_RD_[11]\, RD(10) => \mem_coef_0_RD_[10]\, 
        RD(9) => \mem_coef_0_RD_[9]\, RD(8) => 
        \mem_coef_0_RD_[8]\, RD(7) => \mem_coef_0_RD_[7]\, RD(6)
         => \mem_coef_0_RD_[6]\, RD(5) => \mem_coef_0_RD_[5]\, 
        RD(4) => \mem_coef_0_RD_[4]\, RD(3) => 
        \mem_coef_0_RD_[3]\, RD(2) => \mem_coef_0_RD_[2]\, RD(1)
         => \mem_coef_0_RD_[1]\, RD(0) => \mem_coef_0_RD_[0]\, 
        WEN => mem_coef_control_0_WEN, REN => 
        mem_coef_control_0_REN, WADDR(8) => 
        \mem_coef_control_0_WADDR_[8]\, WADDR(7) => 
        \mem_coef_control_0_WADDR_[7]\, WADDR(6) => 
        \mem_coef_control_0_WADDR_[6]\, WADDR(5) => 
        \mem_coef_control_0_WADDR_[5]\, WADDR(4) => 
        \mem_coef_control_0_WADDR_[4]\, WADDR(3) => 
        \mem_coef_control_0_WADDR_[3]\, WADDR(2) => 
        \mem_coef_control_0_WADDR_[2]\, WADDR(1) => 
        \mem_coef_control_0_WADDR_[1]\, WADDR(0) => 
        \mem_coef_control_0_WADDR_[0]\, RADDR(8) => 
        \mem_coef_control_0_RADDR_[8]\, RADDR(7) => 
        \mem_coef_control_0_RADDR_[7]\, RADDR(6) => 
        \mem_coef_control_0_RADDR_[6]\, RADDR(5) => 
        \mem_coef_control_0_RADDR_[5]\, RADDR(4) => 
        \mem_coef_control_0_RADDR_[4]\, RADDR(3) => 
        \mem_coef_control_0_RADDR_[3]\, RADDR(2) => 
        \mem_coef_control_0_RADDR_[2]\, RADDR(1) => 
        \mem_coef_control_0_RADDR_[1]\, RADDR(0) => 
        \mem_coef_control_0_RADDR_[0]\, RWCLK => CLK, RESET => 
        RST);
    
    mult_0 : mult
      port map(DataA(21) => \mem_sample_control_0_OUTPUT_[21]\, 
        DataA(20) => \mem_sample_control_0_OUTPUT_[20]\, 
        DataA(19) => \mem_sample_control_0_OUTPUT_[19]\, 
        DataA(18) => \mem_sample_control_0_OUTPUT_[18]\, 
        DataA(17) => \mem_sample_control_0_OUTPUT_[17]\, 
        DataA(16) => \mem_sample_control_0_OUTPUT_[16]\, 
        DataA(15) => \mem_sample_control_0_OUTPUT_[15]\, 
        DataA(14) => \mem_sample_control_0_OUTPUT_[14]\, 
        DataA(13) => \mem_sample_control_0_OUTPUT_[13]\, 
        DataA(12) => \mem_sample_control_0_OUTPUT_[12]\, 
        DataA(11) => \mem_sample_control_0_OUTPUT_[11]\, 
        DataA(10) => \mem_sample_control_0_OUTPUT_[10]\, DataA(9)
         => \mem_sample_control_0_OUTPUT_[9]\, DataA(8) => 
        \mem_sample_control_0_OUTPUT_[8]\, DataA(7) => 
        \mem_sample_control_0_OUTPUT_[7]\, DataA(6) => 
        \mem_sample_control_0_OUTPUT_[6]\, DataA(5) => 
        \mem_sample_control_0_OUTPUT_[5]\, DataA(4) => 
        \mem_sample_control_0_OUTPUT_[4]\, DataA(3) => 
        \mem_sample_control_0_OUTPUT_[3]\, DataA(2) => 
        \mem_sample_control_0_OUTPUT_[2]\, DataA(1) => 
        \mem_sample_control_0_OUTPUT_[1]\, DataA(0) => 
        \mem_sample_control_0_OUTPUT_[0]\, DataB(15) => 
        \mem_coef_control_0_OUTPUT_[15]\, DataB(14) => 
        \mem_coef_control_0_OUTPUT_[14]\, DataB(13) => 
        \mem_coef_control_0_OUTPUT_[13]\, DataB(12) => 
        \mem_coef_control_0_OUTPUT_[12]\, DataB(11) => 
        \mem_coef_control_0_OUTPUT_[11]\, DataB(10) => 
        \mem_coef_control_0_OUTPUT_[10]\, DataB(9) => 
        \mem_coef_control_0_OUTPUT_[9]\, DataB(8) => 
        \mem_coef_control_0_OUTPUT_[8]\, DataB(7) => 
        \mem_coef_control_0_OUTPUT_[7]\, DataB(6) => 
        \mem_coef_control_0_OUTPUT_[6]\, DataB(5) => 
        \mem_coef_control_0_OUTPUT_[5]\, DataB(4) => 
        \mem_coef_control_0_OUTPUT_[4]\, DataB(3) => 
        \mem_coef_control_0_OUTPUT_[3]\, DataB(2) => 
        \mem_coef_control_0_OUTPUT_[2]\, DataB(1) => 
        \mem_coef_control_0_OUTPUT_[1]\, DataB(0) => 
        \mem_coef_control_0_OUTPUT_[0]\, Mult(37) => 
        \mult_0_Mult_[37]\, Mult(36) => \mult_0_Mult_[36]\, 
        Mult(35) => \mult_0_Mult_[35]\, Mult(34) => 
        \mult_0_Mult_[34]\, Mult(33) => \mult_0_Mult_[33]\, 
        Mult(32) => \mult_0_Mult_[32]\, Mult(31) => 
        \mult_0_Mult_[31]\, Mult(30) => \mult_0_Mult_[30]\, 
        Mult(29) => \mult_0_Mult_[29]\, Mult(28) => 
        \mult_0_Mult_[28]\, Mult(27) => \mult_0_Mult_[27]\, 
        Mult(26) => \mult_0_Mult_[26]\, Mult(25) => 
        \mult_0_Mult_[25]\, Mult(24) => \mult_0_Mult_[24]\, 
        Mult(23) => \mult_0_Mult_[23]\, Mult(22) => 
        \mult_0_Mult_[22]\, Mult(21) => \mult_0_Mult_[21]\, 
        Mult(20) => \mult_0_Mult_[20]\, Mult(19) => 
        \mult_0_Mult_[19]\, Mult(18) => \mult_0_Mult_[18]\, 
        Mult(17) => \mult_0_Mult_[17]\, Mult(16) => 
        \mult_0_Mult_[16]\, Mult(15) => \mult_0_Mult_[15]\, 
        Mult(14) => \mult_0_Mult_[14]\, Mult(13) => 
        \mult_0_Mult_[13]\, Mult(12) => \mult_0_Mult_[12]\, 
        Mult(11) => \mult_0_Mult_[11]\, Mult(10) => 
        \mult_0_Mult_[10]\, Mult(9) => \mult_0_Mult_[9]\, Mult(8)
         => \mult_0_Mult_[8]\, Mult(7) => \mult_0_Mult_[7]\, 
        Mult(6) => \mult_0_Mult_[6]\, Mult(5) => 
        \mult_0_Mult_[5]\, Mult(4) => \mult_0_Mult_[4]\, Mult(3)
         => \mult_0_Mult_[3]\, Mult(2) => \mult_0_Mult_[2]\, 
        Mult(1) => \mult_0_Mult_[1]\, Mult(0) => 
        \mult_0_Mult_[0]\);
    
    mem_coef_control_0 : entity work.mem_coef_control
      port map(CLK => CLK, RST => RST, WD(17) => 
        \mem_coef_control_0_WD_[17]\, WD(16) => 
        \mem_coef_control_0_WD_[16]\, WD(15) => 
        \mem_coef_control_0_WD_[15]\, WD(14) => 
        \mem_coef_control_0_WD_[14]\, WD(13) => 
        \mem_coef_control_0_WD_[13]\, WD(12) => 
        \mem_coef_control_0_WD_[12]\, WD(11) => 
        \mem_coef_control_0_WD_[11]\, WD(10) => 
        \mem_coef_control_0_WD_[10]\, WD(9) => 
        \mem_coef_control_0_WD_[9]\, WD(8) => 
        \mem_coef_control_0_WD_[8]\, WD(7) => 
        \mem_coef_control_0_WD_[7]\, WD(6) => 
        \mem_coef_control_0_WD_[6]\, WD(5) => 
        \mem_coef_control_0_WD_[5]\, WD(4) => 
        \mem_coef_control_0_WD_[4]\, WD(3) => 
        \mem_coef_control_0_WD_[3]\, WD(2) => 
        \mem_coef_control_0_WD_[2]\, WD(1) => 
        \mem_coef_control_0_WD_[1]\, WD(0) => 
        \mem_coef_control_0_WD_[0]\, WADDR(8) => 
        \mem_coef_control_0_WADDR_[8]\, WADDR(7) => 
        \mem_coef_control_0_WADDR_[7]\, WADDR(6) => 
        \mem_coef_control_0_WADDR_[6]\, WADDR(5) => 
        \mem_coef_control_0_WADDR_[5]\, WADDR(4) => 
        \mem_coef_control_0_WADDR_[4]\, WADDR(3) => 
        \mem_coef_control_0_WADDR_[3]\, WADDR(2) => 
        \mem_coef_control_0_WADDR_[2]\, WADDR(1) => 
        \mem_coef_control_0_WADDR_[1]\, WADDR(0) => 
        \mem_coef_control_0_WADDR_[0]\, RADDR(8) => 
        \mem_coef_control_0_RADDR_[8]\, RADDR(7) => 
        \mem_coef_control_0_RADDR_[7]\, RADDR(6) => 
        \mem_coef_control_0_RADDR_[6]\, RADDR(5) => 
        \mem_coef_control_0_RADDR_[5]\, RADDR(4) => 
        \mem_coef_control_0_RADDR_[4]\, RADDR(3) => 
        \mem_coef_control_0_RADDR_[3]\, RADDR(2) => 
        \mem_coef_control_0_RADDR_[2]\, RADDR(1) => 
        \mem_coef_control_0_RADDR_[1]\, RADDR(0) => 
        \mem_coef_control_0_RADDR_[0]\, WEN => 
        mem_coef_control_0_WEN, REN => mem_coef_control_0_REN, 
        RD(17) => \mem_coef_0_RD_[17]\, RD(16) => 
        \mem_coef_0_RD_[16]\, RD(15) => \mem_coef_0_RD_[15]\, 
        RD(14) => \mem_coef_0_RD_[14]\, RD(13) => 
        \mem_coef_0_RD_[13]\, RD(12) => \mem_coef_0_RD_[12]\, 
        RD(11) => \mem_coef_0_RD_[11]\, RD(10) => 
        \mem_coef_0_RD_[10]\, RD(9) => \mem_coef_0_RD_[9]\, RD(8)
         => \mem_coef_0_RD_[8]\, RD(7) => \mem_coef_0_RD_[7]\, 
        RD(6) => \mem_coef_0_RD_[6]\, RD(5) => 
        \mem_coef_0_RD_[5]\, RD(4) => \mem_coef_0_RD_[4]\, RD(3)
         => \mem_coef_0_RD_[3]\, RD(2) => \mem_coef_0_RD_[2]\, 
        RD(1) => \mem_coef_0_RD_[1]\, RD(0) => 
        \mem_coef_0_RD_[0]\, OUTPUT(15) => 
        \mem_coef_control_0_OUTPUT_[15]\, OUTPUT(14) => 
        \mem_coef_control_0_OUTPUT_[14]\, OUTPUT(13) => 
        \mem_coef_control_0_OUTPUT_[13]\, OUTPUT(12) => 
        \mem_coef_control_0_OUTPUT_[12]\, OUTPUT(11) => 
        \mem_coef_control_0_OUTPUT_[11]\, OUTPUT(10) => 
        \mem_coef_control_0_OUTPUT_[10]\, OUTPUT(9) => 
        \mem_coef_control_0_OUTPUT_[9]\, OUTPUT(8) => 
        \mem_coef_control_0_OUTPUT_[8]\, OUTPUT(7) => 
        \mem_coef_control_0_OUTPUT_[7]\, OUTPUT(6) => 
        \mem_coef_control_0_OUTPUT_[6]\, OUTPUT(5) => 
        \mem_coef_control_0_OUTPUT_[5]\, OUTPUT(4) => 
        \mem_coef_control_0_OUTPUT_[4]\, OUTPUT(3) => 
        \mem_coef_control_0_OUTPUT_[3]\, OUTPUT(2) => 
        \mem_coef_control_0_OUTPUT_[2]\, OUTPUT(1) => 
        \mem_coef_control_0_OUTPUT_[1]\, OUTPUT(0) => 
        \mem_coef_control_0_OUTPUT_[0]\, GET_NEXT => 
        FIR_core_0_GET_NEXT);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    mem_sample_0 : mem_sample
      port map(WD(21) => \mem_sample_control_0_WD_[21]\, WD(20)
         => \mem_sample_control_0_WD_[20]\, WD(19) => 
        \mem_sample_control_0_WD_[19]\, WD(18) => 
        \mem_sample_control_0_WD_[18]\, WD(17) => 
        \mem_sample_control_0_WD_[17]\, WD(16) => 
        \mem_sample_control_0_WD_[16]\, WD(15) => 
        \mem_sample_control_0_WD_[15]\, WD(14) => 
        \mem_sample_control_0_WD_[14]\, WD(13) => 
        \mem_sample_control_0_WD_[13]\, WD(12) => 
        \mem_sample_control_0_WD_[12]\, WD(11) => 
        \mem_sample_control_0_WD_[11]\, WD(10) => 
        \mem_sample_control_0_WD_[10]\, WD(9) => 
        \mem_sample_control_0_WD_[9]\, WD(8) => 
        \mem_sample_control_0_WD_[8]\, WD(7) => 
        \mem_sample_control_0_WD_[7]\, WD(6) => 
        \mem_sample_control_0_WD_[6]\, WD(5) => 
        \mem_sample_control_0_WD_[5]\, WD(4) => 
        \mem_sample_control_0_WD_[4]\, WD(3) => 
        \mem_sample_control_0_WD_[3]\, WD(2) => 
        \mem_sample_control_0_WD_[2]\, WD(1) => 
        \mem_sample_control_0_WD_[1]\, WD(0) => 
        \mem_sample_control_0_WD_[0]\, RD(21) => 
        \mem_sample_0_RD_[21]\, RD(20) => \mem_sample_0_RD_[20]\, 
        RD(19) => \mem_sample_0_RD_[19]\, RD(18) => 
        \mem_sample_0_RD_[18]\, RD(17) => \mem_sample_0_RD_[17]\, 
        RD(16) => \mem_sample_0_RD_[16]\, RD(15) => 
        \mem_sample_0_RD_[15]\, RD(14) => \mem_sample_0_RD_[14]\, 
        RD(13) => \mem_sample_0_RD_[13]\, RD(12) => 
        \mem_sample_0_RD_[12]\, RD(11) => \mem_sample_0_RD_[11]\, 
        RD(10) => \mem_sample_0_RD_[10]\, RD(9) => 
        \mem_sample_0_RD_[9]\, RD(8) => \mem_sample_0_RD_[8]\, 
        RD(7) => \mem_sample_0_RD_[7]\, RD(6) => 
        \mem_sample_0_RD_[6]\, RD(5) => \mem_sample_0_RD_[5]\, 
        RD(4) => \mem_sample_0_RD_[4]\, RD(3) => 
        \mem_sample_0_RD_[3]\, RD(2) => \mem_sample_0_RD_[2]\, 
        RD(1) => \mem_sample_0_RD_[1]\, RD(0) => 
        \mem_sample_0_RD_[0]\, WEN => mem_sample_control_0_WEN, 
        REN => mem_sample_control_0_REN, WADDR(8) => 
        \mem_sample_control_0_WADDR_[8]\, WADDR(7) => 
        \mem_sample_control_0_WADDR_[7]\, WADDR(6) => 
        \mem_sample_control_0_WADDR_[6]\, WADDR(5) => 
        \mem_sample_control_0_WADDR_[5]\, WADDR(4) => 
        \mem_sample_control_0_WADDR_[4]\, WADDR(3) => 
        \mem_sample_control_0_WADDR_[3]\, WADDR(2) => 
        \mem_sample_control_0_WADDR_[2]\, WADDR(1) => 
        \mem_sample_control_0_WADDR_[1]\, WADDR(0) => 
        \mem_sample_control_0_WADDR_[0]\, RADDR(8) => 
        \mem_sample_control_0_RADDR_[8]\, RADDR(7) => 
        \mem_sample_control_0_RADDR_[7]\, RADDR(6) => 
        \mem_sample_control_0_RADDR_[6]\, RADDR(5) => 
        \mem_sample_control_0_RADDR_[5]\, RADDR(4) => 
        \mem_sample_control_0_RADDR_[4]\, RADDR(3) => 
        \mem_sample_control_0_RADDR_[3]\, RADDR(2) => 
        \mem_sample_control_0_RADDR_[2]\, RADDR(1) => 
        \mem_sample_control_0_RADDR_[1]\, RADDR(0) => 
        \mem_sample_control_0_RADDR_[0]\, RWCLK => CLK, RESET => 
        RST);
    

end DEF_ARCH; 
