-- Version: 9.1 SP1 9.1.1.7

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity DDC is

    port( RST   : in    std_logic;
          CLK   : in    std_logic;
          SDATA : in    std_logic_vector(1 to 2);
          SCLK  : out   std_logic;
          CSn   : out   std_logic
        );

end DDC;

architecture DEF_ARCH of DDC is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component mult2
    port( DataA : in    std_logic_vector(15 downto 0) := (others => 'U');
          DataB : in    std_logic_vector(15 downto 0) := (others => 'U');
          Mult  : out   std_logic_vector(31 downto 0)
        );
  end component;

  component sincos_gen
    port( RST       : in    std_logic := 'U';
          CLK       : in    std_logic := 'U';
          DPHASE_EN : in    std_logic := 'U';
          DPHASE    : in    std_logic_vector(15 downto 0) := (others => 'U');
          RDYOUT    : out   std_logic;
          COS_OUT   : out   std_logic_vector(15 downto 0);
          SIN_OUT   : out   std_logic_vector(15 downto 0)
        );
  end component;

  component mult1
    port( DataA : in    std_logic_vector(15 downto 0) := (others => 'U');
          DataB : in    std_logic_vector(15 downto 0) := (others => 'U');
          Mult  : out   std_logic_vector(31 downto 0)
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \ADC_SPI_0_CH1_[15]\, \ADC_SPI_0_CH1_[14]\, 
        \ADC_SPI_0_CH1_[13]\, \ADC_SPI_0_CH1_[12]\, 
        \ADC_SPI_0_CH1_[11]\, \ADC_SPI_0_CH1_[10]\, 
        \ADC_SPI_0_CH1_[9]\, \ADC_SPI_0_CH1_[8]\, 
        \ADC_SPI_0_CH1_[7]\, \ADC_SPI_0_CH1_[6]\, 
        \ADC_SPI_0_CH1_[5]\, \ADC_SPI_0_CH1_[4]\, 
        \ADC_SPI_0_CH1_[3]\, \ADC_SPI_0_CH1_[2]\, 
        \ADC_SPI_0_CH1_[1]\, \ADC_SPI_0_CH1_[0]\, 
        \ADC_SPI_0_CH2_[15]\, \ADC_SPI_0_CH2_[14]\, 
        \ADC_SPI_0_CH2_[13]\, \ADC_SPI_0_CH2_[12]\, 
        \ADC_SPI_0_CH2_[11]\, \ADC_SPI_0_CH2_[10]\, 
        \ADC_SPI_0_CH2_[9]\, \ADC_SPI_0_CH2_[8]\, 
        \ADC_SPI_0_CH2_[7]\, \ADC_SPI_0_CH2_[6]\, 
        \ADC_SPI_0_CH2_[5]\, \ADC_SPI_0_CH2_[4]\, 
        \ADC_SPI_0_CH2_[3]\, \ADC_SPI_0_CH2_[2]\, 
        \ADC_SPI_0_CH2_[1]\, \ADC_SPI_0_CH2_[0]\, 
        \sincos_gen_0_COS_OUT_[15]\, \sincos_gen_0_COS_OUT_[14]\, 
        \sincos_gen_0_COS_OUT_[13]\, \sincos_gen_0_COS_OUT_[12]\, 
        \sincos_gen_0_COS_OUT_[11]\, \sincos_gen_0_COS_OUT_[10]\, 
        \sincos_gen_0_COS_OUT_[9]\, \sincos_gen_0_COS_OUT_[8]\, 
        \sincos_gen_0_COS_OUT_[7]\, \sincos_gen_0_COS_OUT_[6]\, 
        \sincos_gen_0_COS_OUT_[5]\, \sincos_gen_0_COS_OUT_[4]\, 
        \sincos_gen_0_COS_OUT_[3]\, \sincos_gen_0_COS_OUT_[2]\, 
        \sincos_gen_0_COS_OUT_[1]\, \sincos_gen_0_COS_OUT_[0]\, 
        \sincos_gen_0_SIN_OUT_[15]\, \sincos_gen_0_SIN_OUT_[14]\, 
        \sincos_gen_0_SIN_OUT_[13]\, \sincos_gen_0_SIN_OUT_[12]\, 
        \sincos_gen_0_SIN_OUT_[11]\, \sincos_gen_0_SIN_OUT_[10]\, 
        \sincos_gen_0_SIN_OUT_[9]\, \sincos_gen_0_SIN_OUT_[8]\, 
        \sincos_gen_0_SIN_OUT_[7]\, \sincos_gen_0_SIN_OUT_[6]\, 
        \sincos_gen_0_SIN_OUT_[5]\, \sincos_gen_0_SIN_OUT_[4]\, 
        \sincos_gen_0_SIN_OUT_[3]\, \sincos_gen_0_SIN_OUT_[2]\, 
        \sincos_gen_0_SIN_OUT_[1]\, \sincos_gen_0_SIN_OUT_[0]\, 
        GND_net, VCC_net : std_logic;
    signal nc123, nc121, nc47, nc113, nc111, nc34, nc98, nc89, 
        nc70, nc60, nc105, nc74, nc120, nc119, nc64, nc110, nc9, 
        nc92, nc91, nc13, nc23, nc55, nc80, nc33, nc84, nc16, 
        nc26, nc45, nc73, nc58, nc63, nc27, nc17, nc127, nc99, 
        nc126, nc117, nc36, nc116, nc48, nc37, nc5, nc103, nc101, 
        nc52, nc76, nc51, nc66, nc77, nc67, nc4, nc124, nc109, 
        nc42, nc114, nc100, nc83, nc41, nc90, nc94, nc122, nc112, 
        nc86, nc59, nc25, nc15, nc87, nc35, nc49, nc28, nc18, 
        nc128, nc107, nc118, nc106, nc75, nc65, nc38, nc93, nc1, 
        nc2, nc50, nc22, nc12, nc21, nc11, nc78, nc54, nc68, nc3, 
        nc32, nc104, nc40, nc31, nc96, nc44, nc7, nc97, nc85, 
        nc72, nc6, nc71, nc62, nc61, nc125, nc115, nc102, nc19, 
        nc29, nc88, nc53, nc39, nc8, nc82, nc108, nc81, nc79, 
        nc43, nc69, nc56, nc20, nc10, nc57, nc95, nc24, nc14, 
        nc46, nc30 : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net);
    
    mult2_1 : mult2
      port map(DataA(15) => \ADC_SPI_0_CH2_[15]\, DataA(14) => 
        \ADC_SPI_0_CH2_[14]\, DataA(13) => \ADC_SPI_0_CH2_[13]\, 
        DataA(12) => \ADC_SPI_0_CH2_[12]\, DataA(11) => 
        \ADC_SPI_0_CH2_[11]\, DataA(10) => \ADC_SPI_0_CH2_[10]\, 
        DataA(9) => \ADC_SPI_0_CH2_[9]\, DataA(8) => 
        \ADC_SPI_0_CH2_[8]\, DataA(7) => \ADC_SPI_0_CH2_[7]\, 
        DataA(6) => \ADC_SPI_0_CH2_[6]\, DataA(5) => 
        \ADC_SPI_0_CH2_[5]\, DataA(4) => \ADC_SPI_0_CH2_[4]\, 
        DataA(3) => \ADC_SPI_0_CH2_[3]\, DataA(2) => 
        \ADC_SPI_0_CH2_[2]\, DataA(1) => \ADC_SPI_0_CH2_[1]\, 
        DataA(0) => \ADC_SPI_0_CH2_[0]\, DataB(15) => 
        \sincos_gen_0_SIN_OUT_[15]\, DataB(14) => 
        \sincos_gen_0_SIN_OUT_[14]\, DataB(13) => 
        \sincos_gen_0_SIN_OUT_[13]\, DataB(12) => 
        \sincos_gen_0_SIN_OUT_[12]\, DataB(11) => 
        \sincos_gen_0_SIN_OUT_[11]\, DataB(10) => 
        \sincos_gen_0_SIN_OUT_[10]\, DataB(9) => 
        \sincos_gen_0_SIN_OUT_[9]\, DataB(8) => 
        \sincos_gen_0_SIN_OUT_[8]\, DataB(7) => 
        \sincos_gen_0_SIN_OUT_[7]\, DataB(6) => 
        \sincos_gen_0_SIN_OUT_[6]\, DataB(5) => 
        \sincos_gen_0_SIN_OUT_[5]\, DataB(4) => 
        \sincos_gen_0_SIN_OUT_[4]\, DataB(3) => 
        \sincos_gen_0_SIN_OUT_[3]\, DataB(2) => 
        \sincos_gen_0_SIN_OUT_[2]\, DataB(1) => 
        \sincos_gen_0_SIN_OUT_[1]\, DataB(0) => 
        \sincos_gen_0_SIN_OUT_[0]\, Mult(31) => nc123, Mult(30)
         => nc121, Mult(29) => nc47, Mult(28) => nc113, Mult(27)
         => nc111, Mult(26) => nc34, Mult(25) => nc98, Mult(24)
         => nc89, Mult(23) => nc70, Mult(22) => nc60, Mult(21)
         => nc105, Mult(20) => nc74, Mult(19) => nc120, Mult(18)
         => nc119, Mult(17) => nc64, Mult(16) => nc110, Mult(15)
         => nc9, Mult(14) => nc92, Mult(13) => nc91, Mult(12) => 
        nc13, Mult(11) => nc23, Mult(10) => nc55, Mult(9) => nc80, 
        Mult(8) => nc33, Mult(7) => nc84, Mult(6) => nc16, 
        Mult(5) => nc26, Mult(4) => nc45, Mult(3) => nc73, 
        Mult(2) => nc58, Mult(1) => nc63, Mult(0) => nc27);
    
    mult2_0 : mult2
      port map(DataA(15) => \ADC_SPI_0_CH2_[15]\, DataA(14) => 
        \ADC_SPI_0_CH2_[14]\, DataA(13) => \ADC_SPI_0_CH2_[13]\, 
        DataA(12) => \ADC_SPI_0_CH2_[12]\, DataA(11) => 
        \ADC_SPI_0_CH2_[11]\, DataA(10) => \ADC_SPI_0_CH2_[10]\, 
        DataA(9) => \ADC_SPI_0_CH2_[9]\, DataA(8) => 
        \ADC_SPI_0_CH2_[8]\, DataA(7) => \ADC_SPI_0_CH2_[7]\, 
        DataA(6) => \ADC_SPI_0_CH2_[6]\, DataA(5) => 
        \ADC_SPI_0_CH2_[5]\, DataA(4) => \ADC_SPI_0_CH2_[4]\, 
        DataA(3) => \ADC_SPI_0_CH2_[3]\, DataA(2) => 
        \ADC_SPI_0_CH2_[2]\, DataA(1) => \ADC_SPI_0_CH2_[1]\, 
        DataA(0) => \ADC_SPI_0_CH2_[0]\, DataB(15) => 
        \sincos_gen_0_COS_OUT_[15]\, DataB(14) => 
        \sincos_gen_0_COS_OUT_[14]\, DataB(13) => 
        \sincos_gen_0_COS_OUT_[13]\, DataB(12) => 
        \sincos_gen_0_COS_OUT_[12]\, DataB(11) => 
        \sincos_gen_0_COS_OUT_[11]\, DataB(10) => 
        \sincos_gen_0_COS_OUT_[10]\, DataB(9) => 
        \sincos_gen_0_COS_OUT_[9]\, DataB(8) => 
        \sincos_gen_0_COS_OUT_[8]\, DataB(7) => 
        \sincos_gen_0_COS_OUT_[7]\, DataB(6) => 
        \sincos_gen_0_COS_OUT_[6]\, DataB(5) => 
        \sincos_gen_0_COS_OUT_[5]\, DataB(4) => 
        \sincos_gen_0_COS_OUT_[4]\, DataB(3) => 
        \sincos_gen_0_COS_OUT_[3]\, DataB(2) => 
        \sincos_gen_0_COS_OUT_[2]\, DataB(1) => 
        \sincos_gen_0_COS_OUT_[1]\, DataB(0) => 
        \sincos_gen_0_COS_OUT_[0]\, Mult(31) => nc17, Mult(30)
         => nc127, Mult(29) => nc99, Mult(28) => nc126, Mult(27)
         => nc117, Mult(26) => nc36, Mult(25) => nc116, Mult(24)
         => nc48, Mult(23) => nc37, Mult(22) => nc5, Mult(21) => 
        nc103, Mult(20) => nc101, Mult(19) => nc52, Mult(18) => 
        nc76, Mult(17) => nc51, Mult(16) => nc66, Mult(15) => 
        nc77, Mult(14) => nc67, Mult(13) => nc4, Mult(12) => 
        nc124, Mult(11) => nc109, Mult(10) => nc42, Mult(9) => 
        nc114, Mult(8) => nc100, Mult(7) => nc83, Mult(6) => nc41, 
        Mult(5) => nc90, Mult(4) => nc94, Mult(3) => nc122, 
        Mult(2) => nc112, Mult(1) => nc86, Mult(0) => nc59);
    
    sincos_gen_0 : sincos_gen
      port map(RST => RST, CLK => CLK, DPHASE_EN => VCC_net, 
        DPHASE(15) => GND_net, DPHASE(14) => GND_net, DPHASE(13)
         => GND_net, DPHASE(12) => GND_net, DPHASE(11) => GND_net, 
        DPHASE(10) => GND_net, DPHASE(9) => GND_net, DPHASE(8)
         => VCC_net, DPHASE(7) => GND_net, DPHASE(6) => GND_net, 
        DPHASE(5) => GND_net, DPHASE(4) => GND_net, DPHASE(3) => 
        GND_net, DPHASE(2) => GND_net, DPHASE(1) => GND_net, 
        DPHASE(0) => GND_net, RDYOUT => OPEN, COS_OUT(15) => 
        \sincos_gen_0_COS_OUT_[15]\, COS_OUT(14) => 
        \sincos_gen_0_COS_OUT_[14]\, COS_OUT(13) => 
        \sincos_gen_0_COS_OUT_[13]\, COS_OUT(12) => 
        \sincos_gen_0_COS_OUT_[12]\, COS_OUT(11) => 
        \sincos_gen_0_COS_OUT_[11]\, COS_OUT(10) => 
        \sincos_gen_0_COS_OUT_[10]\, COS_OUT(9) => 
        \sincos_gen_0_COS_OUT_[9]\, COS_OUT(8) => 
        \sincos_gen_0_COS_OUT_[8]\, COS_OUT(7) => 
        \sincos_gen_0_COS_OUT_[7]\, COS_OUT(6) => 
        \sincos_gen_0_COS_OUT_[6]\, COS_OUT(5) => 
        \sincos_gen_0_COS_OUT_[5]\, COS_OUT(4) => 
        \sincos_gen_0_COS_OUT_[4]\, COS_OUT(3) => 
        \sincos_gen_0_COS_OUT_[3]\, COS_OUT(2) => 
        \sincos_gen_0_COS_OUT_[2]\, COS_OUT(1) => 
        \sincos_gen_0_COS_OUT_[1]\, COS_OUT(0) => 
        \sincos_gen_0_COS_OUT_[0]\, SIN_OUT(15) => 
        \sincos_gen_0_SIN_OUT_[15]\, SIN_OUT(14) => 
        \sincos_gen_0_SIN_OUT_[14]\, SIN_OUT(13) => 
        \sincos_gen_0_SIN_OUT_[13]\, SIN_OUT(12) => 
        \sincos_gen_0_SIN_OUT_[12]\, SIN_OUT(11) => 
        \sincos_gen_0_SIN_OUT_[11]\, SIN_OUT(10) => 
        \sincos_gen_0_SIN_OUT_[10]\, SIN_OUT(9) => 
        \sincos_gen_0_SIN_OUT_[9]\, SIN_OUT(8) => 
        \sincos_gen_0_SIN_OUT_[8]\, SIN_OUT(7) => 
        \sincos_gen_0_SIN_OUT_[7]\, SIN_OUT(6) => 
        \sincos_gen_0_SIN_OUT_[6]\, SIN_OUT(5) => 
        \sincos_gen_0_SIN_OUT_[5]\, SIN_OUT(4) => 
        \sincos_gen_0_SIN_OUT_[4]\, SIN_OUT(3) => 
        \sincos_gen_0_SIN_OUT_[3]\, SIN_OUT(2) => 
        \sincos_gen_0_SIN_OUT_[2]\, SIN_OUT(1) => 
        \sincos_gen_0_SIN_OUT_[1]\, SIN_OUT(0) => 
        \sincos_gen_0_SIN_OUT_[0]\);
    
    mult1_1 : mult1
      port map(DataA(15) => \ADC_SPI_0_CH1_[15]\, DataA(14) => 
        \ADC_SPI_0_CH1_[14]\, DataA(13) => \ADC_SPI_0_CH1_[13]\, 
        DataA(12) => \ADC_SPI_0_CH1_[12]\, DataA(11) => 
        \ADC_SPI_0_CH1_[11]\, DataA(10) => \ADC_SPI_0_CH1_[10]\, 
        DataA(9) => \ADC_SPI_0_CH1_[9]\, DataA(8) => 
        \ADC_SPI_0_CH1_[8]\, DataA(7) => \ADC_SPI_0_CH1_[7]\, 
        DataA(6) => \ADC_SPI_0_CH1_[6]\, DataA(5) => 
        \ADC_SPI_0_CH1_[5]\, DataA(4) => \ADC_SPI_0_CH1_[4]\, 
        DataA(3) => \ADC_SPI_0_CH1_[3]\, DataA(2) => 
        \ADC_SPI_0_CH1_[2]\, DataA(1) => \ADC_SPI_0_CH1_[1]\, 
        DataA(0) => \ADC_SPI_0_CH1_[0]\, DataB(15) => 
        \sincos_gen_0_SIN_OUT_[15]\, DataB(14) => 
        \sincos_gen_0_SIN_OUT_[14]\, DataB(13) => 
        \sincos_gen_0_SIN_OUT_[13]\, DataB(12) => 
        \sincos_gen_0_SIN_OUT_[12]\, DataB(11) => 
        \sincos_gen_0_SIN_OUT_[11]\, DataB(10) => 
        \sincos_gen_0_SIN_OUT_[10]\, DataB(9) => 
        \sincos_gen_0_SIN_OUT_[9]\, DataB(8) => 
        \sincos_gen_0_SIN_OUT_[8]\, DataB(7) => 
        \sincos_gen_0_SIN_OUT_[7]\, DataB(6) => 
        \sincos_gen_0_SIN_OUT_[6]\, DataB(5) => 
        \sincos_gen_0_SIN_OUT_[5]\, DataB(4) => 
        \sincos_gen_0_SIN_OUT_[4]\, DataB(3) => 
        \sincos_gen_0_SIN_OUT_[3]\, DataB(2) => 
        \sincos_gen_0_SIN_OUT_[2]\, DataB(1) => 
        \sincos_gen_0_SIN_OUT_[1]\, DataB(0) => 
        \sincos_gen_0_SIN_OUT_[0]\, Mult(31) => nc25, Mult(30)
         => nc15, Mult(29) => nc87, Mult(28) => nc35, Mult(27)
         => nc49, Mult(26) => nc28, Mult(25) => nc18, Mult(24)
         => nc128, Mult(23) => nc107, Mult(22) => nc118, Mult(21)
         => nc106, Mult(20) => nc75, Mult(19) => nc65, Mult(18)
         => nc38, Mult(17) => nc93, Mult(16) => nc1, Mult(15) => 
        nc2, Mult(14) => nc50, Mult(13) => nc22, Mult(12) => nc12, 
        Mult(11) => nc21, Mult(10) => nc11, Mult(9) => nc78, 
        Mult(8) => nc54, Mult(7) => nc68, Mult(6) => nc3, Mult(5)
         => nc32, Mult(4) => nc104, Mult(3) => nc40, Mult(2) => 
        nc31, Mult(1) => nc96, Mult(0) => nc44);
    
    mult1_0 : mult1
      port map(DataA(15) => \ADC_SPI_0_CH1_[15]\, DataA(14) => 
        \ADC_SPI_0_CH1_[14]\, DataA(13) => \ADC_SPI_0_CH1_[13]\, 
        DataA(12) => \ADC_SPI_0_CH1_[12]\, DataA(11) => 
        \ADC_SPI_0_CH1_[11]\, DataA(10) => \ADC_SPI_0_CH1_[10]\, 
        DataA(9) => \ADC_SPI_0_CH1_[9]\, DataA(8) => 
        \ADC_SPI_0_CH1_[8]\, DataA(7) => \ADC_SPI_0_CH1_[7]\, 
        DataA(6) => \ADC_SPI_0_CH1_[6]\, DataA(5) => 
        \ADC_SPI_0_CH1_[5]\, DataA(4) => \ADC_SPI_0_CH1_[4]\, 
        DataA(3) => \ADC_SPI_0_CH1_[3]\, DataA(2) => 
        \ADC_SPI_0_CH1_[2]\, DataA(1) => \ADC_SPI_0_CH1_[1]\, 
        DataA(0) => \ADC_SPI_0_CH1_[0]\, DataB(15) => 
        \sincos_gen_0_COS_OUT_[15]\, DataB(14) => 
        \sincos_gen_0_COS_OUT_[14]\, DataB(13) => 
        \sincos_gen_0_COS_OUT_[13]\, DataB(12) => 
        \sincos_gen_0_COS_OUT_[12]\, DataB(11) => 
        \sincos_gen_0_COS_OUT_[11]\, DataB(10) => 
        \sincos_gen_0_COS_OUT_[10]\, DataB(9) => 
        \sincos_gen_0_COS_OUT_[9]\, DataB(8) => 
        \sincos_gen_0_COS_OUT_[8]\, DataB(7) => 
        \sincos_gen_0_COS_OUT_[7]\, DataB(6) => 
        \sincos_gen_0_COS_OUT_[6]\, DataB(5) => 
        \sincos_gen_0_COS_OUT_[5]\, DataB(4) => 
        \sincos_gen_0_COS_OUT_[4]\, DataB(3) => 
        \sincos_gen_0_COS_OUT_[3]\, DataB(2) => 
        \sincos_gen_0_COS_OUT_[2]\, DataB(1) => 
        \sincos_gen_0_COS_OUT_[1]\, DataB(0) => 
        \sincos_gen_0_COS_OUT_[0]\, Mult(31) => nc7, Mult(30) => 
        nc97, Mult(29) => nc85, Mult(28) => nc72, Mult(27) => nc6, 
        Mult(26) => nc71, Mult(25) => nc62, Mult(24) => nc61, 
        Mult(23) => nc125, Mult(22) => nc115, Mult(21) => nc102, 
        Mult(20) => nc19, Mult(19) => nc29, Mult(18) => nc88, 
        Mult(17) => nc53, Mult(16) => nc39, Mult(15) => nc8, 
        Mult(14) => nc82, Mult(13) => nc108, Mult(12) => nc81, 
        Mult(11) => nc79, Mult(10) => nc43, Mult(9) => nc69, 
        Mult(8) => nc56, Mult(7) => nc20, Mult(6) => nc10, 
        Mult(5) => nc57, Mult(4) => nc95, Mult(3) => nc24, 
        Mult(2) => nc14, Mult(1) => nc46, Mult(0) => nc30);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    ADC_SPI_0 : entity work.ADC_SPI
      port map(PCLK => CLK, PRESETn => RST, CH1(15) => 
        \ADC_SPI_0_CH1_[15]\, CH1(14) => \ADC_SPI_0_CH1_[14]\, 
        CH1(13) => \ADC_SPI_0_CH1_[13]\, CH1(12) => 
        \ADC_SPI_0_CH1_[12]\, CH1(11) => \ADC_SPI_0_CH1_[11]\, 
        CH1(10) => \ADC_SPI_0_CH1_[10]\, CH1(9) => 
        \ADC_SPI_0_CH1_[9]\, CH1(8) => \ADC_SPI_0_CH1_[8]\, 
        CH1(7) => \ADC_SPI_0_CH1_[7]\, CH1(6) => 
        \ADC_SPI_0_CH1_[6]\, CH1(5) => \ADC_SPI_0_CH1_[5]\, 
        CH1(4) => \ADC_SPI_0_CH1_[4]\, CH1(3) => 
        \ADC_SPI_0_CH1_[3]\, CH1(2) => \ADC_SPI_0_CH1_[2]\, 
        CH1(1) => \ADC_SPI_0_CH1_[1]\, CH1(0) => 
        \ADC_SPI_0_CH1_[0]\, CH2(15) => \ADC_SPI_0_CH2_[15]\, 
        CH2(14) => \ADC_SPI_0_CH2_[14]\, CH2(13) => 
        \ADC_SPI_0_CH2_[13]\, CH2(12) => \ADC_SPI_0_CH2_[12]\, 
        CH2(11) => \ADC_SPI_0_CH2_[11]\, CH2(10) => 
        \ADC_SPI_0_CH2_[10]\, CH2(9) => \ADC_SPI_0_CH2_[9]\, 
        CH2(8) => \ADC_SPI_0_CH2_[8]\, CH2(7) => 
        \ADC_SPI_0_CH2_[7]\, CH2(6) => \ADC_SPI_0_CH2_[6]\, 
        CH2(5) => \ADC_SPI_0_CH2_[5]\, CH2(4) => 
        \ADC_SPI_0_CH2_[4]\, CH2(3) => \ADC_SPI_0_CH2_[3]\, 
        CH2(2) => \ADC_SPI_0_CH2_[2]\, CH2(1) => 
        \ADC_SPI_0_CH2_[1]\, CH2(0) => \ADC_SPI_0_CH2_[0]\, SCLK
         => SCLK, CSn => CSn, SDATA(1) => SDATA(1), SDATA(2) => 
        SDATA(2), sample_rdy => OPEN);
    

end DEF_ARCH; 
