-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity mult is 
    port( DataA : in std_logic_vector(13 downto 0); DataB : in 
        std_logic_vector(7 downto 0); Mult : out 
        std_logic_vector(21 downto 0)) ;
end mult;


architecture DEF_ARCH of  mult is

    component MAJ3
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component AND2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component XOR3
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component NOR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component BUFF
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component AO1
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component XOR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component AND2A
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component XNOR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    signal S_0_net, S_1_net, S_2_net, S_3_net, E_0_net, E_1_net, 
        E_2_net, E_3_net, PP0_1_net, PP0_2_net, PP0_3_net, 
        PP0_4_net, PP0_5_net, PP0_6_net, PP0_7_net, PP0_8_net, 
        PP0_9_net, PP0_10_net, PP0_11_net, PP0_12_net, PP0_13_net, 
        PP0_14_net, PP1_0_net, PP1_1_net, PP1_2_net, PP1_3_net, 
        PP1_4_net, PP1_5_net, PP1_6_net, PP1_7_net, PP1_8_net, 
        PP1_9_net, PP1_10_net, PP1_11_net, PP1_12_net, PP1_13_net, 
        PP1_14_net, PP2_0_net, PP2_1_net, PP2_2_net, PP2_3_net, 
        PP2_4_net, PP2_5_net, PP2_6_net, PP2_7_net, PP2_8_net, 
        PP2_9_net, PP2_10_net, PP2_11_net, PP2_12_net, PP2_13_net, 
        PP2_14_net, PP3_0_net, PP3_1_net, PP3_2_net, PP3_3_net, 
        PP3_4_net, PP3_5_net, PP3_6_net, PP3_7_net, PP3_8_net, 
        PP3_9_net, PP3_10_net, PP3_11_net, PP3_12_net, PP3_13_net, 
        PP3_14_net, PP4_0_net, PP4_1_net, PP4_2_net, PP4_3_net, 
        PP4_4_net, PP4_5_net, PP4_6_net, PP4_7_net, PP4_8_net, 
        PP4_9_net, PP4_10_net, PP4_11_net, PP4_12_net, PP4_13_net, 
        SumA_3_net, SumA_4_net, SumA_5_net, SumA_6_net, 
        SumA_7_net, SumA_8_net, SumA_9_net, SumA_10_net, 
        SumA_11_net, SumA_12_net, SumA_13_net, SumA_14_net, 
        SumA_15_net, SumA_16_net, SumA_17_net, SumA_18_net, 
        SumA_19_net, SumA_20_net, SumB_2_net, SumB_3_net, 
        SumB_4_net, SumB_5_net, SumB_6_net, SumB_7_net, 
        SumB_8_net, SumB_9_net, SumB_10_net, SumB_11_net, 
        SumB_12_net, SumB_13_net, SumB_14_net, SumB_15_net, 
        SumB_16_net, SumB_17_net, SumB_18_net, SumB_19_net, 
        SumB_20_net, XOR2_10_Y, AND2_44_Y, XOR3_10_Y, MAJ3_3_Y, 
        XOR3_15_Y, MAJ3_19_Y, XOR3_0_Y, MAJ3_14_Y, XOR3_14_Y, 
        MAJ3_16_Y, XOR3_2_Y, MAJ3_11_Y, XOR3_16_Y, MAJ3_1_Y, 
        XOR3_12_Y, MAJ3_4_Y, XOR3_20_Y, MAJ3_18_Y, XOR3_7_Y, 
        MAJ3_20_Y, XOR3_23_Y, MAJ3_12_Y, XOR2_5_Y, AND2_92_Y, 
        XOR2_22_Y, AND2_63_Y, XOR3_21_Y, MAJ3_9_Y, XOR3_18_Y, 
        MAJ3_6_Y, XOR3_8_Y, MAJ3_10_Y, XOR3_13_Y, MAJ3_15_Y, 
        XOR3_3_Y, MAJ3_23_Y, XOR3_5_Y, MAJ3_5_Y, XOR3_4_Y, 
        MAJ3_7_Y, XOR3_22_Y, MAJ3_0_Y, XOR3_9_Y, MAJ3_13_Y, 
        XOR3_1_Y, MAJ3_8_Y, XOR3_19_Y, MAJ3_21_Y, XOR3_17_Y, 
        MAJ3_17_Y, XOR3_6_Y, MAJ3_22_Y, XOR3_11_Y, MAJ3_2_Y, 
        XOR2_35_Y, AND2_67_Y, BUFF_30_Y, BUFF_1_Y, BUFF_26_Y, 
        BUFF_10_Y, BUFF_5_Y, BUFF_13_Y, BUFF_21_Y, BUFF_8_Y, 
        BUFF_9_Y, BUFF_6_Y, BUFF_36_Y, BUFF_16_Y, BUFF_0_Y, 
        BUFF_3_Y, BUFF_4_Y, BUFF_42_Y, BUFF_7_Y, BUFF_17_Y, 
        BUFF_28_Y, BUFF_35_Y, BUFF_2_Y, BUFF_20_Y, BUFF_11_Y, 
        BUFF_39_Y, BUFF_37_Y, BUFF_22_Y, BUFF_43_Y, BUFF_12_Y, 
        BUFF_27_Y, BUFF_23_Y, BUFF_24_Y, BUFF_33_Y, XOR2_16_Y, 
        XOR2_21_Y, NOR2_1_Y, AND2_115_Y, AND2_57_Y, MX2_34_Y, 
        AND2_32_Y, MX2_10_Y, AND2_89_Y, MX2_29_Y, AND2_47_Y, 
        MX2_13_Y, XNOR2_7_Y, XOR2_53_Y, NOR2_3_Y, AND2_127_Y, 
        MX2_38_Y, AND2_54_Y, MX2_45_Y, AND2_99_Y, MX2_2_Y, 
        AND2_19_Y, MX2_24_Y, AND2_17_Y, MX2_42_Y, XNOR2_5_Y, 
        XOR2_19_Y, NOR2_0_Y, AND2_82_Y, MX2_32_Y, AND2_46_Y, 
        MX2_3_Y, AND2_31_Y, AND2_86_Y, MX2_43_Y, AND2_66_Y, 
        MX2_7_Y, XNOR2_0_Y, BUFF_29_Y, BUFF_32_Y, BUFF_40_Y, 
        XOR2_57_Y, AND2A_2_Y, AND2_80_Y, AND2_33_Y, MX2_1_Y, 
        AND2_53_Y, MX2_39_Y, AND2_6_Y, MX2_0_Y, AND2_55_Y, 
        MX2_11_Y, AND2A_1_Y, AND2_72_Y, MX2_22_Y, AND2_98_Y, 
        MX2_20_Y, AND2_9_Y, MX2_40_Y, AND2_71_Y, MX2_4_Y, 
        AND2_13_Y, MX2_33_Y, AND2A_0_Y, AND2_43_Y, MX2_23_Y, 
        AND2_62_Y, MX2_17_Y, AND2_29_Y, AND2_45_Y, MX2_9_Y, 
        AND2_18_Y, MX2_14_Y, BUFF_18_Y, BUFF_19_Y, BUFF_14_Y, 
        BUFF_15_Y, BUFF_25_Y, XOR2_37_Y, XOR2_54_Y, NOR2_2_Y, 
        AND2_40_Y, AND2_39_Y, MX2_46_Y, AND2_104_Y, MX2_15_Y, 
        AND2_125_Y, MX2_37_Y, AND2_15_Y, MX2_5_Y, XNOR2_1_Y, 
        XOR2_32_Y, NOR2_8_Y, AND2_95_Y, MX2_41_Y, AND2_118_Y, 
        MX2_27_Y, AND2_101_Y, MX2_49_Y, AND2_16_Y, MX2_25_Y, 
        AND2_114_Y, MX2_26_Y, XNOR2_2_Y, XOR2_46_Y, NOR2_4_Y, 
        AND2_112_Y, MX2_35_Y, AND2_121_Y, MX2_51_Y, AND2_56_Y, 
        AND2_123_Y, MX2_8_Y, AND2_11_Y, MX2_28_Y, XNOR2_4_Y, 
        BUFF_38_Y, BUFF_31_Y, BUFF_34_Y, BUFF_41_Y, XOR2_29_Y, 
        XOR2_3_Y, NOR2_7_Y, AND2_97_Y, AND2_74_Y, MX2_18_Y, 
        AND2_108_Y, MX2_30_Y, AND2_110_Y, MX2_44_Y, AND2_129_Y, 
        MX2_6_Y, XNOR2_8_Y, XOR2_20_Y, NOR2_6_Y, AND2_117_Y, 
        MX2_21_Y, AND2_41_Y, MX2_19_Y, AND2_8_Y, MX2_36_Y, 
        AND2_59_Y, MX2_47_Y, AND2_126_Y, MX2_48_Y, XNOR2_3_Y, 
        XOR2_38_Y, NOR2_5_Y, AND2_107_Y, MX2_12_Y, AND2_84_Y, 
        MX2_50_Y, AND2_64_Y, AND2_37_Y, MX2_16_Y, AND2_105_Y, 
        MX2_31_Y, XNOR2_6_Y, AND2_78_Y, AND2_109_Y, AND2_30_Y, 
        AND2_76_Y, AND2_85_Y, AND2_124_Y, AND2_34_Y, AND2_91_Y, 
        AND2_21_Y, AND2_35_Y, AND2_52_Y, AND2_50_Y, AND2_3_Y, 
        AND2_61_Y, AND2_83_Y, AND2_130_Y, AND2_58_Y, AND2_100_Y, 
        AND2_28_Y, AND2_23_Y, XOR2_0_Y, XOR2_7_Y, XOR2_43_Y, 
        XOR2_40_Y, XOR2_1_Y, XOR2_48_Y, XOR2_17_Y, XOR2_4_Y, 
        XOR2_49_Y, XOR2_30_Y, XOR2_44_Y, XOR2_25_Y, XOR2_34_Y, 
        XOR2_9_Y, XOR2_33_Y, XOR2_8_Y, XOR2_55_Y, XOR2_51_Y, 
        XOR2_18_Y, XOR2_13_Y, XOR2_23_Y, AND2_122_Y, AO1_16_Y, 
        AND2_73_Y, AO1_42_Y, AND2_102_Y, AO1_19_Y, AND2_131_Y, 
        AO1_3_Y, AND2_106_Y, AO1_26_Y, AND2_24_Y, AO1_30_Y, 
        AND2_51_Y, AO1_14_Y, AND2_38_Y, AO1_11_Y, AND2_79_Y, 
        AO1_21_Y, AND2_87_Y, AND2_113_Y, AND2_60_Y, AO1_25_Y, 
        AND2_88_Y, AO1_43_Y, AND2_120_Y, AO1_45_Y, AND2_94_Y, 
        AO1_9_Y, AND2_12_Y, AO1_31_Y, AND2_27_Y, AO1_33_Y, 
        AND2_20_Y, AO1_27_Y, AND2_65_Y, AO1_39_Y, AND2_0_Y, 
        AO1_20_Y, AND2_25_Y, AO1_18_Y, AND2_111_Y, AND2_1_Y, 
        AND2_42_Y, AND2_7_Y, AND2_70_Y, AO1_36_Y, AND2_90_Y, 
        AO1_38_Y, AND2_81_Y, AO1_32_Y, AND2_119_Y, AO1_44_Y, 
        AND2_68_Y, AO1_37_Y, AND2_96_Y, AO1_35_Y, AND2_36_Y, 
        AO1_46_Y, AND2_69_Y, AND2_103_Y, AND2_77_Y, AND2_128_Y, 
        AND2_14_Y, AND2_2_Y, AND2_49_Y, AND2_4_Y, AND2_26_Y, 
        AO1_7_Y, AND2_116_Y, AND2_5_Y, AND2_48_Y, AND2_10_Y, 
        AND2_75_Y, AO1_28_Y, AND2_93_Y, AND2_22_Y, AO1_4_Y, 
        AO1_13_Y, AO1_10_Y, AO1_29_Y, AO1_0_Y, AO1_1_Y, AO1_17_Y, 
        AO1_22_Y, AO1_23_Y, AO1_34_Y, AO1_5_Y, AO1_8_Y, AO1_2_Y, 
        AO1_15_Y, AO1_12_Y, AO1_24_Y, AO1_40_Y, AO1_41_Y, AO1_6_Y, 
        XOR2_15_Y, XOR2_12_Y, XOR2_42_Y, XOR2_56_Y, XOR2_36_Y, 
        XOR2_28_Y, XOR2_26_Y, XOR2_50_Y, XOR2_11_Y, XOR2_39_Y, 
        XOR2_31_Y, XOR2_27_Y, XOR2_52_Y, XOR2_14_Y, XOR2_47_Y, 
        XOR2_45_Y, XOR2_41_Y, XOR2_2_Y, XOR2_24_Y, XOR2_6_Y, 
        VCC_1_net : std_logic ;
    begin   

    VCC_2_net : VCC port map(Y => VCC_1_net);
    MAJ3_16 : MAJ3
      port map(A => PP2_7_net, B => PP1_9_net, C => PP0_11_net, 
        Y => MAJ3_16_Y);
    AND2_2 : AND2
      port map(A => AND2_90_Y, B => AND2_119_Y, Y => AND2_2_Y);
    XOR3_SumB_17_inst : XOR3
      port map(A => MAJ3_17_Y, B => MAJ3_12_Y, C => XOR3_6_Y, 
        Y => SumB_17_net);
    NOR2_2 : NOR2
      port map(A => XOR2_54_Y, B => XNOR2_1_Y, Y => NOR2_2_Y);
    BUFF_23 : BUFF
      port map(A => DataB(3), Y => BUFF_23_Y);
    AND2_20 : AND2
      port map(A => AND2_106_Y, B => AND2_24_Y, Y => AND2_20_Y);
    AND2_PP4_8_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_17_Y, Y => PP4_8_net);
    XOR3_SumB_8_inst : XOR3
      port map(A => MAJ3_10_Y, B => XOR3_15_Y, C => XOR3_13_Y, 
        Y => SumB_8_net);
    AO1_11 : AO1
      port map(A => XOR2_51_Y, B => AND2_130_Y, C => AND2_58_Y, 
        Y => AO1_11_Y);
    XOR2_PP3_6_inst : XOR2
      port map(A => MX2_27_Y, B => BUFF_15_Y, Y => PP3_6_net);
    XOR2_PP1_4_inst : XOR2
      port map(A => MX2_32_Y, B => BUFF_23_Y, Y => PP1_4_net);
    XOR2_PP1_12_inst : XOR2
      port map(A => MX2_29_Y, B => BUFF_33_Y, Y => PP1_12_net);
    AND2_11 : AND2
      port map(A => XOR2_46_Y, B => BUFF_8_Y, Y => AND2_11_Y);
    XOR2_PP0_6_inst : XOR2
      port map(A => MX2_20_Y, B => BUFF_32_Y, Y => PP0_6_net);
    XOR2_PP2_6_inst : XOR2
      port map(A => MX2_19_Y, B => BUFF_34_Y, Y => PP2_6_net);
    MAJ3_19 : MAJ3
      port map(A => PP2_5_net, B => PP1_7_net, C => PP0_9_net, 
        Y => MAJ3_19_Y);
    BUFF_34 : BUFF
      port map(A => DataB(5), Y => BUFF_34_Y);
    BUFF_10 : BUFF
      port map(A => DataA(1), Y => BUFF_10_Y);
    AND2_22 : AND2
      port map(A => PP0_1_net, B => S_0_net, Y => AND2_22_Y);
    XOR2_PP1_10_inst : XOR2
      port map(A => MX2_10_Y, B => BUFF_33_Y, Y => PP1_10_net);
    AND2_71 : AND2
      port map(A => DataB(0), B => BUFF_4_Y, Y => AND2_71_Y);
    AND2_PP4_3_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_8_Y, Y => PP4_3_net);
    XOR2_PP0_5_inst : XOR2
      port map(A => MX2_40_Y, B => BUFF_32_Y, Y => PP0_5_net);
    XOR2_19 : XOR2
      port map(A => BUFF_27_Y, B => DataB(2), Y => XOR2_19_Y);
    AND2_44 : AND2
      port map(A => PP1_5_net, B => PP0_7_net, Y => AND2_44_Y);
    AO1_31 : AO1
      port map(A => AND2_24_Y, B => AO1_3_Y, C => AO1_26_Y, Y => 
        AO1_31_Y);
    XOR2_23 : XOR2
      port map(A => SumA_20_net, B => SumB_20_net, Y => XOR2_23_Y);
    XOR2_1 : XOR2
      port map(A => SumA_4_net, B => SumB_4_net, Y => XOR2_1_Y);
    MX2_17 : MX2
      port map(A => AND2_62_Y, B => BUFF_30_Y, S => AND2A_0_Y, 
        Y => MX2_17_Y);
    AND2_S_3_inst : AND2
      port map(A => XOR2_37_Y, B => DataB(7), Y => S_3_net);
    MAJ3_SumA_11_inst : MAJ3
      port map(A => XOR3_5_Y, B => MAJ3_23_Y, C => XOR3_14_Y, 
        Y => SumA_11_net);
    MX2_49 : MX2
      port map(A => AND2_101_Y, B => BUFF_6_Y, S => NOR2_8_Y, 
        Y => MX2_49_Y);
    MAJ3_8 : MAJ3
      port map(A => MAJ3_4_Y, B => PP4_7_net, C => PP3_9_net, 
        Y => MAJ3_8_Y);
    BUFF_8 : BUFF
      port map(A => DataA(3), Y => BUFF_8_Y);
    AND2_104 : AND2
      port map(A => XOR2_54_Y, B => BUFF_20_Y, Y => AND2_104_Y);
    XOR2_PP1_13_inst : XOR2
      port map(A => MX2_13_Y, B => BUFF_33_Y, Y => PP1_13_net);
    XOR2_PP1_0_inst : XOR2
      port map(A => XOR2_16_Y, B => DataB(3), Y => PP1_0_net);
    XOR2_47 : XOR2
      port map(A => SumA_15_net, B => SumB_15_net, Y => XOR2_47_Y);
    XOR2_38 : XOR2
      port map(A => BUFF_38_Y, B => DataB(4), Y => XOR2_38_Y);
    XOR2_Mult_0_inst : XOR2
      port map(A => XOR2_57_Y, B => DataB(1), Y => Mult(0));
    MX2_21 : MX2
      port map(A => AND2_117_Y, B => BUFF_7_Y, S => NOR2_6_Y, 
        Y => MX2_21_Y);
    AND2_124 : AND2
      port map(A => SumA_6_net, B => SumB_6_net, Y => AND2_124_Y);
    AO1_7 : AO1
      port map(A => AND2_36_Y, B => AO1_38_Y, C => AO1_35_Y, Y => 
        AO1_7_Y);
    XOR3_18 : XOR3
      port map(A => PP3_1_net, B => PP2_3_net, C => S_3_net, Y => 
        XOR3_18_Y);
    XOR2_Mult_19_inst : XOR2
      port map(A => XOR2_2_Y, B => AO1_40_Y, Y => Mult(19));
    XOR2_PP2_4_inst : XOR2
      port map(A => MX2_12_Y, B => BUFF_31_Y, Y => PP2_4_net);
    AND2_18 : AND2
      port map(A => DataB(0), B => BUFF_21_Y, Y => AND2_18_Y);
    AND2_15 : AND2
      port map(A => XOR2_54_Y, B => BUFF_12_Y, Y => AND2_15_Y);
    AND2_84 : AND2
      port map(A => XOR2_38_Y, B => BUFF_26_Y, Y => AND2_84_Y);
    NOR2_6 : NOR2
      port map(A => XOR2_20_Y, B => XNOR2_3_Y, Y => NOR2_6_Y);
    AO1_25 : AO1
      port map(A => AND2_73_Y, B => AO1_4_Y, C => AO1_16_Y, Y => 
        AO1_25_Y);
    AND2_78 : AND2
      port map(A => PP0_2_net, B => PP1_0_net, Y => AND2_78_Y);
    AND2_75 : AND2
      port map(A => AND2_116_Y, B => AND2_111_Y, Y => AND2_75_Y);
    MX2_44 : MX2
      port map(A => AND2_110_Y, B => BUFF_11_Y, S => NOR2_7_Y, 
        Y => MX2_44_Y);
    XOR2_45 : XOR2
      port map(A => SumA_16_net, B => SumB_16_net, Y => XOR2_45_Y);
    AND2_SumA_3_inst : AND2
      port map(A => PP1_1_net, B => PP0_3_net, Y => SumA_3_net);
    XOR2_Mult_16_inst : XOR2
      port map(A => XOR2_47_Y, B => AO1_15_Y, Y => Mult(16));
    BUFF_21 : BUFF
      port map(A => DataA(3), Y => BUFF_21_Y);
    MAJ3_9 : MAJ3
      port map(A => PP2_2_net, B => PP1_4_net, C => PP0_6_net, 
        Y => MAJ3_9_Y);
    AND2_PP4_0_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_1_Y, Y => PP4_0_net);
    AND2_S_0_inst : AND2
      port map(A => XOR2_57_Y, B => DataB(1), Y => S_0_net);
    AND2_1 : AND2
      port map(A => AND2_60_Y, B => XOR2_1_Y, Y => AND2_1_Y);
    AND2_49 : AND2
      port map(A => AND2_90_Y, B => AND2_68_Y, Y => AND2_49_Y);
    AO1_8 : AO1
      port map(A => AND2_119_Y, B => AO1_36_Y, C => AO1_32_Y, 
        Y => AO1_8_Y);
    AND2_10 : AND2
      port map(A => AND2_116_Y, B => AND2_25_Y, Y => AND2_10_Y);
    MAJ3_23 : MAJ3
      port map(A => MAJ3_19_Y, B => PP4_2_net, C => PP3_4_net, 
        Y => MAJ3_23_Y);
    XOR2_20 : XOR2
      port map(A => BUFF_38_Y, B => DataB(4), Y => XOR2_20_Y);
    AND2_7 : AND2
      port map(A => AND2_60_Y, B => AND2_120_Y, Y => AND2_7_Y);
    AND2_70 : AND2
      port map(A => AND2_88_Y, B => AND2_94_Y, Y => AND2_70_Y);
    AND2_S_1_inst : AND2
      port map(A => XOR2_16_Y, B => DataB(3), Y => S_1_net);
    AND2A_1 : AND2A
      port map(A => DataB(0), B => BUFF_32_Y, Y => AND2A_1_Y);
    AND2_12 : AND2
      port map(A => AND2_106_Y, B => XOR2_44_Y, Y => AND2_12_Y);
    XOR2_52 : XOR2
      port map(A => SumA_13_net, B => SumB_13_net, Y => XOR2_52_Y);
    AO1_42 : AO1
      port map(A => XOR2_48_Y, B => AND2_76_Y, C => AND2_85_Y, 
        Y => AO1_42_Y);
    AND2_72 : AND2
      port map(A => DataB(0), B => BUFF_28_Y, Y => AND2_72_Y);
    AND2_61 : AND2
      port map(A => SumA_14_net, B => SumB_14_net, Y => AND2_61_Y);
    AO1_15 : AO1
      port map(A => AND2_96_Y, B => AO1_38_Y, C => AO1_37_Y, Y => 
        AO1_15_Y);
    MX2_5 : MX2
      port map(A => AND2_15_Y, B => BUFF_22_Y, S => NOR2_2_Y, 
        Y => MX2_5_Y);
    BUFF_28 : BUFF
      port map(A => DataA(9), Y => BUFF_28_Y);
    MX2_25 : MX2
      port map(A => AND2_16_Y, B => BUFF_3_Y, S => NOR2_8_Y, Y => 
        MX2_25_Y);
    MAJ3_13 : MAJ3
      port map(A => MAJ3_1_Y, B => PP4_6_net, C => PP3_8_net, 
        Y => MAJ3_13_Y);
    AND2_PP4_5_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_16_Y, Y => PP4_5_net);
    XOR2_PP2_14_inst : XOR2
      port map(A => AND2_97_Y, B => BUFF_41_Y, Y => PP2_14_net);
    AND2_89 : AND2
      port map(A => XOR2_21_Y, B => BUFF_37_Y, Y => AND2_89_Y);
    XOR2_24 : XOR2
      port map(A => SumA_19_net, B => SumB_19_net, Y => XOR2_24_Y);
    AND2_57 : AND2
      port map(A => XOR2_21_Y, B => BUFF_11_Y, Y => AND2_57_Y);
    XOR2_21 : XOR2
      port map(A => BUFF_27_Y, B => DataB(2), Y => XOR2_21_Y);
    MAJ3_22 : MAJ3
      port map(A => XOR2_5_Y, B => PP4_10_net, C => PP3_12_net, 
        Y => MAJ3_22_Y);
    XOR3_SumB_14_inst : XOR3
      port map(A => MAJ3_13_Y, B => XOR3_20_Y, C => XOR3_1_Y, 
        Y => SumB_14_net);
    BUFF_2 : BUFF
      port map(A => DataA(10), Y => BUFF_2_Y);
    AO1_35 : AO1
      port map(A => AND2_0_Y, B => AO1_33_Y, C => AO1_39_Y, Y => 
        AO1_35_Y);
    XOR2_PP0_7_inst : XOR2
      port map(A => MX2_4_Y, B => BUFF_32_Y, Y => PP0_7_net);
    AND2_46 : AND2
      port map(A => XOR2_19_Y, B => BUFF_26_Y, Y => AND2_46_Y);
    XOR2_PP3_7_inst : XOR2
      port map(A => MX2_25_Y, B => BUFF_15_Y, Y => PP3_7_net);
    XOR2_16 : XOR2
      port map(A => AND2_31_Y, B => BUFF_23_Y, Y => XOR2_16_Y);
    MAJ3_12 : MAJ3
      port map(A => PP2_13_net, B => E_1_net, C => E_0_net, Y => 
        MAJ3_12_Y);
    XOR2_PP2_12_inst : XOR2
      port map(A => MX2_44_Y, B => BUFF_41_Y, Y => PP2_12_net);
    AND2_68 : AND2
      port map(A => AND2_20_Y, B => AND2_51_Y, Y => AND2_68_Y);
    AND2_65 : AND2
      port map(A => AND2_51_Y, B => XOR2_33_Y, Y => AND2_65_Y);
    AO1_24 : AO1
      port map(A => XOR2_55_Y, B => AO1_12_Y, C => AND2_130_Y, 
        Y => AO1_24_Y);
    AND2_43 : AND2
      port map(A => DataB(0), B => BUFF_9_Y, Y => AND2_43_Y);
    XOR2_PP2_10_inst : XOR2
      port map(A => MX2_30_Y, B => BUFF_41_Y, Y => PP2_10_net);
    XOR3_SumB_5_inst : XOR3
      port map(A => AND2_63_Y, B => PP3_0_net, C => XOR3_21_Y, 
        Y => SumB_5_net);
    NOR2_3 : NOR2
      port map(A => XOR2_53_Y, B => XNOR2_5_Y, Y => NOR2_3_Y);
    MX2_20 : MX2
      port map(A => AND2_98_Y, B => BUFF_36_Y, S => AND2A_1_Y, 
        Y => MX2_20_Y);
    AND2_86 : AND2
      port map(A => XOR2_19_Y, B => BUFF_5_Y, Y => AND2_86_Y);
    BUFF_20 : BUFF
      port map(A => DataA(10), Y => BUFF_20_Y);
    MX2_19 : MX2
      port map(A => AND2_41_Y, B => BUFF_36_Y, S => NOR2_6_Y, 
        Y => MX2_19_Y);
    AND2_6 : AND2
      port map(A => DataB(0), B => BUFF_37_Y, Y => AND2_6_Y);
    AND2_60 : AND2
      port map(A => AND2_122_Y, B => AND2_73_Y, Y => AND2_60_Y);
    XOR2_PP2_13_inst : XOR2
      port map(A => MX2_6_Y, B => BUFF_41_Y, Y => PP2_13_net);
    XOR3_23 : XOR3
      port map(A => E_1_net, B => E_0_net, C => PP2_13_net, Y => 
        XOR3_23_Y);
    XOR2_Mult_21_inst : XOR2
      port map(A => XOR2_6_Y, B => AO1_6_Y, Y => Mult(21));
    XOR2_Mult_5_inst : XOR2
      port map(A => XOR2_56_Y, B => AO1_10_Y, Y => Mult(5));
    AND2_83 : AND2
      port map(A => SumA_15_net, B => SumB_15_net, Y => AND2_83_Y);
    XOR2_57 : XOR2
      port map(A => AND2_29_Y, B => BUFF_29_Y, Y => XOR2_57_Y);
    XOR2_33 : XOR2
      port map(A => SumA_14_net, B => SumB_14_net, Y => XOR2_33_Y);
    AND2_62 : AND2
      port map(A => DataB(0), B => BUFF_26_Y, Y => AND2_62_Y);
    AND2_97 : AND2
      port map(A => NOR2_7_Y, B => BUFF_43_Y, Y => AND2_97_Y);
    XNOR2_2 : XNOR2
      port map(A => DataB(6), B => BUFF_15_Y, Y => XNOR2_2_Y);
    XOR2_49 : XOR2
      port map(A => SumA_8_net, B => SumB_8_net, Y => XOR2_49_Y);
    MAJ3_17 : MAJ3
      port map(A => MAJ3_20_Y, B => PP4_9_net, C => PP3_11_net, 
        Y => MAJ3_17_Y);
    MX2_31 : MX2
      port map(A => AND2_105_Y, B => BUFF_5_Y, S => NOR2_5_Y, 
        Y => MX2_31_Y);
    XOR3_13 : XOR3
      port map(A => PP4_1_net, B => PP3_3_net, C => MAJ3_3_Y, 
        Y => XOR3_13_Y);
    AO1_14 : AO1
      port map(A => XOR2_8_Y, B => AND2_61_Y, C => AND2_83_Y, 
        Y => AO1_14_Y);
    XOR3_SumB_13_inst : XOR3
      port map(A => MAJ3_0_Y, B => XOR3_12_Y, C => XOR3_9_Y, Y => 
        SumB_13_net);
    XOR2_PP0_11_inst : XOR2
      port map(A => MX2_1_Y, B => BUFF_40_Y, Y => PP0_11_net);
    XOR3_SumB_3_inst : XOR3
      port map(A => PP1_2_net, B => PP0_4_net, C => PP2_0_net, 
        Y => SumB_3_net);
    XOR2_4 : XOR2
      port map(A => SumA_7_net, B => SumB_7_net, Y => XOR2_4_Y);
    MAJ3_SumA_9_inst : MAJ3
      port map(A => XOR3_13_Y, B => MAJ3_10_Y, C => XOR3_15_Y, 
        Y => SumA_9_net);
    MX2_14 : MX2
      port map(A => AND2_18_Y, B => BUFF_5_Y, S => AND2A_0_Y, 
        Y => MX2_14_Y);
    XOR2_55 : XOR2
      port map(A => SumA_16_net, B => SumB_16_net, Y => XOR2_55_Y);
    XOR2_Mult_7_inst : XOR2
      port map(A => XOR2_28_Y, B => AO1_0_Y, Y => Mult(7));
    AND2_24 : AND2
      port map(A => XOR2_44_Y, B => XOR2_25_Y, Y => AND2_24_Y);
    XOR2_PP3_3_inst : XOR2
      port map(A => MX2_28_Y, B => BUFF_14_Y, Y => PP3_3_net);
    AO1_40 : AO1
      port map(A => AND2_79_Y, B => AO1_12_Y, C => AO1_11_Y, Y => 
        AO1_40_Y);
    XNOR2_0 : XNOR2
      port map(A => DataB(2), B => BUFF_23_Y, Y => XNOR2_0_Y);
    MAJ3_0 : MAJ3
      port map(A => MAJ3_11_Y, B => PP4_5_net, C => PP3_7_net, 
        Y => MAJ3_0_Y);
    AND2_31 : AND2
      port map(A => XOR2_19_Y, B => BUFF_30_Y, Y => AND2_31_Y);
    MAJ3_14 : MAJ3
      port map(A => PP2_6_net, B => PP1_8_net, C => PP0_10_net, 
        Y => MAJ3_14_Y);
    XOR2_PP1_5_inst : XOR2
      port map(A => MX2_2_Y, B => BUFF_24_Y, Y => PP1_5_net);
    AND2_113 : AND2
      port map(A => AND2_122_Y, B => XOR2_43_Y, Y => AND2_113_Y);
    AO1_34 : AO1
      port map(A => AND2_12_Y, B => AO1_36_Y, C => AO1_9_Y, Y => 
        AO1_34_Y);
    XOR3_SumB_19_inst : XOR3
      port map(A => XOR2_35_Y, B => PP4_12_net, C => MAJ3_2_Y, 
        Y => SumB_19_net);
    XOR2_18 : XOR2
      port map(A => SumA_18_net, B => SumB_18_net, Y => XOR2_18_Y);
    INV_E_0_inst : INV
      port map(A => DataB(1), Y => E_0_net);
    BUFF_14 : BUFF
      port map(A => DataB(7), Y => BUFF_14_Y);
    BUFF_32 : BUFF
      port map(A => DataB(1), Y => BUFF_32_Y);
    XOR2_Mult_15_inst : XOR2
      port map(A => XOR2_14_Y, B => AO1_2_Y, Y => Mult(15));
    AO1_46 : AO1
      port map(A => XOR2_23_Y, B => AO1_18_Y, C => AND2_23_Y, 
        Y => AO1_46_Y);
    XOR3_20 : XOR3
      port map(A => PP1_13_net, B => DataB(1), C => PP2_11_net, 
        Y => XOR3_20_Y);
    XOR2_8 : XOR2
      port map(A => SumA_15_net, B => SumB_15_net, Y => XOR2_8_Y);
    AND2_116 : AND2
      port map(A => AND2_81_Y, B => AND2_36_Y, Y => AND2_116_Y);
    AND2_110 : AND2
      port map(A => XOR2_3_Y, B => BUFF_37_Y, Y => AND2_110_Y);
    MAJ3_SumA_5_inst : MAJ3
      port map(A => XOR2_22_Y, B => S_2_net, C => PP2_1_net, Y => 
        SumA_5_net);
    NOR2_0 : NOR2
      port map(A => XOR2_19_Y, B => XNOR2_0_Y, Y => NOR2_0_Y);
    AO1_43 : AO1
      port map(A => XOR2_17_Y, B => AO1_42_Y, C => AND2_124_Y, 
        Y => AO1_43_Y);
    XOR2_30 : XOR2
      port map(A => SumA_9_net, B => SumB_9_net, Y => XOR2_30_Y);
    MX2_35 : MX2
      port map(A => AND2_112_Y, B => BUFF_8_Y, S => NOR2_4_Y, 
        Y => MX2_35_Y);
    XOR3_10 : XOR3
      port map(A => PP1_6_net, B => PP0_8_net, C => PP2_4_net, 
        Y => XOR3_10_Y);
    XOR2_PP3_2_inst : XOR2
      port map(A => MX2_8_Y, B => BUFF_14_Y, Y => PP3_2_net);
    XOR3_SumB_12_inst : XOR3
      port map(A => MAJ3_7_Y, B => XOR3_16_Y, C => XOR3_22_Y, 
        Y => SumB_12_net);
    AND2_38 : AND2
      port map(A => XOR2_33_Y, B => XOR2_8_Y, Y => AND2_38_Y);
    AND2_35 : AND2
      port map(A => SumA_10_net, B => SumB_10_net, Y => AND2_35_Y);
    XOR2_Mult_13_inst : XOR2
      port map(A => XOR2_27_Y, B => AO1_5_Y, Y => Mult(13));
    XOR2_PP0_8_inst : XOR2
      port map(A => MX2_33_Y, B => BUFF_32_Y, Y => PP0_8_net);
    MX2_8 : MX2
      port map(A => AND2_123_Y, B => BUFF_10_Y, S => NOR2_4_Y, 
        Y => MX2_8_Y);
    AND2_29 : AND2
      port map(A => DataB(0), B => BUFF_30_Y, Y => AND2_29_Y);
    BUFF_39 : BUFF
      port map(A => DataA(11), Y => BUFF_39_Y);
    XOR3_21 : XOR3
      port map(A => PP1_4_net, B => PP0_6_net, C => PP2_2_net, 
        Y => XOR3_21_Y);
    AND2_117 : AND2
      port map(A => XOR2_20_Y, B => BUFF_28_Y, Y => AND2_117_Y);
    AND2_PP4_12_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_22_Y, Y => PP4_12_net);
    XOR2_34 : XOR2
      port map(A => SumA_12_net, B => SumB_12_net, Y => XOR2_34_Y);
    MAJ3_4 : MAJ3
      port map(A => PP2_10_net, B => PP1_12_net, C => PP0_14_net, 
        Y => MAJ3_4_Y);
    XOR2_31 : XOR2
      port map(A => SumA_11_net, B => SumB_11_net, Y => XOR2_31_Y);
    MAJ3_SumA_19_inst : MAJ3
      port map(A => XOR3_11_Y, B => MAJ3_22_Y, C => AND2_92_Y, 
        Y => SumA_19_net);
    XOR3_14 : XOR3
      port map(A => PP1_9_net, B => PP0_11_net, C => PP2_7_net, 
        Y => XOR3_14_Y);
    AND2_3 : AND2
      port map(A => SumA_13_net, B => SumB_13_net, Y => AND2_3_Y);
    MAJ3_SumA_10_inst : MAJ3
      port map(A => XOR3_3_Y, B => MAJ3_15_Y, C => XOR3_0_Y, Y => 
        SumA_10_net);
    XOR3_11 : XOR3
      port map(A => PP3_13_net, B => E_2_net, C => PP4_11_net, 
        Y => XOR3_11_Y);
    AND2_30 : AND2
      port map(A => SumA_3_net, B => SumB_3_net, Y => AND2_30_Y);
    XOR2_PP3_14_inst : XOR2
      port map(A => AND2_40_Y, B => BUFF_25_Y, Y => PP3_14_net);
    XNOR2_6 : XNOR2
      port map(A => DataB(4), B => BUFF_31_Y, Y => XNOR2_6_Y);
    AND2_14 : AND2
      port map(A => AND2_90_Y, B => AND2_27_Y, Y => AND2_14_Y);
    AND2_103 : AND2
      port map(A => AND2_70_Y, B => XOR2_49_Y, Y => AND2_103_Y);
    AND2_74 : AND2
      port map(A => XOR2_3_Y, B => BUFF_11_Y, Y => AND2_74_Y);
    AND2_32 : AND2
      port map(A => XOR2_21_Y, B => BUFF_2_Y, Y => AND2_32_Y);
    XOR2_PP3_5_inst : XOR2
      port map(A => MX2_49_Y, B => BUFF_15_Y, Y => PP3_5_net);
    AND2_123 : AND2
      port map(A => XOR2_46_Y, B => BUFF_13_Y, Y => AND2_123_Y);
    XOR2_PP0_9_inst : XOR2
      port map(A => MX2_22_Y, B => BUFF_32_Y, Y => PP0_9_net);
    BUFF_42 : BUFF
      port map(A => DataA(7), Y => BUFF_42_Y);
    XOR2_PP2_2_inst : XOR2
      port map(A => MX2_16_Y, B => BUFF_31_Y, Y => PP2_2_net);
    BUFF_5 : BUFF
      port map(A => DataA(2), Y => BUFF_5_Y);
    XOR3_4 : XOR3
      port map(A => PP4_4_net, B => PP3_6_net, C => MAJ3_16_Y, 
        Y => XOR3_4_Y);
    XOR2_46 : XOR2
      port map(A => BUFF_19_Y, B => DataB(6), Y => XOR2_46_Y);
    MX2_30 : MX2
      port map(A => AND2_108_Y, B => BUFF_28_Y, S => NOR2_7_Y, 
        Y => MX2_30_Y);
    MX2_22 : MX2
      port map(A => AND2_72_Y, B => BUFF_7_Y, S => AND2A_1_Y, 
        Y => MX2_22_Y);
    AO1_2 : AO1
      port map(A => AND2_68_Y, B => AO1_36_Y, C => AO1_44_Y, Y => 
        AO1_2_Y);
    AND2_106 : AND2
      port map(A => XOR2_49_Y, B => XOR2_30_Y, Y => AND2_106_Y);
    AND2_100 : AND2
      port map(A => SumA_18_net, B => SumB_18_net, Y => 
        AND2_100_Y);
    AND2_26 : AND2
      port map(A => AND2_81_Y, B => AND2_36_Y, Y => AND2_26_Y);
    MAJ3_SumA_14_inst : MAJ3
      port map(A => XOR3_9_Y, B => MAJ3_0_Y, C => XOR3_12_Y, Y => 
        SumA_14_net);
    AND2_111 : AND2
      port map(A => AND2_79_Y, B => AND2_87_Y, Y => AND2_111_Y);
    XOR2_PP3_12_inst : XOR2
      port map(A => MX2_37_Y, B => BUFF_25_Y, Y => PP3_12_net);
    XOR2_9 : XOR2
      port map(A => SumA_13_net, B => SumB_13_net, Y => XOR2_9_Y);
    AND2_126 : AND2
      port map(A => XOR2_20_Y, B => BUFF_7_Y, Y => AND2_126_Y);
    AND2_120 : AND2
      port map(A => AND2_102_Y, B => XOR2_17_Y, Y => AND2_120_Y);
    XOR2_Mult_18_inst : XOR2
      port map(A => XOR2_41_Y, B => AO1_24_Y, Y => Mult(18));
    XOR2_PP3_10_inst : XOR2
      port map(A => MX2_15_Y, B => BUFF_25_Y, Y => PP3_10_net);
    AND2_23 : AND2
      port map(A => SumA_20_net, B => SumB_20_net, Y => AND2_23_Y);
    MAJ3_21 : MAJ3
      port map(A => MAJ3_18_Y, B => PP4_8_net, C => PP3_10_net, 
        Y => MAJ3_21_Y);
    XNOR2_4 : XNOR2
      port map(A => DataB(6), B => BUFF_14_Y, Y => XNOR2_4_Y);
    NOR2_1 : NOR2
      port map(A => XOR2_21_Y, B => XNOR2_7_Y, Y => NOR2_1_Y);
    XOR2_5 : XOR2
      port map(A => PP2_14_net, B => VCC_1_net, Y => XOR2_5_Y);
    XOR2_PP0_1_inst : XOR2
      port map(A => MX2_17_Y, B => BUFF_29_Y, Y => PP0_1_net);
    MX2_0 : MX2
      port map(A => AND2_6_Y, B => BUFF_11_Y, S => AND2A_2_Y, 
        Y => MX2_0_Y);
    INV_E_2_inst : INV
      port map(A => DataB(5), Y => E_2_net);
    AND2_107 : AND2
      port map(A => XOR2_38_Y, B => BUFF_9_Y, Y => AND2_107_Y);
    AO1_28 : AO1
      port map(A => AND2_69_Y, B => AO1_7_Y, C => AO1_46_Y, Y => 
        AO1_28_Y);
    XOR2_PP2_0_inst : XOR2
      port map(A => XOR2_29_Y, B => DataB(5), Y => PP2_0_net);
    AND2_19 : AND2
      port map(A => XOR2_53_Y, B => BUFF_4_Y, Y => AND2_19_Y);
    XOR2_PP1_8_inst : XOR2
      port map(A => MX2_42_Y, B => BUFF_24_Y, Y => PP1_8_net);
    MAJ3_SumA_18_inst : MAJ3
      port map(A => XOR3_6_Y, B => MAJ3_17_Y, C => MAJ3_12_Y, 
        Y => SumA_18_net);
    AND2_79 : AND2
      port map(A => XOR2_55_Y, B => XOR2_51_Y, Y => AND2_79_Y);
    XOR2_PP3_13_inst : XOR2
      port map(A => MX2_5_Y, B => BUFF_25_Y, Y => PP3_13_net);
    AND2_119 : AND2
      port map(A => AND2_27_Y, B => XOR2_34_Y, Y => AND2_119_Y);
    XOR2_22 : XOR2
      port map(A => PP1_3_net, B => PP0_5_net, Y => XOR2_22_Y);
    AND2_127 : AND2
      port map(A => XOR2_53_Y, B => BUFF_28_Y, Y => AND2_127_Y);
    AO1_1 : AO1
      port map(A => AND2_120_Y, B => AO1_10_Y, C => AO1_43_Y, 
        Y => AO1_1_Y);
    MX2_41 : MX2
      port map(A => AND2_95_Y, B => BUFF_17_Y, S => NOR2_8_Y, 
        Y => MX2_41_Y);
    MAJ3_11 : MAJ3
      port map(A => PP2_8_net, B => PP1_10_net, C => PP0_12_net, 
        Y => MAJ3_11_Y);
    MX2_28 : MX2
      port map(A => AND2_11_Y, B => BUFF_13_Y, S => NOR2_4_Y, 
        Y => MX2_28_Y);
    XOR2_PP1_3_inst : XOR2
      port map(A => MX2_7_Y, B => BUFF_23_Y, Y => PP1_3_net);
    XOR2_13 : XOR2
      port map(A => SumA_19_net, B => SumB_19_net, Y => XOR2_13_Y);
    XOR3_SumB_11_inst : XOR3
      port map(A => MAJ3_5_Y, B => XOR3_2_Y, C => XOR3_4_Y, Y => 
        SumB_11_net);
    AND2_51 : AND2
      port map(A => XOR2_34_Y, B => XOR2_9_Y, Y => AND2_51_Y);
    AO1_3 : AO1
      port map(A => XOR2_30_Y, B => AND2_91_Y, C => AND2_21_Y, 
        Y => AO1_3_Y);
    AND2_64 : AND2
      port map(A => XOR2_38_Y, B => BUFF_30_Y, Y => AND2_64_Y);
    BUFF_24 : BUFF
      port map(A => DataB(3), Y => BUFF_24_Y);
    AND2_47 : AND2
      port map(A => XOR2_21_Y, B => BUFF_43_Y, Y => AND2_47_Y);
    XOR2_PP2_9_inst : XOR2
      port map(A => MX2_21_Y, B => BUFF_34_Y, Y => PP2_9_net);
    AO1_18 : AO1
      port map(A => AND2_87_Y, B => AO1_11_Y, C => AO1_21_Y, Y => 
        AO1_18_Y);
    XOR2_48 : XOR2
      port map(A => SumA_5_net, B => SumB_5_net, Y => XOR2_48_Y);
    BUFF_36 : BUFF
      port map(A => DataA(5), Y => BUFF_36_Y);
    AND2_PP4_6_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_3_Y, Y => PP4_6_net);
    MX2_26 : MX2
      port map(A => AND2_114_Y, B => BUFF_42_Y, S => NOR2_8_Y, 
        Y => MX2_26_Y);
    AND2A_2 : AND2A
      port map(A => DataB(0), B => BUFF_40_Y, Y => AND2A_2_Y);
    AND2_101 : AND2
      port map(A => XOR2_32_Y, B => BUFF_16_Y, Y => AND2_101_Y);
    AND2_16 : AND2
      port map(A => XOR2_32_Y, B => BUFF_42_Y, Y => AND2_16_Y);
    BUFF_37 : BUFF
      port map(A => DataA(12), Y => BUFF_37_Y);
    XOR2_PP1_6_inst : XOR2
      port map(A => MX2_45_Y, B => BUFF_24_Y, Y => PP1_6_net);
    AND2_76 : AND2
      port map(A => SumA_4_net, B => SumB_4_net, Y => AND2_76_Y);
    AND2_121 : AND2
      port map(A => XOR2_46_Y, B => BUFF_10_Y, Y => AND2_121_Y);
    MAJ3_SumA_8_inst : MAJ3
      port map(A => XOR3_8_Y, B => MAJ3_6_Y, C => XOR3_10_Y, Y => 
        SumA_8_net);
    AO1_38 : AO1
      port map(A => AND2_94_Y, B => AO1_25_Y, C => AO1_45_Y, Y => 
        AO1_38_Y);
    AND2_13 : AND2
      port map(A => DataB(0), B => BUFF_7_Y, Y => AND2_13_Y);
    AND2_87 : AND2
      port map(A => XOR2_18_Y, B => XOR2_13_Y, Y => AND2_87_Y);
    MX2_45 : MX2
      port map(A => AND2_54_Y, B => BUFF_36_Y, S => NOR2_3_Y, 
        Y => MX2_45_Y);
    XOR2_PP1_1_inst : XOR2
      port map(A => MX2_3_Y, B => BUFF_23_Y, Y => PP1_1_net);
    AND2_73 : AND2
      port map(A => XOR2_43_Y, B => XOR2_40_Y, Y => AND2_73_Y);
    XNOR2_1 : XNOR2
      port map(A => DataB(6), B => BUFF_25_Y, Y => XNOR2_1_Y);
    XOR2_10 : XOR2
      port map(A => PP1_5_net, B => PP0_7_net, Y => XOR2_10_Y);
    AND2_58 : AND2
      port map(A => SumA_17_net, B => SumB_17_net, Y => AND2_58_Y);
    AND2_55 : AND2
      port map(A => DataB(0), B => BUFF_43_Y, Y => AND2_55_Y);
    MX2_2 : MX2
      port map(A => AND2_99_Y, B => BUFF_9_Y, S => NOR2_3_Y, Y => 
        MX2_2_Y);
    AND2_109 : AND2
      port map(A => S_1_net, B => SumB_2_net, Y => AND2_109_Y);
    MX2_23 : MX2
      port map(A => AND2_43_Y, B => BUFF_21_Y, S => AND2A_0_Y, 
        Y => MX2_23_Y);
    AND2_69 : AND2
      port map(A => AND2_111_Y, B => XOR2_23_Y, Y => AND2_69_Y);
    INV_E_1_inst : INV
      port map(A => DataB(3), Y => E_1_net);
    AND2_129 : AND2
      port map(A => XOR2_3_Y, B => BUFF_43_Y, Y => AND2_129_Y);
    MAJ3_SumA_4_inst : MAJ3
      port map(A => PP2_0_net, B => PP1_2_net, C => PP0_4_net, 
        Y => SumA_4_net);
    XOR2_27 : XOR2
      port map(A => SumA_12_net, B => SumB_12_net, Y => XOR2_27_Y);
    MAJ3_SumA_16_inst : MAJ3
      port map(A => XOR3_19_Y, B => MAJ3_8_Y, C => XOR3_7_Y, Y => 
        SumA_16_net);
    XOR3_3 : XOR3
      port map(A => PP4_2_net, B => PP3_4_net, C => MAJ3_19_Y, 
        Y => XOR3_3_Y);
    MAJ3_3 : MAJ3
      port map(A => PP2_4_net, B => PP1_6_net, C => PP0_8_net, 
        Y => MAJ3_3_Y);
    XOR3_SumB_10_inst : XOR3
      port map(A => MAJ3_23_Y, B => XOR3_14_Y, C => XOR3_5_Y, 
        Y => SumB_10_net);
    BUFF_12 : BUFF
      port map(A => DataA(13), Y => BUFF_12_Y);
    XOR2_7 : XOR2
      port map(A => PP0_2_net, B => PP1_0_net, Y => XOR2_7_Y);
    AND2_5 : AND2
      port map(A => AND2_26_Y, B => XOR2_55_Y, Y => AND2_5_Y);
    XOR2_56 : XOR2
      port map(A => SumA_4_net, B => SumB_4_net, Y => XOR2_56_Y);
    XOR2_14 : XOR2
      port map(A => SumA_14_net, B => SumB_14_net, Y => XOR2_14_Y);
    XOR2_Mult_3_inst : XOR2
      port map(A => XOR2_12_Y, B => AO1_4_Y, Y => Mult(3));
    AND2_91 : AND2
      port map(A => SumA_8_net, B => SumB_8_net, Y => AND2_91_Y);
    XOR2_PP3_0_inst : XOR2
      port map(A => XOR2_37_Y, B => DataB(7), Y => PP3_0_net);
    AND2_50 : AND2
      port map(A => SumA_12_net, B => SumB_12_net, Y => AND2_50_Y);
    AND2_PP4_10_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_20_Y, Y => PP4_10_net);
    XNOR2_3 : XNOR2
      port map(A => DataB(4), B => BUFF_34_Y, Y => XNOR2_3_Y);
    XOR2_Mult_8_inst : XOR2
      port map(A => XOR2_26_Y, B => AO1_1_Y, Y => Mult(8));
    XOR2_PP0_4_inst : XOR2
      port map(A => MX2_23_Y, B => BUFF_29_Y, Y => PP0_4_net);
    XOR2_11 : XOR2
      port map(A => SumA_9_net, B => SumB_9_net, Y => XOR2_11_Y);
    MX2_32 : MX2
      port map(A => AND2_82_Y, B => BUFF_21_Y, S => NOR2_0_Y, 
        Y => MX2_32_Y);
    XOR2_PP3_8_inst : XOR2
      port map(A => MX2_26_Y, B => BUFF_15_Y, Y => PP3_8_net);
    XOR3_6 : XOR3
      port map(A => PP4_10_net, B => PP3_12_net, C => XOR2_5_Y, 
        Y => XOR3_6_Y);
    XOR2_25 : XOR2
      port map(A => SumA_11_net, B => SumB_11_net, Y => XOR2_25_Y);
    AND2_52 : AND2
      port map(A => SumA_11_net, B => SumB_11_net, Y => AND2_52_Y);
    MAJ3_SumA_13_inst : MAJ3
      port map(A => XOR3_22_Y, B => MAJ3_7_Y, C => XOR3_16_Y, 
        Y => SumA_13_net);
    AO1_22 : AO1
      port map(A => XOR2_49_Y, B => AO1_17_Y, C => AND2_91_Y, 
        Y => AO1_22_Y);
    MAJ3_SumA_12_inst : MAJ3
      port map(A => XOR3_4_Y, B => MAJ3_5_Y, C => XOR3_2_Y, Y => 
        SumA_12_net);
    INV_E_3_inst : INV
      port map(A => DataB(7), Y => E_3_net);
    AND2_PP4_13_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_12_Y, Y => PP4_13_net);
    BUFF_0 : BUFF
      port map(A => DataA(6), Y => BUFF_0_Y);
    MX2_40 : MX2
      port map(A => AND2_9_Y, B => BUFF_9_Y, S => AND2A_1_Y, Y => 
        MX2_40_Y);
    MAJ3_SumA_20_inst : MAJ3
      port map(A => MAJ3_2_Y, B => XOR2_35_Y, C => PP4_12_net, 
        Y => SumA_20_net);
    XOR3_SumB_18_inst : XOR3
      port map(A => MAJ3_22_Y, B => AND2_92_Y, C => XOR3_11_Y, 
        Y => SumB_18_net);
    AND2_PP4_4_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_6_Y, Y => PP4_4_net);
    BUFF_19 : BUFF
      port map(A => DataB(5), Y => BUFF_19_Y);
    AND2_112 : AND2
      port map(A => XOR2_46_Y, B => BUFF_6_Y, Y => AND2_112_Y);
    MX2_27 : MX2
      port map(A => AND2_118_Y, B => BUFF_16_Y, S => NOR2_8_Y, 
        Y => MX2_27_Y);
    MAJ3_SumA_15_inst : MAJ3
      port map(A => XOR3_1_Y, B => MAJ3_13_Y, C => XOR3_20_Y, 
        Y => SumA_15_net);
    AND2_34 : AND2
      port map(A => SumA_7_net, B => SumB_7_net, Y => AND2_34_Y);
    AO1_41 : AO1
      port map(A => AND2_25_Y, B => AO1_7_Y, C => AO1_20_Y, Y => 
        AO1_41_Y);
    XOR2_SumB_2_inst : XOR2
      port map(A => PP1_1_net, B => PP0_3_net, Y => SumB_2_net);
    XOR2_Mult_4_inst : XOR2
      port map(A => XOR2_42_Y, B => AO1_13_Y, Y => Mult(4));
    AND2_66 : AND2
      port map(A => XOR2_19_Y, B => BUFF_21_Y, Y => AND2_66_Y);
    MX2_11 : MX2
      port map(A => AND2_55_Y, B => BUFF_37_Y, S => AND2A_2_Y, 
        Y => MX2_11_Y);
    AO1_6 : AO1
      port map(A => AND2_111_Y, B => AO1_7_Y, C => AO1_18_Y, Y => 
        AO1_6_Y);
    XOR2_Mult_17_inst : XOR2
      port map(A => XOR2_45_Y, B => AO1_12_Y, Y => Mult(17));
    BUFF_35 : BUFF
      port map(A => DataA(9), Y => BUFF_35_Y);
    AND2_98 : AND2
      port map(A => DataB(0), B => BUFF_0_Y, Y => AND2_98_Y);
    AND2_95 : AND2
      port map(A => XOR2_32_Y, B => BUFF_35_Y, Y => AND2_95_Y);
    AND2_PP4_7_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_42_Y, Y => PP4_7_net);
    MX2_38 : MX2
      port map(A => AND2_127_Y, B => BUFF_7_Y, S => NOR2_3_Y, 
        Y => MX2_38_Y);
    NOR2_4 : NOR2
      port map(A => XOR2_46_Y, B => XNOR2_4_Y, Y => NOR2_4_Y);
    XOR2_Mult_1_inst : XOR2
      port map(A => PP0_1_net, B => S_0_net, Y => Mult(1));
    XOR3_22 : XOR3
      port map(A => PP4_5_net, B => PP3_7_net, C => MAJ3_11_Y, 
        Y => XOR3_22_Y);
    AND2_63 : AND2
      port map(A => PP1_3_net, B => PP0_5_net, Y => AND2_63_Y);
    AO1_12 : AO1
      port map(A => AND2_36_Y, B => AO1_38_Y, C => AO1_35_Y, Y => 
        AO1_12_Y);
    XOR2_PP1_11_inst : XOR2
      port map(A => MX2_34_Y, B => BUFF_33_Y, Y => PP1_11_net);
    XOR3_SumB_6_inst : XOR3
      port map(A => MAJ3_9_Y, B => XOR2_10_Y, C => XOR3_18_Y, 
        Y => SumB_6_net);
    XOR2_32 : XOR2
      port map(A => BUFF_19_Y, B => DataB(6), Y => XOR2_32_Y);
    XOR2_Mult_10_inst : XOR2
      port map(A => XOR2_11_Y, B => AO1_22_Y, Y => Mult(10));
    XOR2_Mult_2_inst : XOR2
      port map(A => XOR2_15_Y, B => AND2_22_Y, Y => Mult(2));
    XOR2_PP0_2_inst : XOR2
      port map(A => MX2_9_Y, B => BUFF_29_Y, Y => PP0_2_net);
    XOR3_12 : XOR3
      port map(A => PP1_12_net, B => PP0_14_net, C => PP2_10_net, 
        Y => XOR3_12_Y);
    AND2_9 : AND2
      port map(A => DataB(0), B => BUFF_36_Y, Y => AND2_9_Y);
    MX2_6 : MX2
      port map(A => AND2_129_Y, B => BUFF_37_Y, S => NOR2_7_Y, 
        Y => MX2_6_Y);
    AND2_90 : AND2
      port map(A => AND2_88_Y, B => AND2_94_Y, Y => AND2_90_Y);
    BUFF_33 : BUFF
      port map(A => DataB(3), Y => BUFF_33_Y);
    XOR2_43 : XOR2
      port map(A => S_1_net, B => SumB_2_net, Y => XOR2_43_Y);
    AO1_32 : AO1
      port map(A => XOR2_34_Y, B => AO1_31_Y, C => AND2_50_Y, 
        Y => AO1_32_Y);
    XOR2_PP3_4_inst : XOR2
      port map(A => MX2_35_Y, B => BUFF_14_Y, Y => PP3_4_net);
    AND2_PP4_2_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_13_Y, Y => PP4_2_net);
    MX2_36 : MX2
      port map(A => AND2_8_Y, B => BUFF_9_Y, S => NOR2_6_Y, Y => 
        MX2_36_Y);
    AND2_92 : AND2
      port map(A => PP2_14_net, B => VCC_1_net, Y => AND2_92_Y);
    MX2_7 : MX2
      port map(A => AND2_66_Y, B => BUFF_5_Y, S => NOR2_0_Y, Y => 
        MX2_7_Y);
    AO1_9 : AO1
      port map(A => XOR2_44_Y, B => AO1_3_Y, C => AND2_35_Y, Y => 
        AO1_9_Y);
    XOR3_SumB_4_inst : XOR3
      port map(A => S_2_net, B => PP2_1_net, C => XOR2_22_Y, Y => 
        SumB_4_net);
    NOR2_8 : NOR2
      port map(A => XOR2_32_Y, B => XNOR2_2_Y, Y => NOR2_8_Y);
    AND2_39 : AND2
      port map(A => XOR2_54_Y, B => BUFF_39_Y, Y => AND2_39_Y);
    AND2_115 : AND2
      port map(A => NOR2_1_Y, B => BUFF_43_Y, Y => AND2_115_Y);
    XOR2_Mult_6_inst : XOR2
      port map(A => XOR2_36_Y, B => AO1_29_Y, Y => Mult(6));
    BUFF_9 : BUFF
      port map(A => DataA(4), Y => BUFF_9_Y);
    XOR3_SumB_16_inst : XOR3
      port map(A => MAJ3_21_Y, B => XOR3_23_Y, C => XOR3_17_Y, 
        Y => SumB_16_net);
    XOR3_SumB_9_inst : XOR3
      port map(A => MAJ3_15_Y, B => XOR3_0_Y, C => XOR3_3_Y, Y => 
        SumB_9_net);
    MX2_15 : MX2
      port map(A => AND2_104_Y, B => BUFF_35_Y, S => NOR2_2_Y, 
        Y => MX2_15_Y);
    MAJ3_6 : MAJ3
      port map(A => S_3_net, B => PP3_1_net, C => PP2_3_net, Y => 
        MAJ3_6_Y);
    XOR2_PP0_14_inst : XOR2
      port map(A => AND2_80_Y, B => BUFF_40_Y, Y => PP0_14_net);
    XOR2_PP2_3_inst : XOR2
      port map(A => MX2_31_Y, B => BUFF_31_Y, Y => PP2_3_net);
    AND2_102 : AND2
      port map(A => XOR2_1_Y, B => XOR2_48_Y, Y => AND2_102_Y);
    AND2_27 : AND2
      port map(A => AND2_106_Y, B => AND2_24_Y, Y => AND2_27_Y);
    MX2_3 : MX2
      port map(A => AND2_46_Y, B => BUFF_30_Y, S => NOR2_0_Y, 
        Y => MX2_3_Y);
    AND2_122 : AND2
      port map(A => XOR2_0_Y, B => XOR2_7_Y, Y => AND2_122_Y);
    MX2_33 : MX2
      port map(A => AND2_13_Y, B => BUFF_4_Y, S => AND2A_1_Y, 
        Y => MX2_33_Y);
    XOR2_Mult_12_inst : XOR2
      port map(A => XOR2_31_Y, B => AO1_34_Y, Y => Mult(12));
    AO1_20 : AO1
      port map(A => XOR2_18_Y, B => AO1_11_Y, C => AND2_100_Y, 
        Y => AO1_20_Y);
    AO1_0 : AO1
      port map(A => AND2_102_Y, B => AO1_10_Y, C => AO1_42_Y, 
        Y => AO1_0_Y);
    XOR3_9 : XOR3
      port map(A => PP4_6_net, B => PP3_8_net, C => MAJ3_1_Y, 
        Y => XOR3_9_Y);
    XOR3_SumB_20_inst : XOR3
      port map(A => PP4_13_net, B => E_3_net, C => AND2_67_Y, 
        Y => SumB_20_net);
    XOR3_SumB_15_inst : XOR3
      port map(A => MAJ3_8_Y, B => XOR3_7_Y, C => XOR3_19_Y, Y => 
        SumB_15_net);
    XOR2_29 : XOR2
      port map(A => AND2_64_Y, B => BUFF_31_Y, Y => XOR2_29_Y);
    AO1_45 : AO1
      port map(A => AND2_131_Y, B => AO1_42_Y, C => AO1_19_Y, 
        Y => AO1_45_Y);
    XOR2_40 : XOR2
      port map(A => SumA_3_net, B => SumB_3_net, Y => XOR2_40_Y);
    BUFF_6 : BUFF
      port map(A => DataA(4), Y => BUFF_6_Y);
    XOR3_0 : XOR3
      port map(A => PP1_8_net, B => PP0_10_net, C => PP2_6_net, 
        Y => XOR3_0_Y);
    BUFF_7 : BUFF
      port map(A => DataA(8), Y => BUFF_7_Y);
    MX2_9 : MX2
      port map(A => AND2_45_Y, B => BUFF_26_Y, S => AND2A_0_Y, 
        Y => MX2_9_Y);
    XOR2_2 : XOR2
      port map(A => SumA_18_net, B => SumB_18_net, Y => XOR2_2_Y);
    XOR2_PP0_12_inst : XOR2
      port map(A => MX2_0_Y, B => BUFF_40_Y, Y => PP0_12_net);
    BUFF_31 : BUFF
      port map(A => DataB(5), Y => BUFF_31_Y);
    XOR2_PP0_10_inst : XOR2
      port map(A => MX2_39_Y, B => BUFF_40_Y, Y => PP0_10_net);
    BUFF_43 : BUFF
      port map(A => DataA(13), Y => BUFF_43_Y);
    XOR2_37 : XOR2
      port map(A => AND2_56_Y, B => BUFF_14_Y, Y => XOR2_37_Y);
    AND2_36 : AND2
      port map(A => AND2_20_Y, B => AND2_0_Y, Y => AND2_36_Y);
    AND2A_0 : AND2A
      port map(A => DataB(0), B => BUFF_29_Y, Y => AND2A_0_Y);
    XOR2_PP2_1_inst : XOR2
      port map(A => MX2_50_Y, B => BUFF_31_Y, Y => PP2_1_net);
    AO1_26 : AO1
      port map(A => XOR2_25_Y, B => AND2_35_Y, C => AND2_52_Y, 
        Y => AO1_26_Y);
    BUFF_22 : BUFF
      port map(A => DataA(12), Y => BUFF_22_Y);
    XOR3_17 : XOR3
      port map(A => PP4_9_net, B => PP3_11_net, C => MAJ3_20_Y, 
        Y => XOR3_17_Y);
    BUFF_16 : BUFF
      port map(A => DataA(5), Y => BUFF_16_Y);
    XOR3_5 : XOR3
      port map(A => PP4_3_net, B => PP3_5_net, C => MAJ3_14_Y, 
        Y => XOR3_5_Y);
    MX2_10 : MX2
      port map(A => AND2_32_Y, B => BUFF_28_Y, S => NOR2_1_Y, 
        Y => MX2_10_Y);
    AO1_23 : AO1
      port map(A => AND2_106_Y, B => AO1_17_Y, C => AO1_3_Y, Y => 
        AO1_23_Y);
    AND2_33 : AND2
      port map(A => DataB(0), B => BUFF_11_Y, Y => AND2_33_Y);
    XOR2_44 : XOR2
      port map(A => SumA_10_net, B => SumB_10_net, Y => XOR2_44_Y);
    BUFF_17 : BUFF
      port map(A => DataA(8), Y => BUFF_17_Y);
    AO1_10 : AO1
      port map(A => AND2_73_Y, B => AO1_4_Y, C => AO1_16_Y, Y => 
        AO1_10_Y);
    XOR2_PP1_7_inst : XOR2
      port map(A => MX2_24_Y, B => BUFF_24_Y, Y => PP1_7_net);
    MX2_42 : MX2
      port map(A => AND2_17_Y, B => BUFF_4_Y, S => NOR2_3_Y, Y => 
        MX2_42_Y);
    XOR2_41 : XOR2
      port map(A => SumA_17_net, B => SumB_17_net, Y => XOR2_41_Y);
    XOR2_35 : XOR2
      port map(A => PP3_14_net, B => VCC_1_net, Y => XOR2_35_Y);
    MX2_51 : MX2
      port map(A => AND2_121_Y, B => BUFF_1_Y, S => NOR2_4_Y, 
        Y => MX2_51_Y);
    AND2_105 : AND2
      port map(A => XOR2_38_Y, B => BUFF_21_Y, Y => AND2_105_Y);
    MX2_29 : MX2
      port map(A => AND2_89_Y, B => BUFF_11_Y, S => NOR2_1_Y, 
        Y => MX2_29_Y);
    XOR2_PP0_13_inst : XOR2
      port map(A => MX2_11_Y, B => BUFF_40_Y, Y => PP0_13_net);
    MX2_37 : MX2
      port map(A => AND2_125_Y, B => BUFF_39_Y, S => NOR2_2_Y, 
        Y => MX2_37_Y);
    XOR3_15 : XOR3
      port map(A => PP1_7_net, B => PP0_9_net, C => PP2_5_net, 
        Y => XOR3_15_Y);
    BUFF_38 : BUFF
      port map(A => DataB(3), Y => BUFF_38_Y);
    XOR2_PP2_5_inst : XOR2
      port map(A => MX2_36_Y, B => BUFF_34_Y, Y => PP2_5_net);
    AND2_125 : AND2
      port map(A => XOR2_54_Y, B => BUFF_22_Y, Y => AND2_125_Y);
    AND2_S_2_inst : AND2
      port map(A => XOR2_29_Y, B => DataB(5), Y => S_2_net);
    MAJ3_15 : MAJ3
      port map(A => MAJ3_3_Y, B => PP4_1_net, C => PP3_3_net, 
        Y => MAJ3_15_Y);
    BUFF_29 : BUFF
      port map(A => DataB(1), Y => BUFF_29_Y);
    NOR2_5 : NOR2
      port map(A => XOR2_38_Y, B => XNOR2_6_Y, Y => NOR2_5_Y);
    AO1_30 : AO1
      port map(A => XOR2_9_Y, B => AND2_50_Y, C => AND2_3_Y, Y => 
        AO1_30_Y);
    XOR3_8 : XOR3
      port map(A => PP4_0_net, B => PP3_2_net, C => AND2_44_Y, 
        Y => XOR3_8_Y);
    AND2_41 : AND2
      port map(A => XOR2_20_Y, B => BUFF_0_Y, Y => AND2_41_Y);
    AND2_0 : AND2
      port map(A => AND2_51_Y, B => AND2_38_Y, Y => AND2_0_Y);
    AND2_130 : AND2
      port map(A => SumA_16_net, B => SumB_16_net, Y => 
        AND2_130_Y);
    AO1_16 : AO1
      port map(A => XOR2_40_Y, B => AND2_109_Y, C => AND2_30_Y, 
        Y => AO1_16_Y);
    XOR2_PP1_2_inst : XOR2
      port map(A => MX2_43_Y, B => BUFF_23_Y, Y => PP1_2_net);
    AND2_17 : AND2
      port map(A => XOR2_53_Y, B => BUFF_7_Y, Y => AND2_17_Y);
    MAJ3_SumA_6_inst : MAJ3
      port map(A => XOR3_21_Y, B => AND2_63_Y, C => PP3_0_net, 
        Y => SumA_6_net);
    XOR2_PP2_11_inst : XOR2
      port map(A => MX2_18_Y, B => BUFF_41_Y, Y => PP2_11_net);
    BUFF_3 : BUFF
      port map(A => DataA(6), Y => BUFF_3_Y);
    AO1_29 : AO1
      port map(A => XOR2_1_Y, B => AO1_10_Y, C => AND2_76_Y, Y => 
        AO1_29_Y);
    XOR2_PP2_8_inst : XOR2
      port map(A => MX2_48_Y, B => BUFF_34_Y, Y => PP2_8_net);
    XOR2_6 : XOR2
      port map(A => SumA_20_net, B => SumB_20_net, Y => XOR2_6_Y);
    AND2_77 : AND2
      port map(A => AND2_70_Y, B => AND2_106_Y, Y => AND2_77_Y);
    MX2_24 : MX2
      port map(A => AND2_19_Y, B => BUFF_0_Y, S => NOR2_3_Y, Y => 
        MX2_24_Y);
    AND2_54 : AND2
      port map(A => XOR2_53_Y, B => BUFF_0_Y, Y => AND2_54_Y);
    AO1_13 : AO1
      port map(A => XOR2_43_Y, B => AO1_4_Y, C => AND2_109_Y, 
        Y => AO1_13_Y);
    MX2_48 : MX2
      port map(A => AND2_126_Y, B => BUFF_4_Y, S => NOR2_6_Y, 
        Y => MX2_48_Y);
    XOR2_53 : XOR2
      port map(A => BUFF_27_Y, B => DataB(2), Y => XOR2_53_Y);
    AO1_36 : AO1
      port map(A => AND2_94_Y, B => AO1_25_Y, C => AO1_45_Y, Y => 
        AO1_36_Y);
    BUFF_41 : BUFF
      port map(A => DataB(5), Y => BUFF_41_Y);
    XOR2_Mult_9_inst : XOR2
      port map(A => XOR2_50_Y, B => AO1_17_Y, Y => Mult(9));
    AND2_81 : AND2
      port map(A => AND2_88_Y, B => AND2_94_Y, Y => AND2_81_Y);
    MAJ3_5 : MAJ3
      port map(A => MAJ3_14_Y, B => PP4_3_net, C => PP3_5_net, 
        Y => MAJ3_5_Y);
    AO1_33 : AO1
      port map(A => AND2_24_Y, B => AO1_3_Y, C => AO1_26_Y, Y => 
        AO1_33_Y);
    AO1_44 : AO1
      port map(A => AND2_51_Y, B => AO1_33_Y, C => AO1_30_Y, Y => 
        AO1_44_Y);
    XNOR2_7 : XNOR2
      port map(A => DataB(2), B => BUFF_33_Y, Y => XNOR2_7_Y);
    XOR2_12 : XOR2
      port map(A => S_1_net, B => SumB_2_net, Y => XOR2_12_Y);
    AND2_48 : AND2
      port map(A => AND2_26_Y, B => AND2_79_Y, Y => AND2_48_Y);
    AND2_45 : AND2
      port map(A => DataB(0), B => BUFF_5_Y, Y => AND2_45_Y);
    BUFF_30 : BUFF
      port map(A => DataA(0), Y => BUFF_30_Y);
    AO1_19 : AO1
      port map(A => XOR2_4_Y, B => AND2_124_Y, C => AND2_34_Y, 
        Y => AO1_19_Y);
    XOR2_PP3_1_inst : XOR2
      port map(A => MX2_51_Y, B => BUFF_14_Y, Y => PP3_1_net);
    MX2_46 : MX2
      port map(A => AND2_39_Y, B => BUFF_20_Y, S => NOR2_2_Y, 
        Y => MX2_46_Y);
    XOR2_26 : XOR2
      port map(A => SumA_7_net, B => SumB_7_net, Y => XOR2_26_Y);
    AND2_59 : AND2
      port map(A => XOR2_20_Y, B => BUFF_4_Y, Y => AND2_59_Y);
    BUFF_15 : BUFF
      port map(A => DataB(7), Y => BUFF_15_Y);
    XOR3_SumB_7_inst : XOR3
      port map(A => MAJ3_6_Y, B => XOR3_10_Y, C => XOR3_8_Y, Y => 
        SumB_7_net);
    AND2_4 : AND2
      port map(A => AND2_81_Y, B => AND2_96_Y, Y => AND2_4_Y);
    AO1_39 : AO1
      port map(A => AND2_38_Y, B => AO1_30_Y, C => AO1_14_Y, Y => 
        AO1_39_Y);
    AND2_40 : AND2
      port map(A => NOR2_2_Y, B => BUFF_12_Y, Y => AND2_40_Y);
    MAJ3_18 : MAJ3
      port map(A => PP2_11_net, B => PP1_13_net, C => DataB(1), 
        Y => MAJ3_18_Y);
    AND2_88 : AND2
      port map(A => AND2_122_Y, B => AND2_73_Y, Y => AND2_88_Y);
    AND2_85 : AND2
      port map(A => SumA_5_net, B => SumB_5_net, Y => AND2_85_Y);
    BUFF_4 : BUFF
      port map(A => DataA(7), Y => BUFF_4_Y);
    AND2_131 : AND2
      port map(A => XOR2_17_Y, B => XOR2_4_Y, Y => AND2_131_Y);
    XOR2_50 : XOR2
      port map(A => SumA_8_net, B => SumB_8_net, Y => XOR2_50_Y);
    MAJ3_7 : MAJ3
      port map(A => MAJ3_16_Y, B => PP4_4_net, C => PP3_6_net, 
        Y => MAJ3_7_Y);
    AND2_94 : AND2
      port map(A => AND2_102_Y, B => AND2_131_Y, Y => AND2_94_Y);
    AND2_42 : AND2
      port map(A => AND2_60_Y, B => AND2_102_Y, Y => AND2_42_Y);
    AND2_118 : AND2
      port map(A => XOR2_32_Y, B => BUFF_3_Y, Y => AND2_118_Y);
    XNOR2_5 : XNOR2
      port map(A => DataB(2), B => BUFF_24_Y, Y => XNOR2_5_Y);
    MX2_4 : MX2
      port map(A => AND2_71_Y, B => BUFF_0_Y, S => AND2A_1_Y, 
        Y => MX2_4_Y);
    MAJ3_20 : MAJ3
      port map(A => PP2_12_net, B => PP1_14_net, C => DataB(1), 
        Y => MAJ3_20_Y);
    AO1_5 : AO1
      port map(A => AND2_27_Y, B => AO1_36_Y, C => AO1_31_Y, Y => 
        AO1_5_Y);
    MX2_43 : MX2
      port map(A => AND2_86_Y, B => BUFF_26_Y, S => NOR2_0_Y, 
        Y => MX2_43_Y);
    AND2_PP4_9_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_35_Y, Y => PP4_9_net);
    AND2_67 : AND2
      port map(A => PP3_14_net, B => VCC_1_net, Y => AND2_67_Y);
    MX2_50 : MX2
      port map(A => AND2_84_Y, B => BUFF_30_Y, S => NOR2_5_Y, 
        Y => MX2_50_Y);
    BUFF_13 : BUFF
      port map(A => DataA(2), Y => BUFF_13_Y);
    XOR3_2 : XOR3
      port map(A => PP1_10_net, B => PP0_12_net, C => PP2_8_net, 
        Y => XOR3_2_Y);
    XOR2_39 : XOR2
      port map(A => SumA_10_net, B => SumB_10_net, Y => XOR2_39_Y);
    AND2_8 : AND2
      port map(A => XOR2_20_Y, B => BUFF_36_Y, Y => AND2_8_Y);
    AND2_PP4_11_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_39_Y, Y => PP4_11_net);
    AND2_80 : AND2
      port map(A => AND2A_2_Y, B => BUFF_43_Y, Y => AND2_80_Y);
    NOR2_7 : NOR2
      port map(A => XOR2_3_Y, B => XNOR2_8_Y, Y => NOR2_7_Y);
    XOR2_PP1_9_inst : XOR2
      port map(A => MX2_38_Y, B => BUFF_24_Y, Y => PP1_9_net);
    XOR2_3 : XOR2
      port map(A => BUFF_38_Y, B => DataB(4), Y => XOR2_3_Y);
    XOR3_19 : XOR3
      port map(A => PP4_8_net, B => PP3_10_net, C => MAJ3_18_Y, 
        Y => XOR3_19_Y);
    XOR2_54 : XOR2
      port map(A => BUFF_19_Y, B => DataB(6), Y => XOR2_54_Y);
    MX2_12 : MX2
      port map(A => AND2_107_Y, B => BUFF_21_Y, S => NOR2_5_Y, 
        Y => MX2_12_Y);
    XOR3_1 : XOR3
      port map(A => PP4_7_net, B => PP3_9_net, C => MAJ3_4_Y, 
        Y => XOR3_1_Y);
    XOR2_51 : XOR2
      port map(A => SumA_17_net, B => SumB_17_net, Y => XOR2_51_Y);
    AO1_27 : AO1
      port map(A => XOR2_33_Y, B => AO1_30_Y, C => AND2_61_Y, 
        Y => AO1_27_Y);
    AND2_82 : AND2
      port map(A => XOR2_19_Y, B => BUFF_9_Y, Y => AND2_82_Y);
    MAJ3_10 : MAJ3
      port map(A => AND2_44_Y, B => PP4_0_net, C => PP3_2_net, 
        Y => MAJ3_10_Y);
    BUFF_26 : BUFF
      port map(A => DataA(1), Y => BUFF_26_Y);
    XOR2_Mult_14_inst : XOR2
      port map(A => XOR2_52_Y, B => AO1_8_Y, Y => Mult(14));
    MX2_39 : MX2
      port map(A => AND2_53_Y, B => BUFF_28_Y, S => AND2A_2_Y, 
        Y => MX2_39_Y);
    AND2_56 : AND2
      port map(A => XOR2_46_Y, B => BUFF_1_Y, Y => AND2_56_Y);
    BUFF_40 : BUFF
      port map(A => DataB(1), Y => BUFF_40_Y);
    XOR2_Mult_20_inst : XOR2
      port map(A => XOR2_24_Y, B => AO1_41_Y, Y => Mult(20));
    BUFF_27 : BUFF
      port map(A => DataB(1), Y => BUFF_27_Y);
    XOR2_17 : XOR2
      port map(A => SumA_6_net, B => SumB_6_net, Y => XOR2_17_Y);
    AND2_53 : AND2
      port map(A => DataB(0), B => BUFF_2_Y, Y => AND2_53_Y);
    XOR2_PP3_9_inst : XOR2
      port map(A => MX2_41_Y, B => BUFF_15_Y, Y => PP3_9_net);
    AND2_99 : AND2
      port map(A => XOR2_53_Y, B => BUFF_36_Y, Y => AND2_99_Y);
    XOR2_28 : XOR2
      port map(A => SumA_6_net, B => SumB_6_net, Y => XOR2_28_Y);
    MX2_47 : MX2
      port map(A => AND2_59_Y, B => BUFF_0_Y, S => NOR2_6_Y, Y => 
        MX2_47_Y);
    XOR2_15 : XOR2
      port map(A => PP0_2_net, B => PP1_0_net, Y => XOR2_15_Y);
    MX2_34 : MX2
      port map(A => AND2_57_Y, B => BUFF_2_Y, S => NOR2_1_Y, Y => 
        MX2_34_Y);
    MX2_18 : MX2
      port map(A => AND2_74_Y, B => BUFF_2_Y, S => NOR2_7_Y, Y => 
        MX2_18_Y);
    AO1_17 : AO1
      port map(A => AND2_94_Y, B => AO1_25_Y, C => AO1_45_Y, Y => 
        AO1_17_Y);
    AND2_108 : AND2
      port map(A => XOR2_3_Y, B => BUFF_2_Y, Y => AND2_108_Y);
    BUFF_11 : BUFF
      port map(A => DataA(11), Y => BUFF_11_Y);
    MAJ3_2 : MAJ3
      port map(A => PP4_11_net, B => PP3_13_net, C => E_2_net, 
        Y => MAJ3_2_Y);
    AND2_128 : AND2
      port map(A => AND2_90_Y, B => AND2_12_Y, Y => AND2_128_Y);
    XOR2_PP0_3_inst : XOR2
      port map(A => MX2_14_Y, B => BUFF_29_Y, Y => PP0_3_net);
    MAJ3_SumA_7_inst : MAJ3
      port map(A => XOR3_18_Y, B => MAJ3_9_Y, C => XOR2_10_Y, 
        Y => SumA_7_net);
    XOR2_PP2_7_inst : XOR2
      port map(A => MX2_47_Y, B => BUFF_34_Y, Y => PP2_7_net);
    XOR2_Mult_11_inst : XOR2
      port map(A => XOR2_39_Y, B => AO1_23_Y, Y => Mult(11));
    XOR2_PP3_11_inst : XOR2
      port map(A => MX2_46_Y, B => BUFF_25_Y, Y => PP3_11_net);
    AND2_21 : AND2
      port map(A => SumA_9_net, B => SumB_9_net, Y => AND2_21_Y);
    AO1_37 : AO1
      port map(A => AND2_65_Y, B => AO1_33_Y, C => AO1_27_Y, Y => 
        AO1_37_Y);
    XOR3_7 : XOR3
      port map(A => PP1_14_net, B => DataB(1), C => PP2_12_net, 
        Y => XOR3_7_Y);
    AND2_PP4_1_inst : AND2
      port map(A => BUFF_18_Y, B => BUFF_10_Y, Y => PP4_1_net);
    MX2_16 : MX2
      port map(A => AND2_37_Y, B => BUFF_26_Y, S => NOR2_5_Y, 
        Y => MX2_16_Y);
    XOR2_0 : XOR2
      port map(A => PP0_1_net, B => S_0_net, Y => XOR2_0_Y);
    MAJ3_1 : MAJ3
      port map(A => PP2_9_net, B => PP1_11_net, C => PP0_13_net, 
        Y => MAJ3_1_Y);
    AND2_96 : AND2
      port map(A => AND2_20_Y, B => AND2_65_Y, Y => AND2_96_Y);
    AO1_4 : AO1
      port map(A => XOR2_7_Y, B => AND2_22_Y, C => AND2_78_Y, 
        Y => AO1_4_Y);
    BUFF_18 : BUFF
      port map(A => DataB(7), Y => BUFF_18_Y);
    AND2_37 : AND2
      port map(A => XOR2_38_Y, B => BUFF_5_Y, Y => AND2_37_Y);
    AND2_93 : AND2
      port map(A => AND2_116_Y, B => AND2_69_Y, Y => AND2_93_Y);
    XOR2_42 : XOR2
      port map(A => SumA_3_net, B => SumB_3_net, Y => XOR2_42_Y);
    AO1_21 : AO1
      port map(A => XOR2_13_Y, B => AND2_100_Y, C => AND2_28_Y, 
        Y => AO1_21_Y);
    AND2_114 : AND2
      port map(A => XOR2_32_Y, B => BUFF_17_Y, Y => AND2_114_Y);
    XOR2_36 : XOR2
      port map(A => SumA_5_net, B => SumB_5_net, Y => XOR2_36_Y);
    BUFF_1 : BUFF
      port map(A => DataA(0), Y => BUFF_1_Y);
    XNOR2_8 : XNOR2
      port map(A => DataB(4), B => BUFF_41_Y, Y => XNOR2_8_Y);
    BUFF_25 : BUFF
      port map(A => DataB(7), Y => BUFF_25_Y);
    MAJ3_SumA_17_inst : MAJ3
      port map(A => XOR3_17_Y, B => MAJ3_21_Y, C => XOR3_23_Y, 
        Y => SumA_17_net);
    MX2_1 : MX2
      port map(A => AND2_33_Y, B => BUFF_2_Y, S => AND2A_2_Y, 
        Y => MX2_1_Y);
    XOR3_16 : XOR3
      port map(A => PP1_11_net, B => PP0_13_net, C => PP2_9_net, 
        Y => XOR3_16_Y);
    AND2_28 : AND2
      port map(A => SumA_19_net, B => SumB_19_net, Y => AND2_28_Y);
    XOR2_PP1_14_inst : XOR2
      port map(A => AND2_115_Y, B => BUFF_33_Y, Y => PP1_14_net);
    AND2_25 : AND2
      port map(A => AND2_79_Y, B => XOR2_18_Y, Y => AND2_25_Y);
    MX2_13 : MX2
      port map(A => AND2_47_Y, B => BUFF_37_Y, S => NOR2_1_Y, 
        Y => MX2_13_Y);
end DEF_ARCH;

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.3.4
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:SmartFusion
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_MULT
-- LPM_HINT:XBOOTHMULT
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:D:/Work/marmote/projects/DDC_test/smartgen\mult
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IP4X3M1
-- SMARTGEN_PACKAGE:fg484
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTHA:14
-- WIDTHB:8
-- REPRESENTATION:UNSIGNED
-- CLK_EDGE:RISE
-- MAXPGEN:0
-- PIPES:0
-- INST_FA:1
-- HYBRID:0
-- DEBUG:0

-- _End_Comments_

