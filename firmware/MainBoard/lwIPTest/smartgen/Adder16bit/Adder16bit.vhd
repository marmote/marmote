-- Version: 10.0 SP2 10.0.20.2

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity Adder16bit is

    port( Aset  : in    std_logic;
          Clock : in    std_logic;
          Q     : out   std_logic_vector(15 downto 0)
        );

end Adder16bit;

architecture DEF_ARCH of Adder16bit is 

  component DFN1P0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          PRE : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component DFN1E1P0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          PRE : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component XOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AND2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AND3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal NU_0, NU_1, NU_2, NU_3, NU_4, NU_5, NU_6, NU_7, NU_8, 
        NU_9, NU_10, NU_11, NU_12, NU_13, NU_14, NU_15, NU_0_1, 
        NU_0_1_2, NU_3_4, NU_3_4_5, NU_6_7, NU_6_7_8, NU_9_10, 
        NU_9_10_11, NU_12_13, NU_12_13_14, NU_0_to_8, NU_9_to_14, 
        XOR2_11_Y, INV_0_Y, XOR2_6_Y, AND2_4_Y, XOR2_7_Y, 
        XOR2_8_Y, AND2_8_Y, XOR2_5_Y, AND2_1_Y, XOR2_10_Y, 
        INV_2_Y, INV_1_Y, XOR2_3_Y, AND2_5_Y, XOR2_9_Y, AND2_3_Y, 
        XOR2_0_Y, AND2_0_Y, XOR2_1_Y, AND2_2_Y, XOR2_2_Y, 
        AND2_7_Y, XOR2_4_Y, AND2_6_Y, INV_3_Y : std_logic;

