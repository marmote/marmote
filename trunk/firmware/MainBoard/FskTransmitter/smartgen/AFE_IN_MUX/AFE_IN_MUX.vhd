-- Version: 10.0 SP1 10.0.10.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity AFE_IN_MUX is

    port( Data0_port : in    std_logic_vector(9 downto 0);
          Data1_port : in    std_logic_vector(9 downto 0);
          Data2_port : in    std_logic_vector(9 downto 0);
          Sel0       : in    std_logic;
          Sel1       : in    std_logic;
          Result     : out   std_logic_vector(9 downto 0)
        );

end AFE_IN_MUX;

architecture DEF_ARCH of AFE_IN_MUX is 

  component BUFF
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component MX2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal \SelAux_0[0]\, \SelAux_0[5]\, \SelAux_1[0]\, 
        \SelAux_1[5]\, MX2_7_Y, MX2_9_Y, MX2_8_Y, MX2_5_Y, 
        MX2_0_Y, MX2_3_Y, MX2_6_Y, MX2_1_Y, MX2_2_Y, MX2_4_Y
         : std_logic;

begin 


    \BUFF_SelAux_1[5]\ : BUFF
      port map(A => Sel1, Y => \SelAux_1[5]\);
    
    MX2_9 : MX2
      port map(A => Data0_port(6), B => Data1_port(6), S => 
        \SelAux_0[5]\, Y => MX2_9_Y);
    
    \MX2_Result[4]\ : MX2
      port map(A => MX2_6_Y, B => Data2_port(4), S => 
        \SelAux_1[0]\, Y => Result(4));
    
    MX2_0 : MX2
      port map(A => Data0_port(2), B => Data1_port(2), S => 
        \SelAux_0[0]\, Y => MX2_0_Y);
    
    \MX2_Result[3]\ : MX2
      port map(A => MX2_5_Y, B => Data2_port(3), S => 
        \SelAux_1[0]\, Y => Result(3));
    
    \BUFF_SelAux_1[0]\ : BUFF
      port map(A => Sel1, Y => \SelAux_1[0]\);
    
    \MX2_Result[9]\ : MX2
      port map(A => MX2_7_Y, B => Data2_port(9), S => 
        \SelAux_1[5]\, Y => Result(9));
    
    \MX2_Result[6]\ : MX2
      port map(A => MX2_9_Y, B => Data2_port(6), S => 
        \SelAux_1[5]\, Y => Result(6));
    
    MX2_6 : MX2
      port map(A => Data0_port(4), B => Data1_port(4), S => 
        \SelAux_0[0]\, Y => MX2_6_Y);
    
    MX2_3 : MX2
      port map(A => Data0_port(5), B => Data1_port(5), S => 
        \SelAux_0[5]\, Y => MX2_3_Y);
    
    MX2_4 : MX2
      port map(A => Data0_port(0), B => Data1_port(0), S => 
        \SelAux_0[0]\, Y => MX2_4_Y);
    
    \MX2_Result[8]\ : MX2
      port map(A => MX2_8_Y, B => Data2_port(8), S => 
        \SelAux_1[5]\, Y => Result(8));
    
    \BUFF_SelAux_0[0]\ : BUFF
      port map(A => Sel0, Y => \SelAux_0[0]\);
    
    \MX2_Result[0]\ : MX2
      port map(A => MX2_4_Y, B => Data2_port(0), S => 
        \SelAux_1[0]\, Y => Result(0));
    
    MX2_5 : MX2
      port map(A => Data0_port(3), B => Data1_port(3), S => 
        \SelAux_0[0]\, Y => MX2_5_Y);
    
    \MX2_Result[2]\ : MX2
      port map(A => MX2_0_Y, B => Data2_port(2), S => 
        \SelAux_1[0]\, Y => Result(2));
    
    \BUFF_SelAux_0[5]\ : BUFF
      port map(A => Sel0, Y => \SelAux_0[5]\);
    
    MX2_8 : MX2
      port map(A => Data0_port(8), B => Data1_port(8), S => 
        \SelAux_0[5]\, Y => MX2_8_Y);
    
    MX2_2 : MX2
      port map(A => Data0_port(7), B => Data1_port(7), S => 
        \SelAux_0[5]\, Y => MX2_2_Y);
    
    \MX2_Result[5]\ : MX2
      port map(A => MX2_3_Y, B => Data2_port(5), S => 
        \SelAux_1[5]\, Y => Result(5));
    
    MX2_7 : MX2
      port map(A => Data0_port(9), B => Data1_port(9), S => 
        \SelAux_0[5]\, Y => MX2_7_Y);
    
    \MX2_Result[1]\ : MX2
      port map(A => MX2_1_Y, B => Data2_port(1), S => 
        \SelAux_1[0]\, Y => Result(1));
    
    MX2_1 : MX2
      port map(A => Data0_port(1), B => Data1_port(1), S => 
        \SelAux_0[0]\, Y => MX2_1_Y);
    
    \MX2_Result[7]\ : MX2
      port map(A => MX2_2_Y, B => Data2_port(7), S => 
        \SelAux_1[5]\, Y => Result(7));
    

end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:10.0.10.4
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:PA3SOC2
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_MUX
-- LPM_HINT:None
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:D:/firmware/MainBoard/FskTransmitter/smartgen\AFE_IN_MUX
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:IP6X5M2
-- SMARTGEN_PACKAGE:fg256
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:10
-- SIZE:3
-- SEL0_FANIN:AUTO
-- SEL0_VAL:6
-- SEL0_POLARITY:1
-- SEL1_FANIN:AUTO
-- SEL1_VAL:6
-- SEL1_POLARITY:2
-- SEL2_FANIN:AUTO
-- SEL2_VAL:6
-- SEL2_POLARITY:2
-- SEL3_FANIN:AUTO
-- SEL3_VAL:6
-- SEL3_POLARITY:2
-- SEL4_FANIN:AUTO
-- SEL4_VAL:6
-- SEL4_POLARITY:2

-- _End_Comments_

