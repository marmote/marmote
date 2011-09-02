-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity DDC is

    port( RST      : in    std_logic;
          CLK      : in    std_logic;
          SCLK     : out   std_logic;
          CSn      : out   std_logic;
          SDATA    : in    std_logic_vector(1 to 2);
          CH2      : out   std_logic_vector(13 downto 0);
          CH1      : out   std_logic_vector(13 downto 0);
          OUTPUT_0 : out   std_logic_vector(21 downto 0)
        );

end DDC;

architecture DEF_ARCH of DDC is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component mult2
    port( DataA : in    std_logic_vector(13 downto 0) := (others => 'U');
          DataB : in    std_logic_vector(7 downto 0) := (others => 'U');
          Mult  : out   std_logic_vector(21 downto 0)
        );
  end component;

  component sincos_gen
    port( RST       : in    std_logic := 'U';
          CLK       : in    std_logic := 'U';
          DPHASE_EN : in    std_logic := 'U';
          RDYOUT    : out   std_logic;
          DPHASE    : in    std_logic_vector(15 downto 0) := (others => 'U');
          COS_OUT   : out   std_logic_vector(7 downto 0);
          SIN_OUT   : out   std_logic_vector(7 downto 0)
        );
  end component;

  component mult1
    port( DataA : in    std_logic_vector(13 downto 0) := (others => 'U');
          DataB : in    std_logic_vector(7 downto 0) := (others => 'U');
          Mult  : out   std_logic_vector(21 downto 0)
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \CH1_[13]\, \CH1_[12]\, \CH1_[11]\, \CH1_[10]\, 
        \CH1_[9]\, \CH1_[8]\, \CH1_[7]\, \CH1_[6]\, \CH1_[5]\, 
        \CH1_[4]\, \CH1_[3]\, \CH1_[2]\, \CH1_[1]\, \CH1_[0]\, 
        \CH2_[13]\, \CH2_[12]\, \CH2_[11]\, \CH2_[10]\, \CH2_[9]\, 
        \CH2_[8]\, \CH2_[7]\, \CH2_[6]\, \CH2_[5]\, \CH2_[4]\, 
        \CH2_[3]\, \CH2_[2]\, \CH2_[1]\, \CH2_[0]\, 
        \mult1_0_Mult_0_[21]\, \mult1_0_Mult_0_[20]\, 
        \mult1_0_Mult_0_[19]\, \mult1_0_Mult_0_[18]\, 
        \mult1_0_Mult_0_[17]\, \mult1_0_Mult_0_[16]\, 
        \mult1_0_Mult_0_[15]\, \mult1_0_Mult_0_[14]\, 
        \mult1_0_Mult_0_[13]\, \mult1_0_Mult_0_[12]\, 
        \mult1_0_Mult_0_[11]\, \mult1_0_Mult_0_[10]\, 
        \mult1_0_Mult_0_[9]\, \mult1_0_Mult_0_[8]\, 
        \mult1_0_Mult_0_[7]\, \mult1_0_Mult_0_[6]\, 
        \mult1_0_Mult_0_[5]\, \mult1_0_Mult_0_[4]\, 
        \mult1_0_Mult_0_[3]\, \mult1_0_Mult_0_[2]\, 
        \mult1_0_Mult_0_[1]\, \mult1_0_Mult_0_[0]\, 
        \sincos_gen_0_COS_OUT_0_[7]\, 
        \sincos_gen_0_COS_OUT_0_[6]\, 
        \sincos_gen_0_COS_OUT_0_[5]\, 
        \sincos_gen_0_COS_OUT_0_[4]\, 
        \sincos_gen_0_COS_OUT_0_[3]\, 
        \sincos_gen_0_COS_OUT_0_[2]\, 
        \sincos_gen_0_COS_OUT_0_[1]\, 
        \sincos_gen_0_COS_OUT_0_[0]\, 
        \sincos_gen_0_SIN_OUT_0_[7]\, 
        \sincos_gen_0_SIN_OUT_0_[6]\, 
        \sincos_gen_0_SIN_OUT_0_[5]\, 
        \sincos_gen_0_SIN_OUT_0_[4]\, 
        \sincos_gen_0_SIN_OUT_0_[3]\, 
        \sincos_gen_0_SIN_OUT_0_[2]\, 
        \sincos_gen_0_SIN_OUT_0_[1]\, 
        \sincos_gen_0_SIN_OUT_0_[0]\, GND_net, VCC_net
         : std_logic;
    signal nc47, nc34, nc60, nc64, nc9, nc13, nc23, nc55, nc33, 
        nc16, nc26, nc45, nc58, nc63, nc27, nc17, nc36, nc48, 
        nc37, nc5, nc52, nc51, nc66, nc4, nc42, nc41, nc59, nc25, 
        nc15, nc35, nc49, nc28, nc18, nc65, nc38, nc1, nc2, nc50, 
        nc22, nc12, nc21, nc11, nc54, nc3, nc32, nc40, nc31, nc44, 
        nc7, nc6, nc62, nc61, nc19, nc29, nc53, nc39, nc8, nc43, 
        nc56, nc20, nc10, nc57, nc24, nc14, nc46, nc30
         : std_logic;

begin 

    CH2(13) <= \CH2_[13]\;
    CH2(12) <= \CH2_[12]\;
    CH2(11) <= \CH2_[11]\;
    CH2(10) <= \CH2_[10]\;
    CH2(9) <= \CH2_[9]\;
    CH2(8) <= \CH2_[8]\;
    CH2(7) <= \CH2_[7]\;
    CH2(6) <= \CH2_[6]\;
    CH2(5) <= \CH2_[5]\;
    CH2(4) <= \CH2_[4]\;
    CH2(3) <= \CH2_[3]\;
    CH2(2) <= \CH2_[2]\;
    CH2(1) <= \CH2_[1]\;
    CH2(0) <= \CH2_[0]\;
    CH1(13) <= \CH1_[13]\;
    CH1(12) <= \CH1_[12]\;
    CH1(11) <= \CH1_[11]\;
    CH1(10) <= \CH1_[10]\;
    CH1(9) <= \CH1_[9]\;
    CH1(8) <= \CH1_[8]\;
    CH1(7) <= \CH1_[7]\;
    CH1(6) <= \CH1_[6]\;
    CH1(5) <= \CH1_[5]\;
    CH1(4) <= \CH1_[4]\;
    CH1(3) <= \CH1_[3]\;
    CH1(2) <= \CH1_[2]\;
    CH1(1) <= \CH1_[1]\;
    CH1(0) <= \CH1_[0]\;

    \VCC\ : VCC
      port map(Y => VCC_net);
    
    mult2_1 : mult2
      port map(DataA(13) => \CH2_[13]\, DataA(12) => \CH2_[12]\, 
        DataA(11) => \CH2_[11]\, DataA(10) => \CH2_[10]\, 
        DataA(9) => \CH2_[9]\, DataA(8) => \CH2_[8]\, DataA(7)
         => \CH2_[7]\, DataA(6) => \CH2_[6]\, DataA(5) => 
        \CH2_[5]\, DataA(4) => \CH2_[4]\, DataA(3) => \CH2_[3]\, 
        DataA(2) => \CH2_[2]\, DataA(1) => \CH2_[1]\, DataA(0)
         => \CH2_[0]\, DataB(7) => \sincos_gen_0_SIN_OUT_0_[7]\, 
        DataB(6) => \sincos_gen_0_SIN_OUT_0_[6]\, DataB(5) => 
        \sincos_gen_0_SIN_OUT_0_[5]\, DataB(4) => 
        \sincos_gen_0_SIN_OUT_0_[4]\, DataB(3) => 
        \sincos_gen_0_SIN_OUT_0_[3]\, DataB(2) => 
        \sincos_gen_0_SIN_OUT_0_[2]\, DataB(1) => 
        \sincos_gen_0_SIN_OUT_0_[1]\, DataB(0) => 
        \sincos_gen_0_SIN_OUT_0_[0]\, Mult(21) => nc47, Mult(20)
         => nc34, Mult(19) => nc60, Mult(18) => nc64, Mult(17)
         => nc9, Mult(16) => nc13, Mult(15) => nc23, Mult(14) => 
        nc55, Mult(13) => nc33, Mult(12) => nc16, Mult(11) => 
        nc26, Mult(10) => nc45, Mult(9) => nc58, Mult(8) => nc63, 
        Mult(7) => nc27, Mult(6) => nc17, Mult(5) => nc36, 
        Mult(4) => nc48, Mult(3) => nc37, Mult(2) => nc5, Mult(1)
         => nc52, Mult(0) => nc51);
    
    mult2_0 : mult2
      port map(DataA(13) => \CH2_[13]\, DataA(12) => \CH2_[12]\, 
        DataA(11) => \CH2_[11]\, DataA(10) => \CH2_[10]\, 
        DataA(9) => \CH2_[9]\, DataA(8) => \CH2_[8]\, DataA(7)
         => \CH2_[7]\, DataA(6) => \CH2_[6]\, DataA(5) => 
        \CH2_[5]\, DataA(4) => \CH2_[4]\, DataA(3) => \CH2_[3]\, 
        DataA(2) => \CH2_[2]\, DataA(1) => \CH2_[1]\, DataA(0)
         => \CH2_[0]\, DataB(7) => \sincos_gen_0_COS_OUT_0_[7]\, 
        DataB(6) => \sincos_gen_0_COS_OUT_0_[6]\, DataB(5) => 
        \sincos_gen_0_COS_OUT_0_[5]\, DataB(4) => 
        \sincos_gen_0_COS_OUT_0_[4]\, DataB(3) => 
        \sincos_gen_0_COS_OUT_0_[3]\, DataB(2) => 
        \sincos_gen_0_COS_OUT_0_[2]\, DataB(1) => 
        \sincos_gen_0_COS_OUT_0_[1]\, DataB(0) => 
        \sincos_gen_0_COS_OUT_0_[0]\, Mult(21) => nc66, Mult(20)
         => nc4, Mult(19) => nc42, Mult(18) => nc41, Mult(17) => 
        nc59, Mult(16) => nc25, Mult(15) => nc15, Mult(14) => 
        nc35, Mult(13) => nc49, Mult(12) => nc28, Mult(11) => 
        nc18, Mult(10) => nc65, Mult(9) => nc38, Mult(8) => nc1, 
        Mult(7) => nc2, Mult(6) => nc50, Mult(5) => nc22, Mult(4)
         => nc12, Mult(3) => nc21, Mult(2) => nc11, Mult(1) => 
        nc54, Mult(0) => nc3);
    
    sincos_gen_0 : sincos_gen
      port map(RST => RST, CLK => CLK, DPHASE_EN => VCC_net, 
        RDYOUT => OPEN, DPHASE(15) => GND_net, DPHASE(14) => 
        GND_net, DPHASE(13) => GND_net, DPHASE(12) => GND_net, 
        DPHASE(11) => GND_net, DPHASE(10) => GND_net, DPHASE(9)
         => GND_net, DPHASE(8) => VCC_net, DPHASE(7) => GND_net, 
        DPHASE(6) => GND_net, DPHASE(5) => GND_net, DPHASE(4) => 
        GND_net, DPHASE(3) => GND_net, DPHASE(2) => GND_net, 
        DPHASE(1) => GND_net, DPHASE(0) => GND_net, COS_OUT(7)
         => \sincos_gen_0_COS_OUT_0_[7]\, COS_OUT(6) => 
        \sincos_gen_0_COS_OUT_0_[6]\, COS_OUT(5) => 
        \sincos_gen_0_COS_OUT_0_[5]\, COS_OUT(4) => 
        \sincos_gen_0_COS_OUT_0_[4]\, COS_OUT(3) => 
        \sincos_gen_0_COS_OUT_0_[3]\, COS_OUT(2) => 
        \sincos_gen_0_COS_OUT_0_[2]\, COS_OUT(1) => 
        \sincos_gen_0_COS_OUT_0_[1]\, COS_OUT(0) => 
        \sincos_gen_0_COS_OUT_0_[0]\, SIN_OUT(7) => 
        \sincos_gen_0_SIN_OUT_0_[7]\, SIN_OUT(6) => 
        \sincos_gen_0_SIN_OUT_0_[6]\, SIN_OUT(5) => 
        \sincos_gen_0_SIN_OUT_0_[5]\, SIN_OUT(4) => 
        \sincos_gen_0_SIN_OUT_0_[4]\, SIN_OUT(3) => 
        \sincos_gen_0_SIN_OUT_0_[3]\, SIN_OUT(2) => 
        \sincos_gen_0_SIN_OUT_0_[2]\, SIN_OUT(1) => 
        \sincos_gen_0_SIN_OUT_0_[1]\, SIN_OUT(0) => 
        \sincos_gen_0_SIN_OUT_0_[0]\);
    
    mult1_1 : mult1
      port map(DataA(13) => \CH1_[13]\, DataA(12) => \CH1_[12]\, 
        DataA(11) => \CH1_[11]\, DataA(10) => \CH1_[10]\, 
        DataA(9) => \CH1_[9]\, DataA(8) => \CH1_[8]\, DataA(7)
         => \CH1_[7]\, DataA(6) => \CH1_[6]\, DataA(5) => 
        \CH1_[5]\, DataA(4) => \CH1_[4]\, DataA(3) => \CH1_[3]\, 
        DataA(2) => \CH1_[2]\, DataA(1) => \CH1_[1]\, DataA(0)
         => \CH1_[0]\, DataB(7) => \sincos_gen_0_SIN_OUT_0_[7]\, 
        DataB(6) => \sincos_gen_0_SIN_OUT_0_[6]\, DataB(5) => 
        \sincos_gen_0_SIN_OUT_0_[5]\, DataB(4) => 
        \sincos_gen_0_SIN_OUT_0_[4]\, DataB(3) => 
        \sincos_gen_0_SIN_OUT_0_[3]\, DataB(2) => 
        \sincos_gen_0_SIN_OUT_0_[2]\, DataB(1) => 
        \sincos_gen_0_SIN_OUT_0_[1]\, DataB(0) => 
        \sincos_gen_0_SIN_OUT_0_[0]\, Mult(21) => nc32, Mult(20)
         => nc40, Mult(19) => nc31, Mult(18) => nc44, Mult(17)
         => nc7, Mult(16) => nc6, Mult(15) => nc62, Mult(14) => 
        nc61, Mult(13) => nc19, Mult(12) => nc29, Mult(11) => 
        nc53, Mult(10) => nc39, Mult(9) => nc8, Mult(8) => nc43, 
        Mult(7) => nc56, Mult(6) => nc20, Mult(5) => nc10, 
        Mult(4) => nc57, Mult(3) => nc24, Mult(2) => nc14, 
        Mult(1) => nc46, Mult(0) => nc30);
    
    mult1_0 : mult1
      port map(DataA(13) => \CH1_[13]\, DataA(12) => \CH1_[12]\, 
        DataA(11) => \CH1_[11]\, DataA(10) => \CH1_[10]\, 
        DataA(9) => \CH1_[9]\, DataA(8) => \CH1_[8]\, DataA(7)
         => \CH1_[7]\, DataA(6) => \CH1_[6]\, DataA(5) => 
        \CH1_[5]\, DataA(4) => \CH1_[4]\, DataA(3) => \CH1_[3]\, 
        DataA(2) => \CH1_[2]\, DataA(1) => \CH1_[1]\, DataA(0)
         => \CH1_[0]\, DataB(7) => \sincos_gen_0_COS_OUT_0_[7]\, 
        DataB(6) => \sincos_gen_0_COS_OUT_0_[6]\, DataB(5) => 
        \sincos_gen_0_COS_OUT_0_[5]\, DataB(4) => 
        \sincos_gen_0_COS_OUT_0_[4]\, DataB(3) => 
        \sincos_gen_0_COS_OUT_0_[3]\, DataB(2) => 
        \sincos_gen_0_COS_OUT_0_[2]\, DataB(1) => 
        \sincos_gen_0_COS_OUT_0_[1]\, DataB(0) => 
        \sincos_gen_0_COS_OUT_0_[0]\, Mult(21) => 
        \mult1_0_Mult_0_[21]\, Mult(20) => \mult1_0_Mult_0_[20]\, 
        Mult(19) => \mult1_0_Mult_0_[19]\, Mult(18) => 
        \mult1_0_Mult_0_[18]\, Mult(17) => \mult1_0_Mult_0_[17]\, 
        Mult(16) => \mult1_0_Mult_0_[16]\, Mult(15) => 
        \mult1_0_Mult_0_[15]\, Mult(14) => \mult1_0_Mult_0_[14]\, 
        Mult(13) => \mult1_0_Mult_0_[13]\, Mult(12) => 
        \mult1_0_Mult_0_[12]\, Mult(11) => \mult1_0_Mult_0_[11]\, 
        Mult(10) => \mult1_0_Mult_0_[10]\, Mult(9) => 
        \mult1_0_Mult_0_[9]\, Mult(8) => \mult1_0_Mult_0_[8]\, 
        Mult(7) => \mult1_0_Mult_0_[7]\, Mult(6) => 
        \mult1_0_Mult_0_[6]\, Mult(5) => \mult1_0_Mult_0_[5]\, 
        Mult(4) => \mult1_0_Mult_0_[4]\, Mult(3) => 
        \mult1_0_Mult_0_[3]\, Mult(2) => \mult1_0_Mult_0_[2]\, 
        Mult(1) => \mult1_0_Mult_0_[1]\, Mult(0) => 
        \mult1_0_Mult_0_[0]\);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    CIC_0 : entity work.CIC
      port map(CLK => CLK, RST => RST, INPUT(21) => 
        \mult1_0_Mult_0_[21]\, INPUT(20) => \mult1_0_Mult_0_[20]\, 
        INPUT(19) => \mult1_0_Mult_0_[19]\, INPUT(18) => 
        \mult1_0_Mult_0_[18]\, INPUT(17) => \mult1_0_Mult_0_[17]\, 
        INPUT(16) => \mult1_0_Mult_0_[16]\, INPUT(15) => 
        \mult1_0_Mult_0_[15]\, INPUT(14) => \mult1_0_Mult_0_[14]\, 
        INPUT(13) => \mult1_0_Mult_0_[13]\, INPUT(12) => 
        \mult1_0_Mult_0_[12]\, INPUT(11) => \mult1_0_Mult_0_[11]\, 
        INPUT(10) => \mult1_0_Mult_0_[10]\, INPUT(9) => 
        \mult1_0_Mult_0_[9]\, INPUT(8) => \mult1_0_Mult_0_[8]\, 
        INPUT(7) => \mult1_0_Mult_0_[7]\, INPUT(6) => 
        \mult1_0_Mult_0_[6]\, INPUT(5) => \mult1_0_Mult_0_[5]\, 
        INPUT(4) => \mult1_0_Mult_0_[4]\, INPUT(3) => 
        \mult1_0_Mult_0_[3]\, INPUT(2) => \mult1_0_Mult_0_[2]\, 
        INPUT(1) => \mult1_0_Mult_0_[1]\, INPUT(0) => 
        \mult1_0_Mult_0_[0]\, OUTPUT(21) => OUTPUT_0(21), 
        OUTPUT(20) => OUTPUT_0(20), OUTPUT(19) => OUTPUT_0(19), 
        OUTPUT(18) => OUTPUT_0(18), OUTPUT(17) => OUTPUT_0(17), 
        OUTPUT(16) => OUTPUT_0(16), OUTPUT(15) => OUTPUT_0(15), 
        OUTPUT(14) => OUTPUT_0(14), OUTPUT(13) => OUTPUT_0(13), 
        OUTPUT(12) => OUTPUT_0(12), OUTPUT(11) => OUTPUT_0(11), 
        OUTPUT(10) => OUTPUT_0(10), OUTPUT(9) => OUTPUT_0(9), 
        OUTPUT(8) => OUTPUT_0(8), OUTPUT(7) => OUTPUT_0(7), 
        OUTPUT(6) => OUTPUT_0(6), OUTPUT(5) => OUTPUT_0(5), 
        OUTPUT(4) => OUTPUT_0(4), OUTPUT(3) => OUTPUT_0(3), 
        OUTPUT(2) => OUTPUT_0(2), OUTPUT(1) => OUTPUT_0(1), 
        OUTPUT(0) => OUTPUT_0(0));
    
    ADC_SPI_0 : entity work.ADC_SPI
      port map(PCLK => CLK, PRESETn => RST, SCLK => SCLK, CSn => 
        CSn, sample_rdy => OPEN, CH1(13) => \CH1_[13]\, CH1(12)
         => \CH1_[12]\, CH1(11) => \CH1_[11]\, CH1(10) => 
        \CH1_[10]\, CH1(9) => \CH1_[9]\, CH1(8) => \CH1_[8]\, 
        CH1(7) => \CH1_[7]\, CH1(6) => \CH1_[6]\, CH1(5) => 
        \CH1_[5]\, CH1(4) => \CH1_[4]\, CH1(3) => \CH1_[3]\, 
        CH1(2) => \CH1_[2]\, CH1(1) => \CH1_[1]\, CH1(0) => 
        \CH1_[0]\, CH2(13) => \CH2_[13]\, CH2(12) => \CH2_[12]\, 
        CH2(11) => \CH2_[11]\, CH2(10) => \CH2_[10]\, CH2(9) => 
        \CH2_[9]\, CH2(8) => \CH2_[8]\, CH2(7) => \CH2_[7]\, 
        CH2(6) => \CH2_[6]\, CH2(5) => \CH2_[5]\, CH2(4) => 
        \CH2_[4]\, CH2(3) => \CH2_[3]\, CH2(2) => \CH2_[2]\, 
        CH2(1) => \CH2_[1]\, CH2(0) => \CH2_[0]\, SDATA(1) => 
        SDATA(1), SDATA(2) => SDATA(2));
    

end DEF_ARCH; 
