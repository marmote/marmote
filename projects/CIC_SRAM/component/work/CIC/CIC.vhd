-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity CIC is

    port( RST    : in    std_logic;
          CLK    : in    std_logic;
          INPUT  : in    std_logic_vector(21 downto 0);
          OUTPUT : out   std_logic_vector(46 downto 0)
        );

end CIC;

architecture DEF_ARCH of CIC is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CIC_regs
    port( DINA  : in    std_logic_vector(46 downto 0) := (others => 'U');
          DOUTA : out   std_logic_vector(46 downto 0);
          DINB  : in    std_logic_vector(46 downto 0) := (others => 'U');
          DOUTB : out   std_logic_vector(46 downto 0);
          ADDRA : in    std_logic_vector(3 downto 0) := (others => 'U');
          ADDRB : in    std_logic_vector(3 downto 0) := (others => 'U');
          RWA   : in    std_logic := 'U';
          RWB   : in    std_logic := 'U';
          BLKA  : in    std_logic := 'U';
          BLKB  : in    std_logic := 'U';
          CLKAB : in    std_logic := 'U';
          RESET : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \CIC_control_0_ADDRA_0_[3]\, 
        \CIC_control_0_ADDRA_0_[2]\, \CIC_control_0_ADDRA_0_[1]\, 
        \CIC_control_0_ADDRA_0_[0]\, \CIC_control_0_ADDRB_0_[3]\, 
        \CIC_control_0_ADDRB_0_[2]\, \CIC_control_0_ADDRB_0_[1]\, 
        \CIC_control_0_ADDRB_0_[0]\, CIC_control_0_BLKA, 
        CIC_control_0_BLKB, \CIC_control_0_DINA_0_[46]\, 
        \CIC_control_0_DINA_0_[45]\, \CIC_control_0_DINA_0_[44]\, 
        \CIC_control_0_DINA_0_[43]\, \CIC_control_0_DINA_0_[42]\, 
        \CIC_control_0_DINA_0_[41]\, \CIC_control_0_DINA_0_[40]\, 
        \CIC_control_0_DINA_0_[39]\, \CIC_control_0_DINA_0_[38]\, 
        \CIC_control_0_DINA_0_[37]\, \CIC_control_0_DINA_0_[36]\, 
        \CIC_control_0_DINA_0_[35]\, \CIC_control_0_DINA_0_[34]\, 
        \CIC_control_0_DINA_0_[33]\, \CIC_control_0_DINA_0_[32]\, 
        \CIC_control_0_DINA_0_[31]\, \CIC_control_0_DINA_0_[30]\, 
        \CIC_control_0_DINA_0_[29]\, \CIC_control_0_DINA_0_[28]\, 
        \CIC_control_0_DINA_0_[27]\, \CIC_control_0_DINA_0_[26]\, 
        \CIC_control_0_DINA_0_[25]\, \CIC_control_0_DINA_0_[24]\, 
        \CIC_control_0_DINA_0_[23]\, \CIC_control_0_DINA_0_[22]\, 
        \CIC_control_0_DINA_0_[21]\, \CIC_control_0_DINA_0_[20]\, 
        \CIC_control_0_DINA_0_[19]\, \CIC_control_0_DINA_0_[18]\, 
        \CIC_control_0_DINA_0_[17]\, \CIC_control_0_DINA_0_[16]\, 
        \CIC_control_0_DINA_0_[15]\, \CIC_control_0_DINA_0_[14]\, 
        \CIC_control_0_DINA_0_[13]\, \CIC_control_0_DINA_0_[12]\, 
        \CIC_control_0_DINA_0_[11]\, \CIC_control_0_DINA_0_[10]\, 
        \CIC_control_0_DINA_0_[9]\, \CIC_control_0_DINA_0_[8]\, 
        \CIC_control_0_DINA_0_[7]\, \CIC_control_0_DINA_0_[6]\, 
        \CIC_control_0_DINA_0_[5]\, \CIC_control_0_DINA_0_[4]\, 
        \CIC_control_0_DINA_0_[3]\, \CIC_control_0_DINA_0_[2]\, 
        \CIC_control_0_DINA_0_[1]\, \CIC_control_0_DINA_0_[0]\, 
        \CIC_control_0_DINB_0_[46]\, \CIC_control_0_DINB_0_[45]\, 
        \CIC_control_0_DINB_0_[44]\, \CIC_control_0_DINB_0_[43]\, 
        \CIC_control_0_DINB_0_[42]\, \CIC_control_0_DINB_0_[41]\, 
        \CIC_control_0_DINB_0_[40]\, \CIC_control_0_DINB_0_[39]\, 
        \CIC_control_0_DINB_0_[38]\, \CIC_control_0_DINB_0_[37]\, 
        \CIC_control_0_DINB_0_[36]\, \CIC_control_0_DINB_0_[35]\, 
        \CIC_control_0_DINB_0_[34]\, \CIC_control_0_DINB_0_[33]\, 
        \CIC_control_0_DINB_0_[32]\, \CIC_control_0_DINB_0_[31]\, 
        \CIC_control_0_DINB_0_[30]\, \CIC_control_0_DINB_0_[29]\, 
        \CIC_control_0_DINB_0_[28]\, \CIC_control_0_DINB_0_[27]\, 
        \CIC_control_0_DINB_0_[26]\, \CIC_control_0_DINB_0_[25]\, 
        \CIC_control_0_DINB_0_[24]\, \CIC_control_0_DINB_0_[23]\, 
        \CIC_control_0_DINB_0_[22]\, \CIC_control_0_DINB_0_[21]\, 
        \CIC_control_0_DINB_0_[20]\, \CIC_control_0_DINB_0_[19]\, 
        \CIC_control_0_DINB_0_[18]\, \CIC_control_0_DINB_0_[17]\, 
        \CIC_control_0_DINB_0_[16]\, \CIC_control_0_DINB_0_[15]\, 
        \CIC_control_0_DINB_0_[14]\, \CIC_control_0_DINB_0_[13]\, 
        \CIC_control_0_DINB_0_[12]\, \CIC_control_0_DINB_0_[11]\, 
        \CIC_control_0_DINB_0_[10]\, \CIC_control_0_DINB_0_[9]\, 
        \CIC_control_0_DINB_0_[8]\, \CIC_control_0_DINB_0_[7]\, 
        \CIC_control_0_DINB_0_[6]\, \CIC_control_0_DINB_0_[5]\, 
        \CIC_control_0_DINB_0_[4]\, \CIC_control_0_DINB_0_[3]\, 
        \CIC_control_0_DINB_0_[2]\, \CIC_control_0_DINB_0_[1]\, 
        \CIC_control_0_DINB_0_[0]\, CIC_control_0_RWA, 
        CIC_control_0_RWB, \CIC_regs_0_DOUTA_0_[46]\, 
        \CIC_regs_0_DOUTA_0_[45]\, \CIC_regs_0_DOUTA_0_[44]\, 
        \CIC_regs_0_DOUTA_0_[43]\, \CIC_regs_0_DOUTA_0_[42]\, 
        \CIC_regs_0_DOUTA_0_[41]\, \CIC_regs_0_DOUTA_0_[40]\, 
        \CIC_regs_0_DOUTA_0_[39]\, \CIC_regs_0_DOUTA_0_[38]\, 
        \CIC_regs_0_DOUTA_0_[37]\, \CIC_regs_0_DOUTA_0_[36]\, 
        \CIC_regs_0_DOUTA_0_[35]\, \CIC_regs_0_DOUTA_0_[34]\, 
        \CIC_regs_0_DOUTA_0_[33]\, \CIC_regs_0_DOUTA_0_[32]\, 
        \CIC_regs_0_DOUTA_0_[31]\, \CIC_regs_0_DOUTA_0_[30]\, 
        \CIC_regs_0_DOUTA_0_[29]\, \CIC_regs_0_DOUTA_0_[28]\, 
        \CIC_regs_0_DOUTA_0_[27]\, \CIC_regs_0_DOUTA_0_[26]\, 
        \CIC_regs_0_DOUTA_0_[25]\, \CIC_regs_0_DOUTA_0_[24]\, 
        \CIC_regs_0_DOUTA_0_[23]\, \CIC_regs_0_DOUTA_0_[22]\, 
        \CIC_regs_0_DOUTA_0_[21]\, \CIC_regs_0_DOUTA_0_[20]\, 
        \CIC_regs_0_DOUTA_0_[19]\, \CIC_regs_0_DOUTA_0_[18]\, 
        \CIC_regs_0_DOUTA_0_[17]\, \CIC_regs_0_DOUTA_0_[16]\, 
        \CIC_regs_0_DOUTA_0_[15]\, \CIC_regs_0_DOUTA_0_[14]\, 
        \CIC_regs_0_DOUTA_0_[13]\, \CIC_regs_0_DOUTA_0_[12]\, 
        \CIC_regs_0_DOUTA_0_[11]\, \CIC_regs_0_DOUTA_0_[10]\, 
        \CIC_regs_0_DOUTA_0_[9]\, \CIC_regs_0_DOUTA_0_[8]\, 
        \CIC_regs_0_DOUTA_0_[7]\, \CIC_regs_0_DOUTA_0_[6]\, 
        \CIC_regs_0_DOUTA_0_[5]\, \CIC_regs_0_DOUTA_0_[4]\, 
        \CIC_regs_0_DOUTA_0_[3]\, \CIC_regs_0_DOUTA_0_[2]\, 
        \CIC_regs_0_DOUTA_0_[1]\, \CIC_regs_0_DOUTA_0_[0]\, 
        \CIC_regs_0_DOUTB_0_[46]\, \CIC_regs_0_DOUTB_0_[45]\, 
        \CIC_regs_0_DOUTB_0_[44]\, \CIC_regs_0_DOUTB_0_[43]\, 
        \CIC_regs_0_DOUTB_0_[42]\, \CIC_regs_0_DOUTB_0_[41]\, 
        \CIC_regs_0_DOUTB_0_[40]\, \CIC_regs_0_DOUTB_0_[39]\, 
        \CIC_regs_0_DOUTB_0_[38]\, \CIC_regs_0_DOUTB_0_[37]\, 
        \CIC_regs_0_DOUTB_0_[36]\, \CIC_regs_0_DOUTB_0_[35]\, 
        \CIC_regs_0_DOUTB_0_[34]\, \CIC_regs_0_DOUTB_0_[33]\, 
        \CIC_regs_0_DOUTB_0_[32]\, \CIC_regs_0_DOUTB_0_[31]\, 
        \CIC_regs_0_DOUTB_0_[30]\, \CIC_regs_0_DOUTB_0_[29]\, 
        \CIC_regs_0_DOUTB_0_[28]\, \CIC_regs_0_DOUTB_0_[27]\, 
        \CIC_regs_0_DOUTB_0_[26]\, \CIC_regs_0_DOUTB_0_[25]\, 
        \CIC_regs_0_DOUTB_0_[24]\, \CIC_regs_0_DOUTB_0_[23]\, 
        \CIC_regs_0_DOUTB_0_[22]\, \CIC_regs_0_DOUTB_0_[21]\, 
        \CIC_regs_0_DOUTB_0_[20]\, \CIC_regs_0_DOUTB_0_[19]\, 
        \CIC_regs_0_DOUTB_0_[18]\, \CIC_regs_0_DOUTB_0_[17]\, 
        \CIC_regs_0_DOUTB_0_[16]\, \CIC_regs_0_DOUTB_0_[15]\, 
        \CIC_regs_0_DOUTB_0_[14]\, \CIC_regs_0_DOUTB_0_[13]\, 
        \CIC_regs_0_DOUTB_0_[12]\, \CIC_regs_0_DOUTB_0_[11]\, 
        \CIC_regs_0_DOUTB_0_[10]\, \CIC_regs_0_DOUTB_0_[9]\, 
        \CIC_regs_0_DOUTB_0_[8]\, \CIC_regs_0_DOUTB_0_[7]\, 
        \CIC_regs_0_DOUTB_0_[6]\, \CIC_regs_0_DOUTB_0_[5]\, 
        \CIC_regs_0_DOUTB_0_[4]\, \CIC_regs_0_DOUTB_0_[3]\, 
        \CIC_regs_0_DOUTB_0_[2]\, \CIC_regs_0_DOUTB_0_[1]\, 
        \CIC_regs_0_DOUTB_0_[0]\, GND_net, VCC_net : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net);
    
    CIC_regs_0 : CIC_regs
      port map(DINA(46) => \CIC_control_0_DINA_0_[46]\, DINA(45)
         => \CIC_control_0_DINA_0_[45]\, DINA(44) => 
        \CIC_control_0_DINA_0_[44]\, DINA(43) => 
        \CIC_control_0_DINA_0_[43]\, DINA(42) => 
        \CIC_control_0_DINA_0_[42]\, DINA(41) => 
        \CIC_control_0_DINA_0_[41]\, DINA(40) => 
        \CIC_control_0_DINA_0_[40]\, DINA(39) => 
        \CIC_control_0_DINA_0_[39]\, DINA(38) => 
        \CIC_control_0_DINA_0_[38]\, DINA(37) => 
        \CIC_control_0_DINA_0_[37]\, DINA(36) => 
        \CIC_control_0_DINA_0_[36]\, DINA(35) => 
        \CIC_control_0_DINA_0_[35]\, DINA(34) => 
        \CIC_control_0_DINA_0_[34]\, DINA(33) => 
        \CIC_control_0_DINA_0_[33]\, DINA(32) => 
        \CIC_control_0_DINA_0_[32]\, DINA(31) => 
        \CIC_control_0_DINA_0_[31]\, DINA(30) => 
        \CIC_control_0_DINA_0_[30]\, DINA(29) => 
        \CIC_control_0_DINA_0_[29]\, DINA(28) => 
        \CIC_control_0_DINA_0_[28]\, DINA(27) => 
        \CIC_control_0_DINA_0_[27]\, DINA(26) => 
        \CIC_control_0_DINA_0_[26]\, DINA(25) => 
        \CIC_control_0_DINA_0_[25]\, DINA(24) => 
        \CIC_control_0_DINA_0_[24]\, DINA(23) => 
        \CIC_control_0_DINA_0_[23]\, DINA(22) => 
        \CIC_control_0_DINA_0_[22]\, DINA(21) => 
        \CIC_control_0_DINA_0_[21]\, DINA(20) => 
        \CIC_control_0_DINA_0_[20]\, DINA(19) => 
        \CIC_control_0_DINA_0_[19]\, DINA(18) => 
        \CIC_control_0_DINA_0_[18]\, DINA(17) => 
        \CIC_control_0_DINA_0_[17]\, DINA(16) => 
        \CIC_control_0_DINA_0_[16]\, DINA(15) => 
        \CIC_control_0_DINA_0_[15]\, DINA(14) => 
        \CIC_control_0_DINA_0_[14]\, DINA(13) => 
        \CIC_control_0_DINA_0_[13]\, DINA(12) => 
        \CIC_control_0_DINA_0_[12]\, DINA(11) => 
        \CIC_control_0_DINA_0_[11]\, DINA(10) => 
        \CIC_control_0_DINA_0_[10]\, DINA(9) => 
        \CIC_control_0_DINA_0_[9]\, DINA(8) => 
        \CIC_control_0_DINA_0_[8]\, DINA(7) => 
        \CIC_control_0_DINA_0_[7]\, DINA(6) => 
        \CIC_control_0_DINA_0_[6]\, DINA(5) => 
        \CIC_control_0_DINA_0_[5]\, DINA(4) => 
        \CIC_control_0_DINA_0_[4]\, DINA(3) => 
        \CIC_control_0_DINA_0_[3]\, DINA(2) => 
        \CIC_control_0_DINA_0_[2]\, DINA(1) => 
        \CIC_control_0_DINA_0_[1]\, DINA(0) => 
        \CIC_control_0_DINA_0_[0]\, DOUTA(46) => 
        \CIC_regs_0_DOUTA_0_[46]\, DOUTA(45) => 
        \CIC_regs_0_DOUTA_0_[45]\, DOUTA(44) => 
        \CIC_regs_0_DOUTA_0_[44]\, DOUTA(43) => 
        \CIC_regs_0_DOUTA_0_[43]\, DOUTA(42) => 
        \CIC_regs_0_DOUTA_0_[42]\, DOUTA(41) => 
        \CIC_regs_0_DOUTA_0_[41]\, DOUTA(40) => 
        \CIC_regs_0_DOUTA_0_[40]\, DOUTA(39) => 
        \CIC_regs_0_DOUTA_0_[39]\, DOUTA(38) => 
        \CIC_regs_0_DOUTA_0_[38]\, DOUTA(37) => 
        \CIC_regs_0_DOUTA_0_[37]\, DOUTA(36) => 
        \CIC_regs_0_DOUTA_0_[36]\, DOUTA(35) => 
        \CIC_regs_0_DOUTA_0_[35]\, DOUTA(34) => 
        \CIC_regs_0_DOUTA_0_[34]\, DOUTA(33) => 
        \CIC_regs_0_DOUTA_0_[33]\, DOUTA(32) => 
        \CIC_regs_0_DOUTA_0_[32]\, DOUTA(31) => 
        \CIC_regs_0_DOUTA_0_[31]\, DOUTA(30) => 
        \CIC_regs_0_DOUTA_0_[30]\, DOUTA(29) => 
        \CIC_regs_0_DOUTA_0_[29]\, DOUTA(28) => 
        \CIC_regs_0_DOUTA_0_[28]\, DOUTA(27) => 
        \CIC_regs_0_DOUTA_0_[27]\, DOUTA(26) => 
        \CIC_regs_0_DOUTA_0_[26]\, DOUTA(25) => 
        \CIC_regs_0_DOUTA_0_[25]\, DOUTA(24) => 
        \CIC_regs_0_DOUTA_0_[24]\, DOUTA(23) => 
        \CIC_regs_0_DOUTA_0_[23]\, DOUTA(22) => 
        \CIC_regs_0_DOUTA_0_[22]\, DOUTA(21) => 
        \CIC_regs_0_DOUTA_0_[21]\, DOUTA(20) => 
        \CIC_regs_0_DOUTA_0_[20]\, DOUTA(19) => 
        \CIC_regs_0_DOUTA_0_[19]\, DOUTA(18) => 
        \CIC_regs_0_DOUTA_0_[18]\, DOUTA(17) => 
        \CIC_regs_0_DOUTA_0_[17]\, DOUTA(16) => 
        \CIC_regs_0_DOUTA_0_[16]\, DOUTA(15) => 
        \CIC_regs_0_DOUTA_0_[15]\, DOUTA(14) => 
        \CIC_regs_0_DOUTA_0_[14]\, DOUTA(13) => 
        \CIC_regs_0_DOUTA_0_[13]\, DOUTA(12) => 
        \CIC_regs_0_DOUTA_0_[12]\, DOUTA(11) => 
        \CIC_regs_0_DOUTA_0_[11]\, DOUTA(10) => 
        \CIC_regs_0_DOUTA_0_[10]\, DOUTA(9) => 
        \CIC_regs_0_DOUTA_0_[9]\, DOUTA(8) => 
        \CIC_regs_0_DOUTA_0_[8]\, DOUTA(7) => 
        \CIC_regs_0_DOUTA_0_[7]\, DOUTA(6) => 
        \CIC_regs_0_DOUTA_0_[6]\, DOUTA(5) => 
        \CIC_regs_0_DOUTA_0_[5]\, DOUTA(4) => 
        \CIC_regs_0_DOUTA_0_[4]\, DOUTA(3) => 
        \CIC_regs_0_DOUTA_0_[3]\, DOUTA(2) => 
        \CIC_regs_0_DOUTA_0_[2]\, DOUTA(1) => 
        \CIC_regs_0_DOUTA_0_[1]\, DOUTA(0) => 
        \CIC_regs_0_DOUTA_0_[0]\, DINB(46) => 
        \CIC_control_0_DINB_0_[46]\, DINB(45) => 
        \CIC_control_0_DINB_0_[45]\, DINB(44) => 
        \CIC_control_0_DINB_0_[44]\, DINB(43) => 
        \CIC_control_0_DINB_0_[43]\, DINB(42) => 
        \CIC_control_0_DINB_0_[42]\, DINB(41) => 
        \CIC_control_0_DINB_0_[41]\, DINB(40) => 
        \CIC_control_0_DINB_0_[40]\, DINB(39) => 
        \CIC_control_0_DINB_0_[39]\, DINB(38) => 
        \CIC_control_0_DINB_0_[38]\, DINB(37) => 
        \CIC_control_0_DINB_0_[37]\, DINB(36) => 
        \CIC_control_0_DINB_0_[36]\, DINB(35) => 
        \CIC_control_0_DINB_0_[35]\, DINB(34) => 
        \CIC_control_0_DINB_0_[34]\, DINB(33) => 
        \CIC_control_0_DINB_0_[33]\, DINB(32) => 
        \CIC_control_0_DINB_0_[32]\, DINB(31) => 
        \CIC_control_0_DINB_0_[31]\, DINB(30) => 
        \CIC_control_0_DINB_0_[30]\, DINB(29) => 
        \CIC_control_0_DINB_0_[29]\, DINB(28) => 
        \CIC_control_0_DINB_0_[28]\, DINB(27) => 
        \CIC_control_0_DINB_0_[27]\, DINB(26) => 
        \CIC_control_0_DINB_0_[26]\, DINB(25) => 
        \CIC_control_0_DINB_0_[25]\, DINB(24) => 
        \CIC_control_0_DINB_0_[24]\, DINB(23) => 
        \CIC_control_0_DINB_0_[23]\, DINB(22) => 
        \CIC_control_0_DINB_0_[22]\, DINB(21) => 
        \CIC_control_0_DINB_0_[21]\, DINB(20) => 
        \CIC_control_0_DINB_0_[20]\, DINB(19) => 
        \CIC_control_0_DINB_0_[19]\, DINB(18) => 
        \CIC_control_0_DINB_0_[18]\, DINB(17) => 
        \CIC_control_0_DINB_0_[17]\, DINB(16) => 
        \CIC_control_0_DINB_0_[16]\, DINB(15) => 
        \CIC_control_0_DINB_0_[15]\, DINB(14) => 
        \CIC_control_0_DINB_0_[14]\, DINB(13) => 
        \CIC_control_0_DINB_0_[13]\, DINB(12) => 
        \CIC_control_0_DINB_0_[12]\, DINB(11) => 
        \CIC_control_0_DINB_0_[11]\, DINB(10) => 
        \CIC_control_0_DINB_0_[10]\, DINB(9) => 
        \CIC_control_0_DINB_0_[9]\, DINB(8) => 
        \CIC_control_0_DINB_0_[8]\, DINB(7) => 
        \CIC_control_0_DINB_0_[7]\, DINB(6) => 
        \CIC_control_0_DINB_0_[6]\, DINB(5) => 
        \CIC_control_0_DINB_0_[5]\, DINB(4) => 
        \CIC_control_0_DINB_0_[4]\, DINB(3) => 
        \CIC_control_0_DINB_0_[3]\, DINB(2) => 
        \CIC_control_0_DINB_0_[2]\, DINB(1) => 
        \CIC_control_0_DINB_0_[1]\, DINB(0) => 
        \CIC_control_0_DINB_0_[0]\, DOUTB(46) => 
        \CIC_regs_0_DOUTB_0_[46]\, DOUTB(45) => 
        \CIC_regs_0_DOUTB_0_[45]\, DOUTB(44) => 
        \CIC_regs_0_DOUTB_0_[44]\, DOUTB(43) => 
        \CIC_regs_0_DOUTB_0_[43]\, DOUTB(42) => 
        \CIC_regs_0_DOUTB_0_[42]\, DOUTB(41) => 
        \CIC_regs_0_DOUTB_0_[41]\, DOUTB(40) => 
        \CIC_regs_0_DOUTB_0_[40]\, DOUTB(39) => 
        \CIC_regs_0_DOUTB_0_[39]\, DOUTB(38) => 
        \CIC_regs_0_DOUTB_0_[38]\, DOUTB(37) => 
        \CIC_regs_0_DOUTB_0_[37]\, DOUTB(36) => 
        \CIC_regs_0_DOUTB_0_[36]\, DOUTB(35) => 
        \CIC_regs_0_DOUTB_0_[35]\, DOUTB(34) => 
        \CIC_regs_0_DOUTB_0_[34]\, DOUTB(33) => 
        \CIC_regs_0_DOUTB_0_[33]\, DOUTB(32) => 
        \CIC_regs_0_DOUTB_0_[32]\, DOUTB(31) => 
        \CIC_regs_0_DOUTB_0_[31]\, DOUTB(30) => 
        \CIC_regs_0_DOUTB_0_[30]\, DOUTB(29) => 
        \CIC_regs_0_DOUTB_0_[29]\, DOUTB(28) => 
        \CIC_regs_0_DOUTB_0_[28]\, DOUTB(27) => 
        \CIC_regs_0_DOUTB_0_[27]\, DOUTB(26) => 
        \CIC_regs_0_DOUTB_0_[26]\, DOUTB(25) => 
        \CIC_regs_0_DOUTB_0_[25]\, DOUTB(24) => 
        \CIC_regs_0_DOUTB_0_[24]\, DOUTB(23) => 
        \CIC_regs_0_DOUTB_0_[23]\, DOUTB(22) => 
        \CIC_regs_0_DOUTB_0_[22]\, DOUTB(21) => 
        \CIC_regs_0_DOUTB_0_[21]\, DOUTB(20) => 
        \CIC_regs_0_DOUTB_0_[20]\, DOUTB(19) => 
        \CIC_regs_0_DOUTB_0_[19]\, DOUTB(18) => 
        \CIC_regs_0_DOUTB_0_[18]\, DOUTB(17) => 
        \CIC_regs_0_DOUTB_0_[17]\, DOUTB(16) => 
        \CIC_regs_0_DOUTB_0_[16]\, DOUTB(15) => 
        \CIC_regs_0_DOUTB_0_[15]\, DOUTB(14) => 
        \CIC_regs_0_DOUTB_0_[14]\, DOUTB(13) => 
        \CIC_regs_0_DOUTB_0_[13]\, DOUTB(12) => 
        \CIC_regs_0_DOUTB_0_[12]\, DOUTB(11) => 
        \CIC_regs_0_DOUTB_0_[11]\, DOUTB(10) => 
        \CIC_regs_0_DOUTB_0_[10]\, DOUTB(9) => 
        \CIC_regs_0_DOUTB_0_[9]\, DOUTB(8) => 
        \CIC_regs_0_DOUTB_0_[8]\, DOUTB(7) => 
        \CIC_regs_0_DOUTB_0_[7]\, DOUTB(6) => 
        \CIC_regs_0_DOUTB_0_[6]\, DOUTB(5) => 
        \CIC_regs_0_DOUTB_0_[5]\, DOUTB(4) => 
        \CIC_regs_0_DOUTB_0_[4]\, DOUTB(3) => 
        \CIC_regs_0_DOUTB_0_[3]\, DOUTB(2) => 
        \CIC_regs_0_DOUTB_0_[2]\, DOUTB(1) => 
        \CIC_regs_0_DOUTB_0_[1]\, DOUTB(0) => 
        \CIC_regs_0_DOUTB_0_[0]\, ADDRA(3) => 
        \CIC_control_0_ADDRA_0_[3]\, ADDRA(2) => 
        \CIC_control_0_ADDRA_0_[2]\, ADDRA(1) => 
        \CIC_control_0_ADDRA_0_[1]\, ADDRA(0) => 
        \CIC_control_0_ADDRA_0_[0]\, ADDRB(3) => 
        \CIC_control_0_ADDRB_0_[3]\, ADDRB(2) => 
        \CIC_control_0_ADDRB_0_[2]\, ADDRB(1) => 
        \CIC_control_0_ADDRB_0_[1]\, ADDRB(0) => 
        \CIC_control_0_ADDRB_0_[0]\, RWA => CIC_control_0_RWA, 
        RWB => CIC_control_0_RWB, BLKA => CIC_control_0_BLKA, 
        BLKB => CIC_control_0_BLKB, CLKAB => CLK, RESET => RST);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    CIC_control_0 : entity work.CIC_control
      port map(CLK => CLK, RST => RST, DINA(46) => 
        \CIC_control_0_DINA_0_[46]\, DINA(45) => 
        \CIC_control_0_DINA_0_[45]\, DINA(44) => 
        \CIC_control_0_DINA_0_[44]\, DINA(43) => 
        \CIC_control_0_DINA_0_[43]\, DINA(42) => 
        \CIC_control_0_DINA_0_[42]\, DINA(41) => 
        \CIC_control_0_DINA_0_[41]\, DINA(40) => 
        \CIC_control_0_DINA_0_[40]\, DINA(39) => 
        \CIC_control_0_DINA_0_[39]\, DINA(38) => 
        \CIC_control_0_DINA_0_[38]\, DINA(37) => 
        \CIC_control_0_DINA_0_[37]\, DINA(36) => 
        \CIC_control_0_DINA_0_[36]\, DINA(35) => 
        \CIC_control_0_DINA_0_[35]\, DINA(34) => 
        \CIC_control_0_DINA_0_[34]\, DINA(33) => 
        \CIC_control_0_DINA_0_[33]\, DINA(32) => 
        \CIC_control_0_DINA_0_[32]\, DINA(31) => 
        \CIC_control_0_DINA_0_[31]\, DINA(30) => 
        \CIC_control_0_DINA_0_[30]\, DINA(29) => 
        \CIC_control_0_DINA_0_[29]\, DINA(28) => 
        \CIC_control_0_DINA_0_[28]\, DINA(27) => 
        \CIC_control_0_DINA_0_[27]\, DINA(26) => 
        \CIC_control_0_DINA_0_[26]\, DINA(25) => 
        \CIC_control_0_DINA_0_[25]\, DINA(24) => 
        \CIC_control_0_DINA_0_[24]\, DINA(23) => 
        \CIC_control_0_DINA_0_[23]\, DINA(22) => 
        \CIC_control_0_DINA_0_[22]\, DINA(21) => 
        \CIC_control_0_DINA_0_[21]\, DINA(20) => 
        \CIC_control_0_DINA_0_[20]\, DINA(19) => 
        \CIC_control_0_DINA_0_[19]\, DINA(18) => 
        \CIC_control_0_DINA_0_[18]\, DINA(17) => 
        \CIC_control_0_DINA_0_[17]\, DINA(16) => 
        \CIC_control_0_DINA_0_[16]\, DINA(15) => 
        \CIC_control_0_DINA_0_[15]\, DINA(14) => 
        \CIC_control_0_DINA_0_[14]\, DINA(13) => 
        \CIC_control_0_DINA_0_[13]\, DINA(12) => 
        \CIC_control_0_DINA_0_[12]\, DINA(11) => 
        \CIC_control_0_DINA_0_[11]\, DINA(10) => 
        \CIC_control_0_DINA_0_[10]\, DINA(9) => 
        \CIC_control_0_DINA_0_[9]\, DINA(8) => 
        \CIC_control_0_DINA_0_[8]\, DINA(7) => 
        \CIC_control_0_DINA_0_[7]\, DINA(6) => 
        \CIC_control_0_DINA_0_[6]\, DINA(5) => 
        \CIC_control_0_DINA_0_[5]\, DINA(4) => 
        \CIC_control_0_DINA_0_[4]\, DINA(3) => 
        \CIC_control_0_DINA_0_[3]\, DINA(2) => 
        \CIC_control_0_DINA_0_[2]\, DINA(1) => 
        \CIC_control_0_DINA_0_[1]\, DINA(0) => 
        \CIC_control_0_DINA_0_[0]\, DINB(46) => 
        \CIC_control_0_DINB_0_[46]\, DINB(45) => 
        \CIC_control_0_DINB_0_[45]\, DINB(44) => 
        \CIC_control_0_DINB_0_[44]\, DINB(43) => 
        \CIC_control_0_DINB_0_[43]\, DINB(42) => 
        \CIC_control_0_DINB_0_[42]\, DINB(41) => 
        \CIC_control_0_DINB_0_[41]\, DINB(40) => 
        \CIC_control_0_DINB_0_[40]\, DINB(39) => 
        \CIC_control_0_DINB_0_[39]\, DINB(38) => 
        \CIC_control_0_DINB_0_[38]\, DINB(37) => 
        \CIC_control_0_DINB_0_[37]\, DINB(36) => 
        \CIC_control_0_DINB_0_[36]\, DINB(35) => 
        \CIC_control_0_DINB_0_[35]\, DINB(34) => 
        \CIC_control_0_DINB_0_[34]\, DINB(33) => 
        \CIC_control_0_DINB_0_[33]\, DINB(32) => 
        \CIC_control_0_DINB_0_[32]\, DINB(31) => 
        \CIC_control_0_DINB_0_[31]\, DINB(30) => 
        \CIC_control_0_DINB_0_[30]\, DINB(29) => 
        \CIC_control_0_DINB_0_[29]\, DINB(28) => 
        \CIC_control_0_DINB_0_[28]\, DINB(27) => 
        \CIC_control_0_DINB_0_[27]\, DINB(26) => 
        \CIC_control_0_DINB_0_[26]\, DINB(25) => 
        \CIC_control_0_DINB_0_[25]\, DINB(24) => 
        \CIC_control_0_DINB_0_[24]\, DINB(23) => 
        \CIC_control_0_DINB_0_[23]\, DINB(22) => 
        \CIC_control_0_DINB_0_[22]\, DINB(21) => 
        \CIC_control_0_DINB_0_[21]\, DINB(20) => 
        \CIC_control_0_DINB_0_[20]\, DINB(19) => 
        \CIC_control_0_DINB_0_[19]\, DINB(18) => 
        \CIC_control_0_DINB_0_[18]\, DINB(17) => 
        \CIC_control_0_DINB_0_[17]\, DINB(16) => 
        \CIC_control_0_DINB_0_[16]\, DINB(15) => 
        \CIC_control_0_DINB_0_[15]\, DINB(14) => 
        \CIC_control_0_DINB_0_[14]\, DINB(13) => 
        \CIC_control_0_DINB_0_[13]\, DINB(12) => 
        \CIC_control_0_DINB_0_[12]\, DINB(11) => 
        \CIC_control_0_DINB_0_[11]\, DINB(10) => 
        \CIC_control_0_DINB_0_[10]\, DINB(9) => 
        \CIC_control_0_DINB_0_[9]\, DINB(8) => 
        \CIC_control_0_DINB_0_[8]\, DINB(7) => 
        \CIC_control_0_DINB_0_[7]\, DINB(6) => 
        \CIC_control_0_DINB_0_[6]\, DINB(5) => 
        \CIC_control_0_DINB_0_[5]\, DINB(4) => 
        \CIC_control_0_DINB_0_[4]\, DINB(3) => 
        \CIC_control_0_DINB_0_[3]\, DINB(2) => 
        \CIC_control_0_DINB_0_[2]\, DINB(1) => 
        \CIC_control_0_DINB_0_[1]\, DINB(0) => 
        \CIC_control_0_DINB_0_[0]\, ADDRA(3) => 
        \CIC_control_0_ADDRA_0_[3]\, ADDRA(2) => 
        \CIC_control_0_ADDRA_0_[2]\, ADDRA(1) => 
        \CIC_control_0_ADDRA_0_[1]\, ADDRA(0) => 
        \CIC_control_0_ADDRA_0_[0]\, ADDRB(3) => 
        \CIC_control_0_ADDRB_0_[3]\, ADDRB(2) => 
        \CIC_control_0_ADDRB_0_[2]\, ADDRB(1) => 
        \CIC_control_0_ADDRB_0_[1]\, ADDRB(0) => 
        \CIC_control_0_ADDRB_0_[0]\, RWA => CIC_control_0_RWA, 
        RWB => CIC_control_0_RWB, BLKA => CIC_control_0_BLKA, 
        BLKB => CIC_control_0_BLKB, DOUTA(46) => 
        \CIC_regs_0_DOUTA_0_[46]\, DOUTA(45) => 
        \CIC_regs_0_DOUTA_0_[45]\, DOUTA(44) => 
        \CIC_regs_0_DOUTA_0_[44]\, DOUTA(43) => 
        \CIC_regs_0_DOUTA_0_[43]\, DOUTA(42) => 
        \CIC_regs_0_DOUTA_0_[42]\, DOUTA(41) => 
        \CIC_regs_0_DOUTA_0_[41]\, DOUTA(40) => 
        \CIC_regs_0_DOUTA_0_[40]\, DOUTA(39) => 
        \CIC_regs_0_DOUTA_0_[39]\, DOUTA(38) => 
        \CIC_regs_0_DOUTA_0_[38]\, DOUTA(37) => 
        \CIC_regs_0_DOUTA_0_[37]\, DOUTA(36) => 
        \CIC_regs_0_DOUTA_0_[36]\, DOUTA(35) => 
        \CIC_regs_0_DOUTA_0_[35]\, DOUTA(34) => 
        \CIC_regs_0_DOUTA_0_[34]\, DOUTA(33) => 
        \CIC_regs_0_DOUTA_0_[33]\, DOUTA(32) => 
        \CIC_regs_0_DOUTA_0_[32]\, DOUTA(31) => 
        \CIC_regs_0_DOUTA_0_[31]\, DOUTA(30) => 
        \CIC_regs_0_DOUTA_0_[30]\, DOUTA(29) => 
        \CIC_regs_0_DOUTA_0_[29]\, DOUTA(28) => 
        \CIC_regs_0_DOUTA_0_[28]\, DOUTA(27) => 
        \CIC_regs_0_DOUTA_0_[27]\, DOUTA(26) => 
        \CIC_regs_0_DOUTA_0_[26]\, DOUTA(25) => 
        \CIC_regs_0_DOUTA_0_[25]\, DOUTA(24) => 
        \CIC_regs_0_DOUTA_0_[24]\, DOUTA(23) => 
        \CIC_regs_0_DOUTA_0_[23]\, DOUTA(22) => 
        \CIC_regs_0_DOUTA_0_[22]\, DOUTA(21) => 
        \CIC_regs_0_DOUTA_0_[21]\, DOUTA(20) => 
        \CIC_regs_0_DOUTA_0_[20]\, DOUTA(19) => 
        \CIC_regs_0_DOUTA_0_[19]\, DOUTA(18) => 
        \CIC_regs_0_DOUTA_0_[18]\, DOUTA(17) => 
        \CIC_regs_0_DOUTA_0_[17]\, DOUTA(16) => 
        \CIC_regs_0_DOUTA_0_[16]\, DOUTA(15) => 
        \CIC_regs_0_DOUTA_0_[15]\, DOUTA(14) => 
        \CIC_regs_0_DOUTA_0_[14]\, DOUTA(13) => 
        \CIC_regs_0_DOUTA_0_[13]\, DOUTA(12) => 
        \CIC_regs_0_DOUTA_0_[12]\, DOUTA(11) => 
        \CIC_regs_0_DOUTA_0_[11]\, DOUTA(10) => 
        \CIC_regs_0_DOUTA_0_[10]\, DOUTA(9) => 
        \CIC_regs_0_DOUTA_0_[9]\, DOUTA(8) => 
        \CIC_regs_0_DOUTA_0_[8]\, DOUTA(7) => 
        \CIC_regs_0_DOUTA_0_[7]\, DOUTA(6) => 
        \CIC_regs_0_DOUTA_0_[6]\, DOUTA(5) => 
        \CIC_regs_0_DOUTA_0_[5]\, DOUTA(4) => 
        \CIC_regs_0_DOUTA_0_[4]\, DOUTA(3) => 
        \CIC_regs_0_DOUTA_0_[3]\, DOUTA(2) => 
        \CIC_regs_0_DOUTA_0_[2]\, DOUTA(1) => 
        \CIC_regs_0_DOUTA_0_[1]\, DOUTA(0) => 
        \CIC_regs_0_DOUTA_0_[0]\, DOUTB(46) => 
        \CIC_regs_0_DOUTB_0_[46]\, DOUTB(45) => 
        \CIC_regs_0_DOUTB_0_[45]\, DOUTB(44) => 
        \CIC_regs_0_DOUTB_0_[44]\, DOUTB(43) => 
        \CIC_regs_0_DOUTB_0_[43]\, DOUTB(42) => 
        \CIC_regs_0_DOUTB_0_[42]\, DOUTB(41) => 
        \CIC_regs_0_DOUTB_0_[41]\, DOUTB(40) => 
        \CIC_regs_0_DOUTB_0_[40]\, DOUTB(39) => 
        \CIC_regs_0_DOUTB_0_[39]\, DOUTB(38) => 
        \CIC_regs_0_DOUTB_0_[38]\, DOUTB(37) => 
        \CIC_regs_0_DOUTB_0_[37]\, DOUTB(36) => 
        \CIC_regs_0_DOUTB_0_[36]\, DOUTB(35) => 
        \CIC_regs_0_DOUTB_0_[35]\, DOUTB(34) => 
        \CIC_regs_0_DOUTB_0_[34]\, DOUTB(33) => 
        \CIC_regs_0_DOUTB_0_[33]\, DOUTB(32) => 
        \CIC_regs_0_DOUTB_0_[32]\, DOUTB(31) => 
        \CIC_regs_0_DOUTB_0_[31]\, DOUTB(30) => 
        \CIC_regs_0_DOUTB_0_[30]\, DOUTB(29) => 
        \CIC_regs_0_DOUTB_0_[29]\, DOUTB(28) => 
        \CIC_regs_0_DOUTB_0_[28]\, DOUTB(27) => 
        \CIC_regs_0_DOUTB_0_[27]\, DOUTB(26) => 
        \CIC_regs_0_DOUTB_0_[26]\, DOUTB(25) => 
        \CIC_regs_0_DOUTB_0_[25]\, DOUTB(24) => 
        \CIC_regs_0_DOUTB_0_[24]\, DOUTB(23) => 
        \CIC_regs_0_DOUTB_0_[23]\, DOUTB(22) => 
        \CIC_regs_0_DOUTB_0_[22]\, DOUTB(21) => 
        \CIC_regs_0_DOUTB_0_[21]\, DOUTB(20) => 
        \CIC_regs_0_DOUTB_0_[20]\, DOUTB(19) => 
        \CIC_regs_0_DOUTB_0_[19]\, DOUTB(18) => 
        \CIC_regs_0_DOUTB_0_[18]\, DOUTB(17) => 
        \CIC_regs_0_DOUTB_0_[17]\, DOUTB(16) => 
        \CIC_regs_0_DOUTB_0_[16]\, DOUTB(15) => 
        \CIC_regs_0_DOUTB_0_[15]\, DOUTB(14) => 
        \CIC_regs_0_DOUTB_0_[14]\, DOUTB(13) => 
        \CIC_regs_0_DOUTB_0_[13]\, DOUTB(12) => 
        \CIC_regs_0_DOUTB_0_[12]\, DOUTB(11) => 
        \CIC_regs_0_DOUTB_0_[11]\, DOUTB(10) => 
        \CIC_regs_0_DOUTB_0_[10]\, DOUTB(9) => 
        \CIC_regs_0_DOUTB_0_[9]\, DOUTB(8) => 
        \CIC_regs_0_DOUTB_0_[8]\, DOUTB(7) => 
        \CIC_regs_0_DOUTB_0_[7]\, DOUTB(6) => 
        \CIC_regs_0_DOUTB_0_[6]\, DOUTB(5) => 
        \CIC_regs_0_DOUTB_0_[5]\, DOUTB(4) => 
        \CIC_regs_0_DOUTB_0_[4]\, DOUTB(3) => 
        \CIC_regs_0_DOUTB_0_[3]\, DOUTB(2) => 
        \CIC_regs_0_DOUTB_0_[2]\, DOUTB(1) => 
        \CIC_regs_0_DOUTB_0_[1]\, DOUTB(0) => 
        \CIC_regs_0_DOUTB_0_[0]\, INPUT(21) => INPUT(21), 
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
    

end DEF_ARCH; 
