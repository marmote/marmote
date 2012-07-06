-- Version: 10.0 SP2 10.0.20.2

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity USB_FIFO_IF is

    port( USB_CLK_pin       : in    std_logic;
          USB_TXE_n_pin     : in    std_logic;
          USB_WR_n_pin      : out   std_logic;
          CLK               : in    std_logic;
          RST_n             : in    std_logic;
          USB_SIWU_N        : out   std_logic;
          FROM_ADC_SMPL_RDY : in    std_logic;
          USB_RXF_n_pin     : in    std_logic;
          READ_SUCCESSFUL   : in    std_logic;
          USB_RD_n_pin      : out   std_logic;
          USB_OE_n_pin      : out   std_logic;
          FROM_USB_RDY      : out   std_logic;
          USB_DATA_pin      : inout std_logic_vector(7 downto 0) := (others => 'Z');
          ADC_Q             : in    std_logic_vector(31 downto 16);
          ADC_I             : in    std_logic_vector(15 downto 0);
          READ_FROM_USB_REG : out   std_logic_vector(7 downto 0)
        );

end USB_FIFO_IF;

architecture DEF_ARCH of USB_FIFO_IF is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component sample_FIFO
    port( WE     : in    std_logic := 'U';
          RE     : in    std_logic := 'U';
          WCLOCK : in    std_logic := 'U';
          RCLOCK : in    std_logic := 'U';
          FULL   : out   std_logic;
          EMPTY  : out   std_logic;
          RESET  : in    std_logic := 'U';
          AEMPTY : out   std_logic;
          AFULL  : out   std_logic;
          DATA   : in    std_logic_vector(31 downto 0) := (others => 'U');
          Q      : out   std_logic_vector(31 downto 0)
        );
  end component;

    signal sample_FIFO_0_AEMPTY, sample_FIFO_0_EMPTY, 
        \sample_FIFO_0_Q_[31]\, \sample_FIFO_0_Q_[30]\, 
        \sample_FIFO_0_Q_[29]\, \sample_FIFO_0_Q_[28]\, 
        \sample_FIFO_0_Q_[27]\, \sample_FIFO_0_Q_[26]\, 
        \sample_FIFO_0_Q_[25]\, \sample_FIFO_0_Q_[24]\, 
        \sample_FIFO_0_Q_[23]\, \sample_FIFO_0_Q_[22]\, 
        \sample_FIFO_0_Q_[21]\, \sample_FIFO_0_Q_[20]\, 
        \sample_FIFO_0_Q_[19]\, \sample_FIFO_0_Q_[18]\, 
        \sample_FIFO_0_Q_[17]\, \sample_FIFO_0_Q_[16]\, 
        \sample_FIFO_0_Q_[15]\, \sample_FIFO_0_Q_[14]\, 
        \sample_FIFO_0_Q_[13]\, \sample_FIFO_0_Q_[12]\, 
        \sample_FIFO_0_Q_[11]\, \sample_FIFO_0_Q_[10]\, 
        \sample_FIFO_0_Q_[9]\, \sample_FIFO_0_Q_[8]\, 
        \sample_FIFO_0_Q_[7]\, \sample_FIFO_0_Q_[6]\, 
        \sample_FIFO_0_Q_[5]\, \sample_FIFO_0_Q_[4]\, 
        \sample_FIFO_0_Q_[3]\, \sample_FIFO_0_Q_[2]\, 
        \sample_FIFO_0_Q_[1]\, \sample_FIFO_0_Q_[0]\, 
        USB_IF_0_FIFO_RE, USB_IF_0_FIFO_WE, USB_IF_0_USB_CLK_OUT, 
        GND_net : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => USB_SIWU_N);
    
    USB_IF_0 : entity work.USB_IF
      port map(CLK => CLK, RST_n => RST_n, FROM_ADC_SMPL_RDY => 
        FROM_ADC_SMPL_RDY, FIFO_WE => USB_IF_0_FIFO_WE, FIFO_RE
         => USB_IF_0_FIFO_RE, FIFO_EMPTY => sample_FIFO_0_EMPTY, 
        FIFO_AEMPTY => sample_FIFO_0_AEMPTY, USB_CLK_pin => 
        USB_CLK_pin, USB_CLK_OUT => USB_IF_0_USB_CLK_OUT, 
        USB_TXE_n_pin => USB_TXE_n_pin, USB_RXF_n_pin => 
        USB_RXF_n_pin, USB_WR_n_pin => USB_WR_n_pin, USB_RD_n_pin
         => USB_RD_n_pin, USB_OE_n_pin => USB_OE_n_pin, 
        FROM_USB_RDY => FROM_USB_RDY, READ_SUCCESSFUL => 
        READ_SUCCESSFUL, FIFO_DATA_OUT(31) => 
        \sample_FIFO_0_Q_[31]\, FIFO_DATA_OUT(30) => 
        \sample_FIFO_0_Q_[30]\, FIFO_DATA_OUT(29) => 
        \sample_FIFO_0_Q_[29]\, FIFO_DATA_OUT(28) => 
        \sample_FIFO_0_Q_[28]\, FIFO_DATA_OUT(27) => 
        \sample_FIFO_0_Q_[27]\, FIFO_DATA_OUT(26) => 
        \sample_FIFO_0_Q_[26]\, FIFO_DATA_OUT(25) => 
        \sample_FIFO_0_Q_[25]\, FIFO_DATA_OUT(24) => 
        \sample_FIFO_0_Q_[24]\, FIFO_DATA_OUT(23) => 
        \sample_FIFO_0_Q_[23]\, FIFO_DATA_OUT(22) => 
        \sample_FIFO_0_Q_[22]\, FIFO_DATA_OUT(21) => 
        \sample_FIFO_0_Q_[21]\, FIFO_DATA_OUT(20) => 
        \sample_FIFO_0_Q_[20]\, FIFO_DATA_OUT(19) => 
        \sample_FIFO_0_Q_[19]\, FIFO_DATA_OUT(18) => 
        \sample_FIFO_0_Q_[18]\, FIFO_DATA_OUT(17) => 
        \sample_FIFO_0_Q_[17]\, FIFO_DATA_OUT(16) => 
        \sample_FIFO_0_Q_[16]\, FIFO_DATA_OUT(15) => 
        \sample_FIFO_0_Q_[15]\, FIFO_DATA_OUT(14) => 
        \sample_FIFO_0_Q_[14]\, FIFO_DATA_OUT(13) => 
        \sample_FIFO_0_Q_[13]\, FIFO_DATA_OUT(12) => 
        \sample_FIFO_0_Q_[12]\, FIFO_DATA_OUT(11) => 
        \sample_FIFO_0_Q_[11]\, FIFO_DATA_OUT(10) => 
        \sample_FIFO_0_Q_[10]\, FIFO_DATA_OUT(9) => 
        \sample_FIFO_0_Q_[9]\, FIFO_DATA_OUT(8) => 
        \sample_FIFO_0_Q_[8]\, FIFO_DATA_OUT(7) => 
        \sample_FIFO_0_Q_[7]\, FIFO_DATA_OUT(6) => 
        \sample_FIFO_0_Q_[6]\, FIFO_DATA_OUT(5) => 
        \sample_FIFO_0_Q_[5]\, FIFO_DATA_OUT(4) => 
        \sample_FIFO_0_Q_[4]\, FIFO_DATA_OUT(3) => 
        \sample_FIFO_0_Q_[3]\, FIFO_DATA_OUT(2) => 
        \sample_FIFO_0_Q_[2]\, FIFO_DATA_OUT(1) => 
        \sample_FIFO_0_Q_[1]\, FIFO_DATA_OUT(0) => 
        \sample_FIFO_0_Q_[0]\, USB_DATA_pin(7) => USB_DATA_pin(7), 
        USB_DATA_pin(6) => USB_DATA_pin(6), USB_DATA_pin(5) => 
        USB_DATA_pin(5), USB_DATA_pin(4) => USB_DATA_pin(4), 
        USB_DATA_pin(3) => USB_DATA_pin(3), USB_DATA_pin(2) => 
        USB_DATA_pin(2), USB_DATA_pin(1) => USB_DATA_pin(1), 
        USB_DATA_pin(0) => USB_DATA_pin(0), READ_FROM_USB_REG(7)
         => READ_FROM_USB_REG(7), READ_FROM_USB_REG(6) => 
        READ_FROM_USB_REG(6), READ_FROM_USB_REG(5) => 
        READ_FROM_USB_REG(5), READ_FROM_USB_REG(4) => 
        READ_FROM_USB_REG(4), READ_FROM_USB_REG(3) => 
        READ_FROM_USB_REG(3), READ_FROM_USB_REG(2) => 
        READ_FROM_USB_REG(2), READ_FROM_USB_REG(1) => 
        READ_FROM_USB_REG(1), READ_FROM_USB_REG(0) => 
        READ_FROM_USB_REG(0));
    
    \GND\ : GND
      port map(Y => GND_net);
    
    sample_FIFO_0 : sample_FIFO
      port map(WE => USB_IF_0_FIFO_WE, RE => USB_IF_0_FIFO_RE, 
        WCLOCK => CLK, RCLOCK => USB_IF_0_USB_CLK_OUT, FULL => 
        OPEN, EMPTY => sample_FIFO_0_EMPTY, RESET => RST_n, 
        AEMPTY => sample_FIFO_0_AEMPTY, AFULL => OPEN, DATA(31)
         => ADC_Q(31), DATA(30) => ADC_Q(30), DATA(29) => 
        ADC_Q(29), DATA(28) => ADC_Q(28), DATA(27) => ADC_Q(27), 
        DATA(26) => ADC_Q(26), DATA(25) => ADC_Q(25), DATA(24)
         => ADC_Q(24), DATA(23) => ADC_Q(23), DATA(22) => 
        ADC_Q(22), DATA(21) => ADC_Q(21), DATA(20) => ADC_Q(20), 
        DATA(19) => ADC_Q(19), DATA(18) => ADC_Q(18), DATA(17)
         => ADC_Q(17), DATA(16) => ADC_Q(16), DATA(15) => 
        ADC_I(15), DATA(14) => ADC_I(14), DATA(13) => ADC_I(13), 
        DATA(12) => ADC_I(12), DATA(11) => ADC_I(11), DATA(10)
         => ADC_I(10), DATA(9) => ADC_I(9), DATA(8) => ADC_I(8), 
        DATA(7) => ADC_I(7), DATA(6) => ADC_I(6), DATA(5) => 
        ADC_I(5), DATA(4) => ADC_I(4), DATA(3) => ADC_I(3), 
        DATA(2) => ADC_I(2), DATA(1) => ADC_I(1), DATA(0) => 
        ADC_I(0), Q(31) => \sample_FIFO_0_Q_[31]\, Q(30) => 
        \sample_FIFO_0_Q_[30]\, Q(29) => \sample_FIFO_0_Q_[29]\, 
        Q(28) => \sample_FIFO_0_Q_[28]\, Q(27) => 
        \sample_FIFO_0_Q_[27]\, Q(26) => \sample_FIFO_0_Q_[26]\, 
        Q(25) => \sample_FIFO_0_Q_[25]\, Q(24) => 
        \sample_FIFO_0_Q_[24]\, Q(23) => \sample_FIFO_0_Q_[23]\, 
        Q(22) => \sample_FIFO_0_Q_[22]\, Q(21) => 
        \sample_FIFO_0_Q_[21]\, Q(20) => \sample_FIFO_0_Q_[20]\, 
        Q(19) => \sample_FIFO_0_Q_[19]\, Q(18) => 
        \sample_FIFO_0_Q_[18]\, Q(17) => \sample_FIFO_0_Q_[17]\, 
        Q(16) => \sample_FIFO_0_Q_[16]\, Q(15) => 
        \sample_FIFO_0_Q_[15]\, Q(14) => \sample_FIFO_0_Q_[14]\, 
        Q(13) => \sample_FIFO_0_Q_[13]\, Q(12) => 
        \sample_FIFO_0_Q_[12]\, Q(11) => \sample_FIFO_0_Q_[11]\, 
        Q(10) => \sample_FIFO_0_Q_[10]\, Q(9) => 
        \sample_FIFO_0_Q_[9]\, Q(8) => \sample_FIFO_0_Q_[8]\, 
        Q(7) => \sample_FIFO_0_Q_[7]\, Q(6) => 
        \sample_FIFO_0_Q_[6]\, Q(5) => \sample_FIFO_0_Q_[5]\, 
        Q(4) => \sample_FIFO_0_Q_[4]\, Q(3) => 
        \sample_FIFO_0_Q_[3]\, Q(2) => \sample_FIFO_0_Q_[2]\, 
        Q(1) => \sample_FIFO_0_Q_[1]\, Q(0) => 
        \sample_FIFO_0_Q_[0]\);
    

end DEF_ARCH; 
