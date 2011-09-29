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
          CH1      : out   std_logic_vector(13 downto 0);
          CH2      : out   std_logic_vector(13 downto 0);
          OUTPUT_0 : out   std_logic_vector(46 downto 0);
          OUTPUT_1 : out   std_logic_vector(46 downto 0)
        );

end DDC;

architecture DEF_ARCH of DDC is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component FIR
    port( RST    : in    std_logic := 'U';
          CLK    : in    std_logic := 'U';
          INPUT  : in    std_logic_vector(21 downto 0) := (others => 'U');
          OUTPUT : out   std_logic_vector(46 downto 0)
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
        \mult1_0_Mult_1_[21]\, \mult1_0_Mult_1_[20]\, 
        \mult1_0_Mult_1_[19]\, \mult1_0_Mult_1_[18]\, 
        \mult1_0_Mult_1_[17]\, \mult1_0_Mult_1_[16]\, 
        \mult1_0_Mult_1_[15]\, \mult1_0_Mult_1_[14]\, 
        \mult1_0_Mult_1_[13]\, \mult1_0_Mult_1_[12]\, 
        \mult1_0_Mult_1_[11]\, \mult1_0_Mult_1_[10]\, 
        \mult1_0_Mult_1_[9]\, \mult1_0_Mult_1_[8]\, 
        \mult1_0_Mult_1_[7]\, \mult1_0_Mult_1_[6]\, 
        \mult1_0_Mult_1_[5]\, \mult1_0_Mult_1_[4]\, 
        \mult1_0_Mult_1_[3]\, \mult1_0_Mult_1_[2]\, 
        \mult1_0_Mult_1_[1]\, \mult1_0_Mult_1_[0]\, 
        \mult1_1_Mult_1_[21]\, \mult1_1_Mult_1_[20]\, 
        \mult1_1_Mult_1_[19]\, \mult1_1_Mult_1_[18]\, 
        \mult1_1_Mult_1_[17]\, \mult1_1_Mult_1_[16]\, 
        \mult1_1_Mult_1_[15]\, \mult1_1_Mult_1_[14]\, 
        \mult1_1_Mult_1_[13]\, \mult1_1_Mult_1_[12]\, 
        \mult1_1_Mult_1_[11]\, \mult1_1_Mult_1_[10]\, 
        \mult1_1_Mult_1_[9]\, \mult1_1_Mult_1_[8]\, 
        \mult1_1_Mult_1_[7]\, \mult1_1_Mult_1_[6]\, 
        \mult1_1_Mult_1_[5]\, \mult1_1_Mult_1_[4]\, 
        \mult1_1_Mult_1_[3]\, \mult1_1_Mult_1_[2]\, 
        \mult1_1_Mult_1_[1]\, \mult1_1_Mult_1_[0]\, 
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

begin 

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
    
    FIR_1 : FIR
      port map(RST => RST, CLK => CLK, INPUT(21) => 
        \mult1_1_Mult_1_[21]\, INPUT(20) => \mult1_1_Mult_1_[20]\, 
        INPUT(19) => \mult1_1_Mult_1_[19]\, INPUT(18) => 
        \mult1_1_Mult_1_[18]\, INPUT(17) => \mult1_1_Mult_1_[17]\, 
        INPUT(16) => \mult1_1_Mult_1_[16]\, INPUT(15) => 
        \mult1_1_Mult_1_[15]\, INPUT(14) => \mult1_1_Mult_1_[14]\, 
        INPUT(13) => \mult1_1_Mult_1_[13]\, INPUT(12) => 
        \mult1_1_Mult_1_[12]\, INPUT(11) => \mult1_1_Mult_1_[11]\, 
        INPUT(10) => \mult1_1_Mult_1_[10]\, INPUT(9) => 
        \mult1_1_Mult_1_[9]\, INPUT(8) => \mult1_1_Mult_1_[8]\, 
        INPUT(7) => \mult1_1_Mult_1_[7]\, INPUT(6) => 
        \mult1_1_Mult_1_[6]\, INPUT(5) => \mult1_1_Mult_1_[5]\, 
        INPUT(4) => \mult1_1_Mult_1_[4]\, INPUT(3) => 
        \mult1_1_Mult_1_[3]\, INPUT(2) => \mult1_1_Mult_1_[2]\, 
        INPUT(1) => \mult1_1_Mult_1_[1]\, INPUT(0) => 
        \mult1_1_Mult_1_[0]\, OUTPUT(46) => OUTPUT_1(46), 
        OUTPUT(45) => OUTPUT_1(45), OUTPUT(44) => OUTPUT_1(44), 
        OUTPUT(43) => OUTPUT_1(43), OUTPUT(42) => OUTPUT_1(42), 
        OUTPUT(41) => OUTPUT_1(41), OUTPUT(40) => OUTPUT_1(40), 
        OUTPUT(39) => OUTPUT_1(39), OUTPUT(38) => OUTPUT_1(38), 
        OUTPUT(37) => OUTPUT_1(37), OUTPUT(36) => OUTPUT_1(36), 
        OUTPUT(35) => OUTPUT_1(35), OUTPUT(34) => OUTPUT_1(34), 
        OUTPUT(33) => OUTPUT_1(33), OUTPUT(32) => OUTPUT_1(32), 
        OUTPUT(31) => OUTPUT_1(31), OUTPUT(30) => OUTPUT_1(30), 
        OUTPUT(29) => OUTPUT_1(29), OUTPUT(28) => OUTPUT_1(28), 
        OUTPUT(27) => OUTPUT_1(27), OUTPUT(26) => OUTPUT_1(26), 
        OUTPUT(25) => OUTPUT_1(25), OUTPUT(24) => OUTPUT_1(24), 
        OUTPUT(23) => OUTPUT_1(23), OUTPUT(22) => OUTPUT_1(22), 
        OUTPUT(21) => OUTPUT_1(21), OUTPUT(20) => OUTPUT_1(20), 
        OUTPUT(19) => OUTPUT_1(19), OUTPUT(18) => OUTPUT_1(18), 
        OUTPUT(17) => OUTPUT_1(17), OUTPUT(16) => OUTPUT_1(16), 
        OUTPUT(15) => OUTPUT_1(15), OUTPUT(14) => OUTPUT_1(14), 
        OUTPUT(13) => OUTPUT_1(13), OUTPUT(12) => OUTPUT_1(12), 
        OUTPUT(11) => OUTPUT_1(11), OUTPUT(10) => OUTPUT_1(10), 
        OUTPUT(9) => OUTPUT_1(9), OUTPUT(8) => OUTPUT_1(8), 
        OUTPUT(7) => OUTPUT_1(7), OUTPUT(6) => OUTPUT_1(6), 
        OUTPUT(5) => OUTPUT_1(5), OUTPUT(4) => OUTPUT_1(4), 
        OUTPUT(3) => OUTPUT_1(3), OUTPUT(2) => OUTPUT_1(2), 
        OUTPUT(1) => OUTPUT_1(1), OUTPUT(0) => OUTPUT_1(0));
    
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
        \sincos_gen_0_SIN_OUT_0_[0]\, Mult(21) => 
        \mult1_1_Mult_1_[21]\, Mult(20) => \mult1_1_Mult_1_[20]\, 
        Mult(19) => \mult1_1_Mult_1_[19]\, Mult(18) => 
        \mult1_1_Mult_1_[18]\, Mult(17) => \mult1_1_Mult_1_[17]\, 
        Mult(16) => \mult1_1_Mult_1_[16]\, Mult(15) => 
        \mult1_1_Mult_1_[15]\, Mult(14) => \mult1_1_Mult_1_[14]\, 
        Mult(13) => \mult1_1_Mult_1_[13]\, Mult(12) => 
        \mult1_1_Mult_1_[12]\, Mult(11) => \mult1_1_Mult_1_[11]\, 
        Mult(10) => \mult1_1_Mult_1_[10]\, Mult(9) => 
        \mult1_1_Mult_1_[9]\, Mult(8) => \mult1_1_Mult_1_[8]\, 
        Mult(7) => \mult1_1_Mult_1_[7]\, Mult(6) => 
        \mult1_1_Mult_1_[6]\, Mult(5) => \mult1_1_Mult_1_[5]\, 
        Mult(4) => \mult1_1_Mult_1_[4]\, Mult(3) => 
        \mult1_1_Mult_1_[3]\, Mult(2) => \mult1_1_Mult_1_[2]\, 
        Mult(1) => \mult1_1_Mult_1_[1]\, Mult(0) => 
        \mult1_1_Mult_1_[0]\);
    
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
        \mult1_0_Mult_1_[21]\, Mult(20) => \mult1_0_Mult_1_[20]\, 
        Mult(19) => \mult1_0_Mult_1_[19]\, Mult(18) => 
        \mult1_0_Mult_1_[18]\, Mult(17) => \mult1_0_Mult_1_[17]\, 
        Mult(16) => \mult1_0_Mult_1_[16]\, Mult(15) => 
        \mult1_0_Mult_1_[15]\, Mult(14) => \mult1_0_Mult_1_[14]\, 
        Mult(13) => \mult1_0_Mult_1_[13]\, Mult(12) => 
        \mult1_0_Mult_1_[12]\, Mult(11) => \mult1_0_Mult_1_[11]\, 
        Mult(10) => \mult1_0_Mult_1_[10]\, Mult(9) => 
        \mult1_0_Mult_1_[9]\, Mult(8) => \mult1_0_Mult_1_[8]\, 
        Mult(7) => \mult1_0_Mult_1_[7]\, Mult(6) => 
        \mult1_0_Mult_1_[6]\, Mult(5) => \mult1_0_Mult_1_[5]\, 
        Mult(4) => \mult1_0_Mult_1_[4]\, Mult(3) => 
        \mult1_0_Mult_1_[3]\, Mult(2) => \mult1_0_Mult_1_[2]\, 
        Mult(1) => \mult1_0_Mult_1_[1]\, Mult(0) => 
        \mult1_0_Mult_1_[0]\);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    ADC_SPI_0 : entity work.ADC_SPI
      port map(PCLK => CLK, PRESETn => RST, SCLK => SCLK, CSn => 
        CSn, sample_rdy => OPEN, CH1(13) => \CH1_[13]\, CH1(12)
         => \CH1_[12]\, CH1(11) => \CH1_[11]\, CH1(10) => 
        \CH1_[10]\, CH1(9) => \CH1_[9]\, CH1(8) => \CH1_[8]\, 
        CH1(7) => \CH1_[7]\, CH1(6) => \CH1_[6]\, CH1(5) => 
        \CH1_[5]\, CH1(4) => \CH1_[4]\, CH1(3) => \CH1_[3]\, 
        CH1(2) => \CH1_[2]\, CH1(1) => \CH1_[1]\, CH1(0) => 
        \CH1_[0]\, CH2(13) => CH2(13), CH2(12) => CH2(12), 
        CH2(11) => CH2(11), CH2(10) => CH2(10), CH2(9) => CH2(9), 
        CH2(8) => CH2(8), CH2(7) => CH2(7), CH2(6) => CH2(6), 
        CH2(5) => CH2(5), CH2(4) => CH2(4), CH2(3) => CH2(3), 
        CH2(2) => CH2(2), CH2(1) => CH2(1), CH2(0) => CH2(0), 
        SDATA(1) => SDATA(1), SDATA(2) => SDATA(2));
    
    FIR_0 : FIR
      port map(RST => RST, CLK => CLK, INPUT(21) => 
        \mult1_0_Mult_1_[21]\, INPUT(20) => \mult1_0_Mult_1_[20]\, 
        INPUT(19) => \mult1_0_Mult_1_[19]\, INPUT(18) => 
        \mult1_0_Mult_1_[18]\, INPUT(17) => \mult1_0_Mult_1_[17]\, 
        INPUT(16) => \mult1_0_Mult_1_[16]\, INPUT(15) => 
        \mult1_0_Mult_1_[15]\, INPUT(14) => \mult1_0_Mult_1_[14]\, 
        INPUT(13) => \mult1_0_Mult_1_[13]\, INPUT(12) => 
        \mult1_0_Mult_1_[12]\, INPUT(11) => \mult1_0_Mult_1_[11]\, 
        INPUT(10) => \mult1_0_Mult_1_[10]\, INPUT(9) => 
        \mult1_0_Mult_1_[9]\, INPUT(8) => \mult1_0_Mult_1_[8]\, 
        INPUT(7) => \mult1_0_Mult_1_[7]\, INPUT(6) => 
        \mult1_0_Mult_1_[6]\, INPUT(5) => \mult1_0_Mult_1_[5]\, 
        INPUT(4) => \mult1_0_Mult_1_[4]\, INPUT(3) => 
        \mult1_0_Mult_1_[3]\, INPUT(2) => \mult1_0_Mult_1_[2]\, 
        INPUT(1) => \mult1_0_Mult_1_[1]\, INPUT(0) => 
        \mult1_0_Mult_1_[0]\, OUTPUT(46) => OUTPUT_0(46), 
        OUTPUT(45) => OUTPUT_0(45), OUTPUT(44) => OUTPUT_0(44), 
        OUTPUT(43) => OUTPUT_0(43), OUTPUT(42) => OUTPUT_0(42), 
        OUTPUT(41) => OUTPUT_0(41), OUTPUT(40) => OUTPUT_0(40), 
        OUTPUT(39) => OUTPUT_0(39), OUTPUT(38) => OUTPUT_0(38), 
        OUTPUT(37) => OUTPUT_0(37), OUTPUT(36) => OUTPUT_0(36), 
        OUTPUT(35) => OUTPUT_0(35), OUTPUT(34) => OUTPUT_0(34), 
        OUTPUT(33) => OUTPUT_0(33), OUTPUT(32) => OUTPUT_0(32), 
        OUTPUT(31) => OUTPUT_0(31), OUTPUT(30) => OUTPUT_0(30), 
        OUTPUT(29) => OUTPUT_0(29), OUTPUT(28) => OUTPUT_0(28), 
        OUTPUT(27) => OUTPUT_0(27), OUTPUT(26) => OUTPUT_0(26), 
        OUTPUT(25) => OUTPUT_0(25), OUTPUT(24) => OUTPUT_0(24), 
        OUTPUT(23) => OUTPUT_0(23), OUTPUT(22) => OUTPUT_0(22), 
        OUTPUT(21) => OUTPUT_0(21), OUTPUT(20) => OUTPUT_0(20), 
        OUTPUT(19) => OUTPUT_0(19), OUTPUT(18) => OUTPUT_0(18), 
        OUTPUT(17) => OUTPUT_0(17), OUTPUT(16) => OUTPUT_0(16), 
        OUTPUT(15) => OUTPUT_0(15), OUTPUT(14) => OUTPUT_0(14), 
        OUTPUT(13) => OUTPUT_0(13), OUTPUT(12) => OUTPUT_0(12), 
        OUTPUT(11) => OUTPUT_0(11), OUTPUT(10) => OUTPUT_0(10), 
        OUTPUT(9) => OUTPUT_0(9), OUTPUT(8) => OUTPUT_0(8), 
        OUTPUT(7) => OUTPUT_0(7), OUTPUT(6) => OUTPUT_0(6), 
        OUTPUT(5) => OUTPUT_0(5), OUTPUT(4) => OUTPUT_0(4), 
        OUTPUT(3) => OUTPUT_0(3), OUTPUT(2) => OUTPUT_0(2), 
        OUTPUT(1) => OUTPUT_0(1), OUTPUT(0) => OUTPUT_0(0));
    

end DEF_ARCH; 
