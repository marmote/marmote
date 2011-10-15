-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity adder is 
    port( DataA : in std_logic_vector(21 downto 0); DataB : in 
        std_logic_vector(21 downto 0);Addsub : in std_logic; Sum : 
        out std_logic_vector(21 downto 0)) ;
end adder;


architecture DEF_ARCH of  adder is

    component XOR3
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component MAJ3
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component XNOR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component BUFF
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal AddsubAux_0_net, AddsubAux_6_net, AddsubAux_12_net, 
        AddsubAux_18_net, DataBXnor2_0_net, DataBXnor2_1_net, 
        DataBXnor2_2_net, DataBXnor2_3_net, DataBXnor2_4_net, 
        DataBXnor2_5_net, DataBXnor2_6_net, DataBXnor2_7_net, 
        DataBXnor2_8_net, DataBXnor2_9_net, DataBXnor2_10_net, 
        DataBXnor2_11_net, DataBXnor2_12_net, DataBXnor2_13_net, 
        DataBXnor2_14_net, DataBXnor2_15_net, DataBXnor2_16_net, 
        DataBXnor2_17_net, DataBXnor2_18_net, DataBXnor2_19_net, 
        DataBXnor2_20_net, DataBXnor2_21_net, MAJ3_0_Y, MAJ3_18_Y, 
        MAJ3_9_Y, MAJ3_15_Y, MAJ3_1_Y, MAJ3_12_Y, MAJ3_20_Y, 
        MAJ3_11_Y, MAJ3_19_Y, MAJ3_14_Y, MAJ3_10_Y, MAJ3_4_Y, 
        MAJ3_17_Y, MAJ3_3_Y, MAJ3_2_Y, MAJ3_16_Y, MAJ3_7_Y, 
        MAJ3_8_Y, MAJ3_6_Y, MAJ3_13_Y, MAJ3_5_Y, INV_0_Y : std_logic ;
    begin   

    XOR3_Sum_18_inst : XOR3
      port map(A => DataA(18), B => DataBXnor2_18_net, C => 
        MAJ3_8_Y, Y => Sum(18));
    MAJ3_10 : MAJ3
      port map(A => MAJ3_14_Y, B => DataA(10), C => 
        DataBXnor2_10_net, Y => MAJ3_10_Y);
    XOR3_Sum_3_inst : XOR3
      port map(A => DataA(3), B => DataBXnor2_3_net, C => 
        MAJ3_9_Y, Y => Sum(3));
    MAJ3_19 : MAJ3
      port map(A => MAJ3_11_Y, B => DataA(8), C => 
        DataBXnor2_8_net, Y => MAJ3_19_Y);
    XNOR2_7_inst : XNOR2
      port map(A => DataB(7), B => AddsubAux_6_net, Y => 
        DataBXnor2_7_net);
    XNOR2_19_inst : XNOR2
      port map(A => DataB(19), B => AddsubAux_18_net, Y => 
        DataBXnor2_19_net);
    XNOR2_3_inst : XNOR2
      port map(A => DataB(3), B => AddsubAux_0_net, Y => 
        DataBXnor2_3_net);
    MAJ3_6 : MAJ3
      port map(A => MAJ3_8_Y, B => DataA(18), C => 
        DataBXnor2_18_net, Y => MAJ3_6_Y);
    MAJ3_4 : MAJ3
      port map(A => MAJ3_10_Y, B => DataA(11), C => 
        DataBXnor2_11_net, Y => MAJ3_4_Y);
    XOR3_Sum_14_inst : XOR3
      port map(A => DataA(14), B => DataBXnor2_14_net, C => 
        MAJ3_3_Y, Y => Sum(14));
    MAJ3_16 : MAJ3
      port map(A => MAJ3_2_Y, B => DataA(15), C => 
        DataBXnor2_15_net, Y => MAJ3_16_Y);
    XNOR2_13_inst : XNOR2
      port map(A => DataB(13), B => AddsubAux_12_net, Y => 
        DataBXnor2_13_net);
    XOR3_Sum_7_inst : XOR3
      port map(A => DataA(7), B => DataBXnor2_7_net, C => 
        MAJ3_20_Y, Y => Sum(7));
    XOR3_Sum_9_inst : XOR3
      port map(A => DataA(9), B => DataBXnor2_9_net, C => 
        MAJ3_19_Y, Y => Sum(9));
    XNOR2_16_inst : XNOR2
      port map(A => DataB(16), B => AddsubAux_12_net, Y => 
        DataBXnor2_16_net);
    BUFF_AddsubAux_12_inst : BUFF
      port map(A => Addsub, Y => AddsubAux_12_net);
    XNOR2_15_inst : XNOR2
      port map(A => DataB(15), B => AddsubAux_12_net, Y => 
        DataBXnor2_15_net);
    XNOR2_14_inst : XNOR2
      port map(A => DataB(14), B => AddsubAux_12_net, Y => 
        DataBXnor2_14_net);
    MAJ3_3 : MAJ3
      port map(A => MAJ3_17_Y, B => DataA(13), C => 
        DataBXnor2_13_net, Y => MAJ3_3_Y);
    XOR3_Sum_19_inst : XOR3
      port map(A => DataA(19), B => DataBXnor2_19_net, C => 
        MAJ3_6_Y, Y => Sum(19));
    XOR3_Sum_6_inst : XOR3
      port map(A => DataA(6), B => DataBXnor2_6_net, C => 
        MAJ3_12_Y, Y => Sum(6));
    XNOR2_20_inst : XNOR2
      port map(A => DataB(20), B => AddsubAux_18_net, Y => 
        DataBXnor2_20_net);
    XOR3_Sum_11_inst : XOR3
      port map(A => DataA(11), B => DataBXnor2_11_net, C => 
        MAJ3_10_Y, Y => Sum(11));
    MAJ3_11 : MAJ3
      port map(A => MAJ3_20_Y, B => DataA(7), C => 
        DataBXnor2_7_net, Y => MAJ3_11_Y);
    MAJ3_20 : MAJ3
      port map(A => MAJ3_12_Y, B => DataA(6), C => 
        DataBXnor2_6_net, Y => MAJ3_20_Y);
    XOR3_Sum_4_inst : XOR3
      port map(A => DataA(4), B => DataBXnor2_4_net, C => 
        MAJ3_15_Y, Y => Sum(4));
    MAJ3_1 : MAJ3
      port map(A => MAJ3_15_Y, B => DataA(4), C => 
        DataBXnor2_4_net, Y => MAJ3_1_Y);
    XOR3_Sum_20_inst : XOR3
      port map(A => DataA(20), B => DataBXnor2_20_net, C => 
        MAJ3_13_Y, Y => Sum(20));
    XNOR2_9_inst : XNOR2
      port map(A => DataB(9), B => AddsubAux_6_net, Y => 
        DataBXnor2_9_net);
    XOR3_Sum_1_inst : XOR3
      port map(A => DataA(1), B => DataBXnor2_1_net, C => 
        MAJ3_0_Y, Y => Sum(1));
    XOR3_Sum_2_inst : XOR3
      port map(A => DataA(2), B => DataBXnor2_2_net, C => 
        MAJ3_18_Y, Y => Sum(2));
    XOR3_Sum_17_inst : XOR3
      port map(A => DataA(17), B => DataBXnor2_17_net, C => 
        MAJ3_7_Y, Y => Sum(17));
    XNOR2_10_inst : XNOR2
      port map(A => DataB(10), B => AddsubAux_6_net, Y => 
        DataBXnor2_10_net);
    XNOR2_4_inst : XNOR2
      port map(A => DataB(4), B => AddsubAux_0_net, Y => 
        DataBXnor2_4_net);
    XOR3_Sum_15_inst : XOR3
      port map(A => DataA(15), B => DataBXnor2_15_net, C => 
        MAJ3_2_Y, Y => Sum(15));
    XNOR2_1_inst : XNOR2
      port map(A => DataB(1), B => AddsubAux_0_net, Y => 
        DataBXnor2_1_net);
    MAJ3_12 : MAJ3
      port map(A => MAJ3_1_Y, B => DataA(5), C => 
        DataBXnor2_5_net, Y => MAJ3_12_Y);
    XNOR2_8_inst : XNOR2
      port map(A => DataB(8), B => AddsubAux_6_net, Y => 
        DataBXnor2_8_net);
    XNOR2_5_inst : XNOR2
      port map(A => DataB(5), B => AddsubAux_0_net, Y => 
        DataBXnor2_5_net);
    XOR3_Sum_13_inst : XOR3
      port map(A => DataA(13), B => DataBXnor2_13_net, C => 
        MAJ3_17_Y, Y => Sum(13));
    BUFF_AddsubAux_0_inst : BUFF
      port map(A => Addsub, Y => AddsubAux_0_net);
    XNOR2_6_inst : XNOR2
      port map(A => DataB(6), B => AddsubAux_6_net, Y => 
        DataBXnor2_6_net);
    XNOR2_21_inst : XNOR2
      port map(A => DataB(21), B => AddsubAux_18_net, Y => 
        DataBXnor2_21_net);
    MAJ3_8 : MAJ3
      port map(A => MAJ3_7_Y, B => DataA(17), C => 
        DataBXnor2_17_net, Y => MAJ3_8_Y);
    MAJ3_7 : MAJ3
      port map(A => MAJ3_16_Y, B => DataA(16), C => 
        DataBXnor2_16_net, Y => MAJ3_7_Y);
    XNOR2_2_inst : XNOR2
      port map(A => DataB(2), B => AddsubAux_0_net, Y => 
        DataBXnor2_2_net);
    XOR3_Sum_16_inst : XOR3
      port map(A => DataA(16), B => DataBXnor2_16_net, C => 
        MAJ3_16_Y, Y => Sum(16));
    MAJ3_15 : MAJ3
      port map(A => MAJ3_9_Y, B => DataA(3), C => 
        DataBXnor2_3_net, Y => MAJ3_15_Y);
    MAJ3_5 : MAJ3
      port map(A => MAJ3_13_Y, B => DataA(20), C => 
        DataBXnor2_20_net, Y => MAJ3_5_Y);
    XOR3_Sum_0_inst : XOR3
      port map(A => DataA(0), B => DataBXnor2_0_net, C => INV_0_Y, 
        Y => Sum(0));
    MAJ3_13 : MAJ3
      port map(A => MAJ3_6_Y, B => DataA(19), C => 
        DataBXnor2_19_net, Y => MAJ3_13_Y);
    XOR3_Sum_12_inst : XOR3
      port map(A => DataA(12), B => DataBXnor2_12_net, C => 
        MAJ3_4_Y, Y => Sum(12));
    XOR3_Sum_8_inst : XOR3
      port map(A => DataA(8), B => DataBXnor2_8_net, C => 
        MAJ3_11_Y, Y => Sum(8));
    BUFF_AddsubAux_18_inst : BUFF
      port map(A => Addsub, Y => AddsubAux_18_net);
    MAJ3_18 : MAJ3
      port map(A => MAJ3_0_Y, B => DataA(1), C => 
        DataBXnor2_1_net, Y => MAJ3_18_Y);
    XNOR2_12_inst : XNOR2
      port map(A => DataB(12), B => AddsubAux_12_net, Y => 
        DataBXnor2_12_net);
    XOR3_Sum_10_inst : XOR3
      port map(A => DataA(10), B => DataBXnor2_10_net, C => 
        MAJ3_14_Y, Y => Sum(10));
    MAJ3_2 : MAJ3
      port map(A => MAJ3_3_Y, B => DataA(14), C => 
        DataBXnor2_14_net, Y => MAJ3_2_Y);
    XNOR2_11_inst : XNOR2
      port map(A => DataB(11), B => AddsubAux_6_net, Y => 
        DataBXnor2_11_net);
    INV_0 : INV
      port map(A => AddsubAux_18_net, Y => INV_0_Y);
    XOR3_Sum_5_inst : XOR3
      port map(A => DataA(5), B => DataBXnor2_5_net, C => 
        MAJ3_1_Y, Y => Sum(5));
    XNOR2_17_inst : XNOR2
      port map(A => DataB(17), B => AddsubAux_12_net, Y => 
        DataBXnor2_17_net);
    BUFF_AddsubAux_6_inst : BUFF
      port map(A => Addsub, Y => AddsubAux_6_net);
    MAJ3_0 : MAJ3
      port map(A => INV_0_Y, B => DataA(0), C => DataBXnor2_0_net, 
        Y => MAJ3_0_Y);
    XNOR2_0_inst : XNOR2
      port map(A => DataB(0), B => AddsubAux_0_net, Y => 
        DataBXnor2_0_net);
    XNOR2_18_inst : XNOR2
      port map(A => DataB(18), B => AddsubAux_18_net, Y => 
        DataBXnor2_18_net);
    MAJ3_14 : MAJ3
      port map(A => MAJ3_19_Y, B => DataA(9), C => 
        DataBXnor2_9_net, Y => MAJ3_14_Y);
    MAJ3_9 : MAJ3
      port map(A => MAJ3_18_Y, B => DataA(2), C => 
        DataBXnor2_2_net, Y => MAJ3_9_Y);
    XOR3_Sum_21_inst : XOR3
      port map(A => DataA(21), B => DataBXnor2_21_net, C => 
        MAJ3_5_Y, Y => Sum(21));
    MAJ3_17 : MAJ3
      port map(A => MAJ3_4_Y, B => DataA(12), C => 
        DataBXnor2_12_net, Y => MAJ3_17_Y);
end DEF_ARCH;

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.3.4
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:SmartFusion
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_ADD_SUB
-- LPM_HINT:RIPADDSUB
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:D:/Work/marmote/projects/DDC_test/smartgen\adder
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IP4X3M1
-- SMARTGEN_PACKAGE:fg484
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- CI_POLARITY:2
-- CO_POLARITY:2
-- WIDTH:22
-- ADDSUB_POLARITY:1
-- ADDSUB_FANIN:AUTO
-- ADDSUB_VAL:6
-- DEBUG:0

-- _End_Comments_

