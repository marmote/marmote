-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity DDC is

    port( RST           : in    std_logic;
          CLK           : in    std_logic;
          sample_rdy_in : in    std_logic;
          I_in          : in    std_logic_vector(13 downto 0);
          Q_in          : in    std_logic_vector(13 downto 0);
          I_SMPL_RDY    : out   std_logic;
          I_out         : out   std_logic_vector(31 downto 0);
          Q_SMPL_RDY    : out   std_logic;
          Q_out         : out   std_logic_vector(31 downto 0);
          DPHASE        : in    std_logic_vector(15 downto 0)
        );

end DDC;

architecture DEF_ARCH of DDC is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CIC
    port( CLK      : in    std_logic := 'U';
          RST      : in    std_logic := 'U';
          SMPL_RDY : out   std_logic;
          INPUT    : in    std_logic_vector(22 downto 0) := (others => 'U');
          OUTPUT   : out   std_logic_vector(31 downto 0)
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

  component GND
    port( Y : out   std_logic
        );
  end component;

  component complex_mult
    port( sample_rdy_in : in    std_logic := 'U';
          CLK           : in    std_logic := 'U';
          RST           : in    std_logic := 'U';
          I             : out   std_logic_vector(22 downto 0);
          Q             : out   std_logic_vector(22 downto 0);
          I_A           : in    std_logic_vector(7 downto 0) := (others => 'U');
          I_B           : in    std_logic_vector(13 downto 0) := (others => 'U');
          Q_A           : in    std_logic_vector(7 downto 0) := (others => 'U');
          Q_B           : in    std_logic_vector(13 downto 0) := (others => 'U')
        );
  end component;

    signal \complex_mult_0_I_0_[22]\, \complex_mult_0_I_0_[21]\, 
        \complex_mult_0_I_0_[20]\, \complex_mult_0_I_0_[19]\, 
        \complex_mult_0_I_0_[18]\, \complex_mult_0_I_0_[17]\, 
        \complex_mult_0_I_0_[16]\, \complex_mult_0_I_0_[15]\, 
        \complex_mult_0_I_0_[14]\, \complex_mult_0_I_0_[13]\, 
        \complex_mult_0_I_0_[12]\, \complex_mult_0_I_0_[11]\, 
        \complex_mult_0_I_0_[10]\, \complex_mult_0_I_0_[9]\, 
        \complex_mult_0_I_0_[8]\, \complex_mult_0_I_0_[7]\, 
        \complex_mult_0_I_0_[6]\, \complex_mult_0_I_0_[5]\, 
        \complex_mult_0_I_0_[4]\, \complex_mult_0_I_0_[3]\, 
        \complex_mult_0_I_0_[2]\, \complex_mult_0_I_0_[1]\, 
        \complex_mult_0_I_0_[0]\, \complex_mult_0_Q_0_[22]\, 
        \complex_mult_0_Q_0_[21]\, \complex_mult_0_Q_0_[20]\, 
        \complex_mult_0_Q_0_[19]\, \complex_mult_0_Q_0_[18]\, 
        \complex_mult_0_Q_0_[17]\, \complex_mult_0_Q_0_[16]\, 
        \complex_mult_0_Q_0_[15]\, \complex_mult_0_Q_0_[14]\, 
        \complex_mult_0_Q_0_[13]\, \complex_mult_0_Q_0_[12]\, 
        \complex_mult_0_Q_0_[11]\, \complex_mult_0_Q_0_[10]\, 
        \complex_mult_0_Q_0_[9]\, \complex_mult_0_Q_0_[8]\, 
        \complex_mult_0_Q_0_[7]\, \complex_mult_0_Q_0_[6]\, 
        \complex_mult_0_Q_0_[5]\, \complex_mult_0_Q_0_[4]\, 
        \complex_mult_0_Q_0_[3]\, \complex_mult_0_Q_0_[2]\, 
        \complex_mult_0_Q_0_[1]\, \complex_mult_0_Q_0_[0]\, 
        \sincos_gen_0_COS_OUT_0_[7]\, 
        \sincos_gen_0_COS_OUT_0_[6]\, 
        \sincos_gen_0_COS_OUT_0_[5]\, 
        \sincos_gen_0_COS_OUT_0_[4]\, 
        \sincos_gen_0_COS_OUT_0_[3]\, 
        \sincos_gen_0_COS_OUT_0_[2]\, 
        \sincos_gen_0_COS_OUT_0_[1]\, 
        \sincos_gen_0_COS_OUT_0_[0]\, 
        \sincos_gen_0_SIN_OUT_1_[7]\, 
        \sincos_gen_0_SIN_OUT_1_[6]\, 
        \sincos_gen_0_SIN_OUT_1_[5]\, 
        \sincos_gen_0_SIN_OUT_1_[4]\, 
        \sincos_gen_0_SIN_OUT_1_[3]\, 
        \sincos_gen_0_SIN_OUT_1_[2]\, 
        \sincos_gen_0_SIN_OUT_1_[1]\, 
        \sincos_gen_0_SIN_OUT_1_[0]\, GND_net, VCC_net
         : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net);
    
    CIC_1 : CIC
      port map(CLK => CLK, RST => RST, SMPL_RDY => Q_SMPL_RDY, 
        INPUT(22) => \complex_mult_0_Q_0_[22]\, INPUT(21) => 
        \complex_mult_0_Q_0_[21]\, INPUT(20) => 
        \complex_mult_0_Q_0_[20]\, INPUT(19) => 
        \complex_mult_0_Q_0_[19]\, INPUT(18) => 
        \complex_mult_0_Q_0_[18]\, INPUT(17) => 
        \complex_mult_0_Q_0_[17]\, INPUT(16) => 
        \complex_mult_0_Q_0_[16]\, INPUT(15) => 
        \complex_mult_0_Q_0_[15]\, INPUT(14) => 
        \complex_mult_0_Q_0_[14]\, INPUT(13) => 
        \complex_mult_0_Q_0_[13]\, INPUT(12) => 
        \complex_mult_0_Q_0_[12]\, INPUT(11) => 
        \complex_mult_0_Q_0_[11]\, INPUT(10) => 
        \complex_mult_0_Q_0_[10]\, INPUT(9) => 
        \complex_mult_0_Q_0_[9]\, INPUT(8) => 
        \complex_mult_0_Q_0_[8]\, INPUT(7) => 
        \complex_mult_0_Q_0_[7]\, INPUT(6) => 
        \complex_mult_0_Q_0_[6]\, INPUT(5) => 
        \complex_mult_0_Q_0_[5]\, INPUT(4) => 
        \complex_mult_0_Q_0_[4]\, INPUT(3) => 
        \complex_mult_0_Q_0_[3]\, INPUT(2) => 
        \complex_mult_0_Q_0_[2]\, INPUT(1) => 
        \complex_mult_0_Q_0_[1]\, INPUT(0) => 
        \complex_mult_0_Q_0_[0]\, OUTPUT(31) => Q_out(31), 
        OUTPUT(30) => Q_out(30), OUTPUT(29) => Q_out(29), 
        OUTPUT(28) => Q_out(28), OUTPUT(27) => Q_out(27), 
        OUTPUT(26) => Q_out(26), OUTPUT(25) => Q_out(25), 
        OUTPUT(24) => Q_out(24), OUTPUT(23) => Q_out(23), 
        OUTPUT(22) => Q_out(22), OUTPUT(21) => Q_out(21), 
        OUTPUT(20) => Q_out(20), OUTPUT(19) => Q_out(19), 
        OUTPUT(18) => Q_out(18), OUTPUT(17) => Q_out(17), 
        OUTPUT(16) => Q_out(16), OUTPUT(15) => Q_out(15), 
        OUTPUT(14) => Q_out(14), OUTPUT(13) => Q_out(13), 
        OUTPUT(12) => Q_out(12), OUTPUT(11) => Q_out(11), 
        OUTPUT(10) => Q_out(10), OUTPUT(9) => Q_out(9), OUTPUT(8)
         => Q_out(8), OUTPUT(7) => Q_out(7), OUTPUT(6) => 
        Q_out(6), OUTPUT(5) => Q_out(5), OUTPUT(4) => Q_out(4), 
        OUTPUT(3) => Q_out(3), OUTPUT(2) => Q_out(2), OUTPUT(1)
         => Q_out(1), OUTPUT(0) => Q_out(0));
    
    sincos_gen_0 : sincos_gen
      port map(RST => RST, CLK => CLK, DPHASE_EN => VCC_net, 
        RDYOUT => OPEN, DPHASE(15) => DPHASE(15), DPHASE(14) => 
        DPHASE(14), DPHASE(13) => DPHASE(13), DPHASE(12) => 
        DPHASE(12), DPHASE(11) => DPHASE(11), DPHASE(10) => 
        DPHASE(10), DPHASE(9) => DPHASE(9), DPHASE(8) => 
        DPHASE(8), DPHASE(7) => DPHASE(7), DPHASE(6) => DPHASE(6), 
        DPHASE(5) => DPHASE(5), DPHASE(4) => DPHASE(4), DPHASE(3)
         => DPHASE(3), DPHASE(2) => DPHASE(2), DPHASE(1) => 
        DPHASE(1), DPHASE(0) => DPHASE(0), COS_OUT(7) => 
        \sincos_gen_0_COS_OUT_0_[7]\, COS_OUT(6) => 
        \sincos_gen_0_COS_OUT_0_[6]\, COS_OUT(5) => 
        \sincos_gen_0_COS_OUT_0_[5]\, COS_OUT(4) => 
        \sincos_gen_0_COS_OUT_0_[4]\, COS_OUT(3) => 
        \sincos_gen_0_COS_OUT_0_[3]\, COS_OUT(2) => 
        \sincos_gen_0_COS_OUT_0_[2]\, COS_OUT(1) => 
        \sincos_gen_0_COS_OUT_0_[1]\, COS_OUT(0) => 
        \sincos_gen_0_COS_OUT_0_[0]\, SIN_OUT(7) => 
        \sincos_gen_0_SIN_OUT_1_[7]\, SIN_OUT(6) => 
        \sincos_gen_0_SIN_OUT_1_[6]\, SIN_OUT(5) => 
        \sincos_gen_0_SIN_OUT_1_[5]\, SIN_OUT(4) => 
        \sincos_gen_0_SIN_OUT_1_[4]\, SIN_OUT(3) => 
        \sincos_gen_0_SIN_OUT_1_[3]\, SIN_OUT(2) => 
        \sincos_gen_0_SIN_OUT_1_[2]\, SIN_OUT(1) => 
        \sincos_gen_0_SIN_OUT_1_[1]\, SIN_OUT(0) => 
        \sincos_gen_0_SIN_OUT_1_[0]\);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    complex_mult_0 : complex_mult
      port map(sample_rdy_in => sample_rdy_in, CLK => CLK, RST
         => RST, I(22) => \complex_mult_0_I_0_[22]\, I(21) => 
        \complex_mult_0_I_0_[21]\, I(20) => 
        \complex_mult_0_I_0_[20]\, I(19) => 
        \complex_mult_0_I_0_[19]\, I(18) => 
        \complex_mult_0_I_0_[18]\, I(17) => 
        \complex_mult_0_I_0_[17]\, I(16) => 
        \complex_mult_0_I_0_[16]\, I(15) => 
        \complex_mult_0_I_0_[15]\, I(14) => 
        \complex_mult_0_I_0_[14]\, I(13) => 
        \complex_mult_0_I_0_[13]\, I(12) => 
        \complex_mult_0_I_0_[12]\, I(11) => 
        \complex_mult_0_I_0_[11]\, I(10) => 
        \complex_mult_0_I_0_[10]\, I(9) => 
        \complex_mult_0_I_0_[9]\, I(8) => 
        \complex_mult_0_I_0_[8]\, I(7) => 
        \complex_mult_0_I_0_[7]\, I(6) => 
        \complex_mult_0_I_0_[6]\, I(5) => 
        \complex_mult_0_I_0_[5]\, I(4) => 
        \complex_mult_0_I_0_[4]\, I(3) => 
        \complex_mult_0_I_0_[3]\, I(2) => 
        \complex_mult_0_I_0_[2]\, I(1) => 
        \complex_mult_0_I_0_[1]\, I(0) => 
        \complex_mult_0_I_0_[0]\, Q(22) => 
        \complex_mult_0_Q_0_[22]\, Q(21) => 
        \complex_mult_0_Q_0_[21]\, Q(20) => 
        \complex_mult_0_Q_0_[20]\, Q(19) => 
        \complex_mult_0_Q_0_[19]\, Q(18) => 
        \complex_mult_0_Q_0_[18]\, Q(17) => 
        \complex_mult_0_Q_0_[17]\, Q(16) => 
        \complex_mult_0_Q_0_[16]\, Q(15) => 
        \complex_mult_0_Q_0_[15]\, Q(14) => 
        \complex_mult_0_Q_0_[14]\, Q(13) => 
        \complex_mult_0_Q_0_[13]\, Q(12) => 
        \complex_mult_0_Q_0_[12]\, Q(11) => 
        \complex_mult_0_Q_0_[11]\, Q(10) => 
        \complex_mult_0_Q_0_[10]\, Q(9) => 
        \complex_mult_0_Q_0_[9]\, Q(8) => 
        \complex_mult_0_Q_0_[8]\, Q(7) => 
        \complex_mult_0_Q_0_[7]\, Q(6) => 
        \complex_mult_0_Q_0_[6]\, Q(5) => 
        \complex_mult_0_Q_0_[5]\, Q(4) => 
        \complex_mult_0_Q_0_[4]\, Q(3) => 
        \complex_mult_0_Q_0_[3]\, Q(2) => 
        \complex_mult_0_Q_0_[2]\, Q(1) => 
        \complex_mult_0_Q_0_[1]\, Q(0) => 
        \complex_mult_0_Q_0_[0]\, I_A(7) => 
        \sincos_gen_0_COS_OUT_0_[7]\, I_A(6) => 
        \sincos_gen_0_COS_OUT_0_[6]\, I_A(5) => 
        \sincos_gen_0_COS_OUT_0_[5]\, I_A(4) => 
        \sincos_gen_0_COS_OUT_0_[4]\, I_A(3) => 
        \sincos_gen_0_COS_OUT_0_[3]\, I_A(2) => 
        \sincos_gen_0_COS_OUT_0_[2]\, I_A(1) => 
        \sincos_gen_0_COS_OUT_0_[1]\, I_A(0) => 
        \sincos_gen_0_COS_OUT_0_[0]\, I_B(13) => I_in(13), 
        I_B(12) => I_in(12), I_B(11) => I_in(11), I_B(10) => 
        I_in(10), I_B(9) => I_in(9), I_B(8) => I_in(8), I_B(7)
         => I_in(7), I_B(6) => I_in(6), I_B(5) => I_in(5), I_B(4)
         => I_in(4), I_B(3) => I_in(3), I_B(2) => I_in(2), I_B(1)
         => I_in(1), I_B(0) => I_in(0), Q_A(7) => 
        \sincos_gen_0_SIN_OUT_1_[7]\, Q_A(6) => 
        \sincos_gen_0_SIN_OUT_1_[6]\, Q_A(5) => 
        \sincos_gen_0_SIN_OUT_1_[5]\, Q_A(4) => 
        \sincos_gen_0_SIN_OUT_1_[4]\, Q_A(3) => 
        \sincos_gen_0_SIN_OUT_1_[3]\, Q_A(2) => 
        \sincos_gen_0_SIN_OUT_1_[2]\, Q_A(1) => 
        \sincos_gen_0_SIN_OUT_1_[1]\, Q_A(0) => 
        \sincos_gen_0_SIN_OUT_1_[0]\, Q_B(13) => Q_in(13), 
        Q_B(12) => Q_in(12), Q_B(11) => Q_in(11), Q_B(10) => 
        Q_in(10), Q_B(9) => Q_in(9), Q_B(8) => Q_in(8), Q_B(7)
         => Q_in(7), Q_B(6) => Q_in(6), Q_B(5) => Q_in(5), Q_B(4)
         => Q_in(4), Q_B(3) => Q_in(3), Q_B(2) => Q_in(2), Q_B(1)
         => Q_in(1), Q_B(0) => Q_in(0));
    
    CIC_0 : CIC
      port map(CLK => CLK, RST => RST, SMPL_RDY => I_SMPL_RDY, 
        INPUT(22) => \complex_mult_0_I_0_[22]\, INPUT(21) => 
        \complex_mult_0_I_0_[21]\, INPUT(20) => 
        \complex_mult_0_I_0_[20]\, INPUT(19) => 
        \complex_mult_0_I_0_[19]\, INPUT(18) => 
        \complex_mult_0_I_0_[18]\, INPUT(17) => 
        \complex_mult_0_I_0_[17]\, INPUT(16) => 
        \complex_mult_0_I_0_[16]\, INPUT(15) => 
        \complex_mult_0_I_0_[15]\, INPUT(14) => 
        \complex_mult_0_I_0_[14]\, INPUT(13) => 
        \complex_mult_0_I_0_[13]\, INPUT(12) => 
        \complex_mult_0_I_0_[12]\, INPUT(11) => 
        \complex_mult_0_I_0_[11]\, INPUT(10) => 
        \complex_mult_0_I_0_[10]\, INPUT(9) => 
        \complex_mult_0_I_0_[9]\, INPUT(8) => 
        \complex_mult_0_I_0_[8]\, INPUT(7) => 
        \complex_mult_0_I_0_[7]\, INPUT(6) => 
        \complex_mult_0_I_0_[6]\, INPUT(5) => 
        \complex_mult_0_I_0_[5]\, INPUT(4) => 
        \complex_mult_0_I_0_[4]\, INPUT(3) => 
        \complex_mult_0_I_0_[3]\, INPUT(2) => 
        \complex_mult_0_I_0_[2]\, INPUT(1) => 
        \complex_mult_0_I_0_[1]\, INPUT(0) => 
        \complex_mult_0_I_0_[0]\, OUTPUT(31) => I_out(31), 
        OUTPUT(30) => I_out(30), OUTPUT(29) => I_out(29), 
        OUTPUT(28) => I_out(28), OUTPUT(27) => I_out(27), 
        OUTPUT(26) => I_out(26), OUTPUT(25) => I_out(25), 
        OUTPUT(24) => I_out(24), OUTPUT(23) => I_out(23), 
        OUTPUT(22) => I_out(22), OUTPUT(21) => I_out(21), 
        OUTPUT(20) => I_out(20), OUTPUT(19) => I_out(19), 
        OUTPUT(18) => I_out(18), OUTPUT(17) => I_out(17), 
        OUTPUT(16) => I_out(16), OUTPUT(15) => I_out(15), 
        OUTPUT(14) => I_out(14), OUTPUT(13) => I_out(13), 
        OUTPUT(12) => I_out(12), OUTPUT(11) => I_out(11), 
        OUTPUT(10) => I_out(10), OUTPUT(9) => I_out(9), OUTPUT(8)
         => I_out(8), OUTPUT(7) => I_out(7), OUTPUT(6) => 
        I_out(6), OUTPUT(5) => I_out(5), OUTPUT(4) => I_out(4), 
        OUTPUT(3) => I_out(3), OUTPUT(2) => I_out(2), OUTPUT(1)
         => I_out(1), OUTPUT(0) => I_out(0));
    

end DEF_ARCH; 
