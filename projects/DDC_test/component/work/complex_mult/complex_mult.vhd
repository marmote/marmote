-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity complex_mult is

    port( sample_rdy_in : in    std_logic;
          CLK           : in    std_logic;
          RST           : in    std_logic;
          I             : out   std_logic_vector(22 downto 0);
          Q             : out   std_logic_vector(22 downto 0);
          I_A           : in    std_logic_vector(7 downto 0);
          I_B           : in    std_logic_vector(13 downto 0);
          Q_A           : in    std_logic_vector(7 downto 0);
          Q_B           : in    std_logic_vector(13 downto 0)
        );

end complex_mult;

architecture DEF_ARCH of complex_mult is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \MULTIPLIER_0_C_[21]\, \MULTIPLIER_0_C_[20]\, 
        \MULTIPLIER_0_C_[19]\, \MULTIPLIER_0_C_[18]\, 
        \MULTIPLIER_0_C_[17]\, \MULTIPLIER_0_C_[16]\, 
        \MULTIPLIER_0_C_[15]\, \MULTIPLIER_0_C_[14]\, 
        \MULTIPLIER_0_C_[13]\, \MULTIPLIER_0_C_[12]\, 
        \MULTIPLIER_0_C_[11]\, \MULTIPLIER_0_C_[10]\, 
        \MULTIPLIER_0_C_[9]\, \MULTIPLIER_0_C_[8]\, 
        \MULTIPLIER_0_C_[7]\, \MULTIPLIER_0_C_[6]\, 
        \MULTIPLIER_0_C_[5]\, \MULTIPLIER_0_C_[4]\, 
        \MULTIPLIER_0_C_[3]\, \MULTIPLIER_0_C_[2]\, 
        \MULTIPLIER_0_C_[1]\, \MULTIPLIER_0_C_[0]\, 
        \MULTIPLIER_1_C_[21]\, \MULTIPLIER_1_C_[20]\, 
        \MULTIPLIER_1_C_[19]\, \MULTIPLIER_1_C_[18]\, 
        \MULTIPLIER_1_C_[17]\, \MULTIPLIER_1_C_[16]\, 
        \MULTIPLIER_1_C_[15]\, \MULTIPLIER_1_C_[14]\, 
        \MULTIPLIER_1_C_[13]\, \MULTIPLIER_1_C_[12]\, 
        \MULTIPLIER_1_C_[11]\, \MULTIPLIER_1_C_[10]\, 
        \MULTIPLIER_1_C_[9]\, \MULTIPLIER_1_C_[8]\, 
        \MULTIPLIER_1_C_[7]\, \MULTIPLIER_1_C_[6]\, 
        \MULTIPLIER_1_C_[5]\, \MULTIPLIER_1_C_[4]\, 
        \MULTIPLIER_1_C_[3]\, \MULTIPLIER_1_C_[2]\, 
        \MULTIPLIER_1_C_[1]\, \MULTIPLIER_1_C_[0]\, 
        \MULTIPLIER_2_C_[21]\, \MULTIPLIER_2_C_[20]\, 
        \MULTIPLIER_2_C_[19]\, \MULTIPLIER_2_C_[18]\, 
        \MULTIPLIER_2_C_[17]\, \MULTIPLIER_2_C_[16]\, 
        \MULTIPLIER_2_C_[15]\, \MULTIPLIER_2_C_[14]\, 
        \MULTIPLIER_2_C_[13]\, \MULTIPLIER_2_C_[12]\, 
        \MULTIPLIER_2_C_[11]\, \MULTIPLIER_2_C_[10]\, 
        \MULTIPLIER_2_C_[9]\, \MULTIPLIER_2_C_[8]\, 
        \MULTIPLIER_2_C_[7]\, \MULTIPLIER_2_C_[6]\, 
        \MULTIPLIER_2_C_[5]\, \MULTIPLIER_2_C_[4]\, 
        \MULTIPLIER_2_C_[3]\, \MULTIPLIER_2_C_[2]\, 
        \MULTIPLIER_2_C_[1]\, \MULTIPLIER_2_C_[0]\, 
        \MULTIPLIER_3_C_[21]\, \MULTIPLIER_3_C_[20]\, 
        \MULTIPLIER_3_C_[19]\, \MULTIPLIER_3_C_[18]\, 
        \MULTIPLIER_3_C_[17]\, \MULTIPLIER_3_C_[16]\, 
        \MULTIPLIER_3_C_[15]\, \MULTIPLIER_3_C_[14]\, 
        \MULTIPLIER_3_C_[13]\, \MULTIPLIER_3_C_[12]\, 
        \MULTIPLIER_3_C_[11]\, \MULTIPLIER_3_C_[10]\, 
        \MULTIPLIER_3_C_[9]\, \MULTIPLIER_3_C_[8]\, 
        \MULTIPLIER_3_C_[7]\, \MULTIPLIER_3_C_[6]\, 
        \MULTIPLIER_3_C_[5]\, \MULTIPLIER_3_C_[4]\, 
        \MULTIPLIER_3_C_[3]\, \MULTIPLIER_3_C_[2]\, 
        \MULTIPLIER_3_C_[1]\, \MULTIPLIER_3_C_[0]\, GND_net, 
        VCC_net : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net);
    
    MULTIPLIER_2 : entity work.MULTIPLIER
      port map(CLK => CLK, RST => RST, sample_rdy_in => 
        sample_rdy_in, A(7) => I_A(7), A(6) => I_A(6), A(5) => 
        I_A(5), A(4) => I_A(4), A(3) => I_A(3), A(2) => I_A(2), 
        A(1) => I_A(1), A(0) => I_A(0), B(13) => Q_B(13), B(12)
         => Q_B(12), B(11) => Q_B(11), B(10) => Q_B(10), B(9) => 
        Q_B(9), B(8) => Q_B(8), B(7) => Q_B(7), B(6) => Q_B(6), 
        B(5) => Q_B(5), B(4) => Q_B(4), B(3) => Q_B(3), B(2) => 
        Q_B(2), B(1) => Q_B(1), B(0) => Q_B(0), sample_rdy => 
        OPEN, C(21) => \MULTIPLIER_2_C_[21]\, C(20) => 
        \MULTIPLIER_2_C_[20]\, C(19) => \MULTIPLIER_2_C_[19]\, 
        C(18) => \MULTIPLIER_2_C_[18]\, C(17) => 
        \MULTIPLIER_2_C_[17]\, C(16) => \MULTIPLIER_2_C_[16]\, 
        C(15) => \MULTIPLIER_2_C_[15]\, C(14) => 
        \MULTIPLIER_2_C_[14]\, C(13) => \MULTIPLIER_2_C_[13]\, 
        C(12) => \MULTIPLIER_2_C_[12]\, C(11) => 
        \MULTIPLIER_2_C_[11]\, C(10) => \MULTIPLIER_2_C_[10]\, 
        C(9) => \MULTIPLIER_2_C_[9]\, C(8) => 
        \MULTIPLIER_2_C_[8]\, C(7) => \MULTIPLIER_2_C_[7]\, C(6)
         => \MULTIPLIER_2_C_[6]\, C(5) => \MULTIPLIER_2_C_[5]\, 
        C(4) => \MULTIPLIER_2_C_[4]\, C(3) => 
        \MULTIPLIER_2_C_[3]\, C(2) => \MULTIPLIER_2_C_[2]\, C(1)
         => \MULTIPLIER_2_C_[1]\, C(0) => \MULTIPLIER_2_C_[0]\);
    
    MULTIPLIER_1 : entity work.MULTIPLIER
      port map(CLK => CLK, RST => RST, sample_rdy_in => 
        sample_rdy_in, A(7) => Q_A(7), A(6) => Q_A(6), A(5) => 
        Q_A(5), A(4) => Q_A(4), A(3) => Q_A(3), A(2) => Q_A(2), 
        A(1) => Q_A(1), A(0) => Q_A(0), B(13) => Q_B(13), B(12)
         => Q_B(12), B(11) => Q_B(11), B(10) => Q_B(10), B(9) => 
        Q_B(9), B(8) => Q_B(8), B(7) => Q_B(7), B(6) => Q_B(6), 
        B(5) => Q_B(5), B(4) => Q_B(4), B(3) => Q_B(3), B(2) => 
        Q_B(2), B(1) => Q_B(1), B(0) => Q_B(0), sample_rdy => 
        OPEN, C(21) => \MULTIPLIER_1_C_[21]\, C(20) => 
        \MULTIPLIER_1_C_[20]\, C(19) => \MULTIPLIER_1_C_[19]\, 
        C(18) => \MULTIPLIER_1_C_[18]\, C(17) => 
        \MULTIPLIER_1_C_[17]\, C(16) => \MULTIPLIER_1_C_[16]\, 
        C(15) => \MULTIPLIER_1_C_[15]\, C(14) => 
        \MULTIPLIER_1_C_[14]\, C(13) => \MULTIPLIER_1_C_[13]\, 
        C(12) => \MULTIPLIER_1_C_[12]\, C(11) => 
        \MULTIPLIER_1_C_[11]\, C(10) => \MULTIPLIER_1_C_[10]\, 
        C(9) => \MULTIPLIER_1_C_[9]\, C(8) => 
        \MULTIPLIER_1_C_[8]\, C(7) => \MULTIPLIER_1_C_[7]\, C(6)
         => \MULTIPLIER_1_C_[6]\, C(5) => \MULTIPLIER_1_C_[5]\, 
        C(4) => \MULTIPLIER_1_C_[4]\, C(3) => 
        \MULTIPLIER_1_C_[3]\, C(2) => \MULTIPLIER_1_C_[2]\, C(1)
         => \MULTIPLIER_1_C_[1]\, C(0) => \MULTIPLIER_1_C_[0]\);
    
    MULTIPLIER_3 : entity work.MULTIPLIER
      port map(CLK => CLK, RST => RST, sample_rdy_in => 
        sample_rdy_in, A(7) => Q_A(7), A(6) => Q_A(6), A(5) => 
        Q_A(5), A(4) => Q_A(4), A(3) => Q_A(3), A(2) => Q_A(2), 
        A(1) => Q_A(1), A(0) => Q_A(0), B(13) => I_B(13), B(12)
         => I_B(12), B(11) => I_B(11), B(10) => I_B(10), B(9) => 
        I_B(9), B(8) => I_B(8), B(7) => I_B(7), B(6) => I_B(6), 
        B(5) => I_B(5), B(4) => I_B(4), B(3) => I_B(3), B(2) => 
        I_B(2), B(1) => I_B(1), B(0) => I_B(0), sample_rdy => 
        OPEN, C(21) => \MULTIPLIER_3_C_[21]\, C(20) => 
        \MULTIPLIER_3_C_[20]\, C(19) => \MULTIPLIER_3_C_[19]\, 
        C(18) => \MULTIPLIER_3_C_[18]\, C(17) => 
        \MULTIPLIER_3_C_[17]\, C(16) => \MULTIPLIER_3_C_[16]\, 
        C(15) => \MULTIPLIER_3_C_[15]\, C(14) => 
        \MULTIPLIER_3_C_[14]\, C(13) => \MULTIPLIER_3_C_[13]\, 
        C(12) => \MULTIPLIER_3_C_[12]\, C(11) => 
        \MULTIPLIER_3_C_[11]\, C(10) => \MULTIPLIER_3_C_[10]\, 
        C(9) => \MULTIPLIER_3_C_[9]\, C(8) => 
        \MULTIPLIER_3_C_[8]\, C(7) => \MULTIPLIER_3_C_[7]\, C(6)
         => \MULTIPLIER_3_C_[6]\, C(5) => \MULTIPLIER_3_C_[5]\, 
        C(4) => \MULTIPLIER_3_C_[4]\, C(3) => 
        \MULTIPLIER_3_C_[3]\, C(2) => \MULTIPLIER_3_C_[2]\, C(1)
         => \MULTIPLIER_3_C_[1]\, C(0) => \MULTIPLIER_3_C_[0]\);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    ADDERSUBTRACTOR_1 : entity work.ADDERSUBTRACTOR
      port map(CLK => CLK, RST => RST, addsubtract => VCC_net, 
        A(21) => \MULTIPLIER_2_C_[21]\, A(20) => 
        \MULTIPLIER_2_C_[20]\, A(19) => \MULTIPLIER_2_C_[19]\, 
        A(18) => \MULTIPLIER_2_C_[18]\, A(17) => 
        \MULTIPLIER_2_C_[17]\, A(16) => \MULTIPLIER_2_C_[16]\, 
        A(15) => \MULTIPLIER_2_C_[15]\, A(14) => 
        \MULTIPLIER_2_C_[14]\, A(13) => \MULTIPLIER_2_C_[13]\, 
        A(12) => \MULTIPLIER_2_C_[12]\, A(11) => 
        \MULTIPLIER_2_C_[11]\, A(10) => \MULTIPLIER_2_C_[10]\, 
        A(9) => \MULTIPLIER_2_C_[9]\, A(8) => 
        \MULTIPLIER_2_C_[8]\, A(7) => \MULTIPLIER_2_C_[7]\, A(6)
         => \MULTIPLIER_2_C_[6]\, A(5) => \MULTIPLIER_2_C_[5]\, 
        A(4) => \MULTIPLIER_2_C_[4]\, A(3) => 
        \MULTIPLIER_2_C_[3]\, A(2) => \MULTIPLIER_2_C_[2]\, A(1)
         => \MULTIPLIER_2_C_[1]\, A(0) => \MULTIPLIER_2_C_[0]\, 
        B(21) => \MULTIPLIER_3_C_[21]\, B(20) => 
        \MULTIPLIER_3_C_[20]\, B(19) => \MULTIPLIER_3_C_[19]\, 
        B(18) => \MULTIPLIER_3_C_[18]\, B(17) => 
        \MULTIPLIER_3_C_[17]\, B(16) => \MULTIPLIER_3_C_[16]\, 
        B(15) => \MULTIPLIER_3_C_[15]\, B(14) => 
        \MULTIPLIER_3_C_[14]\, B(13) => \MULTIPLIER_3_C_[13]\, 
        B(12) => \MULTIPLIER_3_C_[12]\, B(11) => 
        \MULTIPLIER_3_C_[11]\, B(10) => \MULTIPLIER_3_C_[10]\, 
        B(9) => \MULTIPLIER_3_C_[9]\, B(8) => 
        \MULTIPLIER_3_C_[8]\, B(7) => \MULTIPLIER_3_C_[7]\, B(6)
         => \MULTIPLIER_3_C_[6]\, B(5) => \MULTIPLIER_3_C_[5]\, 
        B(4) => \MULTIPLIER_3_C_[4]\, B(3) => 
        \MULTIPLIER_3_C_[3]\, B(2) => \MULTIPLIER_3_C_[2]\, B(1)
         => \MULTIPLIER_3_C_[1]\, B(0) => \MULTIPLIER_3_C_[0]\, 
        C(22) => Q(22), C(21) => Q(21), C(20) => Q(20), C(19) => 
        Q(19), C(18) => Q(18), C(17) => Q(17), C(16) => Q(16), 
        C(15) => Q(15), C(14) => Q(14), C(13) => Q(13), C(12) => 
        Q(12), C(11) => Q(11), C(10) => Q(10), C(9) => Q(9), C(8)
         => Q(8), C(7) => Q(7), C(6) => Q(6), C(5) => Q(5), C(4)
         => Q(4), C(3) => Q(3), C(2) => Q(2), C(1) => Q(1), C(0)
         => Q(0));
    
    ADDERSUBTRACTOR_0 : entity work.ADDERSUBTRACTOR
      port map(CLK => CLK, RST => RST, addsubtract => GND_net, 
        A(21) => \MULTIPLIER_0_C_[21]\, A(20) => 
        \MULTIPLIER_0_C_[20]\, A(19) => \MULTIPLIER_0_C_[19]\, 
        A(18) => \MULTIPLIER_0_C_[18]\, A(17) => 
        \MULTIPLIER_0_C_[17]\, A(16) => \MULTIPLIER_0_C_[16]\, 
        A(15) => \MULTIPLIER_0_C_[15]\, A(14) => 
        \MULTIPLIER_0_C_[14]\, A(13) => \MULTIPLIER_0_C_[13]\, 
        A(12) => \MULTIPLIER_0_C_[12]\, A(11) => 
        \MULTIPLIER_0_C_[11]\, A(10) => \MULTIPLIER_0_C_[10]\, 
        A(9) => \MULTIPLIER_0_C_[9]\, A(8) => 
        \MULTIPLIER_0_C_[8]\, A(7) => \MULTIPLIER_0_C_[7]\, A(6)
         => \MULTIPLIER_0_C_[6]\, A(5) => \MULTIPLIER_0_C_[5]\, 
        A(4) => \MULTIPLIER_0_C_[4]\, A(3) => 
        \MULTIPLIER_0_C_[3]\, A(2) => \MULTIPLIER_0_C_[2]\, A(1)
         => \MULTIPLIER_0_C_[1]\, A(0) => \MULTIPLIER_0_C_[0]\, 
        B(21) => \MULTIPLIER_1_C_[21]\, B(20) => 
        \MULTIPLIER_1_C_[20]\, B(19) => \MULTIPLIER_1_C_[19]\, 
        B(18) => \MULTIPLIER_1_C_[18]\, B(17) => 
        \MULTIPLIER_1_C_[17]\, B(16) => \MULTIPLIER_1_C_[16]\, 
        B(15) => \MULTIPLIER_1_C_[15]\, B(14) => 
        \MULTIPLIER_1_C_[14]\, B(13) => \MULTIPLIER_1_C_[13]\, 
        B(12) => \MULTIPLIER_1_C_[12]\, B(11) => 
        \MULTIPLIER_1_C_[11]\, B(10) => \MULTIPLIER_1_C_[10]\, 
        B(9) => \MULTIPLIER_1_C_[9]\, B(8) => 
        \MULTIPLIER_1_C_[8]\, B(7) => \MULTIPLIER_1_C_[7]\, B(6)
         => \MULTIPLIER_1_C_[6]\, B(5) => \MULTIPLIER_1_C_[5]\, 
        B(4) => \MULTIPLIER_1_C_[4]\, B(3) => 
        \MULTIPLIER_1_C_[3]\, B(2) => \MULTIPLIER_1_C_[2]\, B(1)
         => \MULTIPLIER_1_C_[1]\, B(0) => \MULTIPLIER_1_C_[0]\, 
        C(22) => I(22), C(21) => I(21), C(20) => I(20), C(19) => 
        I(19), C(18) => I(18), C(17) => I(17), C(16) => I(16), 
        C(15) => I(15), C(14) => I(14), C(13) => I(13), C(12) => 
        I(12), C(11) => I(11), C(10) => I(10), C(9) => I(9), C(8)
         => I(8), C(7) => I(7), C(6) => I(6), C(5) => I(5), C(4)
         => I(4), C(3) => I(3), C(2) => I(2), C(1) => I(1), C(0)
         => I(0));
    
    MULTIPLIER_0 : entity work.MULTIPLIER
      port map(CLK => CLK, RST => RST, sample_rdy_in => 
        sample_rdy_in, A(7) => I_A(7), A(6) => I_A(6), A(5) => 
        I_A(5), A(4) => I_A(4), A(3) => I_A(3), A(2) => I_A(2), 
        A(1) => I_A(1), A(0) => I_A(0), B(13) => I_B(13), B(12)
         => I_B(12), B(11) => I_B(11), B(10) => I_B(10), B(9) => 
        I_B(9), B(8) => I_B(8), B(7) => I_B(7), B(6) => I_B(6), 
        B(5) => I_B(5), B(4) => I_B(4), B(3) => I_B(3), B(2) => 
        I_B(2), B(1) => I_B(1), B(0) => I_B(0), sample_rdy => 
        OPEN, C(21) => \MULTIPLIER_0_C_[21]\, C(20) => 
        \MULTIPLIER_0_C_[20]\, C(19) => \MULTIPLIER_0_C_[19]\, 
        C(18) => \MULTIPLIER_0_C_[18]\, C(17) => 
        \MULTIPLIER_0_C_[17]\, C(16) => \MULTIPLIER_0_C_[16]\, 
        C(15) => \MULTIPLIER_0_C_[15]\, C(14) => 
        \MULTIPLIER_0_C_[14]\, C(13) => \MULTIPLIER_0_C_[13]\, 
        C(12) => \MULTIPLIER_0_C_[12]\, C(11) => 
        \MULTIPLIER_0_C_[11]\, C(10) => \MULTIPLIER_0_C_[10]\, 
        C(9) => \MULTIPLIER_0_C_[9]\, C(8) => 
        \MULTIPLIER_0_C_[8]\, C(7) => \MULTIPLIER_0_C_[7]\, C(6)
         => \MULTIPLIER_0_C_[6]\, C(5) => \MULTIPLIER_0_C_[5]\, 
        C(4) => \MULTIPLIER_0_C_[4]\, C(3) => 
        \MULTIPLIER_0_C_[3]\, C(2) => \MULTIPLIER_0_C_[2]\, C(1)
         => \MULTIPLIER_0_C_[1]\, C(0) => \MULTIPLIER_0_C_[0]\);
    

end DEF_ARCH; 
