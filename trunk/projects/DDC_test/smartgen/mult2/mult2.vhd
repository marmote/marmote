-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity mult2 is 
    port( DataA : in std_logic_vector(13 downto 0); DataB : in 
        std_logic_vector(7 downto 0); Mult : out 
        std_logic_vector(21 downto 0)) ;
end mult2;


architecture DEF_ARCH of  mult2 is

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
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

    component AO1
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component XOR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component BUFF
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component MAJ3
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component AOI1
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component OR3
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component AND2A
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component AND3
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component XNOR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal S_0_net, S_1_net, S_2_net, S_3_net, E_0_net, E_1_net, 
        E_2_net, E_3_net, EBAR, PP0_1_net, PP0_2_net, PP0_3_net, 
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
        PP3_14_net, SumA_3_net, SumA_4_net, SumA_5_net, 
        SumA_6_net, SumA_7_net, SumA_8_net, SumA_9_net, 
        SumA_10_net, SumA_11_net, SumA_12_net, SumA_13_net, 
        SumA_14_net, SumA_15_net, SumA_16_net, SumA_17_net, 
        SumA_18_net, SumA_19_net, SumB_2_net, SumB_3_net, 
        SumB_4_net, SumB_5_net, SumB_6_net, SumB_7_net, 
        SumB_8_net, SumB_9_net, SumB_10_net, SumB_11_net, 
        SumB_12_net, SumB_13_net, SumB_14_net, SumB_15_net, 
        SumB_16_net, SumB_17_net, SumB_18_net, SumB_19_net, 
        SumB_20_net, XOR2_14_Y, AND2_48_Y, XOR2_1_Y, AND2_17_Y, 
        XOR2_56_Y, AND2_9_Y, XOR2_34_Y, AND2_106_Y, XOR2_7_Y, 
        AND2_99_Y, XOR2_5_Y, AND2_28_Y, XOR2_20_Y, AND2_104_Y, 
        XOR2_29_Y, AND2_3_Y, XOR2_44_Y, AND2_30_Y, XOR2_36_Y, 
        AND2_54_Y, XOR2_53_Y, AND2_126_Y, XOR2_9_Y, AND2_94_Y, 
        XOR3_1_Y, MAJ3_1_Y, XOR3_11_Y, MAJ3_6_Y, XOR3_9_Y, 
        MAJ3_3_Y, XOR3_5_Y, MAJ3_7_Y, XOR3_7_Y, MAJ3_9_Y, 
        XOR3_2_Y, MAJ3_12_Y, XOR3_4_Y, MAJ3_2_Y, XOR3_3_Y, 
        MAJ3_4_Y, XOR3_12_Y, MAJ3_0_Y, XOR3_6_Y, MAJ3_8_Y, 
        XOR3_0_Y, MAJ3_5_Y, XOR3_10_Y, MAJ3_11_Y, XOR3_8_Y, 
        MAJ3_10_Y, BUFF_6_Y, BUFF_3_Y, BUFF_4_Y, BUFF_10_Y, 
        XOR2_22_Y, XOR2_4_Y, AO1_33_Y, XOR2_28_Y, NOR2_1_Y, 
        MX2_3_Y, AND2_62_Y, MX2_38_Y, AND2_37_Y, MX2_12_Y, 
        AND2_91_Y, MX2_32_Y, AND2_51_Y, MX2_15_Y, XNOR2_7_Y, 
        XOR2_65_Y, NOR2_3_Y, AND2_131_Y, MX2_42_Y, AND2_59_Y, 
        MX2_49_Y, AND2_101_Y, MX2_2_Y, AND2_22_Y, MX2_27_Y, 
        AND2_20_Y, MX2_46_Y, XNOR2_5_Y, XOR2_26_Y, NOR2_0_Y, 
        AND2_84_Y, MX2_35_Y, AND2_50_Y, MX2_4_Y, AND2_36_Y, 
        AND2_88_Y, MX2_47_Y, AND2_70_Y, MX2_9_Y, XNOR2_0_Y, 
        OR3_0_Y, AND3_3_Y, BUFF_7_Y, BUFF_9_Y, BUFF_13_Y, 
        XOR2_69_Y, XOR2_18_Y, AND2A_2_Y, MX2_37_Y, AND2_38_Y, 
        MX2_1_Y, AND2_58_Y, MX2_43_Y, AND2_7_Y, MX2_0_Y, 
        AND2_60_Y, MX2_13_Y, AND2A_1_Y, AND2_75_Y, MX2_25_Y, 
        AND2_100_Y, MX2_22_Y, AND2_11_Y, MX2_44_Y, AND2_74_Y, 
        MX2_5_Y, AND2_15_Y, MX2_36_Y, AND2A_0_Y, AND2_47_Y, 
        MX2_26_Y, AND2_67_Y, MX2_19_Y, AND2_34_Y, AND2_49_Y, 
        MX2_11_Y, AND2_21_Y, MX2_16_Y, OR3_2_Y, AND3_2_Y, 
        BUFF_2_Y, BUFF_0_Y, BUFF_1_Y, BUFF_5_Y, XOR2_46_Y, 
        XOR2_59_Y, AO1_48_Y, XOR2_66_Y, NOR2_2_Y, MX2_6_Y, 
        AND2_44_Y, MX2_50_Y, AND2_108_Y, MX2_17_Y, AND2_129_Y, 
        MX2_41_Y, AND2_18_Y, MX2_7_Y, XNOR2_1_Y, XOR2_41_Y, 
        NOR2_8_Y, AND2_97_Y, MX2_45_Y, AND2_121_Y, MX2_30_Y, 
        AND2_103_Y, MX2_53_Y, AND2_19_Y, MX2_28_Y, AND2_118_Y, 
        MX2_29_Y, XNOR2_2_Y, XOR2_57_Y, NOR2_4_Y, AND2_116_Y, 
        MX2_39_Y, AND2_124_Y, MX2_55_Y, AND2_61_Y, AND2_127_Y, 
        MX2_10_Y, AND2_13_Y, MX2_31_Y, XNOR2_4_Y, OR3_3_Y, 
        AND3_1_Y, BUFF_12_Y, BUFF_8_Y, BUFF_11_Y, BUFF_14_Y, 
        XOR2_38_Y, XOR2_24_Y, AO1_19_Y, XOR2_6_Y, NOR2_7_Y, 
        MX2_24_Y, AND2_77_Y, MX2_20_Y, AND2_112_Y, MX2_33_Y, 
        AND2_114_Y, MX2_48_Y, AND2_133_Y, MX2_8_Y, XNOR2_8_Y, 
        XOR2_27_Y, NOR2_6_Y, AND2_120_Y, MX2_23_Y, AND2_45_Y, 
        MX2_21_Y, AND2_10_Y, MX2_40_Y, AND2_64_Y, MX2_51_Y, 
        AND2_130_Y, MX2_52_Y, XNOR2_3_Y, XOR2_47_Y, NOR2_5_Y, 
        AND2_111_Y, MX2_14_Y, AND2_86_Y, MX2_54_Y, AND2_68_Y, 
        AND2_42_Y, MX2_18_Y, AND2_109_Y, MX2_34_Y, XNOR2_6_Y, 
        OR3_1_Y, AND3_0_Y, AND2_81_Y, AND2_113_Y, AND2_35_Y, 
        AND2_79_Y, AND2_87_Y, AND2_128_Y, AND2_39_Y, AND2_93_Y, 
        AND2_24_Y, AND2_40_Y, AND2_57_Y, AND2_55_Y, AND2_4_Y, 
        AND2_66_Y, AND2_85_Y, AND2_134_Y, AND2_63_Y, AND2_102_Y, 
        AND2_33_Y, AND2_26_Y, XOR2_0_Y, XOR2_11_Y, XOR2_52_Y, 
        XOR2_49_Y, XOR2_2_Y, XOR2_60_Y, XOR2_23_Y, XOR2_8_Y, 
        XOR2_61_Y, XOR2_39_Y, XOR2_54_Y, XOR2_32_Y, XOR2_43_Y, 
        XOR2_13_Y, XOR2_42_Y, XOR2_12_Y, XOR2_67_Y, XOR2_63_Y, 
        XOR2_25_Y, XOR2_17_Y, XOR2_30_Y, AND2_125_Y, AO1_16_Y, 
        AND2_76_Y, AO1_44_Y, AND2_105_Y, AO1_20_Y, AND2_135_Y, 
        AO1_3_Y, AND2_110_Y, AO1_27_Y, AND2_27_Y, AO1_31_Y, 
        AND2_56_Y, AO1_14_Y, AND2_43_Y, AO1_11_Y, AND2_82_Y, 
        AO1_22_Y, AND2_89_Y, AND2_117_Y, AND2_65_Y, AO1_26_Y, 
        AND2_90_Y, AO1_45_Y, AND2_123_Y, AO1_47_Y, AND2_96_Y, 
        AO1_9_Y, AND2_14_Y, AO1_32_Y, AND2_32_Y, AO1_35_Y, 
        AND2_23_Y, AO1_28_Y, AND2_69_Y, AO1_41_Y, AND2_0_Y, 
        AO1_21_Y, AND2_29_Y, AO1_18_Y, AND2_115_Y, AND2_1_Y, 
        AND2_46_Y, AND2_8_Y, AND2_73_Y, AO1_38_Y, AND2_92_Y, 
        AO1_40_Y, AND2_83_Y, AO1_34_Y, AND2_122_Y, AO1_46_Y, 
        AND2_71_Y, AO1_39_Y, AND2_98_Y, AO1_37_Y, AND2_41_Y, 
        AO1_49_Y, AND2_72_Y, AND2_107_Y, AND2_80_Y, AND2_132_Y, 
        AND2_16_Y, AND2_2_Y, AND2_53_Y, AND2_5_Y, AND2_31_Y, 
        AO1_7_Y, AND2_119_Y, AND2_6_Y, AND2_52_Y, AND2_12_Y, 
        AND2_78_Y, AO1_29_Y, AND2_95_Y, AND2_25_Y, AO1_4_Y, 
        AO1_13_Y, AO1_10_Y, AO1_30_Y, AO1_0_Y, AO1_1_Y, AO1_17_Y, 
        AO1_23_Y, AO1_24_Y, AO1_36_Y, AO1_5_Y, AO1_8_Y, AO1_2_Y, 
        AO1_15_Y, AO1_12_Y, AO1_25_Y, AO1_42_Y, AO1_43_Y, AO1_6_Y, 
        XOR2_21_Y, XOR2_16_Y, XOR2_51_Y, XOR2_68_Y, XOR2_45_Y, 
        XOR2_37_Y, XOR2_33_Y, XOR2_62_Y, XOR2_15_Y, XOR2_48_Y, 
        XOR2_40_Y, XOR2_35_Y, XOR2_64_Y, XOR2_19_Y, XOR2_58_Y, 
        XOR2_55_Y, XOR2_50_Y, XOR2_3_Y, XOR2_31_Y, XOR2_10_Y, 
        VCC_1_net, GND_1_net : std_logic ;
    begin   

    VCC_2_net : VCC port map(Y => VCC_1_net);
    GND_2_net : GND port map(Y => GND_1_net);
    MX2_52 : MX2
      port map(A => AND2_130_Y, B => DataA(7), S => NOR2_6_Y, 
        Y => MX2_52_Y);
    AND2_132 : AND2
      port map(A => AND2_92_Y, B => AND2_14_Y, Y => AND2_132_Y);
    AND2_2 : AND2
      port map(A => AND2_92_Y, B => AND2_122_Y, Y => AND2_2_Y);
    XOR3_SumB_17_inst : XOR3
      port map(A => MAJ3_11_Y, B => AND2_126_Y, C => XOR3_8_Y, 
        Y => SumB_17_net);
    NOR2_2 : NOR2
      port map(A => XOR2_66_Y, B => XNOR2_1_Y, Y => NOR2_2_Y);
    AND2_20 : AND2
      port map(A => XOR2_65_Y, B => DataA(8), Y => AND2_20_Y);
    XOR3_SumB_8_inst : XOR3
      port map(A => MAJ3_3_Y, B => XOR2_56_Y, C => XOR3_5_Y, Y => 
        SumB_8_net);
    AO1_11 : AO1
      port map(A => XOR2_63_Y, B => AND2_134_Y, C => AND2_63_Y, 
        Y => AO1_11_Y);
    XOR2_PP3_6_inst : XOR2
      port map(A => MX2_30_Y, B => BUFF_1_Y, Y => PP3_6_net);
    XOR2_PP1_4_inst : XOR2
      port map(A => MX2_35_Y, B => BUFF_3_Y, Y => PP1_4_net);
    XOR2_PP1_12_inst : XOR2
      port map(A => MX2_32_Y, B => BUFF_10_Y, Y => PP1_12_net);
    AND2_11 : AND2
      port map(A => DataB(0), B => DataA(5), Y => AND2_11_Y);
    XOR2_PP0_6_inst : XOR2
      port map(A => MX2_22_Y, B => BUFF_9_Y, Y => PP0_6_net);
    XOR2_PP2_6_inst : XOR2
      port map(A => MX2_21_Y, B => BUFF_11_Y, Y => PP2_6_net);
    BUFF_10 : BUFF
      port map(A => DataB(3), Y => BUFF_10_Y);
    AND2_22 : AND2
      port map(A => XOR2_65_Y, B => DataA(7), Y => AND2_22_Y);
    XOR2_PP1_10_inst : XOR2
      port map(A => MX2_12_Y, B => BUFF_10_Y, Y => PP1_10_net);
    AND2_71 : AND2
      port map(A => AND2_23_Y, B => AND2_56_Y, Y => AND2_71_Y);
    XOR2_PP0_5_inst : XOR2
      port map(A => MX2_44_Y, B => BUFF_9_Y, Y => PP0_5_net);
    XOR2_19 : XOR2
      port map(A => SumA_14_net, B => SumB_14_net, Y => XOR2_19_Y);
    AND2_44 : AND2
      port map(A => XOR2_66_Y, B => DataA(11), Y => AND2_44_Y);
    AO1_31 : AO1
      port map(A => XOR2_13_Y, B => AND2_55_Y, C => AND2_4_Y, 
        Y => AO1_31_Y);
    XOR2_23 : XOR2
      port map(A => SumA_6_net, B => SumB_6_net, Y => XOR2_23_Y);
    XOR2_1 : XOR2
      port map(A => PP1_6_net, B => PP0_8_net, Y => XOR2_1_Y);
    MX2_17 : MX2
      port map(A => AND2_108_Y, B => DataA(9), S => NOR2_2_Y, 
        Y => MX2_17_Y);
    MAJ3_SumA_11_inst : MAJ3
      port map(A => XOR3_2_Y, B => MAJ3_9_Y, C => XOR2_7_Y, Y => 
        SumA_11_net);
    AND2_S_3_inst : AND2
      port map(A => XOR2_46_Y, B => DataB(7), Y => S_3_net);
    MX2_49 : MX2
      port map(A => AND2_59_Y, B => DataA(5), S => NOR2_3_Y, Y => 
        MX2_49_Y);
    AO1_EBAR : AO1
      port map(A => XOR2_18_Y, B => OR3_2_Y, C => AND3_2_Y, Y => 
        EBAR);
    BUFF_8 : BUFF
      port map(A => DataB(5), Y => BUFF_8_Y);
    MAJ3_8 : MAJ3
      port map(A => AND2_3_Y, B => PP3_9_net, C => PP2_11_net, 
        Y => MAJ3_8_Y);
    AND2_104 : AND2
      port map(A => PP1_11_net, B => PP0_13_net, Y => AND2_104_Y);
    AND2_SumB_20_inst : AND2
      port map(A => PP3_14_net, B => VCC_1_net, Y => SumB_20_net);
    XOR2_PP1_13_inst : XOR2
      port map(A => MX2_15_Y, B => BUFF_10_Y, Y => PP1_13_net);
    XOR2_PP1_0_inst : XOR2
      port map(A => XOR2_22_Y, B => DataB(3), Y => PP1_0_net);
    XOR2_47 : XOR2
      port map(A => BUFF_12_Y, B => DataB(4), Y => XOR2_47_Y);
    XOR2_38 : XOR2
      port map(A => AND2_68_Y, B => BUFF_8_Y, Y => XOR2_38_Y);
    XOR2_Mult_0_inst : XOR2
      port map(A => XOR2_69_Y, B => DataB(1), Y => Mult(0));
    MX2_21 : MX2
      port map(A => AND2_45_Y, B => DataA(5), S => NOR2_6_Y, Y => 
        MX2_21_Y);
    AND2_124 : AND2
      port map(A => XOR2_57_Y, B => DataA(1), Y => AND2_124_Y);
    AO1_7 : AO1
      port map(A => AND2_41_Y, B => AO1_40_Y, C => AO1_37_Y, Y => 
        AO1_7_Y);
    AOI1_E_2_inst : AOI1
      port map(A => XOR2_24_Y, B => OR3_1_Y, C => AND3_0_Y, Y => 
        E_2_net);
    AND2_135 : AND2
      port map(A => XOR2_23_Y, B => XOR2_8_Y, Y => AND2_135_Y);
    XOR2_Mult_19_inst : XOR2
      port map(A => XOR2_3_Y, B => AO1_42_Y, Y => Mult(19));
    XOR2_PP2_4_inst : XOR2
      port map(A => MX2_14_Y, B => BUFF_8_Y, Y => PP2_4_net);
    AND2_18 : AND2
      port map(A => XOR2_66_Y, B => DataA(13), Y => AND2_18_Y);
    AND2_15 : AND2
      port map(A => DataB(0), B => DataA(8), Y => AND2_15_Y);
    AND2_84 : AND2
      port map(A => XOR2_26_Y, B => DataA(4), Y => AND2_84_Y);
    NOR2_6 : NOR2
      port map(A => XOR2_27_Y, B => XNOR2_3_Y, Y => NOR2_6_Y);
    AO1_25 : AO1
      port map(A => XOR2_67_Y, B => AO1_12_Y, C => AND2_134_Y, 
        Y => AO1_25_Y);
    AND2_78 : AND2
      port map(A => AND2_119_Y, B => AND2_115_Y, Y => AND2_78_Y);
    AND2_75 : AND2
      port map(A => DataB(0), B => DataA(9), Y => AND2_75_Y);
    MX2_44 : MX2
      port map(A => AND2_11_Y, B => DataA(4), S => AND2A_1_Y, 
        Y => MX2_44_Y);
    XOR2_45 : XOR2
      port map(A => SumA_5_net, B => SumB_5_net, Y => XOR2_45_Y);
    XOR2_Mult_16_inst : XOR2
      port map(A => XOR2_58_Y, B => AO1_15_Y, Y => Mult(16));
    AND2_SumA_3_inst : AND2
      port map(A => PP1_1_net, B => PP0_3_net, Y => SumA_3_net);
    MAJ3_9 : MAJ3
      port map(A => AND2_9_Y, B => PP3_4_net, C => PP2_6_net, 
        Y => MAJ3_9_Y);
    AND2_S_0_inst : AND2
      port map(A => XOR2_69_Y, B => DataB(1), Y => S_0_net);
    AND2_1 : AND2
      port map(A => AND2_65_Y, B => XOR2_2_Y, Y => AND2_1_Y);
    AND2_49 : AND2
      port map(A => DataB(0), B => DataA(2), Y => AND2_49_Y);
    AO1_8 : AO1
      port map(A => AND2_122_Y, B => AO1_38_Y, C => AO1_34_Y, 
        Y => AO1_8_Y);
    AND2_10 : AND2
      port map(A => XOR2_27_Y, B => DataA(5), Y => AND2_10_Y);
    XOR2_20 : XOR2
      port map(A => PP1_11_net, B => PP0_13_net, Y => XOR2_20_Y);
    AND2_7 : AND2
      port map(A => DataB(0), B => DataA(12), Y => AND2_7_Y);
    XOR2_63 : XOR2
      port map(A => SumA_17_net, B => SumB_17_net, Y => XOR2_63_Y);
    AND2_70 : AND2
      port map(A => XOR2_26_Y, B => DataA(3), Y => AND2_70_Y);
    OR3_1 : OR3
      port map(A => DataB(3), B => DataB(4), C => DataB(5), Y => 
        OR3_1_Y);
    AND2_S_1_inst : AND2
      port map(A => XOR2_22_Y, B => DataB(3), Y => S_1_net);
    AND2A_1 : AND2A
      port map(A => DataB(0), B => BUFF_9_Y, Y => AND2A_1_Y);
    AND2_12 : AND2
      port map(A => AND2_119_Y, B => AND2_29_Y, Y => AND2_12_Y);
    AO1_42 : AO1
      port map(A => AND2_82_Y, B => AO1_12_Y, C => AO1_11_Y, Y => 
        AO1_42_Y);
    XOR2_52 : XOR2
      port map(A => S_1_net, B => SumB_2_net, Y => XOR2_52_Y);
    AND2_72 : AND2
      port map(A => AND2_115_Y, B => XOR2_30_Y, Y => AND2_72_Y);
    AND2_61 : AND2
      port map(A => XOR2_57_Y, B => DataA(0), Y => AND2_61_Y);
    AO1_15 : AO1
      port map(A => AND2_98_Y, B => AO1_40_Y, C => AO1_39_Y, Y => 
        AO1_15_Y);
    MX2_5 : MX2
      port map(A => AND2_74_Y, B => DataA(6), S => AND2A_1_Y, 
        Y => MX2_5_Y);
    MX2_PP3_14_inst : MX2
      port map(A => MX2_6_Y, B => AO1_48_Y, S => NOR2_2_Y, Y => 
        PP3_14_net);
    MX2_53 : MX2
      port map(A => AND2_103_Y, B => DataA(4), S => NOR2_8_Y, 
        Y => MX2_53_Y);
    MX2_25 : MX2
      port map(A => AND2_75_Y, B => DataA(8), S => AND2A_1_Y, 
        Y => MX2_25_Y);
    AND2_89 : AND2
      port map(A => XOR2_25_Y, B => XOR2_17_Y, Y => AND2_89_Y);
    XOR2_24 : XOR2
      port map(A => DataA(13), B => DataB(5), Y => XOR2_24_Y);
    AND2_57 : AND2
      port map(A => SumA_11_net, B => SumB_11_net, Y => AND2_57_Y);
    XOR2_21 : XOR2
      port map(A => PP0_2_net, B => PP1_0_net, Y => XOR2_21_Y);
    XOR3_SumB_14_inst : XOR3
      port map(A => MAJ3_0_Y, B => XOR2_44_Y, C => XOR3_6_Y, Y => 
        SumB_14_net);
    BUFF_2 : BUFF
      port map(A => DataB(5), Y => BUFF_2_Y);
    AO1_35 : AO1
      port map(A => AND2_27_Y, B => AO1_3_Y, C => AO1_27_Y, Y => 
        AO1_35_Y);
    XOR2_PP0_7_inst : XOR2
      port map(A => MX2_5_Y, B => BUFF_9_Y, Y => PP0_7_net);
    AND2_46 : AND2
      port map(A => AND2_65_Y, B => AND2_105_Y, Y => AND2_46_Y);
    XOR2_PP3_7_inst : XOR2
      port map(A => MX2_28_Y, B => BUFF_1_Y, Y => PP3_7_net);
    XOR2_16 : XOR2
      port map(A => S_1_net, B => SumB_2_net, Y => XOR2_16_Y);
    MAJ3_12 : MAJ3
      port map(A => AND2_106_Y, B => PP3_5_net, C => PP2_7_net, 
        Y => MAJ3_12_Y);
    XOR2_60 : XOR2
      port map(A => SumA_5_net, B => SumB_5_net, Y => XOR2_60_Y);
    XOR2_PP2_12_inst : XOR2
      port map(A => MX2_48_Y, B => BUFF_14_Y, Y => PP2_12_net);
    AND2_68 : AND2
      port map(A => XOR2_47_Y, B => DataA(0), Y => AND2_68_Y);
    AND2_65 : AND2
      port map(A => AND2_125_Y, B => AND2_76_Y, Y => AND2_65_Y);
    AO1_24 : AO1
      port map(A => AND2_110_Y, B => AO1_17_Y, C => AO1_3_Y, Y => 
        AO1_24_Y);
    AND2_43 : AND2
      port map(A => XOR2_42_Y, B => XOR2_12_Y, Y => AND2_43_Y);
    XOR2_PP2_10_inst : XOR2
      port map(A => MX2_33_Y, B => BUFF_14_Y, Y => PP2_10_net);
    XOR3_SumB_5_inst : XOR3
      port map(A => AND2_94_Y, B => PP3_0_net, C => XOR3_1_Y, 
        Y => SumB_5_net);
    NOR2_3 : NOR2
      port map(A => XOR2_65_Y, B => XNOR2_5_Y, Y => NOR2_3_Y);
    AND3_3 : AND3
      port map(A => DataB(1), B => DataB(2), C => DataB(3), Y => 
        AND3_3_Y);
    MX2_20 : MX2
      port map(A => AND2_77_Y, B => DataA(10), S => NOR2_7_Y, 
        Y => MX2_20_Y);
    AND2_86 : AND2
      port map(A => XOR2_47_Y, B => DataA(1), Y => AND2_86_Y);
    MX2_19 : MX2
      port map(A => AND2_67_Y, B => DataA(0), S => AND2A_0_Y, 
        Y => MX2_19_Y);
    AND2_6 : AND2
      port map(A => AND2_31_Y, B => XOR2_67_Y, Y => AND2_6_Y);
    XOR2_64 : XOR2
      port map(A => SumA_13_net, B => SumB_13_net, Y => XOR2_64_Y);
    AND3_0 : AND3
      port map(A => DataB(3), B => DataB(4), C => DataB(5), Y => 
        AND3_0_Y);
    AND2_60 : AND2
      port map(A => DataB(0), B => DataA(13), Y => AND2_60_Y);
    XOR2_61 : XOR2
      port map(A => SumA_8_net, B => SumB_8_net, Y => XOR2_61_Y);
    XOR2_PP2_13_inst : XOR2
      port map(A => MX2_8_Y, B => BUFF_14_Y, Y => PP2_13_net);
    XOR2_Mult_21_inst : XOR2
      port map(A => XOR2_10_Y, B => AO1_6_Y, Y => Mult(21));
    XOR2_Mult_5_inst : XOR2
      port map(A => XOR2_68_Y, B => AO1_10_Y, Y => Mult(5));
    AND2_83 : AND2
      port map(A => AND2_90_Y, B => AND2_96_Y, Y => AND2_83_Y);
    XOR2_57 : XOR2
      port map(A => BUFF_2_Y, B => DataB(6), Y => XOR2_57_Y);
    XOR2_33 : XOR2
      port map(A => SumA_7_net, B => SumB_7_net, Y => XOR2_33_Y);
    AND2_62 : AND2
      port map(A => XOR2_28_Y, B => DataA(11), Y => AND2_62_Y);
    AND2_97 : AND2
      port map(A => XOR2_41_Y, B => DataA(9), Y => AND2_97_Y);
    XNOR2_2 : XNOR2
      port map(A => DataB(6), B => BUFF_1_Y, Y => XNOR2_2_Y);
    XOR2_49 : XOR2
      port map(A => SumA_3_net, B => SumB_3_net, Y => XOR2_49_Y);
    MX2_31 : MX2
      port map(A => AND2_13_Y, B => DataA(2), S => NOR2_4_Y, Y => 
        MX2_31_Y);
    XOR3_SumB_13_inst : XOR3
      port map(A => MAJ3_4_Y, B => XOR2_29_Y, C => XOR3_12_Y, 
        Y => SumB_13_net);
    AO1_14 : AO1
      port map(A => XOR2_12_Y, B => AND2_66_Y, C => AND2_85_Y, 
        Y => AO1_14_Y);
    XOR2_PP0_11_inst : XOR2
      port map(A => MX2_1_Y, B => BUFF_13_Y, Y => PP0_11_net);
    XOR3_SumB_3_inst : XOR3
      port map(A => PP1_2_net, B => PP0_4_net, C => PP2_0_net, 
        Y => SumB_3_net);
    XOR2_4 : XOR2
      port map(A => DataA(13), B => DataB(3), Y => XOR2_4_Y);
    MAJ3_SumA_9_inst : MAJ3
      port map(A => XOR3_5_Y, B => MAJ3_3_Y, C => XOR2_56_Y, Y => 
        SumA_9_net);
    AND3_1 : AND3
      port map(A => DataB(5), B => DataB(6), C => DataB(7), Y => 
        AND3_1_Y);
    MX2_14 : MX2
      port map(A => AND2_111_Y, B => DataA(3), S => NOR2_5_Y, 
        Y => MX2_14_Y);
    XOR2_55 : XOR2
      port map(A => SumA_16_net, B => SumB_16_net, Y => XOR2_55_Y);
    XOR2_Mult_7_inst : XOR2
      port map(A => XOR2_37_Y, B => AO1_0_Y, Y => Mult(7));
    AND2_24 : AND2
      port map(A => SumA_9_net, B => SumB_9_net, Y => AND2_24_Y);
    XOR2_PP3_3_inst : XOR2
      port map(A => MX2_31_Y, B => BUFF_0_Y, Y => PP3_3_net);
    AO1_40 : AO1
      port map(A => AND2_96_Y, B => AO1_26_Y, C => AO1_47_Y, Y => 
        AO1_40_Y);
    XNOR2_0 : XNOR2
      port map(A => DataB(2), B => BUFF_3_Y, Y => XNOR2_0_Y);
    MAJ3_0 : MAJ3
      port map(A => AND2_104_Y, B => PP3_8_net, C => PP2_10_net, 
        Y => MAJ3_0_Y);
    AND2_31 : AND2
      port map(A => AND2_83_Y, B => AND2_41_Y, Y => AND2_31_Y);
    XOR2_PP1_5_inst : XOR2
      port map(A => MX2_2_Y, B => BUFF_4_Y, Y => PP1_5_net);
    AND2_113 : AND2
      port map(A => S_1_net, B => SumB_2_net, Y => AND2_113_Y);
    AO1_34 : AO1
      port map(A => XOR2_43_Y, B => AO1_32_Y, C => AND2_55_Y, 
        Y => AO1_34_Y);
    XOR2_18 : XOR2
      port map(A => DataA(13), B => DataB(1), Y => XOR2_18_Y);
    BUFF_14 : BUFF
      port map(A => DataB(5), Y => BUFF_14_Y);
    XOR2_Mult_15_inst : XOR2
      port map(A => XOR2_19_Y, B => AO1_2_Y, Y => Mult(15));
    AO1_46 : AO1
      port map(A => AND2_56_Y, B => AO1_35_Y, C => AO1_31_Y, Y => 
        AO1_46_Y);
    OR3_2 : OR3
      port map(A => GND_1_net, B => DataB(0), C => DataB(1), Y => 
        OR3_2_Y);
    XOR2_8 : XOR2
      port map(A => SumA_7_net, B => SumB_7_net, Y => XOR2_8_Y);
    AND2_116 : AND2
      port map(A => XOR2_57_Y, B => DataA(4), Y => AND2_116_Y);
    AND2_110 : AND2
      port map(A => XOR2_61_Y, B => XOR2_39_Y, Y => AND2_110_Y);
    MAJ3_SumA_5_inst : MAJ3
      port map(A => XOR2_9_Y, B => S_2_net, C => PP2_1_net, Y => 
        SumA_5_net);
    NOR2_0 : NOR2
      port map(A => XOR2_26_Y, B => XNOR2_0_Y, Y => NOR2_0_Y);
    AO1_43 : AO1
      port map(A => AND2_29_Y, B => AO1_7_Y, C => AO1_21_Y, Y => 
        AO1_43_Y);
    XOR2_30 : XOR2
      port map(A => E_3_net, B => SumB_20_net, Y => XOR2_30_Y);
    MX2_PP0_14_inst : MX2
      port map(A => MX2_37_Y, B => EBAR, S => AND2A_2_Y, Y => 
        PP0_14_net);
    XOR3_10 : XOR3
      port map(A => PP3_11_net, B => PP2_13_net, C => AND2_54_Y, 
        Y => XOR3_10_Y);
    MX2_35 : MX2
      port map(A => AND2_84_Y, B => DataA(3), S => NOR2_0_Y, Y => 
        MX2_35_Y);
    XOR3_SumB_12_inst : XOR3
      port map(A => MAJ3_2_Y, B => XOR2_20_Y, C => XOR3_3_Y, Y => 
        SumB_12_net);
    XOR2_PP3_2_inst : XOR2
      port map(A => MX2_10_Y, B => BUFF_0_Y, Y => PP3_2_net);
    MX2_PP2_14_inst : MX2
      port map(A => MX2_24_Y, B => AO1_19_Y, S => NOR2_7_Y, Y => 
        PP2_14_net);
    AND2_38 : AND2
      port map(A => DataB(0), B => DataA(11), Y => AND2_38_Y);
    AND2_35 : AND2
      port map(A => SumA_3_net, B => SumB_3_net, Y => AND2_35_Y);
    XOR2_Mult_13_inst : XOR2
      port map(A => XOR2_35_Y, B => AO1_5_Y, Y => Mult(13));
    XOR2_PP0_8_inst : XOR2
      port map(A => MX2_36_Y, B => BUFF_9_Y, Y => PP0_8_net);
    MX2_8 : MX2
      port map(A => AND2_133_Y, B => DataA(12), S => NOR2_7_Y, 
        Y => MX2_8_Y);
    AND2_29 : AND2
      port map(A => AND2_82_Y, B => XOR2_25_Y, Y => AND2_29_Y);
    OR3_3 : OR3
      port map(A => DataB(5), B => DataB(6), C => DataB(7), Y => 
        OR3_3_Y);
    AND2_117 : AND2
      port map(A => AND2_125_Y, B => XOR2_52_Y, Y => AND2_117_Y);
    XOR2_34 : XOR2
      port map(A => PP1_8_net, B => PP0_10_net, Y => XOR2_34_Y);
    MAJ3_4 : MAJ3
      port map(A => AND2_28_Y, B => PP3_7_net, C => PP2_9_net, 
        Y => MAJ3_4_Y);
    XOR2_31 : XOR2
      port map(A => SumA_19_net, B => SumB_19_net, Y => XOR2_31_Y);
    MAJ3_SumA_10_inst : MAJ3
      port map(A => XOR3_7_Y, B => MAJ3_7_Y, C => XOR2_34_Y, Y => 
        SumA_10_net);
    AND2_3 : AND2
      port map(A => PP1_12_net, B => PP0_14_net, Y => AND2_3_Y);
    AO1_49 : AO1
      port map(A => XOR2_30_Y, B => AO1_18_Y, C => AND2_26_Y, 
        Y => AO1_49_Y);
    XOR3_11 : XOR3
      port map(A => PP3_1_net, B => PP2_3_net, C => S_3_net, Y => 
        XOR3_11_Y);
    AND2_30 : AND2
      port map(A => PP1_13_net, B => EBAR, Y => AND2_30_Y);
    XNOR2_6 : XNOR2
      port map(A => DataB(4), B => BUFF_8_Y, Y => XNOR2_6_Y);
    AND2_14 : AND2
      port map(A => AND2_110_Y, B => XOR2_54_Y, Y => AND2_14_Y);
    AND2_103 : AND2
      port map(A => XOR2_41_Y, B => DataA(5), Y => AND2_103_Y);
    AND2_74 : AND2
      port map(A => DataB(0), B => DataA(7), Y => AND2_74_Y);
    AND2_32 : AND2
      port map(A => AND2_110_Y, B => AND2_27_Y, Y => AND2_32_Y);
    XOR2_PP3_5_inst : XOR2
      port map(A => MX2_53_Y, B => BUFF_1_Y, Y => PP3_5_net);
    AND2_123 : AND2
      port map(A => AND2_105_Y, B => XOR2_23_Y, Y => AND2_123_Y);
    XOR2_PP0_9_inst : XOR2
      port map(A => MX2_25_Y, B => BUFF_9_Y, Y => PP0_9_net);
    BUFF_5 : BUFF
      port map(A => DataB(7), Y => BUFF_5_Y);
    XOR2_PP2_2_inst : XOR2
      port map(A => MX2_18_Y, B => BUFF_8_Y, Y => PP2_2_net);
    XOR3_4 : XOR3
      port map(A => PP3_6_net, B => PP2_8_net, C => AND2_99_Y, 
        Y => XOR3_4_Y);
    XOR2_46 : XOR2
      port map(A => AND2_61_Y, B => BUFF_0_Y, Y => XOR2_46_Y);
    MX2_30 : MX2
      port map(A => AND2_121_Y, B => DataA(5), S => NOR2_8_Y, 
        Y => MX2_30_Y);
    MX2_22 : MX2
      port map(A => AND2_100_Y, B => DataA(5), S => AND2A_1_Y, 
        Y => MX2_22_Y);
    AO1_2 : AO1
      port map(A => AND2_71_Y, B => AO1_38_Y, C => AO1_46_Y, Y => 
        AO1_2_Y);
    AND2_106 : AND2
      port map(A => PP1_8_net, B => PP0_10_net, Y => AND2_106_Y);
    AND2_100 : AND2
      port map(A => DataB(0), B => DataA(6), Y => AND2_100_Y);
    AND2_26 : AND2
      port map(A => E_3_net, B => SumB_20_net, Y => AND2_26_Y);
    MAJ3_SumA_14_inst : MAJ3
      port map(A => XOR3_12_Y, B => MAJ3_4_Y, C => XOR2_29_Y, 
        Y => SumA_14_net);
    AOI1_E_3_inst : AOI1
      port map(A => XOR2_59_Y, B => OR3_3_Y, C => AND3_1_Y, Y => 
        E_3_net);
    AND2_111 : AND2
      port map(A => XOR2_47_Y, B => DataA(4), Y => AND2_111_Y);
    XOR2_PP3_12_inst : XOR2
      port map(A => MX2_41_Y, B => BUFF_5_Y, Y => PP3_12_net);
    XOR2_9 : XOR2
      port map(A => PP1_3_net, B => PP0_5_net, Y => XOR2_9_Y);
    AND2_126 : AND2
      port map(A => E_1_net, B => E_0_net, Y => AND2_126_Y);
    AND2_120 : AND2
      port map(A => XOR2_27_Y, B => DataA(9), Y => AND2_120_Y);
    XOR2_Mult_18_inst : XOR2
      port map(A => XOR2_50_Y, B => AO1_25_Y, Y => Mult(18));
    XOR2_PP3_10_inst : XOR2
      port map(A => MX2_17_Y, B => BUFF_5_Y, Y => PP3_10_net);
    XOR2_59 : XOR2
      port map(A => DataA(13), B => DataB(7), Y => XOR2_59_Y);
    AND2_23 : AND2
      port map(A => AND2_110_Y, B => AND2_27_Y, Y => AND2_23_Y);
    MX2_54 : MX2
      port map(A => AND2_86_Y, B => DataA(0), S => NOR2_5_Y, Y => 
        MX2_54_Y);
    XNOR2_4 : XNOR2
      port map(A => DataB(6), B => BUFF_0_Y, Y => XNOR2_4_Y);
    NOR2_1 : NOR2
      port map(A => XOR2_28_Y, B => XNOR2_7_Y, Y => NOR2_1_Y);
    XOR2_5 : XOR2
      port map(A => PP1_10_net, B => PP0_12_net, Y => XOR2_5_Y);
    XOR2_PP0_1_inst : XOR2
      port map(A => MX2_19_Y, B => BUFF_7_Y, Y => PP0_1_net);
    MX2_0 : MX2
      port map(A => AND2_7_Y, B => DataA(11), S => AND2A_2_Y, 
        Y => MX2_0_Y);
    AND2_107 : AND2
      port map(A => AND2_73_Y, B => XOR2_61_Y, Y => AND2_107_Y);
    AO1_28 : AO1
      port map(A => XOR2_42_Y, B => AO1_31_Y, C => AND2_66_Y, 
        Y => AO1_28_Y);
    XOR2_PP2_0_inst : XOR2
      port map(A => XOR2_38_Y, B => DataB(5), Y => PP2_0_net);
    AND2_19 : AND2
      port map(A => XOR2_41_Y, B => DataA(7), Y => AND2_19_Y);
    XOR2_PP1_8_inst : XOR2
      port map(A => MX2_46_Y, B => BUFF_4_Y, Y => PP1_8_net);
    MAJ3_SumA_18_inst : MAJ3
      port map(A => XOR3_8_Y, B => MAJ3_11_Y, C => AND2_126_Y, 
        Y => SumA_18_net);
    AND2_79 : AND2
      port map(A => SumA_4_net, B => SumB_4_net, Y => AND2_79_Y);
    XOR2_PP3_13_inst : XOR2
      port map(A => MX2_7_Y, B => BUFF_5_Y, Y => PP3_13_net);
    AND2_119 : AND2
      port map(A => AND2_83_Y, B => AND2_41_Y, Y => AND2_119_Y);
    XOR2_22 : XOR2
      port map(A => AND2_36_Y, B => BUFF_3_Y, Y => XOR2_22_Y);
    AND2_127 : AND2
      port map(A => XOR2_57_Y, B => DataA(2), Y => AND2_127_Y);
    AO1_1 : AO1
      port map(A => AND2_123_Y, B => AO1_10_Y, C => AO1_45_Y, 
        Y => AO1_1_Y);
    MAJ3_11 : MAJ3
      port map(A => AND2_54_Y, B => PP3_11_net, C => PP2_13_net, 
        Y => MAJ3_11_Y);
    MX2_41 : MX2
      port map(A => AND2_129_Y, B => DataA(11), S => NOR2_2_Y, 
        Y => MX2_41_Y);
    MX2_28 : MX2
      port map(A => AND2_19_Y, B => DataA(6), S => NOR2_8_Y, Y => 
        MX2_28_Y);
    AOI1_E_1_inst : AOI1
      port map(A => XOR2_4_Y, B => OR3_0_Y, C => AND3_3_Y, Y => 
        E_1_net);
    XOR2_PP1_3_inst : XOR2
      port map(A => MX2_9_Y, B => BUFF_3_Y, Y => PP1_3_net);
    XOR2_13 : XOR2
      port map(A => SumA_13_net, B => SumB_13_net, Y => XOR2_13_Y);
    AND2_134 : AND2
      port map(A => SumA_16_net, B => SumB_16_net, Y => 
        AND2_134_Y);
    XOR3_SumB_11_inst : XOR3
      port map(A => MAJ3_12_Y, B => XOR2_5_Y, C => XOR3_4_Y, Y => 
        SumB_11_net);
    AND2_51 : AND2
      port map(A => XOR2_28_Y, B => DataA(13), Y => AND2_51_Y);
    AO1_3 : AO1
      port map(A => XOR2_39_Y, B => AND2_93_Y, C => AND2_24_Y, 
        Y => AO1_3_Y);
    AND2_64 : AND2
      port map(A => XOR2_27_Y, B => DataA(7), Y => AND2_64_Y);
    AND2_47 : AND2
      port map(A => DataB(0), B => DataA(4), Y => AND2_47_Y);
    XOR2_PP2_9_inst : XOR2
      port map(A => MX2_23_Y, B => BUFF_11_Y, Y => PP2_9_net);
    AO1_18 : AO1
      port map(A => AND2_89_Y, B => AO1_11_Y, C => AO1_22_Y, Y => 
        AO1_18_Y);
    XOR2_48 : XOR2
      port map(A => SumA_10_net, B => SumB_10_net, Y => XOR2_48_Y);
    AO1_47 : AO1
      port map(A => AND2_135_Y, B => AO1_44_Y, C => AO1_20_Y, 
        Y => AO1_47_Y);
    MX2_26 : MX2
      port map(A => AND2_47_Y, B => DataA(3), S => AND2A_0_Y, 
        Y => MX2_26_Y);
    AND2A_2 : AND2A
      port map(A => DataB(0), B => BUFF_13_Y, Y => AND2A_2_Y);
    AND2_101 : AND2
      port map(A => XOR2_65_Y, B => DataA(5), Y => AND2_101_Y);
    AND2_16 : AND2
      port map(A => AND2_92_Y, B => AND2_32_Y, Y => AND2_16_Y);
    XOR2_PP1_6_inst : XOR2
      port map(A => MX2_49_Y, B => BUFF_4_Y, Y => PP1_6_net);
    AND2_76 : AND2
      port map(A => XOR2_52_Y, B => XOR2_49_Y, Y => AND2_76_Y);
    AND2_121 : AND2
      port map(A => XOR2_41_Y, B => DataA(6), Y => AND2_121_Y);
    AO1_38 : AO1
      port map(A => AND2_96_Y, B => AO1_26_Y, C => AO1_47_Y, Y => 
        AO1_38_Y);
    MAJ3_SumA_8_inst : MAJ3
      port map(A => XOR3_9_Y, B => MAJ3_6_Y, C => XOR2_1_Y, Y => 
        SumA_8_net);
    XOR2_62 : XOR2
      port map(A => SumA_8_net, B => SumB_8_net, Y => XOR2_62_Y);
    AND2_13 : AND2
      port map(A => XOR2_57_Y, B => DataA(3), Y => AND2_13_Y);
    AND2_87 : AND2
      port map(A => SumA_5_net, B => SumB_5_net, Y => AND2_87_Y);
    MX2_45 : MX2
      port map(A => AND2_97_Y, B => DataA(8), S => NOR2_8_Y, Y => 
        MX2_45_Y);
    XOR2_PP1_1_inst : XOR2
      port map(A => MX2_4_Y, B => BUFF_3_Y, Y => PP1_1_net);
    AND2_73 : AND2
      port map(A => AND2_90_Y, B => AND2_96_Y, Y => AND2_73_Y);
    XNOR2_1 : XNOR2
      port map(A => DataB(6), B => BUFF_5_Y, Y => XNOR2_1_Y);
    XOR2_10 : XOR2
      port map(A => E_3_net, B => SumB_20_net, Y => XOR2_10_Y);
    AND2_58 : AND2
      port map(A => DataB(0), B => DataA(10), Y => AND2_58_Y);
    AND2_55 : AND2
      port map(A => SumA_12_net, B => SumB_12_net, Y => AND2_55_Y);
    MX2_2 : MX2
      port map(A => AND2_101_Y, B => DataA(4), S => NOR2_3_Y, 
        Y => MX2_2_Y);
    AND2_109 : AND2
      port map(A => XOR2_47_Y, B => DataA(3), Y => AND2_109_Y);
    MX2_23 : MX2
      port map(A => AND2_120_Y, B => DataA(8), S => NOR2_6_Y, 
        Y => MX2_23_Y);
    AND2_69 : AND2
      port map(A => AND2_56_Y, B => XOR2_42_Y, Y => AND2_69_Y);
    AND2_129 : AND2
      port map(A => XOR2_66_Y, B => DataA(12), Y => AND2_129_Y);
    MAJ3_SumA_16_inst : MAJ3
      port map(A => XOR3_0_Y, B => MAJ3_8_Y, C => XOR2_36_Y, Y => 
        SumA_16_net);
    XOR3_3 : XOR3
      port map(A => PP3_7_net, B => PP2_9_net, C => AND2_28_Y, 
        Y => XOR3_3_Y);
    XOR2_27 : XOR2
      port map(A => BUFF_12_Y, B => DataB(4), Y => XOR2_27_Y);
    MAJ3_3 : MAJ3
      port map(A => AND2_48_Y, B => PP3_2_net, C => PP2_4_net, 
        Y => MAJ3_3_Y);
    MAJ3_SumA_4_inst : MAJ3
      port map(A => PP2_0_net, B => PP1_2_net, C => PP0_4_net, 
        Y => SumA_4_net);
    XOR3_SumB_10_inst : XOR3
      port map(A => MAJ3_9_Y, B => XOR2_7_Y, C => XOR3_2_Y, Y => 
        SumB_10_net);
    BUFF_12 : BUFF
      port map(A => DataB(3), Y => BUFF_12_Y);
    MX2_PP1_14_inst : MX2
      port map(A => MX2_3_Y, B => AO1_33_Y, S => NOR2_1_Y, Y => 
        PP1_14_net);
    XOR2_7 : XOR2
      port map(A => PP1_9_net, B => PP0_11_net, Y => XOR2_7_Y);
    AND2_5 : AND2
      port map(A => AND2_83_Y, B => AND2_98_Y, Y => AND2_5_Y);
    XOR2_56 : XOR2
      port map(A => PP1_7_net, B => PP0_9_net, Y => XOR2_56_Y);
    XOR2_14 : XOR2
      port map(A => PP1_5_net, B => PP0_7_net, Y => XOR2_14_Y);
    XOR2_Mult_3_inst : XOR2
      port map(A => XOR2_16_Y, B => AO1_4_Y, Y => Mult(3));
    AND2_91 : AND2
      port map(A => XOR2_28_Y, B => DataA(12), Y => AND2_91_Y);
    XOR2_PP3_0_inst : XOR2
      port map(A => XOR2_46_Y, B => DataB(7), Y => PP3_0_net);
    AND2_50 : AND2
      port map(A => XOR2_26_Y, B => DataA(1), Y => AND2_50_Y);
    XNOR2_3 : XNOR2
      port map(A => DataB(4), B => BUFF_11_Y, Y => XNOR2_3_Y);
    XOR2_Mult_8_inst : XOR2
      port map(A => XOR2_33_Y, B => AO1_1_Y, Y => Mult(8));
    XOR2_PP0_4_inst : XOR2
      port map(A => MX2_26_Y, B => BUFF_7_Y, Y => PP0_4_net);
    XOR2_11 : XOR2
      port map(A => PP0_2_net, B => PP1_0_net, Y => XOR2_11_Y);
    MX2_32 : MX2
      port map(A => AND2_91_Y, B => DataA(11), S => NOR2_1_Y, 
        Y => MX2_32_Y);
    XOR2_PP3_8_inst : XOR2
      port map(A => MX2_29_Y, B => BUFF_1_Y, Y => PP3_8_net);
    XOR3_6 : XOR3
      port map(A => PP3_9_net, B => PP2_11_net, C => AND2_3_Y, 
        Y => XOR3_6_Y);
    AND2_52 : AND2
      port map(A => AND2_31_Y, B => AND2_82_Y, Y => AND2_52_Y);
    XOR2_25 : XOR2
      port map(A => SumA_18_net, B => SumB_18_net, Y => XOR2_25_Y);
    AO1_22 : AO1
      port map(A => XOR2_17_Y, B => AND2_102_Y, C => AND2_33_Y, 
        Y => AO1_22_Y);
    MAJ3_SumA_13_inst : MAJ3
      port map(A => XOR3_3_Y, B => MAJ3_2_Y, C => XOR2_20_Y, Y => 
        SumA_13_net);
    MAJ3_SumA_12_inst : MAJ3
      port map(A => XOR3_4_Y, B => MAJ3_12_Y, C => XOR2_5_Y, Y => 
        SumA_12_net);
    BUFF_0 : BUFF
      port map(A => DataB(7), Y => BUFF_0_Y);
    MX2_40 : MX2
      port map(A => AND2_10_Y, B => DataA(4), S => NOR2_6_Y, Y => 
        MX2_40_Y);
    XOR3_SumB_18_inst : XOR3
      port map(A => PP3_13_net, B => E_2_net, C => MAJ3_10_Y, 
        Y => SumB_18_net);
    AND2_112 : AND2
      port map(A => XOR2_6_Y, B => DataA(10), Y => AND2_112_Y);
    MX2_27 : MX2
      port map(A => AND2_22_Y, B => DataA(6), S => NOR2_3_Y, Y => 
        MX2_27_Y);
    MAJ3_SumA_15_inst : MAJ3
      port map(A => XOR3_6_Y, B => MAJ3_0_Y, C => XOR2_44_Y, Y => 
        SumA_15_net);
    AND2_34 : AND2
      port map(A => DataB(0), B => DataA(0), Y => AND2_34_Y);
    AO1_41 : AO1
      port map(A => AND2_43_Y, B => AO1_31_Y, C => AO1_14_Y, Y => 
        AO1_41_Y);
    XOR2_Mult_4_inst : XOR2
      port map(A => XOR2_51_Y, B => AO1_13_Y, Y => Mult(4));
    XOR2_SumB_2_inst : XOR2
      port map(A => PP1_1_net, B => PP0_3_net, Y => SumB_2_net);
    AND2_66 : AND2
      port map(A => SumA_14_net, B => SumB_14_net, Y => AND2_66_Y);
    AO1_6 : AO1
      port map(A => AND2_115_Y, B => AO1_7_Y, C => AO1_18_Y, Y => 
        AO1_6_Y);
    MX2_11 : MX2
      port map(A => AND2_49_Y, B => DataA(1), S => AND2A_0_Y, 
        Y => MX2_11_Y);
    XOR2_Mult_17_inst : XOR2
      port map(A => XOR2_55_Y, B => AO1_12_Y, Y => Mult(17));
    AND2_98 : AND2
      port map(A => AND2_23_Y, B => AND2_69_Y, Y => AND2_98_Y);
    AND2_95 : AND2
      port map(A => AND2_119_Y, B => AND2_72_Y, Y => AND2_95_Y);
    XOR2_67 : XOR2
      port map(A => SumA_16_net, B => SumB_16_net, Y => XOR2_67_Y);
    MX2_38 : MX2
      port map(A => AND2_62_Y, B => DataA(10), S => NOR2_1_Y, 
        Y => MX2_38_Y);
    NOR2_4 : NOR2
      port map(A => XOR2_57_Y, B => XNOR2_4_Y, Y => NOR2_4_Y);
    XOR2_Mult_1_inst : XOR2
      port map(A => PP0_1_net, B => S_0_net, Y => Mult(1));
    AND3_2 : AND3
      port map(A => GND_1_net, B => DataB(0), C => DataB(1), Y => 
        AND3_2_Y);
    AND2_63 : AND2
      port map(A => SumA_17_net, B => SumB_17_net, Y => AND2_63_Y);
    AO1_12 : AO1
      port map(A => AND2_41_Y, B => AO1_40_Y, C => AO1_37_Y, Y => 
        AO1_12_Y);
    XOR2_PP1_11_inst : XOR2
      port map(A => MX2_38_Y, B => BUFF_10_Y, Y => PP1_11_net);
    XOR2_32 : XOR2
      port map(A => SumA_11_net, B => SumB_11_net, Y => XOR2_32_Y);
    XOR3_SumB_6_inst : XOR3
      port map(A => MAJ3_1_Y, B => XOR2_14_Y, C => XOR3_11_Y, 
        Y => SumB_6_net);
    XOR2_Mult_10_inst : XOR2
      port map(A => XOR2_15_Y, B => AO1_23_Y, Y => Mult(10));
    XOR2_Mult_2_inst : XOR2
      port map(A => XOR2_21_Y, B => AND2_25_Y, Y => Mult(2));
    OR3_0 : OR3
      port map(A => DataB(1), B => DataB(2), C => DataB(3), Y => 
        OR3_0_Y);
    XOR2_PP0_2_inst : XOR2
      port map(A => MX2_11_Y, B => BUFF_7_Y, Y => PP0_2_net);
    XOR3_12 : XOR3
      port map(A => PP3_8_net, B => PP2_10_net, C => AND2_104_Y, 
        Y => XOR3_12_Y);
    AND2_9 : AND2
      port map(A => PP1_7_net, B => PP0_9_net, Y => AND2_9_Y);
    MX2_6 : MX2
      port map(A => BUFF_5_Y, B => XOR2_59_Y, S => XOR2_66_Y, 
        Y => MX2_6_Y);
    XOR2_65 : XOR2
      port map(A => BUFF_6_Y, B => DataB(2), Y => XOR2_65_Y);
    AND2_90 : AND2
      port map(A => AND2_125_Y, B => AND2_76_Y, Y => AND2_90_Y);
    XOR2_58 : XOR2
      port map(A => SumA_15_net, B => SumB_15_net, Y => XOR2_58_Y);
    AO1_32 : AO1
      port map(A => AND2_27_Y, B => AO1_3_Y, C => AO1_27_Y, Y => 
        AO1_32_Y);
    XOR2_43 : XOR2
      port map(A => SumA_12_net, B => SumB_12_net, Y => XOR2_43_Y);
    XOR2_PP3_4_inst : XOR2
      port map(A => MX2_39_Y, B => BUFF_0_Y, Y => PP3_4_net);
    MX2_36 : MX2
      port map(A => AND2_15_Y, B => DataA(7), S => AND2A_1_Y, 
        Y => MX2_36_Y);
    AND2_92 : AND2
      port map(A => AND2_90_Y, B => AND2_96_Y, Y => AND2_92_Y);
    MX2_7 : MX2
      port map(A => AND2_18_Y, B => DataA(12), S => NOR2_2_Y, 
        Y => MX2_7_Y);
    AO1_9 : AO1
      port map(A => XOR2_54_Y, B => AO1_3_Y, C => AND2_40_Y, Y => 
        AO1_9_Y);
    NOR2_8 : NOR2
      port map(A => XOR2_41_Y, B => XNOR2_2_Y, Y => NOR2_8_Y);
    XOR3_SumB_4_inst : XOR3
      port map(A => S_2_net, B => PP2_1_net, C => XOR2_9_Y, Y => 
        SumB_4_net);
    AND2_39 : AND2
      port map(A => SumA_7_net, B => SumB_7_net, Y => AND2_39_Y);
    AND2_115 : AND2
      port map(A => AND2_82_Y, B => AND2_89_Y, Y => AND2_115_Y);
    BUFF_9 : BUFF
      port map(A => DataB(1), Y => BUFF_9_Y);
    XOR2_Mult_6_inst : XOR2
      port map(A => XOR2_45_Y, B => AO1_30_Y, Y => Mult(6));
    XOR3_SumB_9_inst : XOR3
      port map(A => MAJ3_7_Y, B => XOR2_34_Y, C => XOR3_7_Y, Y => 
        SumB_9_net);
    MX2_15 : MX2
      port map(A => AND2_51_Y, B => DataA(12), S => NOR2_1_Y, 
        Y => MX2_15_Y);
    XOR3_SumB_16_inst : XOR3
      port map(A => MAJ3_5_Y, B => XOR2_53_Y, C => XOR3_10_Y, 
        Y => SumB_16_net);
    MAJ3_6 : MAJ3
      port map(A => S_3_net, B => PP3_1_net, C => PP2_3_net, Y => 
        MAJ3_6_Y);
    XOR2_PP2_3_inst : XOR2
      port map(A => MX2_34_Y, B => BUFF_8_Y, Y => PP2_3_net);
    AND2_102 : AND2
      port map(A => SumA_18_net, B => SumB_18_net, Y => 
        AND2_102_Y);
    AND2_27 : AND2
      port map(A => XOR2_54_Y, B => XOR2_32_Y, Y => AND2_27_Y);
    MX2_3 : MX2
      port map(A => BUFF_10_Y, B => XOR2_4_Y, S => XOR2_28_Y, 
        Y => MX2_3_Y);
    AND2_122 : AND2
      port map(A => AND2_32_Y, B => XOR2_43_Y, Y => AND2_122_Y);
    MX2_33 : MX2
      port map(A => AND2_112_Y, B => DataA(9), S => NOR2_7_Y, 
        Y => MX2_33_Y);
    XOR2_Mult_12_inst : XOR2
      port map(A => XOR2_40_Y, B => AO1_36_Y, Y => Mult(12));
    AO1_20 : AO1
      port map(A => XOR2_8_Y, B => AND2_128_Y, C => AND2_39_Y, 
        Y => AO1_20_Y);
    AO1_0 : AO1
      port map(A => AND2_105_Y, B => AO1_10_Y, C => AO1_44_Y, 
        Y => AO1_0_Y);
    XOR3_9 : XOR3
      port map(A => PP3_2_net, B => PP2_4_net, C => AND2_48_Y, 
        Y => XOR3_9_Y);
    XOR3_SumB_15_inst : XOR3
      port map(A => MAJ3_8_Y, B => XOR2_36_Y, C => XOR3_0_Y, Y => 
        SumB_15_net);
    XOR2_29 : XOR2
      port map(A => PP1_12_net, B => PP0_14_net, Y => XOR2_29_Y);
    AO1_45 : AO1
      port map(A => XOR2_23_Y, B => AO1_44_Y, C => AND2_128_Y, 
        Y => AO1_45_Y);
    BUFF_6 : BUFF
      port map(A => DataB(1), Y => BUFF_6_Y);
    XOR2_40 : XOR2
      port map(A => SumA_11_net, B => SumB_11_net, Y => XOR2_40_Y);
    XOR3_0 : XOR3
      port map(A => PP3_10_net, B => PP2_12_net, C => AND2_30_Y, 
        Y => XOR3_0_Y);
    BUFF_7 : BUFF
      port map(A => DataB(1), Y => BUFF_7_Y);
    MX2_9 : MX2
      port map(A => AND2_70_Y, B => DataA(2), S => NOR2_0_Y, Y => 
        MX2_9_Y);
    XOR2_2 : XOR2
      port map(A => SumA_4_net, B => SumB_4_net, Y => XOR2_2_Y);
    XOR2_PP0_12_inst : XOR2
      port map(A => MX2_0_Y, B => BUFF_13_Y, Y => PP0_12_net);
    XOR2_PP0_10_inst : XOR2
      port map(A => MX2_43_Y, B => BUFF_13_Y, Y => PP0_10_net);
    XOR2_37 : XOR2
      port map(A => SumA_6_net, B => SumB_6_net, Y => XOR2_37_Y);
    AND2A_0 : AND2A
      port map(A => DataB(0), B => BUFF_7_Y, Y => AND2A_0_Y);
    AND2_36 : AND2
      port map(A => XOR2_26_Y, B => DataA(0), Y => AND2_36_Y);
    XOR2_PP2_1_inst : XOR2
      port map(A => MX2_54_Y, B => BUFF_8_Y, Y => PP2_1_net);
    AO1_26 : AO1
      port map(A => AND2_76_Y, B => AO1_4_Y, C => AO1_16_Y, Y => 
        AO1_26_Y);
    XOR3_5 : XOR3
      port map(A => PP3_3_net, B => PP2_5_net, C => AND2_17_Y, 
        Y => XOR3_5_Y);
    MX2_10 : MX2
      port map(A => AND2_127_Y, B => DataA(1), S => NOR2_4_Y, 
        Y => MX2_10_Y);
    AO1_23 : AO1
      port map(A => XOR2_61_Y, B => AO1_17_Y, C => AND2_93_Y, 
        Y => AO1_23_Y);
    MAJ3_SumB_19_inst : MAJ3
      port map(A => MAJ3_10_Y, B => PP3_13_net, C => E_2_net, 
        Y => SumB_19_net);
    AND2_33 : AND2
      port map(A => SumA_19_net, B => SumB_19_net, Y => AND2_33_Y);
    XOR2_44 : XOR2
      port map(A => PP1_13_net, B => EBAR, Y => XOR2_44_Y);
    AO1_10 : AO1
      port map(A => AND2_76_Y, B => AO1_4_Y, C => AO1_16_Y, Y => 
        AO1_10_Y);
    AND2_133 : AND2
      port map(A => XOR2_6_Y, B => DataA(13), Y => AND2_133_Y);
    XOR2_PP1_7_inst : XOR2
      port map(A => MX2_27_Y, B => BUFF_4_Y, Y => PP1_7_net);
    MX2_42 : MX2
      port map(A => AND2_131_Y, B => DataA(8), S => NOR2_3_Y, 
        Y => MX2_42_Y);
    XOR2_41 : XOR2
      port map(A => BUFF_2_Y, B => DataB(6), Y => XOR2_41_Y);
    XOR2_35 : XOR2
      port map(A => SumA_12_net, B => SumB_12_net, Y => XOR2_35_Y);
    MX2_51 : MX2
      port map(A => AND2_64_Y, B => DataA(6), S => NOR2_6_Y, Y => 
        MX2_51_Y);
    AND2_105 : AND2
      port map(A => XOR2_2_Y, B => XOR2_60_Y, Y => AND2_105_Y);
    MX2_29 : MX2
      port map(A => AND2_118_Y, B => DataA(7), S => NOR2_8_Y, 
        Y => MX2_29_Y);
    XOR2_PP0_13_inst : XOR2
      port map(A => MX2_13_Y, B => BUFF_13_Y, Y => PP0_13_net);
    MX2_37 : MX2
      port map(A => BUFF_13_Y, B => XOR2_18_Y, S => DataB(0), 
        Y => MX2_37_Y);
    XOR2_PP2_5_inst : XOR2
      port map(A => MX2_40_Y, B => BUFF_11_Y, Y => PP2_5_net);
    AND2_125 : AND2
      port map(A => XOR2_0_Y, B => XOR2_11_Y, Y => AND2_125_Y);
    AND2_S_2_inst : AND2
      port map(A => XOR2_38_Y, B => DataB(5), Y => S_2_net);
    NOR2_5 : NOR2
      port map(A => XOR2_47_Y, B => XNOR2_6_Y, Y => NOR2_5_Y);
    AO1_30 : AO1
      port map(A => XOR2_2_Y, B => AO1_10_Y, C => AND2_79_Y, Y => 
        AO1_30_Y);
    XOR3_8 : XOR3
      port map(A => PP2_14_net, B => VCC_1_net, C => PP3_12_net, 
        Y => XOR3_8_Y);
    AND2_41 : AND2
      port map(A => AND2_23_Y, B => AND2_0_Y, Y => AND2_41_Y);
    AND2_0 : AND2
      port map(A => AND2_56_Y, B => AND2_43_Y, Y => AND2_0_Y);
    XOR2_69 : XOR2
      port map(A => AND2_34_Y, B => BUFF_7_Y, Y => XOR2_69_Y);
    AND2_130 : AND2
      port map(A => XOR2_27_Y, B => DataA(8), Y => AND2_130_Y);
    AO1_16 : AO1
      port map(A => XOR2_49_Y, B => AND2_113_Y, C => AND2_35_Y, 
        Y => AO1_16_Y);
    XOR2_PP1_2_inst : XOR2
      port map(A => MX2_47_Y, B => BUFF_3_Y, Y => PP1_2_net);
    AND2_17 : AND2
      port map(A => PP1_6_net, B => PP0_8_net, Y => AND2_17_Y);
    MAJ3_SumA_6_inst : MAJ3
      port map(A => XOR3_1_Y, B => AND2_94_Y, C => PP3_0_net, 
        Y => SumA_6_net);
    BUFF_3 : BUFF
      port map(A => DataB(3), Y => BUFF_3_Y);
    XOR2_PP2_11_inst : XOR2
      port map(A => MX2_20_Y, B => BUFF_14_Y, Y => PP2_11_net);
    AO1_29 : AO1
      port map(A => AND2_72_Y, B => AO1_7_Y, C => AO1_49_Y, Y => 
        AO1_29_Y);
    XOR2_PP2_8_inst : XOR2
      port map(A => MX2_52_Y, B => BUFF_11_Y, Y => PP2_8_net);
    XOR2_6 : XOR2
      port map(A => BUFF_12_Y, B => DataB(4), Y => XOR2_6_Y);
    AND2_77 : AND2
      port map(A => XOR2_6_Y, B => DataA(11), Y => AND2_77_Y);
    MX2_24 : MX2
      port map(A => BUFF_14_Y, B => XOR2_24_Y, S => XOR2_6_Y, 
        Y => MX2_24_Y);
    AND2_54 : AND2
      port map(A => PP1_14_net, B => EBAR, Y => AND2_54_Y);
    AO1_13 : AO1
      port map(A => XOR2_52_Y, B => AO1_4_Y, C => AND2_113_Y, 
        Y => AO1_13_Y);
    MX2_48 : MX2
      port map(A => AND2_114_Y, B => DataA(11), S => NOR2_7_Y, 
        Y => MX2_48_Y);
    AO1_36 : AO1
      port map(A => AND2_14_Y, B => AO1_38_Y, C => AO1_9_Y, Y => 
        AO1_36_Y);
    XOR2_53 : XOR2
      port map(A => E_1_net, B => E_0_net, Y => XOR2_53_Y);
    XOR2_Mult_9_inst : XOR2
      port map(A => XOR2_62_Y, B => AO1_17_Y, Y => Mult(9));
    AND2_81 : AND2
      port map(A => PP0_2_net, B => PP1_0_net, Y => AND2_81_Y);
    MAJ3_5 : MAJ3
      port map(A => AND2_30_Y, B => PP3_10_net, C => PP2_12_net, 
        Y => MAJ3_5_Y);
    AO1_33 : AO1
      port map(A => XOR2_4_Y, B => OR3_0_Y, C => AND3_3_Y, Y => 
        AO1_33_Y);
    AO1_44 : AO1
      port map(A => XOR2_60_Y, B => AND2_79_Y, C => AND2_87_Y, 
        Y => AO1_44_Y);
    MX2_55 : MX2
      port map(A => AND2_124_Y, B => DataA(0), S => NOR2_4_Y, 
        Y => MX2_55_Y);
    XNOR2_7 : XNOR2
      port map(A => DataB(2), B => BUFF_10_Y, Y => XNOR2_7_Y);
    XOR2_12 : XOR2
      port map(A => SumA_15_net, B => SumB_15_net, Y => XOR2_12_Y);
    AND2_48 : AND2
      port map(A => PP1_5_net, B => PP0_7_net, Y => AND2_48_Y);
    AND2_45 : AND2
      port map(A => XOR2_27_Y, B => DataA(6), Y => AND2_45_Y);
    AO1_19 : AO1
      port map(A => XOR2_24_Y, B => OR3_1_Y, C => AND3_0_Y, Y => 
        AO1_19_Y);
    XOR2_PP3_1_inst : XOR2
      port map(A => MX2_55_Y, B => BUFF_0_Y, Y => PP3_1_net);
    MX2_46 : MX2
      port map(A => AND2_20_Y, B => DataA(7), S => NOR2_3_Y, Y => 
        MX2_46_Y);
    XOR2_26 : XOR2
      port map(A => BUFF_6_Y, B => DataB(2), Y => XOR2_26_Y);
    AND2_59 : AND2
      port map(A => XOR2_65_Y, B => DataA(6), Y => AND2_59_Y);
    XOR3_SumB_7_inst : XOR3
      port map(A => MAJ3_6_Y, B => XOR2_1_Y, C => XOR3_9_Y, Y => 
        SumB_7_net);
    AND2_4 : AND2
      port map(A => SumA_13_net, B => SumB_13_net, Y => AND2_4_Y);
    AO1_39 : AO1
      port map(A => AND2_69_Y, B => AO1_35_Y, C => AO1_28_Y, Y => 
        AO1_39_Y);
    AND2_40 : AND2
      port map(A => SumA_10_net, B => SumB_10_net, Y => AND2_40_Y);
    AND2_88 : AND2
      port map(A => XOR2_26_Y, B => DataA(2), Y => AND2_88_Y);
    AND2_85 : AND2
      port map(A => SumA_15_net, B => SumB_15_net, Y => AND2_85_Y);
    BUFF_4 : BUFF
      port map(A => DataB(3), Y => BUFF_4_Y);
    AND2_131 : AND2
      port map(A => XOR2_65_Y, B => DataA(9), Y => AND2_131_Y);
    XOR2_50 : XOR2
      port map(A => SumA_17_net, B => SumB_17_net, Y => XOR2_50_Y);
    MAJ3_7 : MAJ3
      port map(A => AND2_17_Y, B => PP3_3_net, C => PP2_5_net, 
        Y => MAJ3_7_Y);
    AND2_94 : AND2
      port map(A => PP1_3_net, B => PP0_5_net, Y => AND2_94_Y);
    AOI1_E_0_inst : AOI1
      port map(A => XOR2_18_Y, B => OR3_2_Y, C => AND3_2_Y, Y => 
        E_0_net);
    AND2_42 : AND2
      port map(A => XOR2_47_Y, B => DataA(2), Y => AND2_42_Y);
    AND2_118 : AND2
      port map(A => XOR2_41_Y, B => DataA(8), Y => AND2_118_Y);
    XNOR2_5 : XNOR2
      port map(A => DataB(2), B => BUFF_4_Y, Y => XNOR2_5_Y);
    MX2_4 : MX2
      port map(A => AND2_50_Y, B => DataA(0), S => NOR2_0_Y, Y => 
        MX2_4_Y);
    AO1_5 : AO1
      port map(A => AND2_32_Y, B => AO1_38_Y, C => AO1_32_Y, Y => 
        AO1_5_Y);
    MX2_43 : MX2
      port map(A => AND2_58_Y, B => DataA(9), S => AND2A_2_Y, 
        Y => MX2_43_Y);
    AND2_67 : AND2
      port map(A => DataB(0), B => DataA(1), Y => AND2_67_Y);
    MX2_50 : MX2
      port map(A => AND2_44_Y, B => DataA(10), S => NOR2_2_Y, 
        Y => MX2_50_Y);
    BUFF_13 : BUFF
      port map(A => DataB(1), Y => BUFF_13_Y);
    XOR3_2 : XOR3
      port map(A => PP3_5_net, B => PP2_7_net, C => AND2_106_Y, 
        Y => XOR3_2_Y);
    XOR2_39 : XOR2
      port map(A => SumA_9_net, B => SumB_9_net, Y => XOR2_39_Y);
    AND2_8 : AND2
      port map(A => AND2_65_Y, B => AND2_123_Y, Y => AND2_8_Y);
    NOR2_7 : NOR2
      port map(A => XOR2_6_Y, B => XNOR2_8_Y, Y => NOR2_7_Y);
    AND2_80 : AND2
      port map(A => AND2_73_Y, B => AND2_110_Y, Y => AND2_80_Y);
    XOR2_PP1_9_inst : XOR2
      port map(A => MX2_42_Y, B => BUFF_4_Y, Y => PP1_9_net);
    XOR2_3 : XOR2
      port map(A => SumA_18_net, B => SumB_18_net, Y => XOR2_3_Y);
    XOR2_54 : XOR2
      port map(A => SumA_10_net, B => SumB_10_net, Y => XOR2_54_Y);
    MX2_12 : MX2
      port map(A => AND2_37_Y, B => DataA(9), S => NOR2_1_Y, Y => 
        MX2_12_Y);
    XOR3_1 : XOR3
      port map(A => PP1_4_net, B => PP0_6_net, C => PP2_2_net, 
        Y => XOR3_1_Y);
    XOR2_51 : XOR2
      port map(A => SumA_3_net, B => SumB_3_net, Y => XOR2_51_Y);
    AO1_27 : AO1
      port map(A => XOR2_32_Y, B => AND2_40_Y, C => AND2_57_Y, 
        Y => AO1_27_Y);
    MAJ3_10 : MAJ3
      port map(A => PP3_12_net, B => PP2_14_net, C => VCC_1_net, 
        Y => MAJ3_10_Y);
    AND2_82 : AND2
      port map(A => XOR2_67_Y, B => XOR2_63_Y, Y => AND2_82_Y);
    XOR2_66 : XOR2
      port map(A => BUFF_2_Y, B => DataB(6), Y => XOR2_66_Y);
    XOR2_Mult_14_inst : XOR2
      port map(A => XOR2_64_Y, B => AO1_8_Y, Y => Mult(14));
    MX2_39 : MX2
      port map(A => AND2_116_Y, B => DataA(3), S => NOR2_4_Y, 
        Y => MX2_39_Y);
    AND2_56 : AND2
      port map(A => XOR2_43_Y, B => XOR2_13_Y, Y => AND2_56_Y);
    XOR2_Mult_20_inst : XOR2
      port map(A => XOR2_31_Y, B => AO1_43_Y, Y => Mult(20));
    XOR2_17 : XOR2
      port map(A => SumA_19_net, B => SumB_19_net, Y => XOR2_17_Y);
    XOR2_SumA_19_inst : XOR2
      port map(A => PP3_14_net, B => VCC_1_net, Y => SumA_19_net);
    AND2_53 : AND2
      port map(A => AND2_92_Y, B => AND2_71_Y, Y => AND2_53_Y);
    XOR2_PP3_9_inst : XOR2
      port map(A => MX2_45_Y, B => BUFF_1_Y, Y => PP3_9_net);
    AND2_99 : AND2
      port map(A => PP1_9_net, B => PP0_11_net, Y => AND2_99_Y);
    XOR2_28 : XOR2
      port map(A => BUFF_6_Y, B => DataB(2), Y => XOR2_28_Y);
    MX2_47 : MX2
      port map(A => AND2_88_Y, B => DataA(1), S => NOR2_0_Y, Y => 
        MX2_47_Y);
    XOR2_15 : XOR2
      port map(A => SumA_9_net, B => SumB_9_net, Y => XOR2_15_Y);
    MX2_34 : MX2
      port map(A => AND2_109_Y, B => DataA(2), S => NOR2_5_Y, 
        Y => MX2_34_Y);
    MX2_18 : MX2
      port map(A => AND2_42_Y, B => DataA(1), S => NOR2_5_Y, Y => 
        MX2_18_Y);
    AO1_17 : AO1
      port map(A => AND2_96_Y, B => AO1_26_Y, C => AO1_47_Y, Y => 
        AO1_17_Y);
    AND2_108 : AND2
      port map(A => XOR2_66_Y, B => DataA(10), Y => AND2_108_Y);
    BUFF_11 : BUFF
      port map(A => DataB(5), Y => BUFF_11_Y);
    MAJ3_2 : MAJ3
      port map(A => AND2_99_Y, B => PP3_6_net, C => PP2_8_net, 
        Y => MAJ3_2_Y);
    AND2_128 : AND2
      port map(A => SumA_6_net, B => SumB_6_net, Y => AND2_128_Y);
    XOR2_PP0_3_inst : XOR2
      port map(A => MX2_16_Y, B => BUFF_7_Y, Y => PP0_3_net);
    MAJ3_SumA_7_inst : MAJ3
      port map(A => XOR3_11_Y, B => MAJ3_1_Y, C => XOR2_14_Y, 
        Y => SumA_7_net);
    XOR2_PP2_7_inst : XOR2
      port map(A => MX2_51_Y, B => BUFF_11_Y, Y => PP2_7_net);
    XOR2_Mult_11_inst : XOR2
      port map(A => XOR2_48_Y, B => AO1_24_Y, Y => Mult(11));
    XOR2_PP3_11_inst : XOR2
      port map(A => MX2_50_Y, B => BUFF_5_Y, Y => PP3_11_net);
    AND2_21 : AND2
      port map(A => DataB(0), B => DataA(3), Y => AND2_21_Y);
    AO1_37 : AO1
      port map(A => AND2_0_Y, B => AO1_35_Y, C => AO1_41_Y, Y => 
        AO1_37_Y);
    XOR3_7 : XOR3
      port map(A => PP3_4_net, B => PP2_6_net, C => AND2_9_Y, 
        Y => XOR3_7_Y);
    MX2_16 : MX2
      port map(A => AND2_21_Y, B => DataA(2), S => AND2A_0_Y, 
        Y => MX2_16_Y);
    XOR2_0 : XOR2
      port map(A => PP0_1_net, B => S_0_net, Y => XOR2_0_Y);
    MAJ3_1 : MAJ3
      port map(A => PP2_2_net, B => PP1_4_net, C => PP0_6_net, 
        Y => MAJ3_1_Y);
    AND2_96 : AND2
      port map(A => AND2_105_Y, B => AND2_135_Y, Y => AND2_96_Y);
    AO1_4 : AO1
      port map(A => XOR2_11_Y, B => AND2_25_Y, C => AND2_81_Y, 
        Y => AO1_4_Y);
    XOR2_68 : XOR2
      port map(A => SumA_4_net, B => SumB_4_net, Y => XOR2_68_Y);
    AND2_37 : AND2
      port map(A => XOR2_28_Y, B => DataA(10), Y => AND2_37_Y);
    AND2_93 : AND2
      port map(A => SumA_8_net, B => SumB_8_net, Y => AND2_93_Y);
    XOR2_42 : XOR2
      port map(A => SumA_14_net, B => SumB_14_net, Y => XOR2_42_Y);
    AO1_21 : AO1
      port map(A => XOR2_25_Y, B => AO1_11_Y, C => AND2_102_Y, 
        Y => AO1_21_Y);
    AND2_114 : AND2
      port map(A => XOR2_6_Y, B => DataA(12), Y => AND2_114_Y);
    XOR2_36 : XOR2
      port map(A => PP1_14_net, B => EBAR, Y => XOR2_36_Y);
    BUFF_1 : BUFF
      port map(A => DataB(7), Y => BUFF_1_Y);
    XNOR2_8 : XNOR2
      port map(A => DataB(4), B => BUFF_14_Y, Y => XNOR2_8_Y);
    MAJ3_SumA_17_inst : MAJ3
      port map(A => XOR3_10_Y, B => MAJ3_5_Y, C => XOR2_53_Y, 
        Y => SumA_17_net);
    MX2_1 : MX2
      port map(A => AND2_38_Y, B => DataA(10), S => AND2A_2_Y, 
        Y => MX2_1_Y);
    AND2_28 : AND2
      port map(A => PP1_10_net, B => PP0_12_net, Y => AND2_28_Y);
    AND2_25 : AND2
      port map(A => PP0_1_net, B => S_0_net, Y => AND2_25_Y);
    MX2_13 : MX2
      port map(A => AND2_60_Y, B => DataA(12), S => AND2A_2_Y, 
        Y => MX2_13_Y);
    AO1_48 : AO1
      port map(A => XOR2_59_Y, B => OR3_3_Y, C => AND3_1_Y, Y => 
        AO1_48_Y);
end DEF_ARCH;

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.2.16
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
-- DESDIR:D:/Work/marmote/projects/DDC_test/smartgen\mult2
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IP4X3M1
-- SMARTGEN_PACKAGE:fg484
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTHA:14
-- WIDTHB:8
-- REPRESENTATION:SIGNED
-- CLK_EDGE:RISE
-- MAXPGEN:0
-- PIPES:0
-- INST_FA:1
-- HYBRID:0
-- DEBUG:0

-- _End_Comments_