begin 

    Q(15) <= NU_15;
    Q(14) <= NU_14;
    Q(13) <= NU_13;
    Q(12) <= NU_12;
    Q(11) <= NU_11;
    Q(10) <= NU_10;
    Q(9) <= NU_9;
    Q(8) <= NU_8;
    Q(7) <= NU_7;
    Q(6) <= NU_6;
    Q(5) <= NU_5;
    Q(4) <= NU_4;
    Q(3) <= NU_3;
    Q(2) <= NU_2;
    Q(1) <= NU_1;
    Q(0) <= NU_0;

    DFN1P0_NU_6 : DFN1P0
      port map(D => XOR2_9_Y, CLK => Clock, PRE => Aset, Q => 
        NU_6);
    
    DFN1E1P0_NU_1 : DFN1E1P0
      port map(D => INV_1_Y, CLK => Clock, PRE => Aset, E => NU_0, 
        Q => NU_1);
    
    DFN1P0_NU_0 : DFN1P0
      port map(D => INV_3_Y, CLK => Clock, PRE => Aset, Q => NU_0);
    
    DFN1E1P0_NU_10 : DFN1E1P0
      port map(D => XOR2_10_Y, CLK => Clock, PRE => Aset, E => 
        NU_0_to_8, Q => NU_10);
    
    XOR2_1 : XOR2
      port map(A => NU_14, B => AND2_2_Y, Y => XOR2_1_Y);
    
    AND2_0 : AND2
      port map(A => NU_9, B => NU_10, Y => AND2_0_Y);
    
    XOR2_4 : XOR2
      port map(A => NU_5, B => AND2_6_Y, Y => XOR2_4_Y);
    
    XOR2_5 : XOR2
      port map(A => NU_15, B => AND2_1_Y, Y => XOR2_5_Y);
    
    INV_0 : INV
      port map(A => NU_9, Y => INV_0_Y);
    
    AND2_4 : AND2
      port map(A => NU_9_10_11, B => NU_12, Y => AND2_4_Y);
    
    AND2_3 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_3_Y);
    
    U_AND2_9_10 : AND2
      port map(A => NU_9, B => NU_10, Y => NU_9_10);
    
    U_AND2_0_1 : AND2
      port map(A => NU_0, B => NU_1, Y => NU_0_1);
    
    AND2_1 : AND2
      port map(A => NU_9_10_11, B => NU_12_13_14, Y => AND2_1_Y);
    
    DFN1E1P0_NU_7 : DFN1E1P0
      port map(D => XOR2_2_Y, CLK => Clock, PRE => Aset, E => 
        NU_6, Q => NU_7);
    
    DFN1E1P0_NU_15 : DFN1E1P0
      port map(D => XOR2_5_Y, CLK => Clock, PRE => Aset, E => 
        NU_0_to_8, Q => NU_15);
    
    XOR2_0 : XOR2
      port map(A => NU_11, B => AND2_0_Y, Y => XOR2_0_Y);
    
    AND2_7 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_7_Y);
    
    DFN1E1P0_NU_14 : DFN1E1P0
      port map(D => XOR2_1_Y, CLK => Clock, PRE => Aset, E => 
        NU_0_to_8, Q => NU_14);
    
    XOR2_2 : XOR2
      port map(A => NU_7, B => AND2_7_Y, Y => XOR2_2_Y);
    
    XOR2_8 : XOR2
      port map(A => NU_2, B => AND2_8_Y, Y => XOR2_8_Y);
    
    XOR2_7 : XOR2
      port map(A => NU_4, B => NU_3, Y => XOR2_7_Y);
    
    AND2_5 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_5_Y);
    
    U_U_AND2_9_to_14 : AND2
      port map(A => NU_9_10_11, B => NU_12_13_14, Y => NU_9_to_14);
    
    XOR2_9 : XOR2
      port map(A => NU_6, B => AND2_3_Y, Y => XOR2_9_Y);
    
    U_U_AND3_0_to_8 : AND3
      port map(A => NU_0_1_2, B => NU_3_4_5, C => NU_6_7_8, Y => 
        NU_0_to_8);
    
    XOR2_11 : XOR2
      port map(A => NU_12, B => NU_9_10_11, Y => XOR2_11_Y);
    
    INV_3 : INV
      port map(A => NU_0, Y => INV_3_Y);
    
    DFN1E1P0_NU_5 : DFN1E1P0
      port map(D => XOR2_4_Y, CLK => Clock, PRE => Aset, E => 
        NU_0_1_2, Q => NU_5);
    
    DFN1E1P0_NU_11 : DFN1E1P0
      port map(D => XOR2_0_Y, CLK => Clock, PRE => Aset, E => 
        NU_0_to_8, Q => NU_11);
    
    DFN1E1P0_NU_8 : DFN1E1P0
      port map(D => XOR2_3_Y, CLK => Clock, PRE => Aset, E => 
        NU_6_7, Q => NU_8);
    
    DFN1E1P0_NU_4 : DFN1E1P0
      port map(D => XOR2_7_Y, CLK => Clock, PRE => Aset, E => 
        NU_0_1_2, Q => NU_4);
    
    INV_1 : INV
      port map(A => NU_1, Y => INV_1_Y);
    
    U_AND2_12_13 : AND2
      port map(A => NU_12, B => NU_13, Y => NU_12_13);
    
    AND2_8 : AND2
      port map(A => NU_0, B => NU_1, Y => AND2_8_Y);
    
    U_AND3_3_4_5 : AND3
      port map(A => NU_3, B => NU_4, C => NU_5, Y => NU_3_4_5);
    
    U_AND2_6_7 : AND2
      port map(A => NU_6, B => NU_7, Y => NU_6_7);
    
    XOR2_3 : XOR2
      port map(A => NU_8, B => AND2_5_Y, Y => XOR2_3_Y);
    
    AND2_2 : AND2
      port map(A => NU_9_10_11, B => NU_12_13, Y => AND2_2_Y);
    
    XOR2_10 : XOR2
      port map(A => NU_10, B => NU_9, Y => XOR2_10_Y);
    
    U_AND3_9_10_11 : AND3
      port map(A => NU_9, B => NU_10, C => NU_11, Y => NU_9_10_11);
    
    INV_2 : INV
      port map(A => NU_3, Y => INV_2_Y);
    
    DFN1E1P0_NU_9 : DFN1E1P0
      port map(D => INV_0_Y, CLK => Clock, PRE => Aset, E => 
        NU_0_to_8, Q => NU_9);
    
    DFN1E1P0_NU_3 : DFN1E1P0
      port map(D => INV_2_Y, CLK => Clock, PRE => Aset, E => 
        NU_0_1_2, Q => NU_3);
    
    DFN1E1P0_NU_13 : DFN1E1P0
      port map(D => XOR2_6_Y, CLK => Clock, PRE => Aset, E => 
        NU_0_to_8, Q => NU_13);
    
    U_AND3_0_1_2 : AND3
      port map(A => NU_0, B => NU_1, C => NU_2, Y => NU_0_1_2);
    
    DFN1P0_NU_2 : DFN1P0
      port map(D => XOR2_8_Y, CLK => Clock, PRE => Aset, Q => 
        NU_2);
    
    U_AND3_6_7_8 : AND3
      port map(A => NU_6, B => NU_7, C => NU_8, Y => NU_6_7_8);
    
    XOR2_6 : XOR2
      port map(A => NU_13, B => AND2_4_Y, Y => XOR2_6_Y);
    
    U_AND2_3_4 : AND2
      port map(A => NU_3, B => NU_4, Y => NU_3_4);
    
    DFN1E1P0_NU_12 : DFN1E1P0
      port map(D => XOR2_11_Y, CLK => Clock, PRE => Aset, E => 
        NU_0_to_8, Q => NU_12);
    
    AND2_6 : AND2
      port map(A => NU_3, B => NU_4, Y => AND2_6_Y);
    
    U_AND3_12_13_14 : AND3
      port map(A => NU_12, B => NU_13, C => NU_14, Y => 
        NU_12_13_14);
    

end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:10.0.20.2
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:PA3SOC2
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_COUNTER
-- LPM_HINT:COMPCNT
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:D:/Work/marmote/firmware/lwIPTest/smartgen\Adder16bit
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:IP6X5M2
-- SMARTGEN_PACKAGE:fg256
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:16
-- DIRECTION:UP
-- CLR_POLARITY:2
-- LD_POLARITY:2
-- EN_POLARITY:2
-- UPDOWN_POLARITY:2
-- CLK_EDGE:RISE
-- CLR_FANIN:MANUAL
-- CLR_VAL:1
-- CLK_FANIN:MANUAL
-- CLK_VAL:1
-- LD_FANIN:AUTO
-- LD_VAL:12
-- UPDOWN_FANIN:AUTO
-- UPDOWN_VAL:12
-- TCNT_POLARITY:2
-- SET_POLARITY:0
-- SET_FANIN:MANUAL
-- SET_VAL:1

-- _End_Comments_

