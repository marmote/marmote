-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity DDC is

    port( RST           : in    std_logic;
          CLK           : in    std_logic;
          PSEL_0        : in    std_logic;
          PENABLE_0     : in    std_logic;
          PWRITE_0      : in    std_logic;
          PREADY_0      : out   std_logic;
          PSLVERR_0     : out   std_logic;
          SMPL_RDY      : out   std_logic;
          sample_rdy_in : in    std_logic;
          PADDR_0       : in    std_logic_vector(31 downto 0);
          PRDATA_0      : out   std_logic_vector(31 downto 0);
          PWDATA_0      : in    std_logic_vector(31 downto 0);
          I_B           : in    std_logic_vector(13 downto 0);
          Q_B           : in    std_logic_vector(13 downto 0)
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

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
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

    signal \CIC_0_OUTPUT_0_[31]\, \CIC_0_OUTPUT_0_[30]\, 
        \CIC_0_OUTPUT_0_[29]\, \CIC_0_OUTPUT_0_[28]\, 
        \CIC_0_OUTPUT_0_[27]\, \CIC_0_OUTPUT_0_[26]\, 
        \CIC_0_OUTPUT_0_[25]\, \CIC_0_OUTPUT_0_[24]\, 
        \CIC_0_OUTPUT_0_[23]\, \CIC_0_OUTPUT_0_[22]\, 
        \CIC_0_OUTPUT_0_[21]\, \CIC_0_OUTPUT_0_[20]\, 
        \CIC_0_OUTPUT_0_[19]\, \CIC_0_OUTPUT_0_[18]\, 
        \CIC_0_OUTPUT_0_[17]\, \CIC_0_OUTPUT_0_[16]\, 
        \CIC_0_OUTPUT_0_[15]\, \CIC_0_OUTPUT_0_[14]\, 
        \CIC_0_OUTPUT_0_[13]\, \CIC_0_OUTPUT_0_[12]\, 
        \CIC_0_OUTPUT_0_[11]\, \CIC_0_OUTPUT_0_[10]\, 
        \CIC_0_OUTPUT_0_[9]\, \CIC_0_OUTPUT_0_[8]\, 
        \CIC_0_OUTPUT_0_[7]\, \CIC_0_OUTPUT_0_[6]\, 
        \CIC_0_OUTPUT_0_[5]\, \CIC_0_OUTPUT_0_[4]\, 
        \CIC_0_OUTPUT_0_[3]\, \CIC_0_OUTPUT_0_[2]\, 
        \CIC_0_OUTPUT_0_[1]\, \CIC_0_OUTPUT_0_[0]\, 
        CIC_0_SMPL_RDY, \CIC_1_OUTPUT_0_[31]\, 
        \CIC_1_OUTPUT_0_[30]\, \CIC_1_OUTPUT_0_[29]\, 
        \CIC_1_OUTPUT_0_[28]\, \CIC_1_OUTPUT_0_[27]\, 
        \CIC_1_OUTPUT_0_[26]\, \CIC_1_OUTPUT_0_[25]\, 
        \CIC_1_OUTPUT_0_[24]\, \CIC_1_OUTPUT_0_[23]\, 
        \CIC_1_OUTPUT_0_[22]\, \CIC_1_OUTPUT_0_[21]\, 
        \CIC_1_OUTPUT_0_[20]\, \CIC_1_OUTPUT_0_[19]\, 
        \CIC_1_OUTPUT_0_[18]\, \CIC_1_OUTPUT_0_[17]\, 
        \CIC_1_OUTPUT_0_[16]\, \CIC_1_OUTPUT_0_[15]\, 
        \CIC_1_OUTPUT_0_[14]\, \CIC_1_OUTPUT_0_[13]\, 
        \CIC_1_OUTPUT_0_[12]\, \CIC_1_OUTPUT_0_[11]\, 
        \CIC_1_OUTPUT_0_[10]\, \CIC_1_OUTPUT_0_[9]\, 
        \CIC_1_OUTPUT_0_[8]\, \CIC_1_OUTPUT_0_[7]\, 
        \CIC_1_OUTPUT_0_[6]\, \CIC_1_OUTPUT_0_[5]\, 
        \CIC_1_OUTPUT_0_[4]\, \CIC_1_OUTPUT_0_[3]\, 
        \CIC_1_OUTPUT_0_[2]\, \CIC_1_OUTPUT_0_[1]\, 
        \CIC_1_OUTPUT_0_[0]\, CIC_1_SMPL_RDY, 
        \complex_mult_0_I_0_[22]\, \complex_mult_0_I_0_[21]\, 
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
        INV_0_Y, \sincos_gen_0_COS_OUT_0_[7]\, 
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
    
    SAMPLE_APB3_0 : entity work.SAMPLE_APB3
      port map(PCLK => CLK, PRESETn => INV_0_Y, PSEL => PSEL_0, 
        PENABLE => PENABLE_0, PWRITE => PWRITE_0, PREADY => 
        PREADY_0, PSLVERR => PSLVERR_0, SMPL_RDY => SMPL_RDY, 
        PADDR(31) => PADDR_0(31), PADDR(30) => PADDR_0(30), 
        PADDR(29) => PADDR_0(29), PADDR(28) => PADDR_0(28), 
        PADDR(27) => PADDR_0(27), PADDR(26) => PADDR_0(26), 
        PADDR(25) => PADDR_0(25), PADDR(24) => PADDR_0(24), 
        PADDR(23) => PADDR_0(23), PADDR(22) => PADDR_0(22), 
        PADDR(21) => PADDR_0(21), PADDR(20) => PADDR_0(20), 
        PADDR(19) => PADDR_0(19), PADDR(18) => PADDR_0(18), 
        PADDR(17) => PADDR_0(17), PADDR(16) => PADDR_0(16), 
        PADDR(15) => PADDR_0(15), PADDR(14) => PADDR_0(14), 
        PADDR(13) => PADDR_0(13), PADDR(12) => PADDR_0(12), 
        PADDR(11) => PADDR_0(11), PADDR(10) => PADDR_0(10), 
        PADDR(9) => PADDR_0(9), PADDR(8) => PADDR_0(8), PADDR(7)
         => PADDR_0(7), PADDR(6) => PADDR_0(6), PADDR(5) => 
        PADDR_0(5), PADDR(4) => PADDR_0(4), PADDR(3) => 
        PADDR_0(3), PADDR(2) => PADDR_0(2), PADDR(1) => 
        PADDR_0(1), PADDR(0) => PADDR_0(0), PWDATA(31) => 
        PWDATA_0(31), PWDATA(30) => PWDATA_0(30), PWDATA(29) => 
        PWDATA_0(29), PWDATA(28) => PWDATA_0(28), PWDATA(27) => 
        PWDATA_0(27), PWDATA(26) => PWDATA_0(26), PWDATA(25) => 
        PWDATA_0(25), PWDATA(24) => PWDATA_0(24), PWDATA(23) => 
        PWDATA_0(23), PWDATA(22) => PWDATA_0(22), PWDATA(21) => 
        PWDATA_0(21), PWDATA(20) => PWDATA_0(20), PWDATA(19) => 
        PWDATA_0(19), PWDATA(18) => PWDATA_0(18), PWDATA(17) => 
        PWDATA_0(17), PWDATA(16) => PWDATA_0(16), PWDATA(15) => 
        PWDATA_0(15), PWDATA(14) => PWDATA_0(14), PWDATA(13) => 
        PWDATA_0(13), PWDATA(12) => PWDATA_0(12), PWDATA(11) => 
        PWDATA_0(11), PWDATA(10) => PWDATA_0(10), PWDATA(9) => 
        PWDATA_0(9), PWDATA(8) => PWDATA_0(8), PWDATA(7) => 
        PWDATA_0(7), PWDATA(6) => PWDATA_0(6), PWDATA(5) => 
        PWDATA_0(5), PWDATA(4) => PWDATA_0(4), PWDATA(3) => 
        PWDATA_0(3), PWDATA(2) => PWDATA_0(2), PWDATA(1) => 
        PWDATA_0(1), PWDATA(0) => PWDATA_0(0), PRDATA(31) => 
        PRDATA_0(31), PRDATA(30) => PRDATA_0(30), PRDATA(29) => 
        PRDATA_0(29), PRDATA(28) => PRDATA_0(28), PRDATA(27) => 
        PRDATA_0(27), PRDATA(26) => PRDATA_0(26), PRDATA(25) => 
        PRDATA_0(25), PRDATA(24) => PRDATA_0(24), PRDATA(23) => 
        PRDATA_0(23), PRDATA(22) => PRDATA_0(22), PRDATA(21) => 
        PRDATA_0(21), PRDATA(20) => PRDATA_0(20), PRDATA(19) => 
        PRDATA_0(19), PRDATA(18) => PRDATA_0(18), PRDATA(17) => 
        PRDATA_0(17), PRDATA(16) => PRDATA_0(16), PRDATA(15) => 
        PRDATA_0(15), PRDATA(14) => PRDATA_0(14), PRDATA(13) => 
        PRDATA_0(13), PRDATA(12) => PRDATA_0(12), PRDATA(11) => 
        PRDATA_0(11), PRDATA(10) => PRDATA_0(10), PRDATA(9) => 
        PRDATA_0(9), PRDATA(8) => PRDATA_0(8), PRDATA(7) => 
        PRDATA_0(7), PRDATA(6) => PRDATA_0(6), PRDATA(5) => 
        PRDATA_0(5), PRDATA(4) => PRDATA_0(4), PRDATA(3) => 
        PRDATA_0(3), PRDATA(2) => PRDATA_0(2), PRDATA(1) => 
        PRDATA_0(1), PRDATA(0) => PRDATA_0(0), INPUT(63) => 
        \CIC_1_OUTPUT_0_[31]\, INPUT(62) => \CIC_1_OUTPUT_0_[30]\, 
        INPUT(61) => \CIC_1_OUTPUT_0_[29]\, INPUT(60) => 
        \CIC_1_OUTPUT_0_[28]\, INPUT(59) => \CIC_1_OUTPUT_0_[27]\, 
        INPUT(58) => \CIC_1_OUTPUT_0_[26]\, INPUT(57) => 
        \CIC_1_OUTPUT_0_[25]\, INPUT(56) => \CIC_1_OUTPUT_0_[24]\, 
        INPUT(55) => \CIC_1_OUTPUT_0_[23]\, INPUT(54) => 
        \CIC_1_OUTPUT_0_[22]\, INPUT(53) => \CIC_1_OUTPUT_0_[21]\, 
        INPUT(52) => \CIC_1_OUTPUT_0_[20]\, INPUT(51) => 
        \CIC_1_OUTPUT_0_[19]\, INPUT(50) => \CIC_1_OUTPUT_0_[18]\, 
        INPUT(49) => \CIC_1_OUTPUT_0_[17]\, INPUT(48) => 
        \CIC_1_OUTPUT_0_[16]\, INPUT(47) => \CIC_1_OUTPUT_0_[15]\, 
        INPUT(46) => \CIC_1_OUTPUT_0_[14]\, INPUT(45) => 
        \CIC_1_OUTPUT_0_[13]\, INPUT(44) => \CIC_1_OUTPUT_0_[12]\, 
        INPUT(43) => \CIC_1_OUTPUT_0_[11]\, INPUT(42) => 
        \CIC_1_OUTPUT_0_[10]\, INPUT(41) => \CIC_1_OUTPUT_0_[9]\, 
        INPUT(40) => \CIC_1_OUTPUT_0_[8]\, INPUT(39) => 
        \CIC_1_OUTPUT_0_[7]\, INPUT(38) => \CIC_1_OUTPUT_0_[6]\, 
        INPUT(37) => \CIC_1_OUTPUT_0_[5]\, INPUT(36) => 
        \CIC_1_OUTPUT_0_[4]\, INPUT(35) => \CIC_1_OUTPUT_0_[3]\, 
        INPUT(34) => \CIC_1_OUTPUT_0_[2]\, INPUT(33) => 
        \CIC_1_OUTPUT_0_[1]\, INPUT(32) => \CIC_1_OUTPUT_0_[0]\, 
        INPUT(31) => \CIC_0_OUTPUT_0_[31]\, INPUT(30) => 
        \CIC_0_OUTPUT_0_[30]\, INPUT(29) => \CIC_0_OUTPUT_0_[29]\, 
        INPUT(28) => \CIC_0_OUTPUT_0_[28]\, INPUT(27) => 
        \CIC_0_OUTPUT_0_[27]\, INPUT(26) => \CIC_0_OUTPUT_0_[26]\, 
        INPUT(25) => \CIC_0_OUTPUT_0_[25]\, INPUT(24) => 
        \CIC_0_OUTPUT_0_[24]\, INPUT(23) => \CIC_0_OUTPUT_0_[23]\, 
        INPUT(22) => \CIC_0_OUTPUT_0_[22]\, INPUT(21) => 
        \CIC_0_OUTPUT_0_[21]\, INPUT(20) => \CIC_0_OUTPUT_0_[20]\, 
        INPUT(19) => \CIC_0_OUTPUT_0_[19]\, INPUT(18) => 
        \CIC_0_OUTPUT_0_[18]\, INPUT(17) => \CIC_0_OUTPUT_0_[17]\, 
        INPUT(16) => \CIC_0_OUTPUT_0_[16]\, INPUT(15) => 
        \CIC_0_OUTPUT_0_[15]\, INPUT(14) => \CIC_0_OUTPUT_0_[14]\, 
        INPUT(13) => \CIC_0_OUTPUT_0_[13]\, INPUT(12) => 
        \CIC_0_OUTPUT_0_[12]\, INPUT(11) => \CIC_0_OUTPUT_0_[11]\, 
        INPUT(10) => \CIC_0_OUTPUT_0_[10]\, INPUT(9) => 
        \CIC_0_OUTPUT_0_[9]\, INPUT(8) => \CIC_0_OUTPUT_0_[8]\, 
        INPUT(7) => \CIC_0_OUTPUT_0_[7]\, INPUT(6) => 
        \CIC_0_OUTPUT_0_[6]\, INPUT(5) => \CIC_0_OUTPUT_0_[5]\, 
        INPUT(4) => \CIC_0_OUTPUT_0_[4]\, INPUT(3) => 
        \CIC_0_OUTPUT_0_[3]\, INPUT(2) => \CIC_0_OUTPUT_0_[2]\, 
        INPUT(1) => \CIC_0_OUTPUT_0_[1]\, INPUT(0) => 
        \CIC_0_OUTPUT_0_[0]\, SMPL_RDY_IN(1) => CIC_0_SMPL_RDY, 
        SMPL_RDY_IN(2) => CIC_1_SMPL_RDY);
    
    CIC_1 : CIC
      port map(CLK => CLK, RST => RST, SMPL_RDY => CIC_1_SMPL_RDY, 
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
        \complex_mult_0_Q_0_[0]\, OUTPUT(31) => 
        \CIC_1_OUTPUT_0_[31]\, OUTPUT(30) => 
        \CIC_1_OUTPUT_0_[30]\, OUTPUT(29) => 
        \CIC_1_OUTPUT_0_[29]\, OUTPUT(28) => 
        \CIC_1_OUTPUT_0_[28]\, OUTPUT(27) => 
        \CIC_1_OUTPUT_0_[27]\, OUTPUT(26) => 
        \CIC_1_OUTPUT_0_[26]\, OUTPUT(25) => 
        \CIC_1_OUTPUT_0_[25]\, OUTPUT(24) => 
        \CIC_1_OUTPUT_0_[24]\, OUTPUT(23) => 
        \CIC_1_OUTPUT_0_[23]\, OUTPUT(22) => 
        \CIC_1_OUTPUT_0_[22]\, OUTPUT(21) => 
        \CIC_1_OUTPUT_0_[21]\, OUTPUT(20) => 
        \CIC_1_OUTPUT_0_[20]\, OUTPUT(19) => 
        \CIC_1_OUTPUT_0_[19]\, OUTPUT(18) => 
        \CIC_1_OUTPUT_0_[18]\, OUTPUT(17) => 
        \CIC_1_OUTPUT_0_[17]\, OUTPUT(16) => 
        \CIC_1_OUTPUT_0_[16]\, OUTPUT(15) => 
        \CIC_1_OUTPUT_0_[15]\, OUTPUT(14) => 
        \CIC_1_OUTPUT_0_[14]\, OUTPUT(13) => 
        \CIC_1_OUTPUT_0_[13]\, OUTPUT(12) => 
        \CIC_1_OUTPUT_0_[12]\, OUTPUT(11) => 
        \CIC_1_OUTPUT_0_[11]\, OUTPUT(10) => 
        \CIC_1_OUTPUT_0_[10]\, OUTPUT(9) => \CIC_1_OUTPUT_0_[9]\, 
        OUTPUT(8) => \CIC_1_OUTPUT_0_[8]\, OUTPUT(7) => 
        \CIC_1_OUTPUT_0_[7]\, OUTPUT(6) => \CIC_1_OUTPUT_0_[6]\, 
        OUTPUT(5) => \CIC_1_OUTPUT_0_[5]\, OUTPUT(4) => 
        \CIC_1_OUTPUT_0_[4]\, OUTPUT(3) => \CIC_1_OUTPUT_0_[3]\, 
        OUTPUT(2) => \CIC_1_OUTPUT_0_[2]\, OUTPUT(1) => 
        \CIC_1_OUTPUT_0_[1]\, OUTPUT(0) => \CIC_1_OUTPUT_0_[0]\);
    
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
        \sincos_gen_0_SIN_OUT_1_[7]\, SIN_OUT(6) => 
        \sincos_gen_0_SIN_OUT_1_[6]\, SIN_OUT(5) => 
        \sincos_gen_0_SIN_OUT_1_[5]\, SIN_OUT(4) => 
        \sincos_gen_0_SIN_OUT_1_[4]\, SIN_OUT(3) => 
        \sincos_gen_0_SIN_OUT_1_[3]\, SIN_OUT(2) => 
        \sincos_gen_0_SIN_OUT_1_[2]\, SIN_OUT(1) => 
        \sincos_gen_0_SIN_OUT_1_[1]\, SIN_OUT(0) => 
        \sincos_gen_0_SIN_OUT_1_[0]\);
    
    INV_0 : INV
      port map(A => RST, Y => INV_0_Y);
    
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
        \sincos_gen_0_COS_OUT_0_[0]\, I_B(13) => I_B(13), I_B(12)
         => I_B(12), I_B(11) => I_B(11), I_B(10) => I_B(10), 
        I_B(9) => I_B(9), I_B(8) => I_B(8), I_B(7) => I_B(7), 
        I_B(6) => I_B(6), I_B(5) => I_B(5), I_B(4) => I_B(4), 
        I_B(3) => I_B(3), I_B(2) => I_B(2), I_B(1) => I_B(1), 
        I_B(0) => I_B(0), Q_A(7) => \sincos_gen_0_SIN_OUT_1_[7]\, 
        Q_A(6) => \sincos_gen_0_SIN_OUT_1_[6]\, Q_A(5) => 
        \sincos_gen_0_SIN_OUT_1_[5]\, Q_A(4) => 
        \sincos_gen_0_SIN_OUT_1_[4]\, Q_A(3) => 
        \sincos_gen_0_SIN_OUT_1_[3]\, Q_A(2) => 
        \sincos_gen_0_SIN_OUT_1_[2]\, Q_A(1) => 
        \sincos_gen_0_SIN_OUT_1_[1]\, Q_A(0) => 
        \sincos_gen_0_SIN_OUT_1_[0]\, Q_B(13) => Q_B(13), Q_B(12)
         => Q_B(12), Q_B(11) => Q_B(11), Q_B(10) => Q_B(10), 
        Q_B(9) => Q_B(9), Q_B(8) => Q_B(8), Q_B(7) => Q_B(7), 
        Q_B(6) => Q_B(6), Q_B(5) => Q_B(5), Q_B(4) => Q_B(4), 
        Q_B(3) => Q_B(3), Q_B(2) => Q_B(2), Q_B(1) => Q_B(1), 
        Q_B(0) => Q_B(0));
    
    CIC_0 : CIC
      port map(CLK => CLK, RST => RST, SMPL_RDY => CIC_0_SMPL_RDY, 
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
        \complex_mult_0_I_0_[0]\, OUTPUT(31) => 
        \CIC_0_OUTPUT_0_[31]\, OUTPUT(30) => 
        \CIC_0_OUTPUT_0_[30]\, OUTPUT(29) => 
        \CIC_0_OUTPUT_0_[29]\, OUTPUT(28) => 
        \CIC_0_OUTPUT_0_[28]\, OUTPUT(27) => 
        \CIC_0_OUTPUT_0_[27]\, OUTPUT(26) => 
        \CIC_0_OUTPUT_0_[26]\, OUTPUT(25) => 
        \CIC_0_OUTPUT_0_[25]\, OUTPUT(24) => 
        \CIC_0_OUTPUT_0_[24]\, OUTPUT(23) => 
        \CIC_0_OUTPUT_0_[23]\, OUTPUT(22) => 
        \CIC_0_OUTPUT_0_[22]\, OUTPUT(21) => 
        \CIC_0_OUTPUT_0_[21]\, OUTPUT(20) => 
        \CIC_0_OUTPUT_0_[20]\, OUTPUT(19) => 
        \CIC_0_OUTPUT_0_[19]\, OUTPUT(18) => 
        \CIC_0_OUTPUT_0_[18]\, OUTPUT(17) => 
        \CIC_0_OUTPUT_0_[17]\, OUTPUT(16) => 
        \CIC_0_OUTPUT_0_[16]\, OUTPUT(15) => 
        \CIC_0_OUTPUT_0_[15]\, OUTPUT(14) => 
        \CIC_0_OUTPUT_0_[14]\, OUTPUT(13) => 
        \CIC_0_OUTPUT_0_[13]\, OUTPUT(12) => 
        \CIC_0_OUTPUT_0_[12]\, OUTPUT(11) => 
        \CIC_0_OUTPUT_0_[11]\, OUTPUT(10) => 
        \CIC_0_OUTPUT_0_[10]\, OUTPUT(9) => \CIC_0_OUTPUT_0_[9]\, 
        OUTPUT(8) => \CIC_0_OUTPUT_0_[8]\, OUTPUT(7) => 
        \CIC_0_OUTPUT_0_[7]\, OUTPUT(6) => \CIC_0_OUTPUT_0_[6]\, 
        OUTPUT(5) => \CIC_0_OUTPUT_0_[5]\, OUTPUT(4) => 
        \CIC_0_OUTPUT_0_[4]\, OUTPUT(3) => \CIC_0_OUTPUT_0_[3]\, 
        OUTPUT(2) => \CIC_0_OUTPUT_0_[2]\, OUTPUT(1) => 
        \CIC_0_OUTPUT_0_[1]\, OUTPUT(0) => \CIC_0_OUTPUT_0_[0]\);
    

end DEF_ARCH; 
