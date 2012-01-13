-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity top is

    port( MSS_RESET_N : in    std_logic;
          INPUT       : in    std_logic;
          OUTPUT      : out   std_logic
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
          M2F_RESET_N : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component FIR
    port( CLK    : in    std_logic := 'U';
          RST    : in    std_logic := 'U';
          INPUT  : in    std_logic_vector(21 downto 0) := (others => 'U');
          OUTPUT : out   std_logic_vector(46 downto 0)
        );
  end component;

    signal \FIR_0_OUTPUT_[46]\, \FIR_0_OUTPUT_[45]\, 
        \FIR_0_OUTPUT_[44]\, \FIR_0_OUTPUT_[43]\, 
        \FIR_0_OUTPUT_[42]\, \FIR_0_OUTPUT_[41]\, 
        \FIR_0_OUTPUT_[40]\, \FIR_0_OUTPUT_[39]\, 
        \FIR_0_OUTPUT_[38]\, \FIR_0_OUTPUT_[37]\, 
        \FIR_0_OUTPUT_[36]\, \FIR_0_OUTPUT_[35]\, 
        \FIR_0_OUTPUT_[34]\, \FIR_0_OUTPUT_[33]\, 
        \FIR_0_OUTPUT_[32]\, \FIR_0_OUTPUT_[31]\, 
        \FIR_0_OUTPUT_[30]\, \FIR_0_OUTPUT_[29]\, 
        \FIR_0_OUTPUT_[28]\, \FIR_0_OUTPUT_[27]\, 
        \FIR_0_OUTPUT_[26]\, \FIR_0_OUTPUT_[25]\, 
        \FIR_0_OUTPUT_[24]\, \FIR_0_OUTPUT_[23]\, 
        \FIR_0_OUTPUT_[22]\, \FIR_0_OUTPUT_[21]\, 
        \FIR_0_OUTPUT_[20]\, \FIR_0_OUTPUT_[19]\, 
        \FIR_0_OUTPUT_[18]\, \FIR_0_OUTPUT_[17]\, 
        \FIR_0_OUTPUT_[16]\, \FIR_0_OUTPUT_[15]\, 
        \FIR_0_OUTPUT_[14]\, \FIR_0_OUTPUT_[13]\, 
        \FIR_0_OUTPUT_[12]\, \FIR_0_OUTPUT_[11]\, 
        \FIR_0_OUTPUT_[10]\, \FIR_0_OUTPUT_[9]\, 
        \FIR_0_OUTPUT_[8]\, \FIR_0_OUTPUT_[7]\, 
        \FIR_0_OUTPUT_[6]\, \FIR_0_OUTPUT_[5]\, 
        \FIR_0_OUTPUT_[4]\, \FIR_0_OUTPUT_[3]\, 
        \FIR_0_OUTPUT_[2]\, \FIR_0_OUTPUT_[1]\, 
        \FIR_0_OUTPUT_[0]\, \test_in_0_OUTPUT_[21]\, 
        \test_in_0_OUTPUT_[20]\, \test_in_0_OUTPUT_[19]\, 
        \test_in_0_OUTPUT_[18]\, \test_in_0_OUTPUT_[17]\, 
        \test_in_0_OUTPUT_[16]\, \test_in_0_OUTPUT_[15]\, 
        \test_in_0_OUTPUT_[14]\, \test_in_0_OUTPUT_[13]\, 
        \test_in_0_OUTPUT_[12]\, \test_in_0_OUTPUT_[11]\, 
        \test_in_0_OUTPUT_[10]\, \test_in_0_OUTPUT_[9]\, 
        \test_in_0_OUTPUT_[8]\, \test_in_0_OUTPUT_[7]\, 
        \test_in_0_OUTPUT_[6]\, \test_in_0_OUTPUT_[5]\, 
        \test_in_0_OUTPUT_[4]\, \test_in_0_OUTPUT_[3]\, 
        \test_in_0_OUTPUT_[2]\, \test_in_0_OUTPUT_[1]\, 
        \test_in_0_OUTPUT_[0]\, uC_0_FAB_CLK, uC_0_M2F_RESET_N, 
        GND_net, VCC_net : std_logic;

begin 


    test_0 : entity work.test
      port map(OUTPUT => OUTPUT, INPUT(46) => \FIR_0_OUTPUT_[46]\, 
        INPUT(45) => \FIR_0_OUTPUT_[45]\, INPUT(44) => 
        \FIR_0_OUTPUT_[44]\, INPUT(43) => \FIR_0_OUTPUT_[43]\, 
        INPUT(42) => \FIR_0_OUTPUT_[42]\, INPUT(41) => 
        \FIR_0_OUTPUT_[41]\, INPUT(40) => \FIR_0_OUTPUT_[40]\, 
        INPUT(39) => \FIR_0_OUTPUT_[39]\, INPUT(38) => 
        \FIR_0_OUTPUT_[38]\, INPUT(37) => \FIR_0_OUTPUT_[37]\, 
        INPUT(36) => \FIR_0_OUTPUT_[36]\, INPUT(35) => 
        \FIR_0_OUTPUT_[35]\, INPUT(34) => \FIR_0_OUTPUT_[34]\, 
        INPUT(33) => \FIR_0_OUTPUT_[33]\, INPUT(32) => 
        \FIR_0_OUTPUT_[32]\, INPUT(31) => \FIR_0_OUTPUT_[31]\, 
        INPUT(30) => \FIR_0_OUTPUT_[30]\, INPUT(29) => 
        \FIR_0_OUTPUT_[29]\, INPUT(28) => \FIR_0_OUTPUT_[28]\, 
        INPUT(27) => \FIR_0_OUTPUT_[27]\, INPUT(26) => 
        \FIR_0_OUTPUT_[26]\, INPUT(25) => \FIR_0_OUTPUT_[25]\, 
        INPUT(24) => \FIR_0_OUTPUT_[24]\, INPUT(23) => 
        \FIR_0_OUTPUT_[23]\, INPUT(22) => \FIR_0_OUTPUT_[22]\, 
        INPUT(21) => \FIR_0_OUTPUT_[21]\, INPUT(20) => 
        \FIR_0_OUTPUT_[20]\, INPUT(19) => \FIR_0_OUTPUT_[19]\, 
        INPUT(18) => \FIR_0_OUTPUT_[18]\, INPUT(17) => 
        \FIR_0_OUTPUT_[17]\, INPUT(16) => \FIR_0_OUTPUT_[16]\, 
        INPUT(15) => \FIR_0_OUTPUT_[15]\, INPUT(14) => 
        \FIR_0_OUTPUT_[14]\, INPUT(13) => \FIR_0_OUTPUT_[13]\, 
        INPUT(12) => \FIR_0_OUTPUT_[12]\, INPUT(11) => 
        \FIR_0_OUTPUT_[11]\, INPUT(10) => \FIR_0_OUTPUT_[10]\, 
        INPUT(9) => \FIR_0_OUTPUT_[9]\, INPUT(8) => 
        \FIR_0_OUTPUT_[8]\, INPUT(7) => \FIR_0_OUTPUT_[7]\, 
        INPUT(6) => \FIR_0_OUTPUT_[6]\, INPUT(5) => 
        \FIR_0_OUTPUT_[5]\, INPUT(4) => \FIR_0_OUTPUT_[4]\, 
        INPUT(3) => \FIR_0_OUTPUT_[3]\, INPUT(2) => 
        \FIR_0_OUTPUT_[2]\, INPUT(1) => \FIR_0_OUTPUT_[1]\, 
        INPUT(0) => \FIR_0_OUTPUT_[0]\);
    
    \VCC\ : VCC
      port map(Y => VCC_net);
    
    uC_0 : uC
      port map(MSS_RESET_N => MSS_RESET_N, FAB_CLK => 
        uC_0_FAB_CLK, M2F_RESET_N => uC_0_M2F_RESET_N);
    
    test_in_0 : entity work.test_in
      port map(INPUT => INPUT, OUTPUT(21) => 
        \test_in_0_OUTPUT_[21]\, OUTPUT(20) => 
        \test_in_0_OUTPUT_[20]\, OUTPUT(19) => 
        \test_in_0_OUTPUT_[19]\, OUTPUT(18) => 
        \test_in_0_OUTPUT_[18]\, OUTPUT(17) => 
        \test_in_0_OUTPUT_[17]\, OUTPUT(16) => 
        \test_in_0_OUTPUT_[16]\, OUTPUT(15) => 
        \test_in_0_OUTPUT_[15]\, OUTPUT(14) => 
        \test_in_0_OUTPUT_[14]\, OUTPUT(13) => 
        \test_in_0_OUTPUT_[13]\, OUTPUT(12) => 
        \test_in_0_OUTPUT_[12]\, OUTPUT(11) => 
        \test_in_0_OUTPUT_[11]\, OUTPUT(10) => 
        \test_in_0_OUTPUT_[10]\, OUTPUT(9) => 
        \test_in_0_OUTPUT_[9]\, OUTPUT(8) => 
        \test_in_0_OUTPUT_[8]\, OUTPUT(7) => 
        \test_in_0_OUTPUT_[7]\, OUTPUT(6) => 
        \test_in_0_OUTPUT_[6]\, OUTPUT(5) => 
        \test_in_0_OUTPUT_[5]\, OUTPUT(4) => 
        \test_in_0_OUTPUT_[4]\, OUTPUT(3) => 
        \test_in_0_OUTPUT_[3]\, OUTPUT(2) => 
        \test_in_0_OUTPUT_[2]\, OUTPUT(1) => 
        \test_in_0_OUTPUT_[1]\, OUTPUT(0) => 
        \test_in_0_OUTPUT_[0]\);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    FIR_0 : FIR
      port map(CLK => uC_0_FAB_CLK, RST => uC_0_M2F_RESET_N, 
        INPUT(21) => \test_in_0_OUTPUT_[21]\, INPUT(20) => 
        \test_in_0_OUTPUT_[20]\, INPUT(19) => 
        \test_in_0_OUTPUT_[19]\, INPUT(18) => 
        \test_in_0_OUTPUT_[18]\, INPUT(17) => 
        \test_in_0_OUTPUT_[17]\, INPUT(16) => 
        \test_in_0_OUTPUT_[16]\, INPUT(15) => 
        \test_in_0_OUTPUT_[15]\, INPUT(14) => 
        \test_in_0_OUTPUT_[14]\, INPUT(13) => 
        \test_in_0_OUTPUT_[13]\, INPUT(12) => 
        \test_in_0_OUTPUT_[12]\, INPUT(11) => 
        \test_in_0_OUTPUT_[11]\, INPUT(10) => 
        \test_in_0_OUTPUT_[10]\, INPUT(9) => 
        \test_in_0_OUTPUT_[9]\, INPUT(8) => 
        \test_in_0_OUTPUT_[8]\, INPUT(7) => 
        \test_in_0_OUTPUT_[7]\, INPUT(6) => 
        \test_in_0_OUTPUT_[6]\, INPUT(5) => 
        \test_in_0_OUTPUT_[5]\, INPUT(4) => 
        \test_in_0_OUTPUT_[4]\, INPUT(3) => 
        \test_in_0_OUTPUT_[3]\, INPUT(2) => 
        \test_in_0_OUTPUT_[2]\, INPUT(1) => 
        \test_in_0_OUTPUT_[1]\, INPUT(0) => 
        \test_in_0_OUTPUT_[0]\, OUTPUT(46) => \FIR_0_OUTPUT_[46]\, 
        OUTPUT(45) => \FIR_0_OUTPUT_[45]\, OUTPUT(44) => 
        \FIR_0_OUTPUT_[44]\, OUTPUT(43) => \FIR_0_OUTPUT_[43]\, 
        OUTPUT(42) => \FIR_0_OUTPUT_[42]\, OUTPUT(41) => 
        \FIR_0_OUTPUT_[41]\, OUTPUT(40) => \FIR_0_OUTPUT_[40]\, 
        OUTPUT(39) => \FIR_0_OUTPUT_[39]\, OUTPUT(38) => 
        \FIR_0_OUTPUT_[38]\, OUTPUT(37) => \FIR_0_OUTPUT_[37]\, 
        OUTPUT(36) => \FIR_0_OUTPUT_[36]\, OUTPUT(35) => 
        \FIR_0_OUTPUT_[35]\, OUTPUT(34) => \FIR_0_OUTPUT_[34]\, 
        OUTPUT(33) => \FIR_0_OUTPUT_[33]\, OUTPUT(32) => 
        \FIR_0_OUTPUT_[32]\, OUTPUT(31) => \FIR_0_OUTPUT_[31]\, 
        OUTPUT(30) => \FIR_0_OUTPUT_[30]\, OUTPUT(29) => 
        \FIR_0_OUTPUT_[29]\, OUTPUT(28) => \FIR_0_OUTPUT_[28]\, 
        OUTPUT(27) => \FIR_0_OUTPUT_[27]\, OUTPUT(26) => 
        \FIR_0_OUTPUT_[26]\, OUTPUT(25) => \FIR_0_OUTPUT_[25]\, 
        OUTPUT(24) => \FIR_0_OUTPUT_[24]\, OUTPUT(23) => 
        \FIR_0_OUTPUT_[23]\, OUTPUT(22) => \FIR_0_OUTPUT_[22]\, 
        OUTPUT(21) => \FIR_0_OUTPUT_[21]\, OUTPUT(20) => 
        \FIR_0_OUTPUT_[20]\, OUTPUT(19) => \FIR_0_OUTPUT_[19]\, 
        OUTPUT(18) => \FIR_0_OUTPUT_[18]\, OUTPUT(17) => 
        \FIR_0_OUTPUT_[17]\, OUTPUT(16) => \FIR_0_OUTPUT_[16]\, 
        OUTPUT(15) => \FIR_0_OUTPUT_[15]\, OUTPUT(14) => 
        \FIR_0_OUTPUT_[14]\, OUTPUT(13) => \FIR_0_OUTPUT_[13]\, 
        OUTPUT(12) => \FIR_0_OUTPUT_[12]\, OUTPUT(11) => 
        \FIR_0_OUTPUT_[11]\, OUTPUT(10) => \FIR_0_OUTPUT_[10]\, 
        OUTPUT(9) => \FIR_0_OUTPUT_[9]\, OUTPUT(8) => 
        \FIR_0_OUTPUT_[8]\, OUTPUT(7) => \FIR_0_OUTPUT_[7]\, 
        OUTPUT(6) => \FIR_0_OUTPUT_[6]\, OUTPUT(5) => 
        \FIR_0_OUTPUT_[5]\, OUTPUT(4) => \FIR_0_OUTPUT_[4]\, 
        OUTPUT(3) => \FIR_0_OUTPUT_[3]\, OUTPUT(2) => 
        \FIR_0_OUTPUT_[2]\, OUTPUT(1) => \FIR_0_OUTPUT_[1]\, 
        OUTPUT(0) => \FIR_0_OUTPUT_[0]\);
    

end DEF_ARCH; 