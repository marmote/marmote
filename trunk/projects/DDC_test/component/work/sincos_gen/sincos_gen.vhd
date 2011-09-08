-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;
library CORECORDIC_LIB;
use CORECORDIC_LIB.all;

entity sincos_gen is

    port( RST       : in    std_logic;
          CLK       : in    std_logic;
          DPHASE_EN : in    std_logic;
          RDYOUT    : out   std_logic;
          DPHASE    : in    std_logic_vector(15 downto 0);
          COS_OUT   : out   std_logic_vector(7 downto 0);
          SIN_OUT   : out   std_logic_vector(7 downto 0)
        );

end sincos_gen;

architecture DEF_ARCH of sincos_gen is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CORECORDIC
    generic (ARCH:integer := 0; BIT_WIDTH:integer := 0; 
        FAMILY:integer := 0; ITERATIONS:integer := 0; 
        MODE:integer := 0);

    port( RST    : in    std_logic := 'U';
          NGRST  : in    std_logic := 'U';
          CLK    : in    std_logic := 'U';
          LDDATA : in    std_logic := 'U';
          RDYOUT : out   std_logic;
          CLKEN  : in    std_logic := 'U';
          X0     : in    std_logic_vector(15 downto 0) := (others => 'U');
          Y0     : in    std_logic_vector(15 downto 0) := (others => 'U');
          A0     : in    std_logic_vector(15 downto 0) := (others => 'U');
          XN     : out   std_logic_vector(15 downto 0);
          YN     : out   std_logic_vector(15 downto 0);
          AN     : out   std_logic_vector(15 downto 0)
        );
  end component;

    signal CORECORDIC_0_RDYOUT, \CORECORDIC_0_XN_[15]\, 
        \CORECORDIC_0_XN_[14]\, \CORECORDIC_0_XN_[13]\, 
        \CORECORDIC_0_XN_[12]\, \CORECORDIC_0_XN_[11]\, 
        \CORECORDIC_0_XN_[10]\, \CORECORDIC_0_XN_[9]\, 
        \CORECORDIC_0_XN_[8]\, \CORECORDIC_0_XN_[7]\, 
        \CORECORDIC_0_XN_[6]\, \CORECORDIC_0_XN_[5]\, 
        \CORECORDIC_0_XN_[4]\, \CORECORDIC_0_XN_[3]\, 
        \CORECORDIC_0_XN_[2]\, \CORECORDIC_0_XN_[1]\, 
        \CORECORDIC_0_XN_[0]\, \CORECORDIC_0_YN_[15]\, 
        \CORECORDIC_0_YN_[14]\, \CORECORDIC_0_YN_[13]\, 
        \CORECORDIC_0_YN_[12]\, \CORECORDIC_0_YN_[11]\, 
        \CORECORDIC_0_YN_[10]\, \CORECORDIC_0_YN_[9]\, 
        \CORECORDIC_0_YN_[8]\, \CORECORDIC_0_YN_[7]\, 
        \CORECORDIC_0_YN_[6]\, \CORECORDIC_0_YN_[5]\, 
        \CORECORDIC_0_YN_[4]\, \CORECORDIC_0_YN_[3]\, 
        \CORECORDIC_0_YN_[2]\, \CORECORDIC_0_YN_[1]\, 
        \CORECORDIC_0_YN_[0]\, PHASE_GEN_0_INV_EN, 
        \PHASE_GEN_0_MAGNITUDE_[15]\, 
        \PHASE_GEN_0_MAGNITUDE_[14]\, 
        \PHASE_GEN_0_MAGNITUDE_[13]\, 
        \PHASE_GEN_0_MAGNITUDE_[12]\, 
        \PHASE_GEN_0_MAGNITUDE_[11]\, 
        \PHASE_GEN_0_MAGNITUDE_[10]\, \PHASE_GEN_0_MAGNITUDE_[9]\, 
        \PHASE_GEN_0_MAGNITUDE_[8]\, \PHASE_GEN_0_MAGNITUDE_[7]\, 
        \PHASE_GEN_0_MAGNITUDE_[6]\, \PHASE_GEN_0_MAGNITUDE_[5]\, 
        \PHASE_GEN_0_MAGNITUDE_[4]\, \PHASE_GEN_0_MAGNITUDE_[3]\, 
        \PHASE_GEN_0_MAGNITUDE_[2]\, \PHASE_GEN_0_MAGNITUDE_[1]\, 
        \PHASE_GEN_0_MAGNITUDE_[0]\, \PHASE_GEN_0_PHASE_[15]\, 
        \PHASE_GEN_0_PHASE_[14]\, \PHASE_GEN_0_PHASE_[13]\, 
        \PHASE_GEN_0_PHASE_[12]\, \PHASE_GEN_0_PHASE_[11]\, 
        \PHASE_GEN_0_PHASE_[10]\, \PHASE_GEN_0_PHASE_[9]\, 
        \PHASE_GEN_0_PHASE_[8]\, \PHASE_GEN_0_PHASE_[7]\, 
        \PHASE_GEN_0_PHASE_[6]\, \PHASE_GEN_0_PHASE_[5]\, 
        \PHASE_GEN_0_PHASE_[4]\, \PHASE_GEN_0_PHASE_[3]\, 
        \PHASE_GEN_0_PHASE_[2]\, \PHASE_GEN_0_PHASE_[1]\, 
        \PHASE_GEN_0_PHASE_[0]\, PHASE_GEN_0_PHASE_EN, GND_net, 
        VCC_net : std_logic;
    signal nc7, nc6, nc12, nc5, nc15, nc1, nc16, nc14, nc9, nc13, 
        nc8, nc4, nc11, nc3, nc10, nc2 : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net);
    
    SIGN_CORRECTOR_0 : entity work.SIGN_CORRECTOR
      port map(CLK => CLK, RST => RST, INV_EN => 
        PHASE_GEN_0_INV_EN, RDY_IN => CORECORDIC_0_RDYOUT, RDYOUT
         => RDYOUT, COS_IN(15) => \CORECORDIC_0_XN_[15]\, 
        COS_IN(14) => \CORECORDIC_0_XN_[14]\, COS_IN(13) => 
        \CORECORDIC_0_XN_[13]\, COS_IN(12) => 
        \CORECORDIC_0_XN_[12]\, COS_IN(11) => 
        \CORECORDIC_0_XN_[11]\, COS_IN(10) => 
        \CORECORDIC_0_XN_[10]\, COS_IN(9) => 
        \CORECORDIC_0_XN_[9]\, COS_IN(8) => \CORECORDIC_0_XN_[8]\, 
        COS_IN(7) => \CORECORDIC_0_XN_[7]\, COS_IN(6) => 
        \CORECORDIC_0_XN_[6]\, COS_IN(5) => \CORECORDIC_0_XN_[5]\, 
        COS_IN(4) => \CORECORDIC_0_XN_[4]\, COS_IN(3) => 
        \CORECORDIC_0_XN_[3]\, COS_IN(2) => \CORECORDIC_0_XN_[2]\, 
        COS_IN(1) => \CORECORDIC_0_XN_[1]\, COS_IN(0) => 
        \CORECORDIC_0_XN_[0]\, SIN_IN(15) => 
        \CORECORDIC_0_YN_[15]\, SIN_IN(14) => 
        \CORECORDIC_0_YN_[14]\, SIN_IN(13) => 
        \CORECORDIC_0_YN_[13]\, SIN_IN(12) => 
        \CORECORDIC_0_YN_[12]\, SIN_IN(11) => 
        \CORECORDIC_0_YN_[11]\, SIN_IN(10) => 
        \CORECORDIC_0_YN_[10]\, SIN_IN(9) => 
        \CORECORDIC_0_YN_[9]\, SIN_IN(8) => \CORECORDIC_0_YN_[8]\, 
        SIN_IN(7) => \CORECORDIC_0_YN_[7]\, SIN_IN(6) => 
        \CORECORDIC_0_YN_[6]\, SIN_IN(5) => \CORECORDIC_0_YN_[5]\, 
        SIN_IN(4) => \CORECORDIC_0_YN_[4]\, SIN_IN(3) => 
        \CORECORDIC_0_YN_[3]\, SIN_IN(2) => \CORECORDIC_0_YN_[2]\, 
        SIN_IN(1) => \CORECORDIC_0_YN_[1]\, SIN_IN(0) => 
        \CORECORDIC_0_YN_[0]\, COS_OUT(7) => COS_OUT(7), 
        COS_OUT(6) => COS_OUT(6), COS_OUT(5) => COS_OUT(5), 
        COS_OUT(4) => COS_OUT(4), COS_OUT(3) => COS_OUT(3), 
        COS_OUT(2) => COS_OUT(2), COS_OUT(1) => COS_OUT(1), 
        COS_OUT(0) => COS_OUT(0), SIN_OUT(7) => SIN_OUT(7), 
        SIN_OUT(6) => SIN_OUT(6), SIN_OUT(5) => SIN_OUT(5), 
        SIN_OUT(4) => SIN_OUT(4), SIN_OUT(3) => SIN_OUT(3), 
        SIN_OUT(2) => SIN_OUT(2), SIN_OUT(1) => SIN_OUT(1), 
        SIN_OUT(0) => SIN_OUT(0));
    
    \GND\ : GND
      port map(Y => GND_net);
    
    PHASE_GEN_0 : entity work.PHASE_GEN
      port map(CLK => CLK, RST => RST, DPHASE_EN => DPHASE_EN, 
        PHASE_EN => PHASE_GEN_0_PHASE_EN, INV_EN => 
        PHASE_GEN_0_INV_EN, DPHASE(15) => DPHASE(15), DPHASE(14)
         => DPHASE(14), DPHASE(13) => DPHASE(13), DPHASE(12) => 
        DPHASE(12), DPHASE(11) => DPHASE(11), DPHASE(10) => 
        DPHASE(10), DPHASE(9) => DPHASE(9), DPHASE(8) => 
        DPHASE(8), DPHASE(7) => DPHASE(7), DPHASE(6) => DPHASE(6), 
        DPHASE(5) => DPHASE(5), DPHASE(4) => DPHASE(4), DPHASE(3)
         => DPHASE(3), DPHASE(2) => DPHASE(2), DPHASE(1) => 
        DPHASE(1), DPHASE(0) => DPHASE(0), MAGNITUDE(15) => 
        \PHASE_GEN_0_MAGNITUDE_[15]\, MAGNITUDE(14) => 
        \PHASE_GEN_0_MAGNITUDE_[14]\, MAGNITUDE(13) => 
        \PHASE_GEN_0_MAGNITUDE_[13]\, MAGNITUDE(12) => 
        \PHASE_GEN_0_MAGNITUDE_[12]\, MAGNITUDE(11) => 
        \PHASE_GEN_0_MAGNITUDE_[11]\, MAGNITUDE(10) => 
        \PHASE_GEN_0_MAGNITUDE_[10]\, MAGNITUDE(9) => 
        \PHASE_GEN_0_MAGNITUDE_[9]\, MAGNITUDE(8) => 
        \PHASE_GEN_0_MAGNITUDE_[8]\, MAGNITUDE(7) => 
        \PHASE_GEN_0_MAGNITUDE_[7]\, MAGNITUDE(6) => 
        \PHASE_GEN_0_MAGNITUDE_[6]\, MAGNITUDE(5) => 
        \PHASE_GEN_0_MAGNITUDE_[5]\, MAGNITUDE(4) => 
        \PHASE_GEN_0_MAGNITUDE_[4]\, MAGNITUDE(3) => 
        \PHASE_GEN_0_MAGNITUDE_[3]\, MAGNITUDE(2) => 
        \PHASE_GEN_0_MAGNITUDE_[2]\, MAGNITUDE(1) => 
        \PHASE_GEN_0_MAGNITUDE_[1]\, MAGNITUDE(0) => 
        \PHASE_GEN_0_MAGNITUDE_[0]\, PHASE(15) => 
        \PHASE_GEN_0_PHASE_[15]\, PHASE(14) => 
        \PHASE_GEN_0_PHASE_[14]\, PHASE(13) => 
        \PHASE_GEN_0_PHASE_[13]\, PHASE(12) => 
        \PHASE_GEN_0_PHASE_[12]\, PHASE(11) => 
        \PHASE_GEN_0_PHASE_[11]\, PHASE(10) => 
        \PHASE_GEN_0_PHASE_[10]\, PHASE(9) => 
        \PHASE_GEN_0_PHASE_[9]\, PHASE(8) => 
        \PHASE_GEN_0_PHASE_[8]\, PHASE(7) => 
        \PHASE_GEN_0_PHASE_[7]\, PHASE(6) => 
        \PHASE_GEN_0_PHASE_[6]\, PHASE(5) => 
        \PHASE_GEN_0_PHASE_[5]\, PHASE(4) => 
        \PHASE_GEN_0_PHASE_[4]\, PHASE(3) => 
        \PHASE_GEN_0_PHASE_[3]\, PHASE(2) => 
        \PHASE_GEN_0_PHASE_[2]\, PHASE(1) => 
        \PHASE_GEN_0_PHASE_[1]\, PHASE(0) => 
        \PHASE_GEN_0_PHASE_[0]\);
    
    CORECORDIC_0 : CORECORDIC
      generic map(ARCH => 1, BIT_WIDTH => 16, FAMILY => 15,
         ITERATIONS => 16, MODE => 0)

      port map(RST => GND_net, NGRST => RST, CLK => CLK, LDDATA
         => PHASE_GEN_0_PHASE_EN, RDYOUT => CORECORDIC_0_RDYOUT, 
        CLKEN => GND_net, X0(15) => \PHASE_GEN_0_MAGNITUDE_[15]\, 
        X0(14) => \PHASE_GEN_0_MAGNITUDE_[14]\, X0(13) => 
        \PHASE_GEN_0_MAGNITUDE_[13]\, X0(12) => 
        \PHASE_GEN_0_MAGNITUDE_[12]\, X0(11) => 
        \PHASE_GEN_0_MAGNITUDE_[11]\, X0(10) => 
        \PHASE_GEN_0_MAGNITUDE_[10]\, X0(9) => 
        \PHASE_GEN_0_MAGNITUDE_[9]\, X0(8) => 
        \PHASE_GEN_0_MAGNITUDE_[8]\, X0(7) => 
        \PHASE_GEN_0_MAGNITUDE_[7]\, X0(6) => 
        \PHASE_GEN_0_MAGNITUDE_[6]\, X0(5) => 
        \PHASE_GEN_0_MAGNITUDE_[5]\, X0(4) => 
        \PHASE_GEN_0_MAGNITUDE_[4]\, X0(3) => 
        \PHASE_GEN_0_MAGNITUDE_[3]\, X0(2) => 
        \PHASE_GEN_0_MAGNITUDE_[2]\, X0(1) => 
        \PHASE_GEN_0_MAGNITUDE_[1]\, X0(0) => 
        \PHASE_GEN_0_MAGNITUDE_[0]\, Y0(15) => GND_net, Y0(14)
         => GND_net, Y0(13) => GND_net, Y0(12) => GND_net, Y0(11)
         => GND_net, Y0(10) => GND_net, Y0(9) => GND_net, Y0(8)
         => GND_net, Y0(7) => GND_net, Y0(6) => GND_net, Y0(5)
         => GND_net, Y0(4) => GND_net, Y0(3) => GND_net, Y0(2)
         => GND_net, Y0(1) => GND_net, Y0(0) => GND_net, A0(15)
         => \PHASE_GEN_0_PHASE_[15]\, A0(14) => 
        \PHASE_GEN_0_PHASE_[14]\, A0(13) => 
        \PHASE_GEN_0_PHASE_[13]\, A0(12) => 
        \PHASE_GEN_0_PHASE_[12]\, A0(11) => 
        \PHASE_GEN_0_PHASE_[11]\, A0(10) => 
        \PHASE_GEN_0_PHASE_[10]\, A0(9) => 
        \PHASE_GEN_0_PHASE_[9]\, A0(8) => \PHASE_GEN_0_PHASE_[8]\, 
        A0(7) => \PHASE_GEN_0_PHASE_[7]\, A0(6) => 
        \PHASE_GEN_0_PHASE_[6]\, A0(5) => \PHASE_GEN_0_PHASE_[5]\, 
        A0(4) => \PHASE_GEN_0_PHASE_[4]\, A0(3) => 
        \PHASE_GEN_0_PHASE_[3]\, A0(2) => \PHASE_GEN_0_PHASE_[2]\, 
        A0(1) => \PHASE_GEN_0_PHASE_[1]\, A0(0) => 
        \PHASE_GEN_0_PHASE_[0]\, XN(15) => \CORECORDIC_0_XN_[15]\, 
        XN(14) => \CORECORDIC_0_XN_[14]\, XN(13) => 
        \CORECORDIC_0_XN_[13]\, XN(12) => \CORECORDIC_0_XN_[12]\, 
        XN(11) => \CORECORDIC_0_XN_[11]\, XN(10) => 
        \CORECORDIC_0_XN_[10]\, XN(9) => \CORECORDIC_0_XN_[9]\, 
        XN(8) => \CORECORDIC_0_XN_[8]\, XN(7) => 
        \CORECORDIC_0_XN_[7]\, XN(6) => \CORECORDIC_0_XN_[6]\, 
        XN(5) => \CORECORDIC_0_XN_[5]\, XN(4) => 
        \CORECORDIC_0_XN_[4]\, XN(3) => \CORECORDIC_0_XN_[3]\, 
        XN(2) => \CORECORDIC_0_XN_[2]\, XN(1) => 
        \CORECORDIC_0_XN_[1]\, XN(0) => \CORECORDIC_0_XN_[0]\, 
        YN(15) => \CORECORDIC_0_YN_[15]\, YN(14) => 
        \CORECORDIC_0_YN_[14]\, YN(13) => \CORECORDIC_0_YN_[13]\, 
        YN(12) => \CORECORDIC_0_YN_[12]\, YN(11) => 
        \CORECORDIC_0_YN_[11]\, YN(10) => \CORECORDIC_0_YN_[10]\, 
        YN(9) => \CORECORDIC_0_YN_[9]\, YN(8) => 
        \CORECORDIC_0_YN_[8]\, YN(7) => \CORECORDIC_0_YN_[7]\, 
        YN(6) => \CORECORDIC_0_YN_[6]\, YN(5) => 
        \CORECORDIC_0_YN_[5]\, YN(4) => \CORECORDIC_0_YN_[4]\, 
        YN(3) => \CORECORDIC_0_YN_[3]\, YN(2) => 
        \CORECORDIC_0_YN_[2]\, YN(1) => \CORECORDIC_0_YN_[1]\, 
        YN(0) => \CORECORDIC_0_YN_[0]\, AN(15) => nc7, AN(14) => 
        nc6, AN(13) => nc12, AN(12) => nc5, AN(11) => nc15, 
        AN(10) => nc1, AN(9) => nc16, AN(8) => nc14, AN(7) => nc9, 
        AN(6) => nc13, AN(5) => nc8, AN(4) => nc4, AN(3) => nc11, 
        AN(2) => nc3, AN(1) => nc10, AN(0) => nc2);
    

end DEF_ARCH; 
