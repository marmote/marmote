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

  component CIC_int_mem
    port( WD    : in    std_logic_vector(53 downto 0) := (others => 'U');
          RD    : out   std_logic_vector(53 downto 0);
          WEN   : in    std_logic := 'U';
          REN   : in    std_logic := 'U';
          WADDR : in    std_logic_vector(2 downto 0) := (others => 'U');
          RADDR : in    std_logic_vector(2 downto 0) := (others => 'U');
          RWCLK : in    std_logic := 'U';
          RESET : in    std_logic := 'U'
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CIC_comb_mem
    port( WD    : in    std_logic_vector(26 downto 0) := (others => 'U');
          RD    : out   std_logic_vector(26 downto 0);
          WEN   : in    std_logic := 'U';
          REN   : in    std_logic := 'U';
          WADDR : in    std_logic_vector(4 downto 0) := (others => 'U');
          RADDR : in    std_logic_vector(4 downto 0) := (others => 'U');
          RWCLK : in    std_logic := 'U';
          RESET : in    std_logic := 'U'
        );
  end component;

    signal \CIC_comb_mem_0_RD_[26]\, \CIC_comb_mem_0_RD_[25]\, 
        \CIC_comb_mem_0_RD_[24]\, \CIC_comb_mem_0_RD_[23]\, 
        \CIC_comb_mem_0_RD_[22]\, \CIC_comb_mem_0_RD_[21]\, 
        \CIC_comb_mem_0_RD_[20]\, \CIC_comb_mem_0_RD_[19]\, 
        \CIC_comb_mem_0_RD_[18]\, \CIC_comb_mem_0_RD_[17]\, 
        \CIC_comb_mem_0_RD_[16]\, \CIC_comb_mem_0_RD_[15]\, 
        \CIC_comb_mem_0_RD_[14]\, \CIC_comb_mem_0_RD_[13]\, 
        \CIC_comb_mem_0_RD_[12]\, \CIC_comb_mem_0_RD_[11]\, 
        \CIC_comb_mem_0_RD_[10]\, \CIC_comb_mem_0_RD_[9]\, 
        \CIC_comb_mem_0_RD_[8]\, \CIC_comb_mem_0_RD_[7]\, 
        \CIC_comb_mem_0_RD_[6]\, \CIC_comb_mem_0_RD_[5]\, 
        \CIC_comb_mem_0_RD_[4]\, \CIC_comb_mem_0_RD_[3]\, 
        \CIC_comb_mem_0_RD_[2]\, \CIC_comb_mem_0_RD_[1]\, 
        \CIC_comb_mem_0_RD_[0]\, \CIC_control_0_RADDR_C_1_[4]\, 
        \CIC_control_0_RADDR_C_1_[3]\, 
        \CIC_control_0_RADDR_C_1_[2]\, 
        \CIC_control_0_RADDR_C_1_[1]\, 
        \CIC_control_0_RADDR_C_1_[0]\, 
        \CIC_control_0_RADDR_I_[2]\, \CIC_control_0_RADDR_I_[1]\, 
        \CIC_control_0_RADDR_I_[0]\, CIC_control_0_REN_C, 
        CIC_control_0_REN_I, \CIC_control_0_WADDR_C_1_[4]\, 
        \CIC_control_0_WADDR_C_1_[3]\, 
        \CIC_control_0_WADDR_C_1_[2]\, 
        \CIC_control_0_WADDR_C_1_[1]\, 
        \CIC_control_0_WADDR_C_1_[0]\, 
        \CIC_control_0_WADDR_I_[2]\, \CIC_control_0_WADDR_I_[1]\, 
        \CIC_control_0_WADDR_I_[0]\, \CIC_control_0_WD_C_[26]\, 
        \CIC_control_0_WD_C_[25]\, \CIC_control_0_WD_C_[24]\, 
        \CIC_control_0_WD_C_[23]\, \CIC_control_0_WD_C_[22]\, 
        \CIC_control_0_WD_C_[21]\, \CIC_control_0_WD_C_[20]\, 
        \CIC_control_0_WD_C_[19]\, \CIC_control_0_WD_C_[18]\, 
        \CIC_control_0_WD_C_[17]\, \CIC_control_0_WD_C_[16]\, 
        \CIC_control_0_WD_C_[15]\, \CIC_control_0_WD_C_[14]\, 
        \CIC_control_0_WD_C_[13]\, \CIC_control_0_WD_C_[12]\, 
        \CIC_control_0_WD_C_[11]\, \CIC_control_0_WD_C_[10]\, 
        \CIC_control_0_WD_C_[9]\, \CIC_control_0_WD_C_[8]\, 
        \CIC_control_0_WD_C_[7]\, \CIC_control_0_WD_C_[6]\, 
        \CIC_control_0_WD_C_[5]\, \CIC_control_0_WD_C_[4]\, 
        \CIC_control_0_WD_C_[3]\, \CIC_control_0_WD_C_[2]\, 
        \CIC_control_0_WD_C_[1]\, \CIC_control_0_WD_C_[0]\, 
        \CIC_control_0_WD_I_[53]\, \CIC_control_0_WD_I_[52]\, 
        \CIC_control_0_WD_I_[51]\, \CIC_control_0_WD_I_[50]\, 
        \CIC_control_0_WD_I_[49]\, \CIC_control_0_WD_I_[48]\, 
        \CIC_control_0_WD_I_[47]\, \CIC_control_0_WD_I_[46]\, 
        \CIC_control_0_WD_I_[45]\, \CIC_control_0_WD_I_[44]\, 
        \CIC_control_0_WD_I_[43]\, \CIC_control_0_WD_I_[42]\, 
        \CIC_control_0_WD_I_[41]\, \CIC_control_0_WD_I_[40]\, 
        \CIC_control_0_WD_I_[39]\, \CIC_control_0_WD_I_[38]\, 
        \CIC_control_0_WD_I_[37]\, \CIC_control_0_WD_I_[36]\, 
        \CIC_control_0_WD_I_[35]\, \CIC_control_0_WD_I_[34]\, 
        \CIC_control_0_WD_I_[33]\, \CIC_control_0_WD_I_[32]\, 
        \CIC_control_0_WD_I_[31]\, \CIC_control_0_WD_I_[30]\, 
        \CIC_control_0_WD_I_[29]\, \CIC_control_0_WD_I_[28]\, 
        \CIC_control_0_WD_I_[27]\, \CIC_control_0_WD_I_[26]\, 
        \CIC_control_0_WD_I_[25]\, \CIC_control_0_WD_I_[24]\, 
        \CIC_control_0_WD_I_[23]\, \CIC_control_0_WD_I_[22]\, 
        \CIC_control_0_WD_I_[21]\, \CIC_control_0_WD_I_[20]\, 
        \CIC_control_0_WD_I_[19]\, \CIC_control_0_WD_I_[18]\, 
        \CIC_control_0_WD_I_[17]\, \CIC_control_0_WD_I_[16]\, 
        \CIC_control_0_WD_I_[15]\, \CIC_control_0_WD_I_[14]\, 
        \CIC_control_0_WD_I_[13]\, \CIC_control_0_WD_I_[12]\, 
        \CIC_control_0_WD_I_[11]\, \CIC_control_0_WD_I_[10]\, 
        \CIC_control_0_WD_I_[9]\, \CIC_control_0_WD_I_[8]\, 
        \CIC_control_0_WD_I_[7]\, \CIC_control_0_WD_I_[6]\, 
        \CIC_control_0_WD_I_[5]\, \CIC_control_0_WD_I_[4]\, 
        \CIC_control_0_WD_I_[3]\, \CIC_control_0_WD_I_[2]\, 
        \CIC_control_0_WD_I_[1]\, \CIC_control_0_WD_I_[0]\, 
        CIC_control_0_WEN_C, CIC_control_0_WEN_I, 
        \CIC_int_mem_0_RD_[53]\, \CIC_int_mem_0_RD_[52]\, 
        \CIC_int_mem_0_RD_[51]\, \CIC_int_mem_0_RD_[50]\, 
        \CIC_int_mem_0_RD_[49]\, \CIC_int_mem_0_RD_[48]\, 
        \CIC_int_mem_0_RD_[47]\, \CIC_int_mem_0_RD_[46]\, 
        \CIC_int_mem_0_RD_[45]\, \CIC_int_mem_0_RD_[44]\, 
        \CIC_int_mem_0_RD_[43]\, \CIC_int_mem_0_RD_[42]\, 
        \CIC_int_mem_0_RD_[41]\, \CIC_int_mem_0_RD_[40]\, 
        \CIC_int_mem_0_RD_[39]\, \CIC_int_mem_0_RD_[38]\, 
        \CIC_int_mem_0_RD_[37]\, \CIC_int_mem_0_RD_[36]\, 
        \CIC_int_mem_0_RD_[35]\, \CIC_int_mem_0_RD_[34]\, 
        \CIC_int_mem_0_RD_[33]\, \CIC_int_mem_0_RD_[32]\, 
        \CIC_int_mem_0_RD_[31]\, \CIC_int_mem_0_RD_[30]\, 
        \CIC_int_mem_0_RD_[29]\, \CIC_int_mem_0_RD_[28]\, 
        \CIC_int_mem_0_RD_[27]\, \CIC_int_mem_0_RD_[26]\, 
        \CIC_int_mem_0_RD_[25]\, \CIC_int_mem_0_RD_[24]\, 
        \CIC_int_mem_0_RD_[23]\, \CIC_int_mem_0_RD_[22]\, 
        \CIC_int_mem_0_RD_[21]\, \CIC_int_mem_0_RD_[20]\, 
        \CIC_int_mem_0_RD_[19]\, \CIC_int_mem_0_RD_[18]\, 
        \CIC_int_mem_0_RD_[17]\, \CIC_int_mem_0_RD_[16]\, 
        \CIC_int_mem_0_RD_[15]\, \CIC_int_mem_0_RD_[14]\, 
        \CIC_int_mem_0_RD_[13]\, \CIC_int_mem_0_RD_[12]\, 
        \CIC_int_mem_0_RD_[11]\, \CIC_int_mem_0_RD_[10]\, 
        \CIC_int_mem_0_RD_[9]\, \CIC_int_mem_0_RD_[8]\, 
        \CIC_int_mem_0_RD_[7]\, \CIC_int_mem_0_RD_[6]\, 
        \CIC_int_mem_0_RD_[5]\, \CIC_int_mem_0_RD_[4]\, 
        \CIC_int_mem_0_RD_[3]\, \CIC_int_mem_0_RD_[2]\, 
        \CIC_int_mem_0_RD_[1]\, \CIC_int_mem_0_RD_[0]\, GND_net, 
        VCC_net : std_logic;

begin 


    CIC_int_mem_0 : CIC_int_mem
      port map(WD(53) => \CIC_control_0_WD_I_[53]\, WD(52) => 
        \CIC_control_0_WD_I_[52]\, WD(51) => 
        \CIC_control_0_WD_I_[51]\, WD(50) => 
        \CIC_control_0_WD_I_[50]\, WD(49) => 
        \CIC_control_0_WD_I_[49]\, WD(48) => 
        \CIC_control_0_WD_I_[48]\, WD(47) => 
        \CIC_control_0_WD_I_[47]\, WD(46) => 
        \CIC_control_0_WD_I_[46]\, WD(45) => 
        \CIC_control_0_WD_I_[45]\, WD(44) => 
        \CIC_control_0_WD_I_[44]\, WD(43) => 
        \CIC_control_0_WD_I_[43]\, WD(42) => 
        \CIC_control_0_WD_I_[42]\, WD(41) => 
        \CIC_control_0_WD_I_[41]\, WD(40) => 
        \CIC_control_0_WD_I_[40]\, WD(39) => 
        \CIC_control_0_WD_I_[39]\, WD(38) => 
        \CIC_control_0_WD_I_[38]\, WD(37) => 
        \CIC_control_0_WD_I_[37]\, WD(36) => 
        \CIC_control_0_WD_I_[36]\, WD(35) => 
        \CIC_control_0_WD_I_[35]\, WD(34) => 
        \CIC_control_0_WD_I_[34]\, WD(33) => 
        \CIC_control_0_WD_I_[33]\, WD(32) => 
        \CIC_control_0_WD_I_[32]\, WD(31) => 
        \CIC_control_0_WD_I_[31]\, WD(30) => 
        \CIC_control_0_WD_I_[30]\, WD(29) => 
        \CIC_control_0_WD_I_[29]\, WD(28) => 
        \CIC_control_0_WD_I_[28]\, WD(27) => 
        \CIC_control_0_WD_I_[27]\, WD(26) => 
        \CIC_control_0_WD_I_[26]\, WD(25) => 
        \CIC_control_0_WD_I_[25]\, WD(24) => 
        \CIC_control_0_WD_I_[24]\, WD(23) => 
        \CIC_control_0_WD_I_[23]\, WD(22) => 
        \CIC_control_0_WD_I_[22]\, WD(21) => 
        \CIC_control_0_WD_I_[21]\, WD(20) => 
        \CIC_control_0_WD_I_[20]\, WD(19) => 
        \CIC_control_0_WD_I_[19]\, WD(18) => 
        \CIC_control_0_WD_I_[18]\, WD(17) => 
        \CIC_control_0_WD_I_[17]\, WD(16) => 
        \CIC_control_0_WD_I_[16]\, WD(15) => 
        \CIC_control_0_WD_I_[15]\, WD(14) => 
        \CIC_control_0_WD_I_[14]\, WD(13) => 
        \CIC_control_0_WD_I_[13]\, WD(12) => 
        \CIC_control_0_WD_I_[12]\, WD(11) => 
        \CIC_control_0_WD_I_[11]\, WD(10) => 
        \CIC_control_0_WD_I_[10]\, WD(9) => 
        \CIC_control_0_WD_I_[9]\, WD(8) => 
        \CIC_control_0_WD_I_[8]\, WD(7) => 
        \CIC_control_0_WD_I_[7]\, WD(6) => 
        \CIC_control_0_WD_I_[6]\, WD(5) => 
        \CIC_control_0_WD_I_[5]\, WD(4) => 
        \CIC_control_0_WD_I_[4]\, WD(3) => 
        \CIC_control_0_WD_I_[3]\, WD(2) => 
        \CIC_control_0_WD_I_[2]\, WD(1) => 
        \CIC_control_0_WD_I_[1]\, WD(0) => 
        \CIC_control_0_WD_I_[0]\, RD(53) => 
        \CIC_int_mem_0_RD_[53]\, RD(52) => 
        \CIC_int_mem_0_RD_[52]\, RD(51) => 
        \CIC_int_mem_0_RD_[51]\, RD(50) => 
        \CIC_int_mem_0_RD_[50]\, RD(49) => 
        \CIC_int_mem_0_RD_[49]\, RD(48) => 
        \CIC_int_mem_0_RD_[48]\, RD(47) => 
        \CIC_int_mem_0_RD_[47]\, RD(46) => 
        \CIC_int_mem_0_RD_[46]\, RD(45) => 
        \CIC_int_mem_0_RD_[45]\, RD(44) => 
        \CIC_int_mem_0_RD_[44]\, RD(43) => 
        \CIC_int_mem_0_RD_[43]\, RD(42) => 
        \CIC_int_mem_0_RD_[42]\, RD(41) => 
        \CIC_int_mem_0_RD_[41]\, RD(40) => 
        \CIC_int_mem_0_RD_[40]\, RD(39) => 
        \CIC_int_mem_0_RD_[39]\, RD(38) => 
        \CIC_int_mem_0_RD_[38]\, RD(37) => 
        \CIC_int_mem_0_RD_[37]\, RD(36) => 
        \CIC_int_mem_0_RD_[36]\, RD(35) => 
        \CIC_int_mem_0_RD_[35]\, RD(34) => 
        \CIC_int_mem_0_RD_[34]\, RD(33) => 
        \CIC_int_mem_0_RD_[33]\, RD(32) => 
        \CIC_int_mem_0_RD_[32]\, RD(31) => 
        \CIC_int_mem_0_RD_[31]\, RD(30) => 
        \CIC_int_mem_0_RD_[30]\, RD(29) => 
        \CIC_int_mem_0_RD_[29]\, RD(28) => 
        \CIC_int_mem_0_RD_[28]\, RD(27) => 
        \CIC_int_mem_0_RD_[27]\, RD(26) => 
        \CIC_int_mem_0_RD_[26]\, RD(25) => 
        \CIC_int_mem_0_RD_[25]\, RD(24) => 
        \CIC_int_mem_0_RD_[24]\, RD(23) => 
        \CIC_int_mem_0_RD_[23]\, RD(22) => 
        \CIC_int_mem_0_RD_[22]\, RD(21) => 
        \CIC_int_mem_0_RD_[21]\, RD(20) => 
        \CIC_int_mem_0_RD_[20]\, RD(19) => 
        \CIC_int_mem_0_RD_[19]\, RD(18) => 
        \CIC_int_mem_0_RD_[18]\, RD(17) => 
        \CIC_int_mem_0_RD_[17]\, RD(16) => 
        \CIC_int_mem_0_RD_[16]\, RD(15) => 
        \CIC_int_mem_0_RD_[15]\, RD(14) => 
        \CIC_int_mem_0_RD_[14]\, RD(13) => 
        \CIC_int_mem_0_RD_[13]\, RD(12) => 
        \CIC_int_mem_0_RD_[12]\, RD(11) => 
        \CIC_int_mem_0_RD_[11]\, RD(10) => 
        \CIC_int_mem_0_RD_[10]\, RD(9) => \CIC_int_mem_0_RD_[9]\, 
        RD(8) => \CIC_int_mem_0_RD_[8]\, RD(7) => 
        \CIC_int_mem_0_RD_[7]\, RD(6) => \CIC_int_mem_0_RD_[6]\, 
        RD(5) => \CIC_int_mem_0_RD_[5]\, RD(4) => 
        \CIC_int_mem_0_RD_[4]\, RD(3) => \CIC_int_mem_0_RD_[3]\, 
        RD(2) => \CIC_int_mem_0_RD_[2]\, RD(1) => 
        \CIC_int_mem_0_RD_[1]\, RD(0) => \CIC_int_mem_0_RD_[0]\, 
        WEN => CIC_control_0_WEN_I, REN => CIC_control_0_REN_I, 
        WADDR(2) => \CIC_control_0_WADDR_I_[2]\, WADDR(1) => 
        \CIC_control_0_WADDR_I_[1]\, WADDR(0) => 
        \CIC_control_0_WADDR_I_[0]\, RADDR(2) => 
        \CIC_control_0_RADDR_I_[2]\, RADDR(1) => 
        \CIC_control_0_RADDR_I_[1]\, RADDR(0) => 
        \CIC_control_0_RADDR_I_[0]\, RWCLK => CLK, RESET => RST);
    
    \VCC\ : VCC
      port map(Y => VCC_net);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    CIC_control_0 : entity work.CIC_control
      port map(CLK => CLK, RST => RST, WD_I(53) => 
        \CIC_control_0_WD_I_[53]\, WD_I(52) => 
        \CIC_control_0_WD_I_[52]\, WD_I(51) => 
        \CIC_control_0_WD_I_[51]\, WD_I(50) => 
        \CIC_control_0_WD_I_[50]\, WD_I(49) => 
        \CIC_control_0_WD_I_[49]\, WD_I(48) => 
        \CIC_control_0_WD_I_[48]\, WD_I(47) => 
        \CIC_control_0_WD_I_[47]\, WD_I(46) => 
        \CIC_control_0_WD_I_[46]\, WD_I(45) => 
        \CIC_control_0_WD_I_[45]\, WD_I(44) => 
        \CIC_control_0_WD_I_[44]\, WD_I(43) => 
        \CIC_control_0_WD_I_[43]\, WD_I(42) => 
        \CIC_control_0_WD_I_[42]\, WD_I(41) => 
        \CIC_control_0_WD_I_[41]\, WD_I(40) => 
        \CIC_control_0_WD_I_[40]\, WD_I(39) => 
        \CIC_control_0_WD_I_[39]\, WD_I(38) => 
        \CIC_control_0_WD_I_[38]\, WD_I(37) => 
        \CIC_control_0_WD_I_[37]\, WD_I(36) => 
        \CIC_control_0_WD_I_[36]\, WD_I(35) => 
        \CIC_control_0_WD_I_[35]\, WD_I(34) => 
        \CIC_control_0_WD_I_[34]\, WD_I(33) => 
        \CIC_control_0_WD_I_[33]\, WD_I(32) => 
        \CIC_control_0_WD_I_[32]\, WD_I(31) => 
        \CIC_control_0_WD_I_[31]\, WD_I(30) => 
        \CIC_control_0_WD_I_[30]\, WD_I(29) => 
        \CIC_control_0_WD_I_[29]\, WD_I(28) => 
        \CIC_control_0_WD_I_[28]\, WD_I(27) => 
        \CIC_control_0_WD_I_[27]\, WD_I(26) => 
        \CIC_control_0_WD_I_[26]\, WD_I(25) => 
        \CIC_control_0_WD_I_[25]\, WD_I(24) => 
        \CIC_control_0_WD_I_[24]\, WD_I(23) => 
        \CIC_control_0_WD_I_[23]\, WD_I(22) => 
        \CIC_control_0_WD_I_[22]\, WD_I(21) => 
        \CIC_control_0_WD_I_[21]\, WD_I(20) => 
        \CIC_control_0_WD_I_[20]\, WD_I(19) => 
        \CIC_control_0_WD_I_[19]\, WD_I(18) => 
        \CIC_control_0_WD_I_[18]\, WD_I(17) => 
        \CIC_control_0_WD_I_[17]\, WD_I(16) => 
        \CIC_control_0_WD_I_[16]\, WD_I(15) => 
        \CIC_control_0_WD_I_[15]\, WD_I(14) => 
        \CIC_control_0_WD_I_[14]\, WD_I(13) => 
        \CIC_control_0_WD_I_[13]\, WD_I(12) => 
        \CIC_control_0_WD_I_[12]\, WD_I(11) => 
        \CIC_control_0_WD_I_[11]\, WD_I(10) => 
        \CIC_control_0_WD_I_[10]\, WD_I(9) => 
        \CIC_control_0_WD_I_[9]\, WD_I(8) => 
        \CIC_control_0_WD_I_[8]\, WD_I(7) => 
        \CIC_control_0_WD_I_[7]\, WD_I(6) => 
        \CIC_control_0_WD_I_[6]\, WD_I(5) => 
        \CIC_control_0_WD_I_[5]\, WD_I(4) => 
        \CIC_control_0_WD_I_[4]\, WD_I(3) => 
        \CIC_control_0_WD_I_[3]\, WD_I(2) => 
        \CIC_control_0_WD_I_[2]\, WD_I(1) => 
        \CIC_control_0_WD_I_[1]\, WD_I(0) => 
        \CIC_control_0_WD_I_[0]\, WADDR_I(2) => 
        \CIC_control_0_WADDR_I_[2]\, WADDR_I(1) => 
        \CIC_control_0_WADDR_I_[1]\, WADDR_I(0) => 
        \CIC_control_0_WADDR_I_[0]\, RADDR_I(2) => 
        \CIC_control_0_RADDR_I_[2]\, RADDR_I(1) => 
        \CIC_control_0_RADDR_I_[1]\, RADDR_I(0) => 
        \CIC_control_0_RADDR_I_[0]\, WEN_I => CIC_control_0_WEN_I, 
        REN_I => CIC_control_0_REN_I, RD_I(53) => 
        \CIC_int_mem_0_RD_[53]\, RD_I(52) => 
        \CIC_int_mem_0_RD_[52]\, RD_I(51) => 
        \CIC_int_mem_0_RD_[51]\, RD_I(50) => 
        \CIC_int_mem_0_RD_[50]\, RD_I(49) => 
        \CIC_int_mem_0_RD_[49]\, RD_I(48) => 
        \CIC_int_mem_0_RD_[48]\, RD_I(47) => 
        \CIC_int_mem_0_RD_[47]\, RD_I(46) => 
        \CIC_int_mem_0_RD_[46]\, RD_I(45) => 
        \CIC_int_mem_0_RD_[45]\, RD_I(44) => 
        \CIC_int_mem_0_RD_[44]\, RD_I(43) => 
        \CIC_int_mem_0_RD_[43]\, RD_I(42) => 
        \CIC_int_mem_0_RD_[42]\, RD_I(41) => 
        \CIC_int_mem_0_RD_[41]\, RD_I(40) => 
        \CIC_int_mem_0_RD_[40]\, RD_I(39) => 
        \CIC_int_mem_0_RD_[39]\, RD_I(38) => 
        \CIC_int_mem_0_RD_[38]\, RD_I(37) => 
        \CIC_int_mem_0_RD_[37]\, RD_I(36) => 
        \CIC_int_mem_0_RD_[36]\, RD_I(35) => 
        \CIC_int_mem_0_RD_[35]\, RD_I(34) => 
        \CIC_int_mem_0_RD_[34]\, RD_I(33) => 
        \CIC_int_mem_0_RD_[33]\, RD_I(32) => 
        \CIC_int_mem_0_RD_[32]\, RD_I(31) => 
        \CIC_int_mem_0_RD_[31]\, RD_I(30) => 
        \CIC_int_mem_0_RD_[30]\, RD_I(29) => 
        \CIC_int_mem_0_RD_[29]\, RD_I(28) => 
        \CIC_int_mem_0_RD_[28]\, RD_I(27) => 
        \CIC_int_mem_0_RD_[27]\, RD_I(26) => 
        \CIC_int_mem_0_RD_[26]\, RD_I(25) => 
        \CIC_int_mem_0_RD_[25]\, RD_I(24) => 
        \CIC_int_mem_0_RD_[24]\, RD_I(23) => 
        \CIC_int_mem_0_RD_[23]\, RD_I(22) => 
        \CIC_int_mem_0_RD_[22]\, RD_I(21) => 
        \CIC_int_mem_0_RD_[21]\, RD_I(20) => 
        \CIC_int_mem_0_RD_[20]\, RD_I(19) => 
        \CIC_int_mem_0_RD_[19]\, RD_I(18) => 
        \CIC_int_mem_0_RD_[18]\, RD_I(17) => 
        \CIC_int_mem_0_RD_[17]\, RD_I(16) => 
        \CIC_int_mem_0_RD_[16]\, RD_I(15) => 
        \CIC_int_mem_0_RD_[15]\, RD_I(14) => 
        \CIC_int_mem_0_RD_[14]\, RD_I(13) => 
        \CIC_int_mem_0_RD_[13]\, RD_I(12) => 
        \CIC_int_mem_0_RD_[12]\, RD_I(11) => 
        \CIC_int_mem_0_RD_[11]\, RD_I(10) => 
        \CIC_int_mem_0_RD_[10]\, RD_I(9) => 
        \CIC_int_mem_0_RD_[9]\, RD_I(8) => \CIC_int_mem_0_RD_[8]\, 
        RD_I(7) => \CIC_int_mem_0_RD_[7]\, RD_I(6) => 
        \CIC_int_mem_0_RD_[6]\, RD_I(5) => \CIC_int_mem_0_RD_[5]\, 
        RD_I(4) => \CIC_int_mem_0_RD_[4]\, RD_I(3) => 
        \CIC_int_mem_0_RD_[3]\, RD_I(2) => \CIC_int_mem_0_RD_[2]\, 
        RD_I(1) => \CIC_int_mem_0_RD_[1]\, RD_I(0) => 
        \CIC_int_mem_0_RD_[0]\, WD_C(26) => 
        \CIC_control_0_WD_C_[26]\, WD_C(25) => 
        \CIC_control_0_WD_C_[25]\, WD_C(24) => 
        \CIC_control_0_WD_C_[24]\, WD_C(23) => 
        \CIC_control_0_WD_C_[23]\, WD_C(22) => 
        \CIC_control_0_WD_C_[22]\, WD_C(21) => 
        \CIC_control_0_WD_C_[21]\, WD_C(20) => 
        \CIC_control_0_WD_C_[20]\, WD_C(19) => 
        \CIC_control_0_WD_C_[19]\, WD_C(18) => 
        \CIC_control_0_WD_C_[18]\, WD_C(17) => 
        \CIC_control_0_WD_C_[17]\, WD_C(16) => 
        \CIC_control_0_WD_C_[16]\, WD_C(15) => 
        \CIC_control_0_WD_C_[15]\, WD_C(14) => 
        \CIC_control_0_WD_C_[14]\, WD_C(13) => 
        \CIC_control_0_WD_C_[13]\, WD_C(12) => 
        \CIC_control_0_WD_C_[12]\, WD_C(11) => 
        \CIC_control_0_WD_C_[11]\, WD_C(10) => 
        \CIC_control_0_WD_C_[10]\, WD_C(9) => 
        \CIC_control_0_WD_C_[9]\, WD_C(8) => 
        \CIC_control_0_WD_C_[8]\, WD_C(7) => 
        \CIC_control_0_WD_C_[7]\, WD_C(6) => 
        \CIC_control_0_WD_C_[6]\, WD_C(5) => 
        \CIC_control_0_WD_C_[5]\, WD_C(4) => 
        \CIC_control_0_WD_C_[4]\, WD_C(3) => 
        \CIC_control_0_WD_C_[3]\, WD_C(2) => 
        \CIC_control_0_WD_C_[2]\, WD_C(1) => 
        \CIC_control_0_WD_C_[1]\, WD_C(0) => 
        \CIC_control_0_WD_C_[0]\, WADDR_C(4) => 
        \CIC_control_0_WADDR_C_1_[4]\, WADDR_C(3) => 
        \CIC_control_0_WADDR_C_1_[3]\, WADDR_C(2) => 
        \CIC_control_0_WADDR_C_1_[2]\, WADDR_C(1) => 
        \CIC_control_0_WADDR_C_1_[1]\, WADDR_C(0) => 
        \CIC_control_0_WADDR_C_1_[0]\, RADDR_C(4) => 
        \CIC_control_0_RADDR_C_1_[4]\, RADDR_C(3) => 
        \CIC_control_0_RADDR_C_1_[3]\, RADDR_C(2) => 
        \CIC_control_0_RADDR_C_1_[2]\, RADDR_C(1) => 
        \CIC_control_0_RADDR_C_1_[1]\, RADDR_C(0) => 
        \CIC_control_0_RADDR_C_1_[0]\, WEN_C => 
        CIC_control_0_WEN_C, REN_C => CIC_control_0_REN_C, 
        RD_C(26) => \CIC_comb_mem_0_RD_[26]\, RD_C(25) => 
        \CIC_comb_mem_0_RD_[25]\, RD_C(24) => 
        \CIC_comb_mem_0_RD_[24]\, RD_C(23) => 
        \CIC_comb_mem_0_RD_[23]\, RD_C(22) => 
        \CIC_comb_mem_0_RD_[22]\, RD_C(21) => 
        \CIC_comb_mem_0_RD_[21]\, RD_C(20) => 
        \CIC_comb_mem_0_RD_[20]\, RD_C(19) => 
        \CIC_comb_mem_0_RD_[19]\, RD_C(18) => 
        \CIC_comb_mem_0_RD_[18]\, RD_C(17) => 
        \CIC_comb_mem_0_RD_[17]\, RD_C(16) => 
        \CIC_comb_mem_0_RD_[16]\, RD_C(15) => 
        \CIC_comb_mem_0_RD_[15]\, RD_C(14) => 
        \CIC_comb_mem_0_RD_[14]\, RD_C(13) => 
        \CIC_comb_mem_0_RD_[13]\, RD_C(12) => 
        \CIC_comb_mem_0_RD_[12]\, RD_C(11) => 
        \CIC_comb_mem_0_RD_[11]\, RD_C(10) => 
        \CIC_comb_mem_0_RD_[10]\, RD_C(9) => 
        \CIC_comb_mem_0_RD_[9]\, RD_C(8) => 
        \CIC_comb_mem_0_RD_[8]\, RD_C(7) => 
        \CIC_comb_mem_0_RD_[7]\, RD_C(6) => 
        \CIC_comb_mem_0_RD_[6]\, RD_C(5) => 
        \CIC_comb_mem_0_RD_[5]\, RD_C(4) => 
        \CIC_comb_mem_0_RD_[4]\, RD_C(3) => 
        \CIC_comb_mem_0_RD_[3]\, RD_C(2) => 
        \CIC_comb_mem_0_RD_[2]\, RD_C(1) => 
        \CIC_comb_mem_0_RD_[1]\, RD_C(0) => 
        \CIC_comb_mem_0_RD_[0]\, INPUT(21) => INPUT(21), 
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
    
    CIC_comb_mem_0 : CIC_comb_mem
      port map(WD(26) => \CIC_control_0_WD_C_[26]\, WD(25) => 
        \CIC_control_0_WD_C_[25]\, WD(24) => 
        \CIC_control_0_WD_C_[24]\, WD(23) => 
        \CIC_control_0_WD_C_[23]\, WD(22) => 
        \CIC_control_0_WD_C_[22]\, WD(21) => 
        \CIC_control_0_WD_C_[21]\, WD(20) => 
        \CIC_control_0_WD_C_[20]\, WD(19) => 
        \CIC_control_0_WD_C_[19]\, WD(18) => 
        \CIC_control_0_WD_C_[18]\, WD(17) => 
        \CIC_control_0_WD_C_[17]\, WD(16) => 
        \CIC_control_0_WD_C_[16]\, WD(15) => 
        \CIC_control_0_WD_C_[15]\, WD(14) => 
        \CIC_control_0_WD_C_[14]\, WD(13) => 
        \CIC_control_0_WD_C_[13]\, WD(12) => 
        \CIC_control_0_WD_C_[12]\, WD(11) => 
        \CIC_control_0_WD_C_[11]\, WD(10) => 
        \CIC_control_0_WD_C_[10]\, WD(9) => 
        \CIC_control_0_WD_C_[9]\, WD(8) => 
        \CIC_control_0_WD_C_[8]\, WD(7) => 
        \CIC_control_0_WD_C_[7]\, WD(6) => 
        \CIC_control_0_WD_C_[6]\, WD(5) => 
        \CIC_control_0_WD_C_[5]\, WD(4) => 
        \CIC_control_0_WD_C_[4]\, WD(3) => 
        \CIC_control_0_WD_C_[3]\, WD(2) => 
        \CIC_control_0_WD_C_[2]\, WD(1) => 
        \CIC_control_0_WD_C_[1]\, WD(0) => 
        \CIC_control_0_WD_C_[0]\, RD(26) => 
        \CIC_comb_mem_0_RD_[26]\, RD(25) => 
        \CIC_comb_mem_0_RD_[25]\, RD(24) => 
        \CIC_comb_mem_0_RD_[24]\, RD(23) => 
        \CIC_comb_mem_0_RD_[23]\, RD(22) => 
        \CIC_comb_mem_0_RD_[22]\, RD(21) => 
        \CIC_comb_mem_0_RD_[21]\, RD(20) => 
        \CIC_comb_mem_0_RD_[20]\, RD(19) => 
        \CIC_comb_mem_0_RD_[19]\, RD(18) => 
        \CIC_comb_mem_0_RD_[18]\, RD(17) => 
        \CIC_comb_mem_0_RD_[17]\, RD(16) => 
        \CIC_comb_mem_0_RD_[16]\, RD(15) => 
        \CIC_comb_mem_0_RD_[15]\, RD(14) => 
        \CIC_comb_mem_0_RD_[14]\, RD(13) => 
        \CIC_comb_mem_0_RD_[13]\, RD(12) => 
        \CIC_comb_mem_0_RD_[12]\, RD(11) => 
        \CIC_comb_mem_0_RD_[11]\, RD(10) => 
        \CIC_comb_mem_0_RD_[10]\, RD(9) => 
        \CIC_comb_mem_0_RD_[9]\, RD(8) => \CIC_comb_mem_0_RD_[8]\, 
        RD(7) => \CIC_comb_mem_0_RD_[7]\, RD(6) => 
        \CIC_comb_mem_0_RD_[6]\, RD(5) => \CIC_comb_mem_0_RD_[5]\, 
        RD(4) => \CIC_comb_mem_0_RD_[4]\, RD(3) => 
        \CIC_comb_mem_0_RD_[3]\, RD(2) => \CIC_comb_mem_0_RD_[2]\, 
        RD(1) => \CIC_comb_mem_0_RD_[1]\, RD(0) => 
        \CIC_comb_mem_0_RD_[0]\, WEN => CIC_control_0_WEN_C, REN
         => CIC_control_0_REN_C, WADDR(4) => 
        \CIC_control_0_WADDR_C_1_[4]\, WADDR(3) => 
        \CIC_control_0_WADDR_C_1_[3]\, WADDR(2) => 
        \CIC_control_0_WADDR_C_1_[2]\, WADDR(1) => 
        \CIC_control_0_WADDR_C_1_[1]\, WADDR(0) => 
        \CIC_control_0_WADDR_C_1_[0]\, RADDR(4) => 
        \CIC_control_0_RADDR_C_1_[4]\, RADDR(3) => 
        \CIC_control_0_RADDR_C_1_[3]\, RADDR(2) => 
        \CIC_control_0_RADDR_C_1_[2]\, RADDR(1) => 
        \CIC_control_0_RADDR_C_1_[1]\, RADDR(0) => 
        \CIC_control_0_RADDR_C_1_[0]\, RWCLK => CLK, RESET => RST);
    

end DEF_ARCH; 
