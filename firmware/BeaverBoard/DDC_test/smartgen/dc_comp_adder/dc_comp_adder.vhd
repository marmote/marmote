-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity dc_comp_adder is 
    port( DataA : in std_logic_vector(13 downto 0); DataB : in 
        std_logic_vector(13 downto 0); Sum : out 
        std_logic_vector(13 downto 0)) ;
end dc_comp_adder;


architecture DEF_ARCH of  dc_comp_adder is

    component AND2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component AO1
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component XOR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal G_0_1_0_net, G_0_2_0_net, G_0_3_0_net, G_0_4_0_net, 
        G_0_5_0_net, G_0_6_0_net, G_0_7_0_net, G_0_8_0_net, 
        G_0_9_0_net, G_0_10_0_net, G_0_11_0_net, G_0_12_0_net, 
        G_0_13_0_net, P_0_0_0_net, P_0_1_0_net, P_0_2_0_net, 
        P_0_3_0_net, P_0_4_0_net, P_0_5_0_net, P_0_6_0_net, 
        P_0_7_0_net, P_0_8_0_net, P_0_9_0_net, P_0_10_0_net, 
        P_0_11_0_net, P_0_12_0_net, P_0_13_0_net, P_10_1_0_net, 
        G_1_3_0_net, P_1_3_0_net, G_1_5_0_net, P_1_5_0_net, 
        G_1_7_0_net, P_1_7_0_net, G_1_9_0_net, P_1_9_0_net, 
        G_1_11_0_net, P_1_11_0_net, G_1_13_0_net, P_1_13_0_net, 
        P_10_2_0_net, P_10_3_0_net, G_2_6_0_net, P_2_6_0_net, 
        G_2_7_0_net, P_2_7_0_net, G_2_10_0_net, P_2_10_0_net, 
        G_2_11_0_net, P_2_11_0_net, P_10_4_0_net, P_10_5_0_net, 
        P_10_6_0_net, P_10_7_0_net, G_3_12_0_net, P_3_12_0_net, 
        G_3_13_0_net, P_3_13_0_net, P_10_8_0_net, P_10_9_0_net, 
        P_10_10_0_net, P_10_11_0_net, P_10_12_0_net, 
        G_10_13_0_net, P_10_13_0_net, Carry_1_net, Carry_2_net, 
        Carry_3_net, Carry_4_net, Carry_5_net, Carry_6_net, 
        Carry_7_net, Carry_8_net, Carry_9_net, Carry_10_net, 
        Carry_11_net, Carry_12_net, Carry_13_net, 
        partial_sum_1_net, partial_sum_2_net, partial_sum_3_net, 
        partial_sum_4_net, partial_sum_5_net, partial_sum_6_net, 
        partial_sum_7_net, partial_sum_8_net, partial_sum_9_net, 
        partial_sum_10_net, partial_sum_11_net, 
        partial_sum_12_net, partial_sum_13_net : std_logic ;
    begin   

    AND2_P_10_13_0_inst : AND2
      port map(A => P_10_7_0_net, B => P_3_13_0_net, Y => 
        P_10_13_0_net);
    AO1_Carry_10_inst : AO1
      port map(A => P_1_9_0_net, B => Carry_8_net, C => 
        G_1_9_0_net, Y => Carry_10_net);
    AND2_G_0_6_0_inst : AND2
      port map(A => DataA(6), B => DataB(6), Y => G_0_6_0_net);
    XOR2_Sum_13_inst : XOR2
      port map(A => partial_sum_13_net, B => Carry_13_net, Y => 
        Sum(13));
    AO1_G_2_11_0_inst : AO1
      port map(A => P_1_11_0_net, B => G_1_9_0_net, C => 
        G_1_11_0_net, Y => G_2_11_0_net);
    AO1_G_1_7_0_inst : AO1
      port map(A => P_0_7_0_net, B => G_0_6_0_net, C => 
        G_0_7_0_net, Y => G_1_7_0_net);
    XOR2_partial_sum_1_inst : XOR2
      port map(A => DataA(1), B => DataB(1), Y => 
        partial_sum_1_net);
    XOR2_Sum_9_inst : XOR2
      port map(A => partial_sum_9_net, B => Carry_9_net, Y => 
        Sum(9));
    AND2_P_10_8_0_inst : AND2
      port map(A => P_10_7_0_net, B => P_0_8_0_net, Y => 
        P_10_8_0_net);
    AND2_P_10_5_0_inst : AND2
      port map(A => P_10_3_0_net, B => P_1_5_0_net, Y => 
        P_10_5_0_net);
    AND2_G_0_3_0_inst : AND2
      port map(A => DataA(3), B => DataB(3), Y => G_0_3_0_net);
    AND2_G_0_11_0_inst : AND2
      port map(A => DataA(11), B => DataB(11), Y => G_0_11_0_net);
    AND2_P_10_3_0_inst : AND2
      port map(A => P_10_1_0_net, B => P_1_3_0_net, Y => 
        P_10_3_0_net);
    XOR2_P_0_9_0_inst : XOR2
      port map(A => DataA(9), B => DataB(9), Y => P_0_9_0_net);
    XOR2_Sum_12_inst : XOR2
      port map(A => partial_sum_12_net, B => Carry_12_net, Y => 
        Sum(12));
    AO1_G_3_13_0_inst : AO1
      port map(A => P_1_13_0_net, B => G_2_11_0_net, C => 
        G_1_13_0_net, Y => G_3_13_0_net);
    AO1_Carry_9_inst : AO1
      port map(A => P_0_8_0_net, B => Carry_8_net, C => 
        G_0_8_0_net, Y => Carry_9_net);
    AO1_Carry_3_inst : AO1
      port map(A => P_0_2_0_net, B => Carry_2_net, C => 
        G_0_2_0_net, Y => Carry_3_net);
    AO1_G_2_10_0_inst : AO1
      port map(A => P_0_10_0_net, B => G_1_9_0_net, C => 
        G_0_10_0_net, Y => G_2_10_0_net);
    XOR2_Sum_5_inst : XOR2
      port map(A => partial_sum_5_net, B => Carry_5_net, Y => 
        Sum(5));
    AND2_G_0_8_0_inst : AND2
      port map(A => DataA(8), B => DataB(8), Y => G_0_8_0_net);
    AO1_Carry_12_inst : AO1
      port map(A => P_2_11_0_net, B => Carry_8_net, C => 
        G_2_11_0_net, Y => Carry_12_net);
    XOR2_P_0_0_0_inst : XOR2
      port map(A => DataA(0), B => DataB(0), Y => P_0_0_0_net);
    XOR2_Sum_3_inst : XOR2
      port map(A => partial_sum_3_net, B => Carry_3_net, Y => 
        Sum(3));
    AND2_P_10_2_0_inst : AND2
      port map(A => P_10_1_0_net, B => P_0_2_0_net, Y => 
        P_10_2_0_net);
    AND2_P_10_12_0_inst : AND2
      port map(A => P_10_7_0_net, B => P_3_12_0_net, Y => 
        P_10_12_0_net);
    XOR2_Sum_10_inst : XOR2
      port map(A => partial_sum_10_net, B => Carry_10_net, Y => 
        Sum(10));
    AND2_G_0_4_0_inst : AND2
      port map(A => DataA(4), B => DataB(4), Y => G_0_4_0_net);
    AO1_G_1_9_0_inst : AO1
      port map(A => P_0_9_0_net, B => G_0_8_0_net, C => 
        G_0_9_0_net, Y => G_1_9_0_net);
    XOR2_partial_sum_13_inst : XOR2
      port map(A => DataA(13), B => DataB(13), Y => 
        partial_sum_13_net);
    AND2_P_3_12_0_inst : AND2
      port map(A => P_2_11_0_net, B => P_0_12_0_net, Y => 
        P_3_12_0_net);
    AND2_P_10_10_0_inst : AND2
      port map(A => P_10_7_0_net, B => P_2_10_0_net, Y => 
        P_10_10_0_net);
    AO1_Carry_5_inst : AO1
      port map(A => P_0_4_0_net, B => Carry_4_net, C => 
        G_0_4_0_net, Y => Carry_5_net);
    AND2_Carry_1_inst : AND2
      port map(A => DataA(0), B => DataB(0), Y => Carry_1_net);
    AO1_Carry_6_inst : AO1
      port map(A => P_1_5_0_net, B => Carry_4_net, C => 
        G_1_5_0_net, Y => Carry_6_net);
    AND2_P_1_3_0_inst : AND2
      port map(A => P_0_2_0_net, B => P_0_3_0_net, Y => 
        P_1_3_0_net);
    AO1_G_1_11_0_inst : AO1
      port map(A => P_0_11_0_net, B => G_0_10_0_net, C => 
        G_0_11_0_net, Y => G_1_11_0_net);
    XOR2_P_0_7_0_inst : XOR2
      port map(A => DataA(7), B => DataB(7), Y => P_0_7_0_net);
    AND2_G_0_1_0_inst : AND2
      port map(A => DataA(1), B => DataB(1), Y => G_0_1_0_net);
    AND2_P_3_13_0_inst : AND2
      port map(A => P_2_11_0_net, B => P_1_13_0_net, Y => 
        P_3_13_0_net);
    XOR2_Sum_4_inst : XOR2
      port map(A => partial_sum_4_net, B => Carry_4_net, Y => 
        Sum(4));
    XOR2_Sum_8_inst : XOR2
      port map(A => partial_sum_8_net, B => Carry_8_net, Y => 
        Sum(8));
    AND2_P_10_11_0_inst : AND2
      port map(A => P_10_7_0_net, B => P_2_11_0_net, Y => 
        P_10_11_0_net);
    XOR2_partial_sum_7_inst : XOR2
      port map(A => DataA(7), B => DataB(7), Y => 
        partial_sum_7_net);
    AND2_P_2_7_0_inst : AND2
      port map(A => P_1_5_0_net, B => P_1_7_0_net, Y => 
        P_2_7_0_net);
    AND2_P_10_7_0_inst : AND2
      port map(A => P_10_3_0_net, B => P_2_7_0_net, Y => 
        P_10_7_0_net);
    XOR2_P_0_13_0_inst : XOR2
      port map(A => DataA(13), B => DataB(13), Y => P_0_13_0_net);
    XOR2_P_0_2_0_inst : XOR2
      port map(A => DataA(2), B => DataB(2), Y => P_0_2_0_net);
    XOR2_partial_sum_4_inst : XOR2
      port map(A => DataA(4), B => DataB(4), Y => 
        partial_sum_4_net);
    AND2_G_0_12_0_inst : AND2
      port map(A => DataA(12), B => DataB(12), Y => G_0_12_0_net);
    XOR2_P_0_1_0_inst : XOR2
      port map(A => DataA(1), B => DataB(1), Y => P_0_1_0_net);
    XOR2_partial_sum_8_inst : XOR2
      port map(A => DataA(8), B => DataB(8), Y => 
        partial_sum_8_net);
    AND2_P_10_9_0_inst : AND2
      port map(A => P_10_7_0_net, B => P_1_9_0_net, Y => 
        P_10_9_0_net);
    AND2_P_2_10_0_inst : AND2
      port map(A => P_1_9_0_net, B => P_0_10_0_net, Y => 
        P_2_10_0_net);
    XOR2_P_0_3_0_inst : XOR2
      port map(A => DataA(3), B => DataB(3), Y => P_0_3_0_net);
    AO1_Carry_7_inst : AO1
      port map(A => P_2_6_0_net, B => Carry_4_net, C => 
        G_2_6_0_net, Y => Carry_7_net);
    XOR2_P_0_6_0_inst : XOR2
      port map(A => DataA(6), B => DataB(6), Y => P_0_6_0_net);
    AO1_G_10_13_0_inst : AO1
      port map(A => P_3_13_0_net, B => Carry_8_net, C => 
        G_3_13_0_net, Y => G_10_13_0_net);
    AND2_G_0_13_0_inst : AND2
      port map(A => DataA(13), B => DataB(13), Y => G_0_13_0_net);
    XOR2_P_0_8_0_inst : XOR2
      port map(A => DataA(8), B => DataB(8), Y => P_0_8_0_net);
    AND2_G_0_9_0_inst : AND2
      port map(A => DataA(9), B => DataB(9), Y => G_0_9_0_net);
    AND2_G_0_7_0_inst : AND2
      port map(A => DataA(7), B => DataB(7), Y => G_0_7_0_net);
    XOR2_Sum_0_inst : XOR2
      port map(A => DataA(0), B => DataB(0), Y => Sum(0));
    XOR2_partial_sum_6_inst : XOR2
      port map(A => DataA(6), B => DataB(6), Y => 
        partial_sum_6_net);
    XOR2_partial_sum_12_inst : XOR2
      port map(A => DataA(12), B => DataB(12), Y => 
        partial_sum_12_net);
    AND2_P_1_5_0_inst : AND2
      port map(A => P_0_4_0_net, B => P_0_5_0_net, Y => 
        P_1_5_0_net);
    AND2_P_10_6_0_inst : AND2
      port map(A => P_10_3_0_net, B => P_2_6_0_net, Y => 
        P_10_6_0_net);
    AO1_Carry_8_inst : AO1
      port map(A => P_2_7_0_net, B => Carry_4_net, C => 
        G_2_7_0_net, Y => Carry_8_net);
    AND2_G_0_5_0_inst : AND2
      port map(A => DataA(5), B => DataB(5), Y => G_0_5_0_net);
    AND2_P_1_7_0_inst : AND2
      port map(A => P_0_6_0_net, B => P_0_7_0_net, Y => 
        P_1_7_0_net);
    XOR2_partial_sum_11_inst : XOR2
      port map(A => DataA(11), B => DataB(11), Y => 
        partial_sum_11_net);
    AO1_G_1_13_0_inst : AO1
      port map(A => P_0_13_0_net, B => G_0_12_0_net, C => 
        G_0_13_0_net, Y => G_1_13_0_net);
    AND2_P_2_11_0_inst : AND2
      port map(A => P_1_9_0_net, B => P_1_11_0_net, Y => 
        P_2_11_0_net);
    AND2_P_1_11_0_inst : AND2
      port map(A => P_0_10_0_net, B => P_0_11_0_net, Y => 
        P_1_11_0_net);
    XOR2_P_0_4_0_inst : XOR2
      port map(A => DataA(4), B => DataB(4), Y => P_0_4_0_net);
    AO1_G_2_7_0_inst : AO1
      port map(A => P_1_7_0_net, B => G_1_5_0_net, C => 
        G_1_7_0_net, Y => G_2_7_0_net);
    XOR2_P_0_5_0_inst : XOR2
      port map(A => DataA(5), B => DataB(5), Y => P_0_5_0_net);
    XOR2_P_0_12_0_inst : XOR2
      port map(A => DataA(12), B => DataB(12), Y => P_0_12_0_net);
    AND2_P_10_1_0_inst : AND2
      port map(A => P_0_0_0_net, B => P_0_1_0_net, Y => 
        P_10_1_0_net);
    AND2_G_0_2_0_inst : AND2
      port map(A => DataA(2), B => DataB(2), Y => G_0_2_0_net);
    AO1_G_1_5_0_inst : AO1
      port map(A => P_0_5_0_net, B => G_0_4_0_net, C => 
        G_0_5_0_net, Y => G_1_5_0_net);
    XOR2_Sum_6_inst : XOR2
      port map(A => partial_sum_6_net, B => Carry_6_net, Y => 
        Sum(6));
    AO1_G_2_6_0_inst : AO1
      port map(A => P_0_6_0_net, B => G_1_5_0_net, C => 
        G_0_6_0_net, Y => G_2_6_0_net);
    AND2_P_2_6_0_inst : AND2
      port map(A => P_1_5_0_net, B => P_0_6_0_net, Y => 
        P_2_6_0_net);
    XOR2_partial_sum_5_inst : XOR2
      port map(A => DataA(5), B => DataB(5), Y => 
        partial_sum_5_net);
    AO1_Carry_11_inst : AO1
      port map(A => P_2_10_0_net, B => Carry_8_net, C => 
        G_2_10_0_net, Y => Carry_11_net);
    AO1_G_3_12_0_inst : AO1
      port map(A => P_0_12_0_net, B => G_2_11_0_net, C => 
        G_0_12_0_net, Y => G_3_12_0_net);
    XOR2_Sum_11_inst : XOR2
      port map(A => partial_sum_11_net, B => Carry_11_net, Y => 
        Sum(11));
    XOR2_partial_sum_10_inst : XOR2
      port map(A => DataA(10), B => DataB(10), Y => 
        partial_sum_10_net);
    AO1_G_1_3_0_inst : AO1
      port map(A => P_0_3_0_net, B => G_0_2_0_net, C => 
        G_0_3_0_net, Y => G_1_3_0_net);
    AO1_Carry_13_inst : AO1
      port map(A => P_3_12_0_net, B => Carry_8_net, C => 
        G_3_12_0_net, Y => Carry_13_net);
    XOR2_partial_sum_2_inst : XOR2
      port map(A => DataA(2), B => DataB(2), Y => 
        partial_sum_2_net);
    AND2_P_1_9_0_inst : AND2
      port map(A => P_0_8_0_net, B => P_0_9_0_net, Y => 
        P_1_9_0_net);
    XOR2_partial_sum_3_inst : XOR2
      port map(A => DataA(3), B => DataB(3), Y => 
        partial_sum_3_net);
    XOR2_Sum_1_inst : XOR2
      port map(A => partial_sum_1_net, B => Carry_1_net, Y => 
        Sum(1));
    AND2_P_10_4_0_inst : AND2
      port map(A => P_10_3_0_net, B => P_0_4_0_net, Y => 
        P_10_4_0_net);
    XOR2_P_0_11_0_inst : XOR2
      port map(A => DataA(11), B => DataB(11), Y => P_0_11_0_net);
    XOR2_Sum_7_inst : XOR2
      port map(A => partial_sum_7_net, B => Carry_7_net, Y => 
        Sum(7));
    XOR2_Sum_2_inst : XOR2
      port map(A => partial_sum_2_net, B => Carry_2_net, Y => 
        Sum(2));
    AO1_Carry_2_inst : AO1
      port map(A => P_0_1_0_net, B => Carry_1_net, C => 
        G_0_1_0_net, Y => Carry_2_net);
    XOR2_partial_sum_9_inst : XOR2
      port map(A => DataA(9), B => DataB(9), Y => 
        partial_sum_9_net);
    AND2_P_1_13_0_inst : AND2
      port map(A => P_0_12_0_net, B => P_0_13_0_net, Y => 
        P_1_13_0_net);
    AND2_G_0_10_0_inst : AND2
      port map(A => DataA(10), B => DataB(10), Y => G_0_10_0_net);
    AO1_Carry_4_inst : AO1
      port map(A => P_1_3_0_net, B => Carry_2_net, C => 
        G_1_3_0_net, Y => Carry_4_net);
    XOR2_P_0_10_0_inst : XOR2
      port map(A => DataA(10), B => DataB(10), Y => P_0_10_0_net);
end DEF_ARCH;

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.3.4
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:SmartFusion
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_ADD_SUB
-- LPM_HINT:SKADD
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:D:/Work/marmote/projects/DDC_test/smartgen\dc_comp_adder
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IP4X3M1
-- SMARTGEN_PACKAGE:fg484
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- CI_POLARITY:2
-- CO_POLARITY:2
-- WIDTH:14
-- MAXFANOUT:11
-- DEBUG:0

-- _End_Comments_

