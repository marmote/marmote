-- Version: 10.0 SP2 10.0.20.2

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity StreamingReceiver is

    port( MSS_RESET_N  : in    std_logic;
          MAINXIN      : in    std_logic;
          AFE1_CLK     : out   std_logic;
          AFE1_SHDN_n  : out   std_logic;
          AFE1_TR_n    : out   std_logic;
          TXE_n_pin    : in    std_logic;
          OE_n_pin     : out   std_logic;
          RD_n_pin     : out   std_logic;
          WR_n_pin     : out   std_logic;
          SIWU_n_pin   : out   std_logic;
          USB_CLK_pin  : in    std_logic;
          DATA_pin     : inout std_logic_vector(9 downto 0) := (others => 'Z');
          USB_DATA_pin : inout std_logic_vector(7 downto 0) := (others => 'Z')
        );

end StreamingReceiver;

architecture DEF_ARCH of StreamingReceiver is 

  component USB_FIFO_IF
    port( USB_CLK_pin       : in    std_logic := 'U';
          OE_n              : out   std_logic;
          RD_n              : out   std_logic;
          SIWU_n            : out   std_logic;
          TXE_n_pin         : in    std_logic := 'U';
          RSTn              : in    std_logic := 'U';
          FROM_ADC_SMPL_RDY : in    std_logic := 'U';
          WR_n_pin          : out   std_logic;
          CLK               : in    std_logic := 'U';
          ADC_Q             : in    std_logic_vector(31 downto 16) := (others => 'U');
          ADC_I             : in    std_logic_vector(15 downto 0) := (others => 'U');
          USB_DATA_pin      : inout   std_logic_vector(7 downto 0)
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component StreamingReceiver_MSS
    port( MSS_RESET_N : in    std_logic := 'U';
          M2F_RESET_N : out   std_logic;
          GLB         : out   std_logic;
          MAINXIN     : in    std_logic := 'U'
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

    signal \AFE_IF_0_RX_I_[9]\, INV_0_Y, \AFE_IF_0_RX_I_[8]\, 
        \AFE_IF_0_RX_I_[7]\, \AFE_IF_0_RX_I_[6]\, 
        \AFE_IF_0_RX_I_[5]\, \AFE_IF_0_RX_I_[4]\, 
        \AFE_IF_0_RX_I_[3]\, \AFE_IF_0_RX_I_[2]\, 
        \AFE_IF_0_RX_I_[1]\, \AFE_IF_0_RX_I_[0]\, 
        \AFE_IF_0_RX_Q_[9]\, INV_1_Y, \AFE_IF_0_RX_Q_[8]\, 
        \AFE_IF_0_RX_Q_[7]\, \AFE_IF_0_RX_Q_[6]\, 
        \AFE_IF_0_RX_Q_[5]\, \AFE_IF_0_RX_Q_[4]\, 
        \AFE_IF_0_RX_Q_[3]\, \AFE_IF_0_RX_Q_[2]\, 
        \AFE_IF_0_RX_Q_[1]\, \AFE_IF_0_RX_Q_[0]\, 
        StreamingReceiver_MSS_0_GLB, 
        StreamingReceiver_MSS_0_M2F_RESET_N, INV_2_Y, GND_net, 
        VCC_net : std_logic;

begin 


    USB_FIFO_IF_0 : USB_FIFO_IF
      port map(USB_CLK_pin => USB_CLK_pin, OE_n => OE_n_pin, RD_n
         => RD_n_pin, SIWU_n => SIWU_n_pin, TXE_n_pin => 
        TXE_n_pin, RSTn => StreamingReceiver_MSS_0_M2F_RESET_N, 
        FROM_ADC_SMPL_RDY => VCC_net, WR_n_pin => WR_n_pin, CLK
         => StreamingReceiver_MSS_0_GLB, ADC_Q(31) => 
        \AFE_IF_0_RX_Q_[9]\, ADC_Q(30) => \AFE_IF_0_RX_Q_[8]\, 
        ADC_Q(29) => \AFE_IF_0_RX_Q_[7]\, ADC_Q(28) => 
        \AFE_IF_0_RX_Q_[6]\, ADC_Q(27) => \AFE_IF_0_RX_Q_[5]\, 
        ADC_Q(26) => \AFE_IF_0_RX_Q_[4]\, ADC_Q(25) => 
        \AFE_IF_0_RX_Q_[3]\, ADC_Q(24) => \AFE_IF_0_RX_Q_[2]\, 
        ADC_Q(23) => \AFE_IF_0_RX_Q_[1]\, ADC_Q(22) => 
        \AFE_IF_0_RX_Q_[0]\, ADC_Q(21) => GND_net, ADC_Q(20) => 
        GND_net, ADC_Q(19) => GND_net, ADC_Q(18) => GND_net, 
        ADC_Q(17) => GND_net, ADC_Q(16) => GND_net, ADC_I(15) => 
        \AFE_IF_0_RX_I_[9]\, ADC_I(14) => \AFE_IF_0_RX_I_[8]\, 
        ADC_I(13) => \AFE_IF_0_RX_I_[7]\, ADC_I(12) => 
        \AFE_IF_0_RX_I_[6]\, ADC_I(11) => \AFE_IF_0_RX_I_[5]\, 
        ADC_I(10) => \AFE_IF_0_RX_I_[4]\, ADC_I(9) => 
        \AFE_IF_0_RX_I_[3]\, ADC_I(8) => \AFE_IF_0_RX_I_[2]\, 
        ADC_I(7) => \AFE_IF_0_RX_I_[1]\, ADC_I(6) => 
        \AFE_IF_0_RX_I_[0]\, ADC_I(5) => GND_net, ADC_I(4) => 
        GND_net, ADC_I(3) => GND_net, ADC_I(2) => GND_net, 
        ADC_I(1) => GND_net, ADC_I(0) => GND_net, USB_DATA_pin(7)
         => USB_DATA_pin(7), USB_DATA_pin(6) => USB_DATA_pin(6), 
        USB_DATA_pin(5) => USB_DATA_pin(5), USB_DATA_pin(4) => 
        USB_DATA_pin(4), USB_DATA_pin(3) => USB_DATA_pin(3), 
        USB_DATA_pin(2) => USB_DATA_pin(2), USB_DATA_pin(1) => 
        USB_DATA_pin(1), USB_DATA_pin(0) => USB_DATA_pin(0));
    
    \VCC\ : VCC
      port map(Y => VCC_net);
    
    AFE_IF_0 : entity work.AFE_IF
      port map(CLK => StreamingReceiver_MSS_0_GLB, RST => INV_2_Y, 
        SHDN => GND_net, TX_RX_n => GND_net, RX_STROBE => OPEN, 
        TX_STROBE => GND_net, CLK_pin => AFE1_CLK, SHDN_n_pin => 
        AFE1_SHDN_n, T_R_n_pin => AFE1_TR_n, RX_I(9) => INV_0_Y, 
        RX_I(8) => \AFE_IF_0_RX_I_[8]\, RX_I(7) => 
        \AFE_IF_0_RX_I_[7]\, RX_I(6) => \AFE_IF_0_RX_I_[6]\, 
        RX_I(5) => \AFE_IF_0_RX_I_[5]\, RX_I(4) => 
        \AFE_IF_0_RX_I_[4]\, RX_I(3) => \AFE_IF_0_RX_I_[3]\, 
        RX_I(2) => \AFE_IF_0_RX_I_[2]\, RX_I(1) => 
        \AFE_IF_0_RX_I_[1]\, RX_I(0) => \AFE_IF_0_RX_I_[0]\, 
        RX_Q(9) => INV_1_Y, RX_Q(8) => \AFE_IF_0_RX_Q_[8]\, 
        RX_Q(7) => \AFE_IF_0_RX_Q_[7]\, RX_Q(6) => 
        \AFE_IF_0_RX_Q_[6]\, RX_Q(5) => \AFE_IF_0_RX_Q_[5]\, 
        RX_Q(4) => \AFE_IF_0_RX_Q_[4]\, RX_Q(3) => 
        \AFE_IF_0_RX_Q_[3]\, RX_Q(2) => \AFE_IF_0_RX_Q_[2]\, 
        RX_Q(1) => \AFE_IF_0_RX_Q_[1]\, RX_Q(0) => 
        \AFE_IF_0_RX_Q_[0]\, TX_I(9) => GND_net, TX_I(8) => 
        GND_net, TX_I(7) => GND_net, TX_I(6) => GND_net, TX_I(5)
         => GND_net, TX_I(4) => GND_net, TX_I(3) => GND_net, 
        TX_I(2) => GND_net, TX_I(1) => GND_net, TX_I(0) => 
        GND_net, TX_Q(9) => GND_net, TX_Q(8) => GND_net, TX_Q(7)
         => GND_net, TX_Q(6) => GND_net, TX_Q(5) => GND_net, 
        TX_Q(4) => GND_net, TX_Q(3) => GND_net, TX_Q(2) => 
        GND_net, TX_Q(1) => GND_net, TX_Q(0) => GND_net, 
        DATA_pin(9) => DATA_pin(9), DATA_pin(8) => DATA_pin(8), 
        DATA_pin(7) => DATA_pin(7), DATA_pin(6) => DATA_pin(6), 
        DATA_pin(5) => DATA_pin(5), DATA_pin(4) => DATA_pin(4), 
        DATA_pin(3) => DATA_pin(3), DATA_pin(2) => DATA_pin(2), 
        DATA_pin(1) => DATA_pin(1), DATA_pin(0) => DATA_pin(0));
    
    StreamingReceiver_MSS_0 : StreamingReceiver_MSS
      port map(MSS_RESET_N => MSS_RESET_N, M2F_RESET_N => 
        StreamingReceiver_MSS_0_M2F_RESET_N, GLB => 
        StreamingReceiver_MSS_0_GLB, MAINXIN => MAINXIN);
    
    INV_0 : INV
      port map(A => INV_0_Y, Y => \AFE_IF_0_RX_I_[9]\);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    INV_2 : INV
      port map(A => StreamingReceiver_MSS_0_M2F_RESET_N, Y => 
        INV_2_Y);
    
    INV_1 : INV
      port map(A => INV_1_Y, Y => \AFE_IF_0_RX_Q_[9]\);
    

end DEF_ARCH; 
