-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity mult is 
    port( DataA : in std_logic_vector(21 downto 0); DataB : in 
        std_logic_vector(15 downto 0); Mult : out 
        std_logic_vector(37 downto 0)) ;
end mult;


architecture DEF_ARCH of  mult is

    component BUFF
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component XOR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component XOR3
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component AND2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component AO1
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component MAJ3
        port(A, B, C : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component XNOR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component NOR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component AND2A
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    signal S_0_net, S_1_net, S_2_net, S_3_net, S_4_net, S_5_net, 
        S_6_net, S_7_net, E_0_net, E_1_net, E_2_net, E_3_net, 
        E_4_net, E_5_net, E_6_net, E_7_net, PP0_1_net, PP0_2_net, 
        PP0_3_net, PP0_4_net, PP0_5_net, PP0_6_net, PP0_7_net, 
        PP0_8_net, PP0_9_net, PP0_10_net, PP0_11_net, PP0_12_net, 
        PP0_13_net, PP0_14_net, PP0_15_net, PP0_16_net, 
        PP0_17_net, PP0_18_net, PP0_19_net, PP0_20_net, 
        PP0_21_net, PP0_22_net, PP1_0_net, PP1_1_net, PP1_2_net, 
        PP1_3_net, PP1_4_net, PP1_5_net, PP1_6_net, PP1_7_net, 
        PP1_8_net, PP1_9_net, PP1_10_net, PP1_11_net, PP1_12_net, 
        PP1_13_net, PP1_14_net, PP1_15_net, PP1_16_net, 
        PP1_17_net, PP1_18_net, PP1_19_net, PP1_20_net, 
        PP1_21_net, PP1_22_net, PP2_0_net, PP2_1_net, PP2_2_net, 
        PP2_3_net, PP2_4_net, PP2_5_net, PP2_6_net, PP2_7_net, 
        PP2_8_net, PP2_9_net, PP2_10_net, PP2_11_net, PP2_12_net, 
        PP2_13_net, PP2_14_net, PP2_15_net, PP2_16_net, 
        PP2_17_net, PP2_18_net, PP2_19_net, PP2_20_net, 
        PP2_21_net, PP2_22_net, PP3_0_net, PP3_1_net, PP3_2_net, 
        PP3_3_net, PP3_4_net, PP3_5_net, PP3_6_net, PP3_7_net, 
        PP3_8_net, PP3_9_net, PP3_10_net, PP3_11_net, PP3_12_net, 
        PP3_13_net, PP3_14_net, PP3_15_net, PP3_16_net, 
        PP3_17_net, PP3_18_net, PP3_19_net, PP3_20_net, 
        PP3_21_net, PP3_22_net, PP4_0_net, PP4_1_net, PP4_2_net, 
        PP4_3_net, PP4_4_net, PP4_5_net, PP4_6_net, PP4_7_net, 
        PP4_8_net, PP4_9_net, PP4_10_net, PP4_11_net, PP4_12_net, 
        PP4_13_net, PP4_14_net, PP4_15_net, PP4_16_net, 
        PP4_17_net, PP4_18_net, PP4_19_net, PP4_20_net, 
        PP4_21_net, PP4_22_net, PP5_0_net, PP5_1_net, PP5_2_net, 
        PP5_3_net, PP5_4_net, PP5_5_net, PP5_6_net, PP5_7_net, 
        PP5_8_net, PP5_9_net, PP5_10_net, PP5_11_net, PP5_12_net, 
        PP5_13_net, PP5_14_net, PP5_15_net, PP5_16_net, 
        PP5_17_net, PP5_18_net, PP5_19_net, PP5_20_net, 
        PP5_21_net, PP5_22_net, PP6_0_net, PP6_1_net, PP6_2_net, 
        PP6_3_net, PP6_4_net, PP6_5_net, PP6_6_net, PP6_7_net, 
        PP6_8_net, PP6_9_net, PP6_10_net, PP6_11_net, PP6_12_net, 
        PP6_13_net, PP6_14_net, PP6_15_net, PP6_16_net, 
        PP6_17_net, PP6_18_net, PP6_19_net, PP6_20_net, 
        PP6_21_net, PP6_22_net, PP7_0_net, PP7_1_net, PP7_2_net, 
        PP7_3_net, PP7_4_net, PP7_5_net, PP7_6_net, PP7_7_net, 
        PP7_8_net, PP7_9_net, PP7_10_net, PP7_11_net, PP7_12_net, 
        PP7_13_net, PP7_14_net, PP7_15_net, PP7_16_net, 
        PP7_17_net, PP7_18_net, PP7_19_net, PP7_20_net, 
        PP7_21_net, PP7_22_net, PP8_0_net, PP8_1_net, PP8_2_net, 
        PP8_3_net, PP8_4_net, PP8_5_net, PP8_6_net, PP8_7_net, 
        PP8_8_net, PP8_9_net, PP8_10_net, PP8_11_net, PP8_12_net, 
        PP8_13_net, PP8_14_net, PP8_15_net, PP8_16_net, 
        PP8_17_net, PP8_18_net, PP8_19_net, PP8_20_net, 
        PP8_21_net, SumA_3_net, SumA_4_net, SumA_5_net, 
        SumA_6_net, SumA_7_net, SumA_8_net, SumA_9_net, 
        SumA_10_net, SumA_11_net, SumA_12_net, SumA_13_net, 
        SumA_14_net, SumA_15_net, SumA_16_net, SumA_17_net, 
        SumA_18_net, SumA_19_net, SumA_20_net, SumA_21_net, 
        SumA_22_net, SumA_23_net, SumA_24_net, SumA_25_net, 
        SumA_26_net, SumA_27_net, SumA_28_net, SumA_29_net, 
        SumA_30_net, SumA_31_net, SumA_32_net, SumA_33_net, 
        SumA_34_net, SumA_35_net, SumA_36_net, SumB_2_net, 
        SumB_3_net, SumB_4_net, SumB_5_net, SumB_6_net, 
        SumB_7_net, SumB_8_net, SumB_9_net, SumB_10_net, 
        SumB_11_net, SumB_12_net, SumB_13_net, SumB_14_net, 
        SumB_15_net, SumB_16_net, SumB_17_net, SumB_18_net, 
        SumB_19_net, SumB_20_net, SumB_21_net, SumB_22_net, 
        SumB_23_net, SumB_24_net, SumB_25_net, SumB_26_net, 
        SumB_27_net, SumB_28_net, SumB_29_net, SumB_30_net, 
        SumB_31_net, SumB_32_net, SumB_33_net, SumB_34_net, 
        SumB_35_net, SumB_36_net, XOR2_24_Y, AND2_299_Y, 
        XOR3_46_Y, MAJ3_35_Y, XOR3_25_Y, MAJ3_92_Y, XOR2_44_Y, 
        AND2_303_Y, XOR3_14_Y, MAJ3_88_Y, XOR3_52_Y, MAJ3_8_Y, 
        XOR3_72_Y, MAJ3_78_Y, XOR3_57_Y, MAJ3_102_Y, XOR2_19_Y, 
        AND2_163_Y, XOR3_109_Y, MAJ3_19_Y, XOR3_58_Y, MAJ3_100_Y, 
        XOR3_73_Y, MAJ3_116_Y, XOR3_39_Y, MAJ3_91_Y, XOR3_34_Y, 
        MAJ3_20_Y, XOR3_74_Y, MAJ3_63_Y, XOR3_60_Y, MAJ3_34_Y, 
        XOR3_90_Y, MAJ3_73_Y, XOR3_3_Y, MAJ3_109_Y, XOR3_103_Y, 
        MAJ3_15_Y, XOR3_82_Y, MAJ3_28_Y, XOR3_2_Y, MAJ3_31_Y, 
        XOR3_17_Y, MAJ3_44_Y, XOR3_101_Y, MAJ3_26_Y, XOR3_95_Y, 
        MAJ3_66_Y, XOR3_20_Y, MAJ3_6_Y, XOR3_8_Y, MAJ3_83_Y, 
        XOR3_43_Y, MAJ3_13_Y, XOR3_71_Y, MAJ3_37_Y, XOR3_51_Y, 
        MAJ3_58_Y, XOR3_32_Y, MAJ3_75_Y, XOR3_29_Y, MAJ3_85_Y, 
        XOR3_44_Y, MAJ3_110_Y, XOR3_7_Y, MAJ3_77_Y, XOR3_0_Y, 
        MAJ3_12_Y, XOR3_45_Y, MAJ3_55_Y, XOR3_31_Y, MAJ3_27_Y, 
        XOR3_64_Y, MAJ3_62_Y, XOR3_88_Y, MAJ3_101_Y, XOR3_75_Y, 
        MAJ3_7_Y, XOR3_54_Y, MAJ3_17_Y, XOR3_1_Y, MAJ3_30_Y, 
        XOR2_79_Y, AND2_259_Y, XOR3_99_Y, MAJ3_24_Y, XOR3_94_Y, 
        MAJ3_64_Y, XOR3_18_Y, MAJ3_4_Y, XOR2_10_Y, AND2_134_Y, 
        XOR3_41_Y, MAJ3_10_Y, XOR2_38_Y, AND2_76_Y, XOR2_69_Y, 
        AND2_46_Y, XOR3_30_Y, MAJ3_72_Y, XOR3_59_Y, MAJ3_95_Y, 
        XOR2_70_Y, AND2_306_Y, XOR3_40_Y, MAJ3_84_Y, XOR3_37_Y, 
        MAJ3_18_Y, XOR3_76_Y, MAJ3_61_Y, XOR3_62_Y, MAJ3_32_Y, 
        XOR3_91_Y, MAJ3_69_Y, XOR3_5_Y, MAJ3_106_Y, XOR3_106_Y, 
        MAJ3_11_Y, XOR3_85_Y, MAJ3_25_Y, XOR3_116_Y, MAJ3_59_Y, 
        XOR3_11_Y, MAJ3_87_Y, XOR3_93_Y, MAJ3_54_Y, XOR3_92_Y, 
        MAJ3_115_Y, XOR3_13_Y, MAJ3_42_Y, XOR3_118_Y, MAJ3_5_Y, 
        XOR3_36_Y, MAJ3_47_Y, XOR3_66_Y, MAJ3_70_Y, XOR3_48_Y, 
        MAJ3_112_Y, XOR3_26_Y, MAJ3_0_Y, XOR3_23_Y, MAJ3_57_Y, 
        XOR3_33_Y, MAJ3_82_Y, XOR3_115_Y, MAJ3_52_Y, XOR3_113_Y, 
        MAJ3_113_Y, XOR3_35_Y, MAJ3_40_Y, XOR3_24_Y, MAJ3_2_Y, 
        XOR3_55_Y, MAJ3_46_Y, XOR3_83_Y, MAJ3_68_Y, XOR3_67_Y, 
        MAJ3_111_Y, XOR3_49_Y, MAJ3_119_Y, XOR3_100_Y, MAJ3_41_Y, 
        XOR3_110_Y, MAJ3_53_Y, XOR3_80_Y, MAJ3_38_Y, XOR3_78_Y, 
        MAJ3_90_Y, XOR3_111_Y, MAJ3_21_Y, XOR3_105_Y, MAJ3_107_Y, 
        XOR3_19_Y, MAJ3_29_Y, XOR3_50_Y, MAJ3_48_Y, XOR3_27_Y, 
        MAJ3_80_Y, XOR3_9_Y, MAJ3_98_Y, XOR3_86_Y, MAJ3_103_Y, 
        XOR3_102_Y, MAJ3_118_Y, XOR3_69_Y, MAJ3_94_Y, XOR3_68_Y, 
        MAJ3_22_Y, XOR3_104_Y, MAJ3_65_Y, XOR3_87_Y, MAJ3_36_Y, 
        XOR3_4_Y, MAJ3_76_Y, XOR2_103_Y, AND2_249_Y, XOR3_15_Y, 
        MAJ3_16_Y, XOR2_77_Y, AND2_55_Y, XOR2_45_Y, AND2_9_Y, 
        XOR3_6_Y, MAJ3_9_Y, XOR3_65_Y, MAJ3_105_Y, XOR3_108_Y, 
        MAJ3_39_Y, XOR3_10_Y, MAJ3_99_Y, XOR3_97_Y, MAJ3_114_Y, 
        XOR3_84_Y, MAJ3_79_Y, XOR3_22_Y, MAJ3_1_Y, XOR3_70_Y, 
        MAJ3_50_Y, XOR3_28_Y, MAJ3_117_Y, XOR3_53_Y, MAJ3_93_Y, 
        XOR3_114_Y, MAJ3_97_Y, XOR3_56_Y, MAJ3_56_Y, XOR3_96_Y, 
        MAJ3_3_Y, XOR3_117_Y, MAJ3_51_Y, XOR3_89_Y, MAJ3_71_Y, 
        XOR3_79_Y, MAJ3_43_Y, XOR3_12_Y, MAJ3_81_Y, XOR3_63_Y, 
        MAJ3_23_Y, XOR3_21_Y, MAJ3_74_Y, XOR3_38_Y, MAJ3_104_Y, 
        XOR3_98_Y, MAJ3_108_Y, XOR3_42_Y, MAJ3_67_Y, XOR3_81_Y, 
        MAJ3_14_Y, XOR3_107_Y, MAJ3_60_Y, XOR3_77_Y, MAJ3_86_Y, 
        XOR3_61_Y, MAJ3_49_Y, XOR3_112_Y, MAJ3_96_Y, XOR3_47_Y, 
        MAJ3_33_Y, XOR3_119_Y, MAJ3_89_Y, XOR3_16_Y, MAJ3_45_Y, 
        XOR2_106_Y, AND2_159_Y, BUFF_56_Y, BUFF_24_Y, BUFF_68_Y, 
        BUFF_40_Y, BUFF_63_Y, BUFF_30_Y, BUFF_53_Y, BUFF_50_Y, 
        BUFF_51_Y, BUFF_55_Y, BUFF_18_Y, BUFF_70_Y, BUFF_73_Y, 
        BUFF_13_Y, BUFF_11_Y, BUFF_85_Y, BUFF_65_Y, BUFF_29_Y, 
        BUFF_23_Y, BUFF_31_Y, BUFF_76_Y, BUFF_21_Y, BUFF_84_Y, 
        BUFF_1_Y, BUFF_32_Y, BUFF_37_Y, BUFF_59_Y, BUFF_26_Y, 
        BUFF_72_Y, BUFF_89_Y, BUFF_81_Y, BUFF_25_Y, BUFF_88_Y, 
        BUFF_80_Y, BUFF_33_Y, BUFF_2_Y, BUFF_47_Y, BUFF_12_Y, 
        BUFF_9_Y, BUFF_34_Y, BUFF_60_Y, BUFF_82_Y, BUFF_7_Y, 
        BUFF_58_Y, BUFF_64_Y, BUFF_86_Y, BUFF_75_Y, BUFF_45_Y, 
        BUFF_77_Y, BUFF_69_Y, BUFF_49_Y, BUFF_41_Y, BUFF_48_Y, 
        BUFF_54_Y, BUFF_0_Y, BUFF_5_Y, BUFF_8_Y, BUFF_20_Y, 
        BUFF_79_Y, BUFF_15_Y, BUFF_6_Y, BUFF_39_Y, BUFF_10_Y, 
        BUFF_3_Y, BUFF_42_Y, BUFF_17_Y, BUFF_87_Y, BUFF_78_Y, 
        BUFF_43_Y, XOR2_88_Y, XOR2_57_Y, NOR2_17_Y, AND2_30_Y, 
        AND2_71_Y, MX2_47_Y, AND2_206_Y, MX2_82_Y, AND2_176_Y, 
        MX2_131_Y, AND2_90_Y, MX2_65_Y, AND2_175_Y, MX2_49_Y, 
        AND2_334_Y, MX2_19_Y, XNOR2_3_Y, XOR2_53_Y, NOR2_1_Y, 
        AND2_26_Y, MX2_112_Y, AND2_174_Y, MX2_159_Y, AND2_319_Y, 
        MX2_90_Y, AND2_193_Y, MX2_125_Y, AND2_127_Y, MX2_92_Y, 
        AND2_204_Y, MX2_67_Y, AND2_178_Y, MX2_46_Y, AND2_100_Y, 
        MX2_20_Y, XNOR2_4_Y, XOR2_65_Y, NOR2_6_Y, AND2_186_Y, 
        MX2_123_Y, AND2_147_Y, MX2_27_Y, AND2_300_Y, MX2_155_Y, 
        AND2_191_Y, AND2_321_Y, MX2_133_Y, AND2_282_Y, MX2_146_Y, 
        AND2_155_Y, MX2_1_Y, AND2_286_Y, MX2_145_Y, XNOR2_5_Y, 
        BUFF_35_Y, BUFF_22_Y, BUFF_71_Y, XOR2_3_Y, XOR2_33_Y, 
        NOR2_0_Y, AND2_124_Y, AND2_275_Y, MX2_11_Y, AND2_148_Y, 
        MX2_12_Y, AND2_23_Y, MX2_71_Y, AND2_57_Y, MX2_81_Y, 
        AND2_167_Y, MX2_32_Y, AND2_58_Y, MX2_6_Y, XNOR2_7_Y, 
        XOR2_17_Y, NOR2_12_Y, AND2_32_Y, MX2_162_Y, AND2_116_Y, 
        MX2_59_Y, AND2_33_Y, MX2_139_Y, AND2_153_Y, MX2_68_Y, 
        AND2_145_Y, MX2_142_Y, AND2_83_Y, MX2_54_Y, AND2_236_Y, 
        MX2_135_Y, AND2_211_Y, MX2_48_Y, XNOR2_15_Y, XOR2_64_Y, 
        NOR2_9_Y, AND2_91_Y, MX2_108_Y, AND2_84_Y, MX2_25_Y, 
        AND2_67_Y, MX2_114_Y, AND2_132_Y, AND2_326_Y, MX2_164_Y, 
        AND2_104_Y, MX2_97_Y, AND2_223_Y, MX2_89_Y, AND2_296_Y, 
        MX2_34_Y, XNOR2_0_Y, BUFF_36_Y, BUFF_27_Y, BUFF_74_Y, 
        XOR2_98_Y, XOR2_18_Y, NOR2_2_Y, AND2_111_Y, AND2_279_Y, 
        MX2_26_Y, AND2_158_Y, MX2_14_Y, AND2_28_Y, MX2_3_Y, 
        AND2_126_Y, MX2_122_Y, AND2_302_Y, MX2_7_Y, AND2_192_Y, 
        MX2_50_Y, XNOR2_10_Y, XOR2_16_Y, NOR2_15_Y, AND2_72_Y, 
        MX2_105_Y, AND2_182_Y, MX2_102_Y, AND2_292_Y, MX2_23_Y, 
        AND2_291_Y, MX2_77_Y, AND2_280_Y, MX2_95_Y, AND2_293_Y, 
        MX2_74_Y, AND2_92_Y, MX2_84_Y, AND2_276_Y, MX2_107_Y, 
        XNOR2_20_Y, XOR2_58_Y, NOR2_18_Y, AND2_183_Y, MX2_30_Y, 
        AND2_333_Y, MX2_83_Y, AND2_307_Y, MX2_66_Y, AND2_101_Y, 
        AND2_311_Y, MX2_160_Y, AND2_247_Y, MX2_163_Y, AND2_61_Y, 
        MX2_42_Y, AND2_99_Y, MX2_69_Y, XNOR2_16_Y, BUFF_52_Y, 
        BUFF_46_Y, BUFF_4_Y, XOR2_61_Y, AND2A_0_Y, AND2_138_Y, 
        AND2_56_Y, MX2_150_Y, AND2_213_Y, MX2_45_Y, AND2_48_Y, 
        MX2_16_Y, AND2_221_Y, MX2_43_Y, AND2_150_Y, MX2_56_Y, 
        AND2_255_Y, MX2_121_Y, AND2A_2_Y, AND2_119_Y, MX2_126_Y, 
        AND2_205_Y, MX2_94_Y, AND2_230_Y, MX2_9_Y, AND2_180_Y, 
        MX2_22_Y, AND2_14_Y, MX2_75_Y, AND2_109_Y, MX2_99_Y, 
        AND2_129_Y, MX2_128_Y, AND2_258_Y, MX2_100_Y, AND2A_1_Y, 
        AND2_87_Y, MX2_129_Y, AND2_245_Y, MX2_106_Y, AND2_40_Y, 
        MX2_127_Y, AND2_27_Y, AND2_271_Y, MX2_15_Y, AND2_151_Y, 
        MX2_113_Y, AND2_144_Y, MX2_0_Y, AND2_105_Y, MX2_41_Y, 
        BUFF_44_Y, BUFF_38_Y, BUFF_83_Y, XOR2_46_Y, XOR2_90_Y, 
        NOR2_7_Y, AND2_11_Y, AND2_108_Y, MX2_63_Y, AND2_187_Y, 
        MX2_70_Y, AND2_322_Y, MX2_5_Y, AND2_197_Y, MX2_76_Y, 
        AND2_336_Y, MX2_24_Y, AND2_82_Y, MX2_55_Y, XNOR2_13_Y, 
        XOR2_83_Y, NOR2_4_Y, AND2_273_Y, MX2_143_Y, AND2_231_Y, 
        MX2_88_Y, AND2_115_Y, MX2_37_Y, AND2_177_Y, MX2_57_Y, 
        AND2_274_Y, MX2_13_Y, AND2_34_Y, MX2_157_Y, AND2_50_Y, 
        MX2_44_Y, AND2_332_Y, MX2_33_Y, XNOR2_1_Y, XOR2_6_Y, 
        NOR2_16_Y, AND2_10_Y, MX2_64_Y, AND2_4_Y, MX2_118_Y, 
        AND2_3_Y, MX2_153_Y, AND2_320_Y, AND2_254_Y, MX2_39_Y, 
        AND2_35_Y, MX2_137_Y, AND2_329_Y, MX2_91_Y, AND2_239_Y, 
        MX2_52_Y, XNOR2_19_Y, BUFF_66_Y, BUFF_61_Y, BUFF_19_Y, 
        XOR2_0_Y, XOR2_2_Y, NOR2_14_Y, AND2_262_Y, AND2_243_Y, 
        MX2_109_Y, AND2_263_Y, MX2_80_Y, AND2_294_Y, MX2_120_Y, 
        AND2_312_Y, MX2_60_Y, AND2_240_Y, MX2_141_Y, AND2_86_Y, 
        MX2_104_Y, XNOR2_6_Y, XOR2_36_Y, NOR2_13_Y, AND2_313_Y, 
        MX2_61_Y, AND2_62_Y, MX2_110_Y, AND2_314_Y, MX2_21_Y, 
        AND2_112_Y, MX2_93_Y, AND2_137_Y, MX2_78_Y, AND2_264_Y, 
        MX2_166_Y, AND2_17_Y, MX2_136_Y, AND2_269_Y, MX2_2_Y, 
        XNOR2_9_Y, XOR2_62_Y, NOR2_3_Y, AND2_98_Y, MX2_158_Y, 
        AND2_157_Y, MX2_134_Y, AND2_45_Y, MX2_10_Y, AND2_146_Y, 
        AND2_18_Y, MX2_17_Y, AND2_141_Y, MX2_73_Y, AND2_199_Y, 
        MX2_165_Y, AND2_330_Y, MX2_117_Y, XNOR2_18_Y, BUFF_28_Y, 
        BUFF_16_Y, BUFF_67_Y, XOR2_49_Y, XOR2_59_Y, NOR2_20_Y, 
        AND2_81_Y, AND2_29_Y, MX2_115_Y, AND2_161_Y, MX2_154_Y, 
        AND2_12_Y, MX2_4_Y, AND2_156_Y, MX2_72_Y, AND2_181_Y, 
        MX2_101_Y, AND2_169_Y, MX2_132_Y, XNOR2_17_Y, XOR2_109_Y, 
        NOR2_10_Y, AND2_162_Y, MX2_152_Y, AND2_113_Y, MX2_85_Y, 
        AND2_234_Y, MX2_144_Y, AND2_256_Y, MX2_79_Y, AND2_227_Y, 
        MX2_31_Y, AND2_107_Y, MX2_119_Y, AND2_190_Y, MX2_130_Y, 
        AND2_37_Y, MX2_87_Y, XNOR2_14_Y, XOR2_28_Y, NOR2_5_Y, 
        AND2_212_Y, MX2_140_Y, AND2_310_Y, MX2_98_Y, AND2_6_Y, 
        MX2_161_Y, AND2_184_Y, AND2_38_Y, MX2_124_Y, AND2_94_Y, 
        MX2_116_Y, AND2_160_Y, MX2_40_Y, AND2_335_Y, MX2_38_Y, 
        XNOR2_2_Y, BUFF_62_Y, BUFF_57_Y, BUFF_14_Y, XOR2_35_Y, 
        XOR2_81_Y, NOR2_8_Y, AND2_70_Y, AND2_233_Y, MX2_111_Y, 
        AND2_201_Y, MX2_35_Y, AND2_2_Y, MX2_151_Y, AND2_24_Y, 
        MX2_18_Y, AND2_93_Y, MX2_138_Y, AND2_265_Y, MX2_167_Y, 
        XNOR2_8_Y, XOR2_13_Y, NOR2_11_Y, AND2_42_Y, MX2_147_Y, 
        AND2_0_Y, MX2_156_Y, AND2_43_Y, MX2_148_Y, AND2_220_Y, 
        MX2_62_Y, AND2_59_Y, MX2_28_Y, AND2_142_Y, MX2_8_Y, 
        AND2_185_Y, MX2_103_Y, AND2_284_Y, MX2_29_Y, XNOR2_11_Y, 
        XOR2_105_Y, NOR2_19_Y, AND2_216_Y, MX2_51_Y, AND2_210_Y, 
        MX2_86_Y, AND2_168_Y, MX2_58_Y, AND2_31_Y, AND2_207_Y, 
        MX2_53_Y, AND2_237_Y, MX2_36_Y, AND2_96_Y, MX2_149_Y, 
        AND2_69_Y, MX2_96_Y, XNOR2_12_Y, AND2_8_Y, AND2_22_Y, 
        AND2_13_Y, AND2_217_Y, AND2_122_Y, AND2_189_Y, AND2_173_Y, 
        AND2_235_Y, AND2_95_Y, AND2_315_Y, AND2_209_Y, AND2_248_Y, 
        AND2_166_Y, AND2_331_Y, AND2_54_Y, AND2_97_Y, AND2_15_Y, 
        AND2_66_Y, AND2_241_Y, AND2_5_Y, AND2_251_Y, AND2_283_Y, 
        AND2_215_Y, AND2_25_Y, AND2_79_Y, AND2_125_Y, AND2_52_Y, 
        AND2_89_Y, AND2_281_Y, AND2_106_Y, AND2_16_Y, AND2_47_Y, 
        AND2_328_Y, AND2_120_Y, AND2_195_Y, AND2_261_Y, 
        XOR2_111_Y, XOR2_72_Y, XOR2_107_Y, XOR2_97_Y, XOR2_92_Y, 
        XOR2_76_Y, XOR2_67_Y, XOR2_48_Y, XOR2_32_Y, XOR2_27_Y, 
        XOR2_41_Y, XOR2_113_Y, XOR2_101_Y, XOR2_43_Y, XOR2_66_Y, 
        XOR2_26_Y, XOR2_86_Y, XOR2_47_Y, XOR2_9_Y, XOR2_54_Y, 
        XOR2_85_Y, XOR2_30_Y, XOR2_15_Y, XOR2_87_Y, XOR2_102_Y, 
        XOR2_60_Y, XOR2_5_Y, XOR2_91_Y, XOR2_39_Y, XOR2_95_Y, 
        XOR2_78_Y, XOR2_23_Y, XOR2_11_Y, XOR2_80_Y, XOR2_96_Y, 
        XOR2_51_Y, XOR2_112_Y, AND2_225_Y, AO1_78_Y, AND2_309_Y, 
        AO1_88_Y, AND2_171_Y, AO1_16_Y, AND2_325_Y, AO1_100_Y, 
        AND2_232_Y, AO1_66_Y, AND2_121_Y, AO1_0_Y, AND2_272_Y, 
        AO1_22_Y, AND2_44_Y, AO1_96_Y, AND2_65_Y, AO1_7_Y, 
        AND2_88_Y, AO1_36_Y, AND2_74_Y, AO1_11_Y, AND2_139_Y, 
        AO1_71_Y, AND2_39_Y, AO1_40_Y, AND2_323_Y, AO1_69_Y, 
        AND2_229_Y, AO1_53_Y, AND2_118_Y, AO1_26_Y, AND2_267_Y, 
        AO1_57_Y, AND2_41_Y, AND2_63_Y, AND2_85_Y, AO1_42_Y, 
        AND2_73_Y, AO1_13_Y, AND2_136_Y, AO1_75_Y, AND2_36_Y, 
        AO1_45_Y, AND2_252_Y, AO1_72_Y, AND2_135_Y, AO1_60_Y, 
        AND2_60_Y, AO1_32_Y, AND2_165_Y, AO1_63_Y, AND2_305_Y, 
        AO1_4_Y, AND2_324_Y, AO1_99_Y, AND2_21_Y, AO1_23_Y, 
        AND2_1_Y, AO1_102_Y, AND2_75_Y, AO1_54_Y, AND2_301_Y, 
        AO1_27_Y, AND2_103_Y, AO1_52_Y, AND2_19_Y, AO1_41_Y, 
        AND2_277_Y, AO1_17_Y, AND2_49_Y, AO1_44_Y, AND2_152_Y, 
        AO1_87_Y, AND2_179_Y, AO1_80_Y, AND2_224_Y, AND2_200_Y, 
        AND2_289_Y, AND2_149_Y, AND2_242_Y, AO1_62_Y, AND2_128_Y, 
        AO1_48_Y, AND2_51_Y, AO1_20_Y, AND2_154_Y, AO1_49_Y, 
        AND2_297_Y, AO1_97_Y, AND2_316_Y, AO1_84_Y, AND2_7_Y, 
        AO1_35_Y, AND2_327_Y, AO1_10_Y, AND2_68_Y, AO1_70_Y, 
        AND2_295_Y, AO1_38_Y, AND2_131_Y, AO1_68_Y, AND2_53_Y, 
        AO1_51_Y, AND2_304_Y, AO1_24_Y, AND2_78_Y, AO1_56_Y, 
        AND2_198_Y, AO1_101_Y, AND2_226_Y, AO1_91_Y, AND2_268_Y, 
        AO1_28_Y, AND2_244_Y, AO1_1_Y, AND2_318_Y, AND2_194_Y, 
        AND2_278_Y, AND2_290_Y, AND2_196_Y, AND2_114_Y, 
        AND2_202_Y, AND2_77_Y, AND2_250_Y, AO1_90_Y, AND2_218_Y, 
        AO1_50_Y, AND2_253_Y, AO1_15_Y, AND2_170_Y, AO1_95_Y, 
        AND2_203_Y, AO1_12_Y, AND2_222_Y, AO1_3_Y, AND2_123_Y, 
        AO1_81_Y, AND2_64_Y, AO1_8_Y, AND2_130_Y, AO1_39_Y, 
        AND2_20_Y, AO1_30_Y, AND2_164_Y, AO1_58_Y, AND2_140_Y, 
        AO1_21_Y, AND2_172_Y, AND2_110_Y, AND2_287_Y, AND2_298_Y, 
        AND2_208_Y, AND2_117_Y, AND2_214_Y, AND2_80_Y, AND2_260_Y, 
        AND2_228_Y, AND2_266_Y, AND2_188_Y, AND2_308_Y, 
        AND2_317_Y, AND2_238_Y, AND2_143_Y, AND2_246_Y, AO1_25_Y, 
        AND2_102_Y, AND2_285_Y, AND2_257_Y, AND2_288_Y, 
        AND2_219_Y, AO1_82_Y, AND2_270_Y, AND2_133_Y, AO1_67_Y, 
        AO1_103_Y, AO1_93_Y, AO1_31_Y, AO1_6_Y, AO1_64_Y, 
        AO1_33_Y, AO1_59_Y, AO1_29_Y, AO1_55_Y, AO1_43_Y, 
        AO1_19_Y, AO1_47_Y, AO1_92_Y, AO1_83_Y, AO1_89_Y, 
        AO1_61_Y, AO1_86_Y, AO1_73_Y, AO1_46_Y, AO1_77_Y, 
        AO1_14_Y, AO1_9_Y, AO1_76_Y, AO1_37_Y, AO1_5_Y, AO1_79_Y, 
        AO1_2_Y, AO1_94_Y, AO1_65_Y, AO1_98_Y, AO1_18_Y, AO1_74_Y, 
        AO1_34_Y, AO1_85_Y, XOR2_31_Y, XOR2_50_Y, XOR2_108_Y, 
        XOR2_73_Y, XOR2_93_Y, XOR2_14_Y, XOR2_110_Y, XOR2_40_Y, 
        XOR2_12_Y, XOR2_29_Y, XOR2_71_Y, XOR2_63_Y, XOR2_4_Y, 
        XOR2_84_Y, XOR2_100_Y, XOR2_22_Y, XOR2_68_Y, XOR2_7_Y, 
        XOR2_89_Y, XOR2_104_Y, XOR2_25_Y, XOR2_20_Y, XOR2_75_Y, 
        XOR2_37_Y, XOR2_55_Y, XOR2_99_Y, XOR2_34_Y, XOR2_94_Y, 
        XOR2_52_Y, XOR2_74_Y, XOR2_1_Y, XOR2_42_Y, XOR2_8_Y, 
        XOR2_56_Y, XOR2_21_Y, XOR2_82_Y, VCC_1_net : std_logic ;
    begin   

    VCC_2_net : VCC port map(Y => VCC_1_net);
    BUFF_8 : BUFF
      port map(A => DataA(18), Y => BUFF_8_Y);
    MX2_113 : MX2
      port map(A => AND2_151_Y, B => BUFF_73_Y, S => AND2A_1_Y, 
        Y => MX2_113_Y);
    XOR2_PP7_9_inst : XOR2
      port map(A => MX2_37_Y, B => BUFF_38_Y, Y => PP7_9_net);
    XOR2_Mult_8_inst : XOR2
      port map(A => XOR2_110_Y, B => AO1_64_Y, Y => Mult(8));
    BUFF_88 : BUFF
      port map(A => DataA(10), Y => BUFF_88_Y);
    XOR3_SumB_16_inst : XOR3
      port map(A => MAJ3_97_Y, B => XOR3_36_Y, C => XOR3_56_Y, 
        Y => SumB_16_net);
    XOR2_Mult_29_inst : XOR2
      port map(A => XOR2_94_Y, B => AO1_79_Y, Y => Mult(29));
    AND2_12 : AND2
      port map(A => XOR2_59_Y, B => BUFF_69_Y, Y => AND2_12_Y);
    AO1_23 : AO1
      port map(A => AND2_88_Y, B => AO1_96_Y, C => AO1_7_Y, Y => 
        AO1_23_Y);
    AND2_326 : AND2
      port map(A => XOR2_64_Y, B => BUFF_1_Y, Y => AND2_326_Y);
    MAJ3_9 : MAJ3
      port map(A => PP2_2_net, B => PP1_4_net, C => PP0_6_net, 
        Y => MAJ3_9_Y);
    AND2_72 : AND2
      port map(A => XOR2_16_Y, B => BUFF_7_Y, Y => AND2_72_Y);
    AND2_302 : AND2
      port map(A => XOR2_18_Y, B => BUFF_0_Y, Y => AND2_302_Y);
    AND2_158 : AND2
      port map(A => XOR2_18_Y, B => BUFF_41_Y, Y => AND2_158_Y);
    AND2_PP8_15_inst : AND2
      port map(A => DataB(15), B => BUFF_45_Y, Y => PP8_15_net);
    MAJ3_17 : MAJ3
      port map(A => PP5_16_net, B => PP3_20_net, C => VCC_1_net, 
        Y => MAJ3_17_Y);
    XNOR2_19 : XNOR2
      port map(A => DataB(14), B => BUFF_44_Y, Y => XNOR2_19_Y);
    AND2_225 : AND2
      port map(A => XOR2_111_Y, B => XOR2_72_Y, Y => AND2_225_Y);
    MAJ3_62 : MAJ3
      port map(A => PP6_13_net, B => PP3_19_net, C => E_0_net, 
        Y => MAJ3_62_Y);
    XOR2_58 : XOR2
      port map(A => DataB(1), B => DataB(2), Y => XOR2_58_Y);
    XOR2_Mult_2_inst : XOR2
      port map(A => XOR2_31_Y, B => AND2_133_Y, Y => Mult(2));
    MAJ3_52 : MAJ3
      port map(A => XOR3_101_Y, B => MAJ3_15_Y, C => MAJ3_31_Y, 
        Y => MAJ3_52_Y);
    XOR2_Mult_13_inst : XOR2
      port map(A => XOR2_63_Y, B => AO1_43_Y, Y => Mult(13));
    BUFF_67 : BUFF
      port map(A => DataB(7), Y => BUFF_67_Y);
    XOR3_21 : XOR3
      port map(A => MAJ3_111_Y, B => MAJ3_119_Y, C => XOR3_110_Y, 
        Y => XOR3_21_Y);
    AND2_232 : AND2
      port map(A => XOR2_32_Y, B => XOR2_27_Y, Y => AND2_232_Y);
    NOR2_15 : NOR2
      port map(A => XOR2_16_Y, B => XNOR2_20_Y, Y => NOR2_15_Y);
    XOR2_PP0_13_inst : XOR2
      port map(A => MX2_99_Y, B => BUFF_46_Y, Y => PP0_13_net);
    AND2_PP8_9_inst : AND2
      port map(A => DataB(15), B => BUFF_89_Y, Y => PP8_9_net);
    XOR2_PP5_4_inst : XOR2
      port map(A => MX2_27_Y, B => BUFF_87_Y, Y => PP5_4_net);
    AND2_309 : AND2
      port map(A => XOR2_107_Y, B => XOR2_97_Y, Y => AND2_309_Y);
    AND2_49 : AND2
      port map(A => AND2_229_Y, B => XOR2_78_Y, Y => AND2_49_Y);
    AND2_23 : AND2
      port map(A => XOR2_33_Y, B => BUFF_49_Y, Y => AND2_23_Y);
    XOR3_7 : XOR3
      port map(A => PP5_13_net, B => PP2_19_net, C => PP8_7_net, 
        Y => XOR3_7_Y);
    XOR3_18 : XOR3
      port map(A => PP3_22_net, B => VCC_1_net, C => PP4_20_net, 
        Y => XOR3_18_Y);
    AO1_22 : AO1
      port map(A => XOR2_26_Y, B => AND2_331_Y, C => AND2_54_Y, 
        Y => AO1_22_Y);
    XOR2_40 : XOR2
      port map(A => SumA_8_net, B => SumB_8_net, Y => XOR2_40_Y);
    NOR2_12 : NOR2
      port map(A => XOR2_17_Y, B => XNOR2_15_Y, Y => NOR2_12_Y);
    AND2_91 : AND2
      port map(A => XOR2_64_Y, B => BUFF_76_Y, Y => AND2_91_Y);
    XOR3_31 : XOR3
      port map(A => PP5_14_net, B => PP2_20_net, C => PP8_8_net, 
        Y => XOR3_31_Y);
    AND2_248 : AND2
      port map(A => SumA_12_net, B => SumB_12_net, Y => 
        AND2_248_Y);
    MAJ3_31 : MAJ3
      port map(A => PP8_3_net, B => PP5_9_net, C => PP2_15_net, 
        Y => MAJ3_31_Y);
    XOR2_PP6_6_inst : XOR2
      port map(A => MX2_108_Y, B => BUFF_35_Y, Y => PP6_6_net);
    BUFF_7 : BUFF
      port map(A => DataA(14), Y => BUFF_7_Y);
    XOR3_82 : XOR3
      port map(A => PP4_11_net, B => PP1_17_net, C => PP7_5_net, 
        Y => XOR3_82_Y);
    AO1_54 : AO1
      port map(A => AND2_139_Y, B => AO1_36_Y, C => AO1_11_Y, 
        Y => AO1_54_Y);
    MAJ3_44 : MAJ3
      port map(A => PP6_8_net, B => PP3_14_net, C => PP0_20_net, 
        Y => MAJ3_44_Y);
    BUFF_78 : BUFF
      port map(A => DataB(11), Y => BUFF_78_Y);
    XOR2_PP6_4_inst : XOR2
      port map(A => MX2_25_Y, B => BUFF_35_Y, Y => PP6_4_net);
    XOR2_PP5_13_inst : XOR2
      port map(A => MX2_67_Y, B => BUFF_78_Y, Y => PP5_13_net);
    AND2_184 : AND2
      port map(A => XOR2_28_Y, B => BUFF_24_Y, Y => AND2_184_Y);
    XOR2_PP6_10_inst : XOR2
      port map(A => MX2_135_Y, B => BUFF_22_Y, Y => PP6_10_net);
    AO1_84 : AO1
      port map(A => AND2_165_Y, B => AO1_60_Y, C => AO1_32_Y, 
        Y => AO1_84_Y);
    MX2_124 : MX2
      port map(A => AND2_38_Y, B => BUFF_31_Y, S => NOR2_5_Y, 
        Y => MX2_124_Y);
    MX2_89 : MX2
      port map(A => AND2_223_Y, B => BUFF_30_Y, S => NOR2_9_Y, 
        Y => MX2_89_Y);
    AND2_291 : AND2
      port map(A => XOR2_16_Y, B => BUFF_32_Y, Y => AND2_291_Y);
    AND2_69 : AND2
      port map(A => XOR2_105_Y, B => BUFF_55_Y, Y => AND2_69_Y);
    MX2_37 : MX2
      port map(A => AND2_115_Y, B => BUFF_59_Y, S => NOR2_4_Y, 
        Y => MX2_37_Y);
    XOR2_92 : XOR2
      port map(A => SumA_4_net, B => SumB_4_net, Y => XOR2_92_Y);
    MX2_54 : MX2
      port map(A => AND2_83_Y, B => BUFF_9_Y, S => NOR2_12_Y, 
        Y => MX2_54_Y);
    MX2_75 : MX2
      port map(A => AND2_14_Y, B => BUFF_7_Y, S => AND2A_2_Y, 
        Y => MX2_75_Y);
    AND2_55 : AND2
      port map(A => PP6_22_net, B => VCC_1_net, Y => AND2_55_Y);
    XOR2_Mult_10_inst : XOR2
      port map(A => XOR2_12_Y, B => AO1_59_Y, Y => Mult(10));
    MX2_112 : MX2
      port map(A => AND2_26_Y, B => BUFF_60_Y, S => NOR2_1_Y, 
        Y => MX2_112_Y);
    MX2_23 : MX2
      port map(A => AND2_292_Y, B => BUFF_32_Y, S => NOR2_15_Y, 
        Y => MX2_23_Y);
    AND2_323 : AND2
      port map(A => XOR2_5_Y, B => XOR2_91_Y, Y => AND2_323_Y);
    MX2_94 : MX2
      port map(A => AND2_205_Y, B => BUFF_80_Y, S => AND2A_2_Y, 
        Y => MX2_94_Y);
    MAJ3_19 : MAJ3
      port map(A => PP6_4_net, B => PP3_10_net, C => PP0_16_net, 
        Y => MAJ3_19_Y);
    XOR2_PP2_4_inst : XOR2
      port map(A => MX2_86_Y, B => BUFF_62_Y, Y => PP2_4_net);
    MAJ3_18 : MAJ3
      port map(A => PP5_0_net, B => PP3_4_net, C => PP1_8_net, 
        Y => MAJ3_18_Y);
    AND2_181 : AND2
      port map(A => XOR2_59_Y, B => BUFF_5_Y, Y => AND2_181_Y);
    MX2_65 : MX2
      port map(A => AND2_90_Y, B => BUFF_39_Y, S => NOR2_17_Y, 
        Y => MX2_65_Y);
    AND2_299 : AND2
      port map(A => PP1_9_net, B => PP0_11_net, Y => AND2_299_Y);
    MX2_1 : MX2
      port map(A => AND2_155_Y, B => BUFF_63_Y, S => NOR2_6_Y, 
        Y => MX2_1_Y);
    XOR3_SumB_31_inst : XOR3
      port map(A => MAJ3_49_Y, B => XOR3_4_Y, C => XOR3_112_Y, 
        Y => SumB_31_net);
    XOR3_86 : XOR3
      port map(A => PP8_13_net, B => PP6_17_net, C => MAJ3_4_Y, 
        Y => XOR3_86_Y);
    XOR3_SumB_28_inst : XOR3
      port map(A => MAJ3_14_Y, B => XOR3_86_Y, C => XOR3_107_Y, 
        Y => SumB_28_net);
    MAJ3_SumA_17_inst : MAJ3
      port map(A => XOR3_56_Y, B => MAJ3_97_Y, C => XOR3_36_Y, 
        Y => SumA_17_net);
    XOR2_PP2_11_inst : XOR2
      port map(A => MX2_29_Y, B => BUFF_57_Y, Y => PP2_11_net);
    AND2_96 : AND2
      port map(A => XOR2_105_Y, B => BUFF_53_Y, Y => AND2_96_Y);
    AND2_253 : AND2
      port map(A => AND2_154_Y, B => AND2_327_Y, Y => AND2_253_Y);
    AO1_59 : AO1
      port map(A => XOR2_32_Y, B => AO1_33_Y, C => AND2_235_Y, 
        Y => AO1_59_Y);
    XOR2_71 : XOR2
      port map(A => SumA_11_net, B => SumB_11_net, Y => XOR2_71_Y);
    AND2_146 : AND2
      port map(A => XOR2_62_Y, B => BUFF_24_Y, Y => AND2_146_Y);
    XOR2_Mult_12_inst : XOR2
      port map(A => XOR2_71_Y, B => AO1_55_Y, Y => Mult(12));
    XOR3_94 : XOR3
      port map(A => PP5_17_net, B => PP3_21_net, C => PP7_13_net, 
        Y => XOR3_94_Y);
    XOR2_PP1_15_inst : XOR2
      port map(A => MX2_95_Y, B => BUFF_27_Y, Y => PP1_15_net);
    AND2_18 : AND2
      port map(A => XOR2_62_Y, B => BUFF_84_Y, Y => AND2_18_Y);
    MAJ3_21 : MAJ3
      port map(A => XOR3_1_Y, B => MAJ3_101_Y, C => XOR2_79_Y, 
        Y => MAJ3_21_Y);
    BUFF_12 : BUFF
      port map(A => DataA(12), Y => BUFF_12_Y);
    XOR2_PP4_16_inst : XOR2
      port map(A => MX2_120_Y, B => BUFF_19_Y, Y => PP4_16_net);
    XOR2_96 : XOR2
      port map(A => SumA_34_net, B => SumB_34_net, Y => XOR2_96_Y);
    AND2_78 : AND2
      port map(A => AND2_1_Y, B => AND2_301_Y, Y => AND2_78_Y);
    AO1_30 : AO1
      port map(A => AND2_226_Y, B => AO1_24_Y, C => AO1_101_Y, 
        Y => AO1_30_Y);
    AO1_89 : AO1
      port map(A => XOR2_86_Y, B => AO1_83_Y, C => AND2_97_Y, 
        Y => AO1_89_Y);
    MAJ3_104 : MAJ3
      port map(A => XOR3_78_Y, B => MAJ3_41_Y, C => MAJ3_53_Y, 
        Y => MAJ3_104_Y);
    MAJ3_SumA_19_inst : MAJ3
      port map(A => XOR3_117_Y, B => MAJ3_3_Y, C => XOR3_23_Y, 
        Y => SumA_19_net);
    AND2_285 : AND2
      port map(A => AND2_246_Y, B => XOR2_11_Y, Y => AND2_285_Y);
    XOR3_SumB_36_inst : XOR3
      port map(A => PP8_21_net, B => E_7_net, C => AND2_159_Y, 
        Y => SumB_36_net);
    XOR3_101 : XOR3
      port map(A => PP4_12_net, B => PP1_18_net, C => PP7_6_net, 
        Y => XOR3_101_Y);
    AND2_138 : AND2
      port map(A => AND2A_0_Y, B => BUFF_3_Y, Y => AND2_138_Y);
    XNOR2_4 : XNOR2
      port map(A => DataB(10), B => BUFF_78_Y, Y => XNOR2_4_Y);
    XOR2_PP4_7_inst : XOR2
      port map(A => MX2_17_Y, B => BUFF_66_Y, Y => PP4_7_net);
    XOR2_PP4_20_inst : XOR2
      port map(A => MX2_109_Y, B => BUFF_19_Y, Y => PP4_20_net);
    AND2_40 : AND2
      port map(A => DataB(0), B => BUFF_40_Y, Y => AND2_40_Y);
    MX2_121 : MX2
      port map(A => AND2_255_Y, B => BUFF_0_Y, S => AND2A_0_Y, 
        Y => MX2_121_Y);
    BUFF_33 : BUFF
      port map(A => DataA(11), Y => BUFF_33_Y);
    BUFF_31 : BUFF
      port map(A => DataA(6), Y => BUFF_31_Y);
    AND2_315 : AND2
      port map(A => SumA_10_net, B => SumB_10_net, Y => 
        AND2_315_Y);
    MX2_100 : MX2
      port map(A => AND2_258_Y, B => BUFF_81_Y, S => AND2A_2_Y, 
        Y => MX2_100_Y);
    XOR2_PP1_18_inst : XOR2
      port map(A => MX2_7_Y, B => BUFF_74_Y, Y => PP1_18_net);
    XOR3_114 : XOR3
      port map(A => MAJ3_54_Y, B => MAJ3_115_Y, C => XOR3_118_Y, 
        Y => XOR3_114_Y);
    MAJ3_84 : MAJ3
      port map(A => PP4_2_net, B => PP2_6_net, C => PP0_10_net, 
        Y => MAJ3_84_Y);
    XOR2_24 : XOR2
      port map(A => PP1_9_net, B => PP0_11_net, Y => XOR2_24_Y);
    MAJ3_71 : MAJ3
      port map(A => XOR3_113_Y, B => MAJ3_57_Y, C => MAJ3_82_Y, 
        Y => MAJ3_71_Y);
    AND2_153 : AND2
      port map(A => XOR2_17_Y, B => BUFF_59_Y, Y => AND2_153_Y);
    XOR3_118 : XOR3
      port map(A => XOR3_73_Y, B => MAJ3_102_Y, C => XOR3_109_Y, 
        Y => XOR3_118_Y);
    AO1_71 : AO1
      port map(A => XOR2_60_Y, B => AND2_25_Y, C => AND2_79_Y, 
        Y => AO1_71_Y);
    BUFF_22 : BUFF
      port map(A => DataB(13), Y => BUFF_22_Y);
    XOR2_34 : XOR2
      port map(A => SumA_27_net, B => SumB_27_net, Y => XOR2_34_Y);
    AND2_32 : AND2
      port map(A => XOR2_17_Y, B => BUFF_64_Y, Y => AND2_32_Y);
    XOR2_PP2_14_inst : XOR2
      port map(A => MX2_147_Y, B => BUFF_57_Y, Y => PP2_14_net);
    MAJ3_SumA_9_inst : MAJ3
      port map(A => XOR3_10_Y, B => MAJ3_39_Y, C => XOR3_59_Y, 
        Y => SumA_9_net);
    AO1_66 : AO1
      port map(A => XOR2_113_Y, B => AND2_315_Y, C => AND2_209_Y, 
        Y => AO1_66_Y);
    AND2_201 : AND2
      port map(A => XOR2_81_Y, B => BUFF_41_Y, Y => AND2_201_Y);
    AND2_60 : AND2
      port map(A => AND2_232_Y, B => AND2_121_Y, Y => AND2_60_Y);
    MAJ3_96 : MAJ3
      port map(A => MAJ3_65_Y, B => MAJ3_36_Y, C => XOR2_103_Y, 
        Y => MAJ3_96_Y);
    MX2_147 : MX2
      port map(A => AND2_42_Y, B => BUFF_34_Y, S => NOR2_11_Y, 
        Y => MX2_147_Y);
    XOR2_PP3_0_inst : XOR2
      port map(A => XOR2_49_Y, B => DataB(7), Y => PP3_0_net);
    MX2_0 : MX2
      port map(A => AND2_144_Y, B => BUFF_40_Y, S => AND2A_1_Y, 
        Y => MX2_0_Y);
    XOR2_43 : XOR2
      port map(A => SumA_13_net, B => SumB_13_net, Y => XOR2_43_Y);
    BUFF_69 : BUFF
      port map(A => DataA(16), Y => BUFF_69_Y);
    BUFF_4 : BUFF
      port map(A => DataB(1), Y => BUFF_4_Y);
    XOR2_61 : XOR2
      port map(A => AND2_27_Y, B => BUFF_52_Y, Y => XOR2_61_Y);
    XOR3_SumB_19_inst : XOR3
      port map(A => MAJ3_51_Y, B => XOR3_115_Y, C => XOR3_89_Y, 
        Y => SumB_19_net);
    BUFF_48 : BUFF
      port map(A => DataA(17), Y => BUFF_48_Y);
    XOR2_49 : XOR2
      port map(A => AND2_184_Y, B => BUFF_28_Y, Y => XOR2_49_Y);
    XNOR2_2 : XNOR2
      port map(A => DataB(6), B => BUFF_28_Y, Y => XNOR2_2_Y);
    AND2_85 : AND2
      port map(A => AND2_225_Y, B => AND2_309_Y, Y => AND2_85_Y);
    AND2_147 : AND2
      port map(A => XOR2_65_Y, B => BUFF_13_Y, Y => AND2_147_Y);
    AND2_209 : AND2
      port map(A => SumA_11_net, B => SumB_11_net, Y => 
        AND2_209_Y);
    AO1_35 : AO1
      port map(A => AND2_305_Y, B => AO1_60_Y, C => AO1_63_Y, 
        Y => AO1_35_Y);
    AO1_27 : AO1
      port map(A => XOR2_5_Y, B => AO1_71_Y, C => AND2_125_Y, 
        Y => AO1_27_Y);
    XOR2_PP2_17_inst : XOR2
      port map(A => MX2_35_Y, B => BUFF_14_Y, Y => PP2_17_net);
    MX2_21 : MX2
      port map(A => AND2_314_Y, B => BUFF_37_Y, S => NOR2_13_Y, 
        Y => MX2_21_Y);
    AND2_53 : AND2
      port map(A => AND2_1_Y, B => AND2_301_Y, Y => AND2_53_Y);
    XOR3_22 : XOR3
      port map(A => MAJ3_61_Y, B => MAJ3_32_Y, C => XOR3_5_Y, 
        Y => XOR3_22_Y);
    AO1_13 : AO1
      port map(A => XOR2_67_Y, B => AO1_88_Y, C => AND2_189_Y, 
        Y => AO1_13_Y);
    BUFF_84 : BUFF
      port map(A => DataA(7), Y => BUFF_84_Y);
    XOR3_95 : XOR3
      port map(A => PP5_10_net, B => PP2_16_net, C => PP8_4_net, 
        Y => XOR3_95_Y);
    MX2_14 : MX2
      port map(A => AND2_158_Y, B => BUFF_77_Y, S => NOR2_2_Y, 
        Y => MX2_14_Y);
    AND2_174 : AND2
      port map(A => XOR2_53_Y, B => BUFF_12_Y, Y => AND2_174_Y);
    AND2_125 : AND2
      port map(A => SumA_26_net, B => SumB_26_net, Y => 
        AND2_125_Y);
    MX2_33 : MX2
      port map(A => AND2_332_Y, B => BUFF_88_Y, S => NOR2_4_Y, 
        Y => MX2_33_Y);
    XOR3_8 : XOR3
      port map(A => PP4_13_net, B => PP1_19_net, C => PP7_7_net, 
        Y => XOR3_8_Y);
    XOR2_PP7_11_inst : XOR2
      port map(A => MX2_33_Y, B => BUFF_38_Y, Y => PP7_11_net);
    XOR3_32 : XOR3
      port map(A => PP5_12_net, B => PP2_18_net, C => PP8_6_net, 
        Y => XOR3_32_Y);
    INV_E_0_inst : INV
      port map(A => DataB(1), Y => E_0_net);
    MAJ3_37 : MAJ3
      port map(A => PP6_10_net, B => PP3_16_net, C => PP0_22_net, 
        Y => MAJ3_37_Y);
    XOR3_119 : XOR3
      port map(A => PP8_18_net, B => PP7_20_net, C => XOR2_77_Y, 
        Y => XOR3_119_Y);
    MX2_129 : MX2
      port map(A => AND2_87_Y, B => BUFF_85_Y, S => AND2A_1_Y, 
        Y => MX2_129_Y);
    MX2_28 : MX2
      port map(A => AND2_59_Y, B => BUFF_7_Y, S => NOR2_11_Y, 
        Y => MX2_28_Y);
    XOR2_Mult_3_inst : XOR2
      port map(A => XOR2_50_Y, B => AO1_67_Y, Y => Mult(3));
    AND2_99 : AND2
      port map(A => XOR2_58_Y, B => BUFF_55_Y, Y => AND2_99_Y);
    XOR2_PP5_1_inst : XOR2
      port map(A => MX2_155_Y, B => BUFF_87_Y, Y => PP5_1_net);
    AND2_314 : AND2
      port map(A => XOR2_36_Y, B => BUFF_72_Y, Y => AND2_314_Y);
    XOR2_47 : XOR2
      port map(A => SumA_17_net, B => SumB_17_net, Y => XOR2_47_Y);
    XOR3_SumB_4_inst : XOR3
      port map(A => S_2_net, B => PP2_1_net, C => XOR2_45_Y, Y => 
        SumB_4_net);
    BUFF_53 : BUFF
      port map(A => DataA(2), Y => BUFF_53_Y);
    MAJ3_SumA_14_inst : MAJ3
      port map(A => XOR3_28_Y, B => MAJ3_50_Y, C => XOR3_116_Y, 
        Y => SumA_14_net);
    BUFF_51 : BUFF
      port map(A => DataA(2), Y => BUFF_51_Y);
    AND2_233 : AND2
      port map(A => XOR2_81_Y, B => BUFF_6_Y, Y => AND2_233_Y);
    XOR2_PP4_10_inst : XOR2
      port map(A => MX2_136_Y, B => BUFF_61_Y, Y => PP4_10_net);
    AO1_28 : AO1
      port map(A => AND2_152_Y, B => AO1_41_Y, C => AO1_44_Y, 
        Y => AO1_28_Y);
    XOR2_PP3_11_inst : XOR2
      port map(A => MX2_87_Y, B => BUFF_16_Y, Y => PP3_11_net);
    XOR2_9 : XOR2
      port map(A => SumA_18_net, B => SumB_18_net, Y => XOR2_9_Y);
    AND2_224 : AND2
      port map(A => AND2_267_Y, B => AND2_41_Y, Y => AND2_224_Y);
    AO1_12 : AO1
      port map(A => XOR2_102_Y, B => AO1_68_Y, C => AND2_25_Y, 
        Y => AO1_12_Y);
    MX2_160 : MX2
      port map(A => AND2_311_Y, B => BUFF_23_Y, S => NOR2_18_Y, 
        Y => MX2_160_Y);
    MAJ3_61 : MAJ3
      port map(A => S_5_net, B => PP4_3_net, C => PP2_7_net, Y => 
        MAJ3_61_Y);
    AND2_171 : AND2
      port map(A => XOR2_92_Y, B => XOR2_76_Y, Y => AND2_171_Y);
    MAJ3_51 : MAJ3
      port map(A => XOR3_33_Y, B => MAJ3_112_Y, C => MAJ3_0_Y, 
        Y => MAJ3_51_Y);
    AND2_120 : AND2
      port map(A => SumA_34_net, B => SumB_34_net, Y => 
        AND2_120_Y);
    XOR2_25 : XOR2
      port map(A => SumA_21_net, B => SumB_21_net, Y => XOR2_25_Y);
    XOR2_Mult_17_inst : XOR2
      port map(A => XOR2_22_Y, B => AO1_83_Y, Y => Mult(17));
    XOR2_35 : XOR2
      port map(A => AND2_31_Y, B => BUFF_62_Y, Y => XOR2_35_Y);
    XOR2_SumB_2_inst : XOR2
      port map(A => PP1_1_net, B => PP0_3_net, Y => SumB_2_net);
    INV_E_4_inst : INV
      port map(A => DataB(9), Y => E_4_net);
    XOR3_26 : XOR3
      port map(A => XOR3_3_Y, B => MAJ3_20_Y, C => XOR3_60_Y, 
        Y => XOR3_26_Y);
    XOR2_PP4_0_inst : XOR2
      port map(A => XOR2_0_Y, B => DataB(9), Y => PP4_0_net);
    XOR2_PP1_1_inst : XOR2
      port map(A => MX2_66_Y, B => BUFF_36_Y, Y => PP1_1_net);
    AO1_93 : AO1
      port map(A => AND2_309_Y, B => AO1_67_Y, C => AO1_78_Y, 
        Y => AO1_93_Y);
    AND2_250 : AND2
      port map(A => AND2_51_Y, B => AND2_327_Y, Y => AND2_250_Y);
    MX2_50 : MX2
      port map(A => AND2_192_Y, B => BUFF_0_Y, S => NOR2_2_Y, 
        Y => MX2_50_Y);
    MX2_7 : MX2
      port map(A => AND2_302_Y, B => BUFF_41_Y, S => NOR2_2_Y, 
        Y => MX2_7_Y);
    BUFF_74 : BUFF
      port map(A => DataB(3), Y => BUFF_74_Y);
    AND2_17 : AND2
      port map(A => XOR2_36_Y, B => BUFF_25_Y, Y => AND2_17_Y);
    XOR3_36 : XOR3
      port map(A => MAJ3_19_Y, B => MAJ3_116_Y, C => XOR3_34_Y, 
        Y => XOR3_36_Y);
    AND2_114 : AND2
      port map(A => AND2_128_Y, B => AND2_297_Y, Y => AND2_114_Y);
    AND2_77 : AND2
      port map(A => AND2_51_Y, B => AND2_7_Y, Y => AND2_77_Y);
    XOR2_PP7_14_inst : XOR2
      port map(A => MX2_143_Y, B => BUFF_38_Y, Y => PP7_14_net);
    MAJ3_SumA_7_inst : MAJ3
      port map(A => XOR3_65_Y, B => MAJ3_9_Y, C => XOR2_69_Y, 
        Y => SumA_7_net);
    MX2_136 : MX2
      port map(A => AND2_17_Y, B => BUFF_72_Y, S => NOR2_13_Y, 
        Y => MX2_136_Y);
    AO1_3 : AO1
      port map(A => AND2_39_Y, B => AO1_51_Y, C => AO1_71_Y, Y => 
        AO1_3_Y);
    BUFF_16 : BUFF
      port map(A => DataB(7), Y => BUFF_16_Y);
    MAJ3_112 : MAJ3
      port map(A => XOR3_90_Y, B => MAJ3_91_Y, C => MAJ3_63_Y, 
        Y => MAJ3_112_Y);
    XOR2_PP0_19_inst : XOR2
      port map(A => MX2_121_Y, B => BUFF_4_Y, Y => PP0_19_net);
    MX2_90 : MX2
      port map(A => AND2_319_Y, B => BUFF_37_Y, S => NOR2_1_Y, 
        Y => MX2_90_Y);
    AND2_133 : AND2
      port map(A => PP0_1_net, B => S_0_net, Y => AND2_133_Y);
    NOR2_2 : NOR2
      port map(A => XOR2_18_Y, B => XNOR2_10_Y, Y => NOR2_2_Y);
    AND2_38 : AND2
      port map(A => XOR2_28_Y, B => BUFF_84_Y, Y => AND2_38_Y);
    MX2_135 : MX2
      port map(A => AND2_236_Y, B => BUFF_89_Y, S => NOR2_12_Y, 
        Y => MX2_135_Y);
    AND2_275 : AND2
      port map(A => XOR2_33_Y, B => BUFF_10_Y, Y => AND2_275_Y);
    XOR3_SumB_20_inst : XOR3
      port map(A => MAJ3_71_Y, B => XOR3_35_Y, C => XOR3_79_Y, 
        Y => SumB_20_net);
    MX2_6 : MX2
      port map(A => AND2_58_Y, B => BUFF_8_Y, S => NOR2_0_Y, Y => 
        MX2_6_Y);
    MAJ3_111 : MAJ3
      port map(A => XOR3_44_Y, B => MAJ3_37_Y, C => MAJ3_75_Y, 
        Y => MAJ3_111_Y);
    NOR2_3 : NOR2
      port map(A => XOR2_62_Y, B => XNOR2_18_Y, Y => NOR2_3_Y);
    XOR2_PP3_22_inst : XOR2
      port map(A => AND2_81_Y, B => BUFF_67_Y, Y => PP3_22_net);
    XOR2_72 : XOR2
      port map(A => PP0_2_net, B => PP1_0_net, Y => XOR2_72_Y);
    AND2_129 : AND2
      port map(A => DataB(0), B => BUFF_81_Y, Y => AND2_129_Y);
    XOR2_PP3_14_inst : XOR2
      port map(A => MX2_152_Y, B => BUFF_16_Y, Y => PP3_14_net);
    AO1_92 : AO1
      port map(A => AND2_7_Y, B => AO1_48_Y, C => AO1_84_Y, Y => 
        AO1_92_Y);
    MAJ3_27 : MAJ3
      port map(A => PP8_8_net, B => PP5_14_net, C => PP2_20_net, 
        Y => MAJ3_27_Y);
    XOR2_PP1_20_inst : XOR2
      port map(A => MX2_26_Y, B => BUFF_74_Y, Y => PP1_20_net);
    MAJ3_39 : MAJ3
      port map(A => AND2_46_Y, B => PP4_0_net, C => PP3_2_net, 
        Y => MAJ3_39_Y);
    AND2_330 : AND2
      port map(A => XOR2_62_Y, B => BUFF_18_Y, Y => AND2_330_Y);
    XOR3_116 : XOR3
      port map(A => AND2_303_Y, B => PP6_2_net, C => XOR3_52_Y, 
        Y => XOR3_116_Y);
    AO1_56 : AO1
      port map(A => XOR2_39_Y, B => AO1_52_Y, C => AND2_89_Y, 
        Y => AO1_56_Y);
    XOR3_90 : XOR3
      port map(A => PP4_10_net, B => PP1_16_net, C => PP7_4_net, 
        Y => XOR3_90_Y);
    MAJ3_38 : MAJ3
      port map(A => XOR3_88_Y, B => MAJ3_12_Y, C => MAJ3_27_Y, 
        Y => MAJ3_38_Y);
    AO1_0 : AO1
      port map(A => XOR2_43_Y, B => AND2_248_Y, C => AND2_166_Y, 
        Y => AO1_0_Y);
    XOR2_PP0_12_inst : XOR2
      port map(A => MX2_94_Y, B => BUFF_46_Y, Y => PP0_12_net);
    XOR3_112 : XOR3
      port map(A => MAJ3_36_Y, B => XOR2_103_Y, C => MAJ3_65_Y, 
        Y => XOR3_112_Y);
    AND2_111 : AND2
      port map(A => NOR2_2_Y, B => BUFF_3_Y, Y => AND2_111_Y);
    XOR2_PP5_19_inst : XOR2
      port map(A => MX2_19_Y, B => BUFF_43_Y, Y => PP5_19_net);
    XOR3_44 : XOR3
      port map(A => PP4_15_net, B => PP1_21_net, C => PP7_9_net, 
        Y => XOR3_44_Y);
    BUFF_26 : BUFF
      port map(A => DataA(9), Y => BUFF_26_Y);
    AO1_86 : AO1
      port map(A => AND2_324_Y, B => AO1_90_Y, C => AO1_4_Y, Y => 
        AO1_86_Y);
    XOR2_PP7_17_inst : XOR2
      port map(A => MX2_70_Y, B => BUFF_83_Y, Y => PP7_17_net);
    XOR3_64 : XOR3
      port map(A => PP3_19_net, B => E_0_net, C => PP6_13_net, 
        Y => XOR3_64_Y);
    AND2_258 : AND2
      port map(A => DataB(0), B => BUFF_80_Y, Y => AND2_258_Y);
    XOR2_PP2_22_inst : XOR2
      port map(A => AND2_70_Y, B => BUFF_14_Y, Y => PP2_22_net);
    AND2_83 : AND2
      port map(A => XOR2_17_Y, B => BUFF_82_Y, Y => AND2_83_Y);
    MX2_42 : MX2
      port map(A => AND2_61_Y, B => BUFF_40_Y, S => NOR2_18_Y, 
        Y => MX2_42_Y);
    MAJ3_119 : MAJ3
      port map(A => XOR3_29_Y, B => XOR3_7_Y, C => MAJ3_58_Y, 
        Y => MAJ3_119_Y);
    AND2_11 : AND2
      port map(A => NOR2_7_Y, B => BUFF_17_Y, Y => AND2_11_Y);
    XOR2_18 : XOR2
      port map(A => DataB(1), B => DataB(2), Y => XOR2_18_Y);
    AND2_90 : AND2
      port map(A => XOR2_57_Y, B => BUFF_42_Y, Y => AND2_90_Y);
    MAJ3_95 : MAJ3
      port map(A => PP2_5_net, B => PP1_7_net, C => PP0_9_net, 
        Y => MAJ3_95_Y);
    MAJ3_SumA_10_inst : MAJ3
      port map(A => XOR3_97_Y, B => MAJ3_99_Y, C => XOR3_40_Y, 
        Y => SumA_10_net);
    XOR2_PP5_12_inst : XOR2
      port map(A => MX2_159_Y, B => BUFF_78_Y, Y => PP5_12_net);
    MAJ3_77 : MAJ3
      port map(A => PP8_7_net, B => PP5_13_net, C => PP2_19_net, 
        Y => MAJ3_77_Y);
    AND2_316 : AND2
      port map(A => AND2_60_Y, B => AND2_272_Y, Y => AND2_316_Y);
    AND2_71 : AND2
      port map(A => XOR2_57_Y, B => BUFF_39_Y, Y => AND2_71_Y);
    XOR2_PP3_17_inst : XOR2
      port map(A => MX2_154_Y, B => BUFF_67_Y, Y => PP3_17_net);
    MX2_128 : MX2
      port map(A => AND2_129_Y, B => BUFF_26_Y, S => AND2A_2_Y, 
        Y => MX2_128_Y);
    AND2_185 : AND2
      port map(A => XOR2_13_Y, B => BUFF_81_Y, Y => AND2_185_Y);
    AND2_164 : AND2
      port map(A => AND2_78_Y, B => AND2_226_Y, Y => AND2_164_Y);
    BUFF_37 : BUFF
      port map(A => DataA(8), Y => BUFF_37_Y);
    XOR2_20 : XOR2
      port map(A => SumA_22_net, B => SumB_22_net, Y => XOR2_20_Y);
    MX2_31 : MX2
      port map(A => AND2_227_Y, B => BUFF_58_Y, S => NOR2_10_Y, 
        Y => MX2_31_Y);
    XOR2_76 : XOR2
      port map(A => SumA_5_net, B => SumB_5_net, Y => XOR2_76_Y);
    AND2_215 : AND2
      port map(A => SumA_23_net, B => SumB_23_net, Y => 
        AND2_215_Y);
    MX2_85 : MX2
      port map(A => AND2_113_Y, B => BUFF_33_Y, S => NOR2_10_Y, 
        Y => MX2_85_Y);
    XOR2_30 : XOR2
      port map(A => SumA_21_net, B => SumB_21_net, Y => XOR2_30_Y);
    XOR2_88 : XOR2
      port map(A => AND2_191_Y, B => BUFF_87_Y, Y => XOR2_88_Y);
    BUFF_85 : BUFF
      port map(A => DataA(5), Y => BUFF_85_Y);
    BUFF_80 : BUFF
      port map(A => DataA(11), Y => BUFF_80_Y);
    MX2_56 : MX2
      port map(A => AND2_150_Y, B => BUFF_41_Y, S => AND2A_0_Y, 
        Y => MX2_56_Y);
    AND2_284 : AND2
      port map(A => XOR2_13_Y, B => BUFF_80_Y, Y => AND2_284_Y);
    MX2_38 : MX2
      port map(A => AND2_335_Y, B => BUFF_50_Y, S => NOR2_5_Y, 
        Y => MX2_38_Y);
    AND2_S_3_inst : AND2
      port map(A => XOR2_49_Y, B => DataB(7), Y => S_3_net);
    MX2_107 : MX2
      port map(A => AND2_276_Y, B => BUFF_81_Y, S => NOR2_15_Y, 
        Y => MX2_107_Y);
    AND2_180 : AND2
      port map(A => DataB(0), B => BUFF_32_Y, Y => AND2_180_Y);
    MAJ3_SumA_12_inst : MAJ3
      port map(A => XOR3_22_Y, B => MAJ3_79_Y, C => XOR3_91_Y, 
        Y => SumA_12_net);
    XOR2_62 : XOR2
      port map(A => DataB(7), B => DataB(8), Y => XOR2_62_Y);
    AND2_161 : AND2
      port map(A => XOR2_59_Y, B => BUFF_48_Y, Y => AND2_161_Y);
    MAJ3_SumA_35_inst : MAJ3
      port map(A => XOR3_16_Y, B => MAJ3_89_Y, C => AND2_55_Y, 
        Y => SumA_35_net);
    AND2_4 : AND2
      port map(A => XOR2_6_Y, B => BUFF_11_Y, Y => AND2_4_Y);
    AND2_328 : AND2
      port map(A => SumA_33_net, B => SumB_33_net, Y => 
        AND2_328_Y);
    XOR3_2 : XOR3
      port map(A => PP5_9_net, B => PP2_15_net, C => PP8_3_net, 
        Y => XOR3_2_Y);
    MAJ3_29 : MAJ3
      port map(A => XOR3_94_Y, B => MAJ3_30_Y, C => PP8_11_net, 
        Y => MAJ3_29_Y);
    MAJ3_SumA_25_inst : MAJ3
      port map(A => XOR3_38_Y, B => MAJ3_74_Y, C => XOR3_80_Y, 
        Y => SumA_25_net);
    MX2_96 : MX2
      port map(A => AND2_69_Y, B => BUFF_53_Y, S => NOR2_19_Y, 
        Y => MX2_96_Y);
    MAJ3_28 : MAJ3
      port map(A => PP7_5_net, B => PP4_11_net, C => PP1_17_net, 
        Y => MAJ3_28_Y);
    MX2_74 : MX2
      port map(A => AND2_293_Y, B => BUFF_47_Y, S => NOR2_15_Y, 
        Y => MX2_74_Y);
    XOR2_PP7_8_inst : XOR2
      port map(A => MX2_57_Y, B => BUFF_38_Y, Y => PP7_8_net);
    AND2_0 : AND2
      port map(A => XOR2_13_Y, B => BUFF_47_Y, Y => AND2_0_Y);
    AND2_230 : AND2
      port map(A => DataB(0), B => BUFF_26_Y, Y => AND2_230_Y);
    AND2_156 : AND2
      port map(A => XOR2_59_Y, B => BUFF_42_Y, Y => AND2_156_Y);
    AO1_34 : AO1
      port map(A => AND2_179_Y, B => AO1_25_Y, C => AO1_87_Y, 
        Y => AO1_34_Y);
    XOR3_3 : XOR3
      port map(A => PP5_8_net, B => PP2_14_net, C => PP8_2_net, 
        Y => XOR3_3_Y);
    AND2_PP8_13_inst : AND2
      port map(A => DataB(15), B => BUFF_82_Y, Y => PP8_13_net);
    AO1_43 : AO1
      port map(A => AND2_135_Y, B => AO1_62_Y, C => AO1_72_Y, 
        Y => AO1_43_Y);
    MAJ3_93 : MAJ3
      port map(A => XOR3_92_Y, B => MAJ3_59_Y, C => MAJ3_87_Y, 
        Y => MAJ3_93_Y);
    MX2_116 : MX2
      port map(A => AND2_94_Y, B => BUFF_13_Y, S => NOR2_5_Y, 
        Y => MX2_116_Y);
    AND2_16 : AND2
      port map(A => SumA_31_net, B => SumB_31_net, Y => AND2_16_Y);
    MX2_64 : MX2
      port map(A => AND2_10_Y, B => BUFF_29_Y, S => NOR2_16_Y, 
        Y => MX2_64_Y);
    AND2_76 : AND2
      port map(A => PP4_22_net, B => VCC_1_net, Y => AND2_76_Y);
    MX2_10 : MX2
      port map(A => AND2_45_Y, B => BUFF_24_Y, S => NOR2_3_Y, 
        Y => MX2_10_Y);
    AND2_6 : AND2
      port map(A => XOR2_28_Y, B => BUFF_63_Y, Y => AND2_6_Y);
    MX2_115 : MX2
      port map(A => AND2_29_Y, B => BUFF_79_Y, S => NOR2_20_Y, 
        Y => MX2_115_Y);
    AO1_17 : AO1
      port map(A => XOR2_78_Y, B => AO1_69_Y, C => AND2_106_Y, 
        Y => AO1_17_Y);
    XOR3_45 : XOR3
      port map(A => PP4_16_net, B => PP1_22_net, C => PP7_10_net, 
        Y => XOR3_45_Y);
    XOR2_PP6_13_inst : XOR2
      port map(A => MX2_54_Y, B => BUFF_22_Y, Y => PP6_13_net);
    XNOR2_0 : XNOR2
      port map(A => DataB(12), B => BUFF_35_Y, Y => XNOR2_0_Y);
    XOR3_65 : XOR3
      port map(A => PP3_1_net, B => PP2_3_net, C => S_3_net, Y => 
        XOR3_65_Y);
    BUFF_44 : BUFF
      port map(A => DataB(15), Y => BUFF_44_Y);
    MAJ3_79 : MAJ3
      port map(A => XOR3_62_Y, B => MAJ3_84_Y, C => MAJ3_18_Y, 
        Y => MAJ3_79_Y);
    BUFF_75 : BUFF
      port map(A => DataA(15), Y => BUFF_75_Y);
    AND2_265 : AND2
      port map(A => XOR2_81_Y, B => BUFF_20_Y, Y => AND2_265_Y);
    AND2_189 : AND2
      port map(A => SumA_6_net, B => SumB_6_net, Y => AND2_189_Y);
    AND2_313 : AND2
      port map(A => XOR2_36_Y, B => BUFF_58_Y, Y => AND2_313_Y);
    MAJ3_78 : MAJ3
      port map(A => PP4_7_net, B => PP2_11_net, C => PP0_15_net, 
        Y => MAJ3_78_Y);
    MX2_49 : MX2
      port map(A => AND2_175_Y, B => BUFF_48_Y, S => NOR2_17_Y, 
        Y => MX2_49_Y);
    XNOR2_15 : XNOR2
      port map(A => DataB(12), B => BUFF_22_Y, Y => XNOR2_15_Y);
    BUFF_70 : BUFF
      port map(A => DataA(3), Y => BUFF_70_Y);
    MAJ3_67 : MAJ3
      port map(A => XOR3_50_Y, B => MAJ3_21_Y, C => MAJ3_107_Y, 
        Y => MAJ3_67_Y);
    XOR3_SumB_24_inst : XOR3
      port map(A => MAJ3_74_Y, B => XOR3_80_Y, C => XOR3_38_Y, 
        Y => SumB_24_net);
    XOR2_66 : XOR2
      port map(A => SumA_14_net, B => SumB_14_net, Y => XOR2_66_Y);
    MAJ3_57 : MAJ3
      port map(A => XOR3_82_Y, B => MAJ3_34_Y, C => MAJ3_109_Y, 
        Y => MAJ3_57_Y);
    XOR2_PP0_5_inst : XOR2
      port map(A => MX2_113_Y, B => BUFF_52_Y, Y => PP0_5_net);
    XOR3_SumB_25_inst : XOR3
      port map(A => MAJ3_104_Y, B => XOR3_111_Y, C => XOR3_98_Y, 
        Y => SumB_25_net);
    BUFF_57 : BUFF
      port map(A => DataB(5), Y => BUFF_57_Y);
    AO1_42 : AO1
      port map(A => AND2_309_Y, B => AO1_67_Y, C => AO1_78_Y, 
        Y => AO1_42_Y);
    XOR2_PP5_21_inst : XOR2
      port map(A => MX2_65_Y, B => BUFF_43_Y, Y => PP5_21_net);
    MAJ3_106 : MAJ3
      port map(A => XOR3_46_Y, B => PP6_0_net, C => PP4_4_net, 
        Y => MAJ3_106_Y);
    AND2_37 : AND2
      port map(A => XOR2_109_Y, B => BUFF_33_Y, Y => AND2_37_Y);
    MX2_154 : MX2
      port map(A => AND2_161_Y, B => BUFF_69_Y, S => NOR2_20_Y, 
        Y => MX2_154_Y);
    AND2_305 : AND2
      port map(A => AND2_272_Y, B => AND2_44_Y, Y => AND2_305_Y);
    MAJ3_107 : MAJ3
      port map(A => XOR3_54_Y, B => MAJ3_62_Y, C => MAJ3_7_Y, 
        Y => MAJ3_107_Y);
    AO1_18 : AO1
      port map(A => XOR2_11_Y, B => AO1_98_Y, C => AND2_47_Y, 
        Y => AO1_18_Y);
    XOR2_PP6_20_inst : XOR2
      port map(A => MX2_11_Y, B => BUFF_71_Y, Y => PP6_20_net);
    XNOR2_20 : XNOR2
      port map(A => DataB(2), B => BUFF_27_Y, Y => XNOR2_20_Y);
    AND2_238 : AND2
      port map(A => AND2_170_Y, B => AND2_164_Y, Y => AND2_238_Y);
    XOR3_93 : XOR3
      port map(A => MAJ3_8_Y, B => S_7_net, C => XOR3_57_Y, Y => 
        XOR3_93_Y);
    AO1_39 : AO1
      port map(A => AND2_198_Y, B => AO1_51_Y, C => AO1_56_Y, 
        Y => AO1_39_Y);
    MAJ3_90 : MAJ3
      port map(A => XOR3_64_Y, B => XOR3_75_Y, C => MAJ3_55_Y, 
        Y => MAJ3_90_Y);
    XOR2_41 : XOR2
      port map(A => SumA_10_net, B => SumB_10_net, Y => XOR2_41_Y);
    XOR2_PP2_8_inst : XOR2
      port map(A => MX2_62_Y, B => BUFF_57_Y, Y => PP2_8_net);
    AO1_21 : AO1
      port map(A => AND2_244_Y, B => AO1_24_Y, C => AO1_28_Y, 
        Y => AO1_21_Y);
    AND2_194 : AND2
      port map(A => AND2_242_Y, B => XOR2_32_Y, Y => AND2_194_Y);
    MX2_167 : MX2
      port map(A => AND2_265_Y, B => BUFF_0_Y, S => NOR2_8_Y, 
        Y => MX2_167_Y);
    XOR2_7 : XOR2
      port map(A => SumA_18_net, B => SumB_18_net, Y => XOR2_7_Y);
    AO1_97 : AO1
      port map(A => AND2_272_Y, B => AO1_60_Y, C => AO1_0_Y, Y => 
        AO1_97_Y);
    XOR3_99 : XOR3
      port map(A => PP4_19_net, B => E_2_net, C => PP6_15_net, 
        Y => XOR3_99_Y);
    XOR2_54 : XOR2
      port map(A => SumA_19_net, B => SumB_19_net, Y => XOR2_54_Y);
    MAJ3_42 : MAJ3
      port map(A => XOR3_58_Y, B => MAJ3_78_Y, C => AND2_163_Y, 
        Y => MAJ3_42_Y);
    BUFF_6 : BUFF
      port map(A => DataA(20), Y => BUFF_6_Y);
    MAJ3_1 : MAJ3
      port map(A => XOR3_5_Y, B => MAJ3_61_Y, C => MAJ3_32_Y, 
        Y => MAJ3_1_Y);
    BUFF_68 : BUFF
      port map(A => DataA(0), Y => BUFF_68_Y);
    AND2_157 : AND2
      port map(A => XOR2_62_Y, B => BUFF_13_Y, Y => AND2_157_Y);
    AND2_44 : AND2
      port map(A => XOR2_66_Y, B => XOR2_26_Y, Y => AND2_44_Y);
    INV_E_6_inst : INV
      port map(A => DataB(13), Y => E_6_net);
    XOR3_14 : XOR3
      port map(A => PP2_10_net, B => PP0_14_net, C => PP4_6_net, 
        Y => XOR3_14_Y);
    XOR2_23 : XOR2
      port map(A => SumA_31_net, B => SumB_31_net, Y => XOR2_23_Y);
    AND2_175 : AND2
      port map(A => XOR2_57_Y, B => BUFF_5_Y, Y => AND2_175_Y);
    XOR2_PP5_2_inst : XOR2
      port map(A => MX2_1_Y, B => BUFF_87_Y, Y => PP5_2_net);
    AND2_191 : AND2
      port map(A => XOR2_65_Y, B => BUFF_24_Y, Y => AND2_191_Y);
    XOR2_33 : XOR2
      port map(A => DataB(11), B => DataB(12), Y => XOR2_33_Y);
    AND2_31 : AND2
      port map(A => XOR2_105_Y, B => BUFF_56_Y, Y => AND2_31_Y);
    AO1_98 : AO1
      port map(A => AND2_172_Y, B => AO1_95_Y, C => AO1_21_Y, 
        Y => AO1_98_Y);
    XOR3_103 : XOR3
      port map(A => PP3_13_net, B => PP0_19_net, C => PP6_7_net, 
        Y => XOR3_103_Y);
    MAJ3_69 : MAJ3
      port map(A => AND2_299_Y, B => PP5_2_net, C => PP3_6_net, 
        Y => MAJ3_69_Y);
    INV_E_7_inst : INV
      port map(A => DataB(15), Y => E_7_net);
    XOR2_PP2_15_inst : XOR2
      port map(A => MX2_28_Y, B => BUFF_57_Y, Y => PP2_15_net);
    MX2_16 : MX2
      port map(A => AND2_48_Y, B => BUFF_86_Y, S => AND2A_0_Y, 
        Y => MX2_16_Y);
    AND2_122 : AND2
      port map(A => SumA_5_net, B => SumB_5_net, Y => AND2_122_Y);
    XOR2_29 : XOR2
      port map(A => SumA_10_net, B => SumB_10_net, Y => XOR2_29_Y);
    XOR3_97 : XOR3
      port map(A => MAJ3_95_Y, B => AND2_306_Y, C => XOR3_37_Y, 
        Y => XOR3_97_Y);
    MAJ3_59 : MAJ3
      port map(A => XOR3_52_Y, B => AND2_303_Y, C => PP6_2_net, 
        Y => MAJ3_59_Y);
    AND2_241 : AND2
      port map(A => SumA_19_net, B => SumB_19_net, Y => 
        AND2_241_Y);
    MAJ3_68 : MAJ3
      port map(A => XOR3_71_Y, B => XOR3_32_Y, C => MAJ3_83_Y, 
        Y => MAJ3_68_Y);
    AND2_64 : AND2
      port map(A => AND2_304_Y, B => AND2_103_Y, Y => AND2_64_Y);
    XOR3_40 : XOR3
      port map(A => PP2_6_net, B => PP0_10_net, C => PP4_2_net, 
        Y => XOR3_40_Y);
    MAJ3_58 : MAJ3
      port map(A => PP7_8_net, B => PP4_14_net, C => PP1_20_net, 
        Y => MAJ3_58_Y);
    XOR3_60 : XOR3
      port map(A => PP3_12_net, B => PP0_18_net, C => PP6_6_net, 
        Y => XOR3_60_Y);
    BUFF_39 : BUFF
      port map(A => DataA(20), Y => BUFF_39_Y);
    XOR2_39 : XOR2
      port map(A => SumA_28_net, B => SumB_28_net, Y => XOR2_39_Y);
    AND2_274 : AND2
      port map(A => XOR2_83_Y, B => BUFF_45_Y, Y => AND2_274_Y);
    XOR2_PP3_5_inst : XOR2
      port map(A => MX2_116_Y, B => BUFF_28_Y, Y => PP3_5_net);
    XOR2_PP1_16_inst : XOR2
      port map(A => MX2_3_Y, B => BUFF_74_Y, Y => PP1_16_net);
    XOR2_PP0_9_inst : XOR2
      port map(A => MX2_9_Y, B => BUFF_46_Y, Y => PP0_9_net);
    MX2_151 : MX2
      port map(A => AND2_2_Y, B => BUFF_86_Y, S => NOR2_8_Y, Y => 
        MX2_151_Y);
    AND2_136 : AND2
      port map(A => AND2_171_Y, B => XOR2_67_Y, Y => AND2_136_Y);
    AND2_170 : AND2
      port map(A => AND2_154_Y, B => AND2_327_Y, Y => AND2_170_Y);
    XOR2_Mult_28_inst : XOR2
      port map(A => XOR2_34_Y, B => AO1_5_Y, Y => Mult(28));
    XOR2_PP2_6_inst : XOR2
      port map(A => MX2_51_Y, B => BUFF_62_Y, Y => PP2_6_net);
    AND2_19 : AND2
      port map(A => AND2_39_Y, B => AND2_323_Y, Y => AND2_19_Y);
    AND2_304 : AND2
      port map(A => AND2_1_Y, B => AND2_301_Y, Y => AND2_304_Y);
    AND2_79 : AND2
      port map(A => SumA_25_net, B => SumB_25_net, Y => AND2_79_Y);
    XOR2_PP2_18_inst : XOR2
      port map(A => MX2_138_Y, B => BUFF_14_Y, Y => PP2_18_net);
    MX2_57 : MX2
      port map(A => AND2_177_Y, B => BUFF_1_Y, S => NOR2_4_Y, 
        Y => MX2_57_Y);
    AND2_295 : AND2
      port map(A => AND2_21_Y, B => AND2_74_Y, Y => AND2_295_Y);
    AND2_249 : AND2
      port map(A => PP8_16_net, B => PP7_18_net, Y => AND2_249_Y);
    XOR2_27 : XOR2
      port map(A => SumA_9_net, B => SumB_9_net, Y => XOR2_27_Y);
    XOR2_PP7_22_inst : XOR2
      port map(A => AND2_11_Y, B => BUFF_83_Y, Y => PP7_22_net);
    MX2_8 : MX2
      port map(A => AND2_142_Y, B => BUFF_47_Y, S => NOR2_11_Y, 
        Y => MX2_8_Y);
    XOR2_6 : XOR2
      port map(A => DataB(13), B => DataB(14), Y => XOR2_6_Y);
    AND2_227 : AND2
      port map(A => XOR2_109_Y, B => BUFF_75_Y, Y => AND2_227_Y);
    XOR2_37 : XOR2
      port map(A => SumA_24_net, B => SumB_24_net, Y => XOR2_37_Y);
    MX2_97 : MX2
      port map(A => AND2_104_Y, B => BUFF_11_Y, S => NOR2_9_Y, 
        Y => MX2_97_Y);
    BUFF_13 : BUFF
      port map(A => DataA(4), Y => BUFF_13_Y);
    BUFF_11 : BUFF
      port map(A => DataA(4), Y => BUFF_11_Y);
    AND2_115 : AND2
      port map(A => XOR2_83_Y, B => BUFF_89_Y, Y => AND2_115_Y);
    XOR2_PP0_20_inst : XOR2
      port map(A => MX2_150_Y, B => BUFF_4_Y, Y => PP0_20_net);
    XOR2_PP7_0_inst : XOR2
      port map(A => XOR2_46_Y, B => DataB(15), Y => PP7_0_net);
    XOR3_100 : XOR3
      port map(A => MAJ3_85_Y, B => MAJ3_77_Y, C => XOR3_45_Y, 
        Y => XOR3_100_Y);
    BUFF_45 : BUFF
      port map(A => DataA(15), Y => BUFF_45_Y);
    XOR3_111 : XOR3
      port map(A => MAJ3_101_Y, B => XOR2_79_Y, C => XOR3_1_Y, 
        Y => XOR3_111_Y);
    XOR2_55 : XOR2
      port map(A => SumA_25_net, B => SumB_25_net, Y => XOR2_55_Y);
    BUFF_40 : BUFF
      port map(A => DataA(1), Y => BUFF_40_Y);
    XOR2_Mult_15_inst : XOR2
      port map(A => XOR2_84_Y, B => AO1_47_Y, Y => Mult(15));
    AND2A_2 : AND2A
      port map(A => DataB(0), B => BUFF_46_Y, Y => AND2A_2_Y);
    XOR2_109 : XOR2
      port map(A => DataB(5), B => DataB(6), Y => XOR2_109_Y);
    AND2_104 : AND2
      port map(A => XOR2_64_Y, B => BUFF_29_Y, Y => AND2_104_Y);
    AND2_36 : AND2
      port map(A => AND2_171_Y, B => AND2_325_Y, Y => AND2_36_Y);
    MX2_130 : MX2
      port map(A => AND2_190_Y, B => BUFF_72_Y, S => NOR2_10_Y, 
        Y => MX2_130_Y);
    AND2_179 : AND2
      port map(A => AND2_267_Y, B => XOR2_96_Y, Y => AND2_179_Y);
    MAJ3_82 : MAJ3
      port map(A => XOR3_103_Y, B => XOR3_2_Y, C => MAJ3_73_Y, 
        Y => MAJ3_82_Y);
    AND2_9 : AND2
      port map(A => PP1_3_net, B => PP0_5_net, Y => AND2_9_Y);
    XNOR2_16 : XNOR2
      port map(A => DataB(2), B => BUFF_36_Y, Y => XNOR2_16_Y);
    MX2_123 : MX2
      port map(A => AND2_186_Y, B => BUFF_65_Y, S => NOR2_6_Y, 
        Y => MX2_123_Y);
    AND2_226 : AND2
      port map(A => AND2_277_Y, B => AND2_229_Y, Y => AND2_226_Y);
    AND2_214 : AND2
      port map(A => AND2_218_Y, B => AND2_295_Y, Y => AND2_214_Y);
    XOR3_58 : XOR3
      port map(A => PP4_8_net, B => PP1_14_net, C => PP7_2_net, 
        Y => XOR3_58_Y);
    XOR2_PP6_5_inst : XOR2
      port map(A => MX2_97_Y, B => BUFF_35_Y, Y => PP6_5_net);
    AND2A_1 : AND2A
      port map(A => DataB(0), B => BUFF_52_Y, Y => AND2A_1_Y);
    MX2_70 : MX2
      port map(A => AND2_187_Y, B => BUFF_49_Y, S => NOR2_7_Y, 
        Y => MX2_70_Y);
    XOR2_PP6_8_inst : XOR2
      port map(A => MX2_68_Y, B => BUFF_22_Y, Y => PP6_8_net);
    XOR3_15 : XOR3
      port map(A => PP6_21_net, B => E_5_net, C => PP7_19_net, 
        Y => XOR3_15_Y);
    AND2_110 : AND2
      port map(A => AND2_250_Y, B => XOR2_86_Y, Y => AND2_110_Y);
    MAJ3_SumA_33_inst : MAJ3
      port map(A => XOR3_47_Y, B => MAJ3_96_Y, C => XOR3_15_Y, 
        Y => SumA_33_net);
    MAJ3_SumA_23_inst : MAJ3
      port map(A => XOR3_63_Y, B => MAJ3_81_Y, C => XOR3_67_Y, 
        Y => SumA_23_net);
    XOR3_SumB_13_inst : XOR3
      port map(A => MAJ3_50_Y, B => XOR3_116_Y, C => XOR3_28_Y, 
        Y => SumB_13_net);
    BUFF_23 : BUFF
      port map(A => DataA(6), Y => BUFF_23_Y);
    XOR2_PP4_3_inst : XOR2
      port map(A => MX2_117_Y, B => BUFF_66_Y, Y => PP4_3_net);
    XOR2_PP4_13_inst : XOR2
      port map(A => MX2_166_Y, B => BUFF_61_Y, Y => PP4_13_net);
    BUFF_21 : BUFF
      port map(A => DataA(7), Y => BUFF_21_Y);
    NOR2_5 : NOR2
      port map(A => XOR2_28_Y, B => XNOR2_2_Y, Y => NOR2_5_Y);
    MX2_60 : MX2
      port map(A => AND2_312_Y, B => BUFF_39_Y, S => NOR2_14_Y, 
        Y => MX2_60_Y);
    BUFF_59 : BUFF
      port map(A => DataA(8), Y => BUFF_59_Y);
    AND2_101 : AND2
      port map(A => XOR2_58_Y, B => BUFF_56_Y, Y => AND2_101_Y);
    MX2_159 : MX2
      port map(A => AND2_174_Y, B => BUFF_33_Y, S => NOR2_1_Y, 
        Y => MX2_159_Y);
    AO1_47 : AO1
      port map(A => AND2_316_Y, B => AO1_48_Y, C => AO1_97_Y, 
        Y => AO1_47_Y);
    AND2_137 : AND2
      port map(A => XOR2_36_Y, B => BUFF_75_Y, Y => AND2_137_Y);
    AND2_331 : AND2
      port map(A => SumA_14_net, B => SumB_14_net, Y => 
        AND2_331_Y);
    AND2_PP8_6_inst : AND2
      port map(A => DataB(15), B => BUFF_76_Y, Y => PP8_6_net);
    XOR2_PP7_15_inst : XOR2
      port map(A => MX2_13_Y, B => BUFF_38_Y, Y => PP7_15_net);
    AND2_165 : AND2
      port map(A => AND2_272_Y, B => XOR2_66_Y, Y => AND2_165_Y);
    AND2_182 : AND2
      port map(A => XOR2_16_Y, B => BUFF_47_Y, Y => AND2_182_Y);
    XOR3_SumB_17_inst : XOR3
      port map(A => MAJ3_56_Y, B => XOR3_48_Y, C => XOR3_96_Y, 
        Y => SumB_17_net);
    AND2_10 : AND2
      port map(A => XOR2_6_Y, B => BUFF_76_Y, Y => AND2_10_Y);
    XOR2_PP6_9_inst : XOR2
      port map(A => MX2_139_Y, B => BUFF_22_Y, Y => PP6_9_net);
    XOR2_PP1_2_inst : XOR2
      port map(A => MX2_42_Y, B => BUFF_36_Y, Y => PP1_2_net);
    AND2_119 : AND2
      port map(A => DataB(0), B => BUFF_7_Y, Y => AND2_119_Y);
    AND2_306 : AND2
      port map(A => PP4_1_net, B => PP3_3_net, Y => AND2_306_Y);
    AND2_70 : AND2
      port map(A => NOR2_8_Y, B => BUFF_3_Y, Y => AND2_70_Y);
    XOR3_78 : XOR3
      port map(A => XOR3_75_Y, B => MAJ3_55_Y, C => XOR3_64_Y, 
        Y => XOR3_78_Y);
    XOR2_PP1_10_inst : XOR2
      port map(A => MX2_84_Y, B => BUFF_27_Y, Y => PP1_10_net);
    XOR2_PP3_15_inst : XOR2
      port map(A => MX2_31_Y, B => BUFF_16_Y, Y => PP3_15_net);
    MAJ3_16 : MAJ3
      port map(A => PP7_19_net, B => PP6_21_net, C => E_5_net, 
        Y => MAJ3_16_Y);
    AO1_48 : AO1
      port map(A => AND2_36_Y, B => AO1_42_Y, C => AO1_75_Y, Y => 
        AO1_48_Y);
    XNOR2_7 : XNOR2
      port map(A => DataB(12), B => BUFF_71_Y, Y => XNOR2_7_Y);
    AND2_205 : AND2
      port map(A => DataB(0), B => BUFF_47_Y, Y => AND2_205_Y);
    XOR2_42 : XOR2
      port map(A => SumA_32_net, B => SumB_32_net, Y => XOR2_42_Y);
    AND2_PP8_8_inst : AND2
      port map(A => DataB(15), B => BUFF_59_Y, Y => PP8_8_net);
    XOR2_PP7_18_inst : XOR2
      port map(A => MX2_24_Y, B => BUFF_83_Y, Y => PP7_18_net);
    AND2_264 : AND2
      port map(A => XOR2_36_Y, B => BUFF_60_Y, Y => AND2_264_Y);
    AO1_36 : AO1
      port map(A => XOR2_30_Y, B => AND2_5_Y, C => AND2_251_Y, 
        Y => AO1_36_Y);
    XOR2_PP5_9_inst : XOR2
      port map(A => MX2_90_Y, B => BUFF_78_Y, Y => PP5_9_net);
    XOR2_Mult_21_inst : XOR2
      port map(A => XOR2_104_Y, B => AO1_73_Y, Y => Mult(21));
    AND2_160 : AND2
      port map(A => XOR2_28_Y, B => BUFF_50_Y, Y => AND2_160_Y);
    XOR3_43 : XOR3
      port map(A => PP5_11_net, B => PP2_17_net, C => PP8_5_net, 
        Y => XOR3_43_Y);
    XOR3_63 : XOR3
      port map(A => MAJ3_46_Y, B => MAJ3_68_Y, C => XOR3_49_Y, 
        Y => XOR3_63_Y);
    INV_E_5_inst : INV
      port map(A => DataB(11), Y => E_5_net);
    XOR2_50 : XOR2
      port map(A => S_1_net, B => SumB_2_net, Y => XOR2_50_Y);
    MX2_84 : MX2
      port map(A => AND2_92_Y, B => BUFF_26_Y, S => NOR2_15_Y, 
        Y => MX2_84_Y);
    XOR2_PP6_19_inst : XOR2
      port map(A => MX2_6_Y, B => BUFF_71_Y, Y => PP6_19_net);
    XOR2_PP3_18_inst : XOR2
      port map(A => MX2_101_Y, B => BUFF_67_Y, Y => PP3_18_net);
    XOR3_49 : XOR3
      port map(A => XOR3_7_Y, B => MAJ3_58_Y, C => XOR3_29_Y, 
        Y => XOR3_49_Y);
    XOR2_0 : XOR2
      port map(A => AND2_146_Y, B => BUFF_66_Y, Y => XOR2_0_Y);
    XOR2_101 : XOR2
      port map(A => SumA_12_net, B => SumB_12_net, Y => 
        XOR2_101_Y);
    XOR3_69 : XOR3
      port map(A => PP7_16_net, B => PP5_20_net, C => XOR2_38_Y, 
        Y => XOR3_69_Y);
    AO1_11 : AO1
      port map(A => XOR2_87_Y, B => AND2_283_Y, C => AND2_215_Y, 
        Y => AO1_11_Y);
    AND2_94 : AND2
      port map(A => XOR2_28_Y, B => BUFF_65_Y, Y => AND2_94_Y);
    AND2_287 : AND2
      port map(A => AND2_250_Y, B => AND2_65_Y, Y => AND2_287_Y);
    MX2_122 : MX2
      port map(A => AND2_126_Y, B => BUFF_6_Y, S => NOR2_2_Y, 
        Y => MX2_122_Y);
    MAJ3_100 : MAJ3
      port map(A => PP7_2_net, B => PP4_8_net, C => PP1_14_net, 
        Y => MAJ3_100_Y);
    AND2_222 : AND2
      port map(A => AND2_53_Y, B => XOR2_102_Y, Y => AND2_222_Y);
    MX2_17 : MX2
      port map(A => AND2_18_Y, B => BUFF_31_Y, S => NOR2_3_Y, 
        Y => MX2_17_Y);
    AO1_70 : AO1
      port map(A => AND2_74_Y, B => AO1_99_Y, C => AO1_36_Y, Y => 
        AO1_70_Y);
    MX2_76 : MX2
      port map(A => AND2_197_Y, B => BUFF_10_Y, S => NOR2_7_Y, 
        Y => MX2_76_Y);
    XOR3_10 : XOR3
      port map(A => XOR2_70_Y, B => S_4_net, C => MAJ3_72_Y, Y => 
        XOR3_10_Y);
    AND2_22 : AND2
      port map(A => S_1_net, B => SumB_2_net, Y => AND2_22_Y);
    AO1_63 : AO1
      port map(A => AND2_44_Y, B => AO1_0_Y, C => AO1_22_Y, Y => 
        AO1_63_Y);
    MAJ3_3 : MAJ3
      port map(A => XOR3_26_Y, B => MAJ3_47_Y, C => MAJ3_70_Y, 
        Y => MAJ3_3_Y);
    XOR2_PP6_12_inst : XOR2
      port map(A => MX2_59_Y, B => BUFF_22_Y, Y => PP6_12_net);
    MX2_53 : MX2
      port map(A => AND2_207_Y, B => BUFF_23_Y, S => NOR2_19_Y, 
        Y => MX2_53_Y);
    AND2_39 : AND2
      port map(A => XOR2_102_Y, B => XOR2_60_Y, Y => AND2_39_Y);
    XOR2_PP0_1_inst : XOR2
      port map(A => MX2_127_Y, B => BUFF_52_Y, Y => PP0_1_net);
    XOR2_PP4_1_inst : XOR2
      port map(A => MX2_10_Y, B => BUFF_66_Y, Y => PP4_1_net);
    XOR2_PP5_3_inst : XOR2
      port map(A => MX2_145_Y, B => BUFF_87_Y, Y => PP5_3_net);
    BUFF_64 : BUFF
      port map(A => DataA(14), Y => BUFF_64_Y);
    MX2_110 : MX2
      port map(A => AND2_62_Y, B => BUFF_33_Y, S => NOR2_13_Y, 
        Y => MX2_110_Y);
    AND2_PP8_16_inst : AND2
      port map(A => DataB(15), B => BUFF_49_Y, Y => PP8_16_net);
    XOR2_46 : XOR2
      port map(A => AND2_320_Y, B => BUFF_44_Y, Y => XOR2_46_Y);
    MX2_66 : MX2
      port map(A => AND2_307_Y, B => BUFF_56_Y, S => NOR2_18_Y, 
        Y => MX2_66_Y);
    MAJ3_41 : MAJ3
      port map(A => XOR3_45_Y, B => MAJ3_85_Y, C => MAJ3_77_Y, 
        Y => MAJ3_41_Y);
    AND2_286 : AND2
      port map(A => XOR2_65_Y, B => BUFF_18_Y, Y => AND2_286_Y);
    AND2_169 : AND2
      port map(A => XOR2_59_Y, B => BUFF_79_Y, Y => AND2_169_Y);
    XOR2_Mult_24_inst : XOR2
      port map(A => XOR2_75_Y, B => AO1_14_Y, Y => Mult(24));
    AND2_PP8_21_inst : AND2
      port map(A => DataB(15), B => BUFF_17_Y, Y => PP8_21_net);
    MX2_93 : MX2
      port map(A => AND2_112_Y, B => BUFF_84_Y, S => NOR2_13_Y, 
        Y => MX2_93_Y);
    XOR3_47 : XOR3
      port map(A => AND2_249_Y, B => PP8_17_net, C => MAJ3_76_Y, 
        Y => XOR3_47_Y);
    MX2_45 : MX2
      port map(A => AND2_213_Y, B => BUFF_77_Y, S => AND2A_0_Y, 
        Y => MX2_45_Y);
    XOR3_67 : XOR3
      port map(A => MAJ3_37_Y, B => MAJ3_75_Y, C => XOR3_44_Y, 
        Y => XOR3_67_Y);
    AND2_303 : AND2
      port map(A => PP4_5_net, B => PP3_7_net, Y => AND2_303_Y);
    AND2_318 : AND2
      port map(A => AND2_224_Y, B => XOR2_112_Y, Y => AND2_318_Y);
    MX2_158 : MX2
      port map(A => AND2_98_Y, B => BUFF_65_Y, S => NOR2_3_Y, 
        Y => MX2_158_Y);
    AO1_62 : AO1
      port map(A => AND2_36_Y, B => AO1_42_Y, C => AO1_75_Y, Y => 
        AO1_62_Y);
    AO1_91 : AO1
      port map(A => AND2_49_Y, B => AO1_41_Y, C => AO1_17_Y, Y => 
        AO1_91_Y);
    XOR3_SumB_33_inst : XOR3
      port map(A => MAJ3_33_Y, B => MAJ3_16_Y, C => XOR3_119_Y, 
        Y => SumB_33_net);
    XOR3_91 : XOR3
      port map(A => PP5_2_net, B => PP3_6_net, C => AND2_299_Y, 
        Y => XOR3_91_Y);
    MAJ3_94 : MAJ3
      port map(A => XOR2_38_Y, B => PP7_16_net, C => PP5_20_net, 
        Y => MAJ3_94_Y);
    MAJ3_118 : MAJ3
      port map(A => XOR3_41_Y, B => AND2_134_Y, C => PP7_15_net, 
        Y => MAJ3_118_Y);
    XOR2_Mult_6_inst : XOR2
      port map(A => XOR2_93_Y, B => AO1_31_Y, Y => Mult(6));
    MAJ3_SumA_36_inst : MAJ3
      port map(A => MAJ3_45_Y, B => XOR2_106_Y, C => PP8_20_net, 
        Y => SumA_36_net);
    MAJ3_SumA_26_inst : MAJ3
      port map(A => XOR3_98_Y, B => MAJ3_104_Y, C => XOR3_111_Y, 
        Y => SumA_26_net);
    AND2_195 : AND2
      port map(A => SumA_35_net, B => SumB_35_net, Y => 
        AND2_195_Y);
    XOR2_103 : XOR2
      port map(A => PP8_16_net, B => PP7_18_net, Y => XOR2_103_Y);
    MX2_144 : MX2
      port map(A => AND2_234_Y, B => BUFF_37_Y, S => NOR2_10_Y, 
        Y => MX2_144_Y);
    AND2_332 : AND2
      port map(A => XOR2_83_Y, B => BUFF_2_Y, Y => AND2_332_Y);
    BUFF_17 : BUFF
      port map(A => DataA(21), Y => BUFF_17_Y);
    AND2_45 : AND2
      port map(A => XOR2_62_Y, B => BUFF_63_Y, Y => AND2_45_Y);
    AO1_75 : AO1
      port map(A => AND2_325_Y, B => AO1_88_Y, C => AO1_16_Y, 
        Y => AO1_75_Y);
    MAJ3_2 : MAJ3
      port map(A => XOR3_20_Y, B => XOR3_43_Y, C => MAJ3_26_Y, 
        Y => MAJ3_2_Y);
    XOR2_Mult_16_inst : XOR2
      port map(A => XOR2_100_Y, B => AO1_92_Y, Y => Mult(16));
    XOR2_PP4_22_inst : XOR2
      port map(A => AND2_262_Y, B => BUFF_19_Y, Y => PP4_22_net);
    AND2_294 : AND2
      port map(A => XOR2_2_Y, B => BUFF_69_Y, Y => AND2_294_Y);
    XOR2_PP3_21_inst : XOR2
      port map(A => MX2_72_Y, B => BUFF_67_Y, Y => PP3_21_net);
    XOR2_21 : XOR2
      port map(A => SumA_35_net, B => SumB_35_net, Y => XOR2_21_Y);
    AND2_190 : AND2
      port map(A => XOR2_109_Y, B => BUFF_25_Y, Y => AND2_190_Y);
    XOR2_PP0_2_inst : XOR2
      port map(A => MX2_0_Y, B => BUFF_52_Y, Y => PP0_2_net);
    XOR2_31 : XOR2
      port map(A => PP0_2_net, B => PP1_0_net, Y => XOR2_31_Y);
    XOR2_PP6_3_inst : XOR2
      port map(A => MX2_34_Y, B => BUFF_35_Y, Y => PP6_3_net);
    AND2_172 : AND2
      port map(A => AND2_78_Y, B => AND2_244_Y, Y => AND2_172_Y);
    XOR2_Mult_31_inst : XOR2
      port map(A => XOR2_74_Y, B => AO1_94_Y, Y => Mult(31));
    AND2_128 : AND2
      port map(A => AND2_73_Y, B => AND2_36_Y, Y => AND2_128_Y);
    AND2_251 : AND2
      port map(A => SumA_21_net, B => SumB_21_net, Y => 
        AND2_251_Y);
    XOR2_PP0_11_inst : XOR2
      port map(A => MX2_100_Y, B => BUFF_46_Y, Y => PP0_11_net);
    AND2_65 : AND2
      port map(A => XOR2_86_Y, B => XOR2_47_Y, Y => AND2_65_Y);
    XOR2_14 : XOR2
      port map(A => SumA_6_net, B => SumB_6_net, Y => XOR2_14_Y);
    MX2_137 : MX2
      port map(A => AND2_35_Y, B => BUFF_11_Y, S => NOR2_16_Y, 
        Y => MX2_137_Y);
    BUFF_27 : BUFF
      port map(A => DataB(3), Y => BUFF_27_Y);
    BUFF_3 : BUFF
      port map(A => DataA(21), Y => BUFF_3_Y);
    AND2_30 : AND2
      port map(A => NOR2_17_Y, B => BUFF_42_Y, Y => AND2_30_Y);
    AND2_PP8_20_inst : AND2
      port map(A => DataB(15), B => BUFF_10_Y, Y => PP8_20_net);
    AND2_282 : AND2
      port map(A => XOR2_65_Y, B => BUFF_65_Y, Y => AND2_282_Y);
    MX2_22 : MX2
      port map(A => AND2_180_Y, B => BUFF_21_Y, S => AND2A_2_Y, 
        Y => MX2_22_Y);
    MAJ3_7 : MAJ3
      port map(A => PP8_9_net, B => PP5_15_net, C => PP2_21_net, 
        Y => MAJ3_7_Y);
    BUFF_38 : BUFF
      port map(A => DataB(15), Y => BUFF_38_Y);
    MAJ3_81 : MAJ3
      port map(A => XOR3_83_Y, B => MAJ3_40_Y, C => MAJ3_2_Y, 
        Y => MAJ3_81_Y);
    AND2_28 : AND2
      port map(A => XOR2_18_Y, B => BUFF_77_Y, Y => AND2_28_Y);
    XOR2_PP2_21_inst : XOR2
      port map(A => MX2_18_Y, B => BUFF_14_Y, Y => PP2_21_net);
    MAJ3_15 : MAJ3
      port map(A => PP6_7_net, B => PP3_13_net, C => PP0_19_net, 
        Y => MAJ3_15_Y);
    XOR2_84 : XOR2
      port map(A => SumA_14_net, B => SumB_14_net, Y => XOR2_84_Y);
    XOR2_53 : XOR2
      port map(A => DataB(9), B => DataB(10), Y => XOR2_53_Y);
    AO1_102 : AO1
      port map(A => XOR2_15_Y, B => AO1_36_Y, C => AND2_283_Y, 
        Y => AO1_102_Y);
    MX2_51 : MX2
      port map(A => AND2_216_Y, B => BUFF_85_Y, S => NOR2_19_Y, 
        Y => MX2_51_Y);
    XOR2_4 : XOR2
      port map(A => SumA_13_net, B => SumB_13_net, Y => XOR2_4_Y);
    XOR2_PP5_11_inst : XOR2
      port map(A => MX2_20_Y, B => BUFF_78_Y, Y => PP5_11_net);
    AND2_259 : AND2
      port map(A => PP8_10_net, B => PP7_12_net, Y => AND2_259_Y);
    AO1_53 : AO1
      port map(A => XOR2_23_Y, B => AND2_106_Y, C => AND2_16_Y, 
        Y => AO1_53_Y);
    XOR2_59 : XOR2
      port map(A => DataB(5), B => DataB(6), Y => XOR2_59_Y);
    XOR3_88 : XOR3
      port map(A => PP4_17_net, B => E_1_net, C => PP7_11_net, 
        Y => XOR3_88_Y);
    XNOR2_13 : XNOR2
      port map(A => DataB(14), B => BUFF_83_Y, Y => XNOR2_13_Y);
    AND2_199 : AND2
      port map(A => XOR2_62_Y, B => BUFF_50_Y, Y => AND2_199_Y);
    XOR2_PP1_9_inst : XOR2
      port map(A => MX2_23_Y, B => BUFF_27_Y, Y => PP1_9_net);
    XOR3_13 : XOR3
      port map(A => MAJ3_78_Y, B => AND2_163_Y, C => XOR3_58_Y, 
        Y => XOR3_13_Y);
    AND2_277 : AND2
      port map(A => AND2_39_Y, B => AND2_323_Y, Y => AND2_277_Y);
    MX2_13 : MX2
      port map(A => AND2_274_Y, B => BUFF_64_Y, S => NOR2_4_Y, 
        Y => MX2_13_Y);
    MX2_141 : MX2
      port map(A => AND2_240_Y, B => BUFF_48_Y, S => NOR2_14_Y, 
        Y => MX2_141_Y);
    MX2_91 : MX2
      port map(A => AND2_329_Y, B => BUFF_30_Y, S => NOR2_16_Y, 
        Y => MX2_91_Y);
    AO1_83 : AO1
      port map(A => AND2_327_Y, B => AO1_48_Y, C => AO1_35_Y, 
        Y => AO1_83_Y);
    AO1_7 : AO1
      port map(A => XOR2_54_Y, B => AND2_66_Y, C => AND2_241_Y, 
        Y => AO1_7_Y);
    XOR2_Mult_34_inst : XOR2
      port map(A => XOR2_8_Y, B => AO1_18_Y, Y => Mult(34));
    MX2_58 : MX2
      port map(A => AND2_168_Y, B => BUFF_56_Y, S => NOR2_19_Y, 
        Y => MX2_58_Y);
    XOR3_19 : XOR3
      port map(A => MAJ3_30_Y, B => PP8_11_net, C => XOR3_94_Y, 
        Y => XOR3_19_Y);
    XOR2_PP5_6_inst : XOR2
      port map(A => MX2_123_Y, B => BUFF_87_Y, Y => PP5_6_net);
    BUFF_65 : BUFF
      port map(A => DataA(5), Y => BUFF_65_Y);
    XOR2_98 : XOR2
      port map(A => AND2_101_Y, B => BUFF_36_Y, Y => XOR2_98_Y);
    AND2_112 : AND2
      port map(A => XOR2_36_Y, B => BUFF_37_Y, Y => AND2_112_Y);
    XOR2_PP0_14_inst : XOR2
      port map(A => MX2_126_Y, B => BUFF_46_Y, Y => PP0_14_net);
    XOR2_PP4_19_inst : XOR2
      port map(A => MX2_104_Y, B => BUFF_19_Y, Y => PP4_19_net);
    BUFF_60 : BUFF
      port map(A => DataA(13), Y => BUFF_60_Y);
    MX2_77 : MX2
      port map(A => AND2_291_Y, B => BUFF_21_Y, S => NOR2_15_Y, 
        Y => MX2_77_Y);
    XOR3_SumB_18_inst : XOR3
      port map(A => MAJ3_3_Y, B => XOR3_23_Y, C => XOR3_117_Y, 
        Y => SumB_18_net);
    AND2_105 : AND2
      port map(A => DataB(0), B => BUFF_55_Y, Y => AND2_105_Y);
    AND2_52 : AND2
      port map(A => SumA_27_net, B => SumB_27_net, Y => AND2_52_Y);
    AND2_276 : AND2
      port map(A => XOR2_16_Y, B => BUFF_80_Y, Y => AND2_276_Y);
    MX2_98 : MX2
      port map(A => AND2_310_Y, B => BUFF_18_Y, S => NOR2_5_Y, 
        Y => MX2_98_Y);
    AO1_52 : AO1
      port map(A => AND2_323_Y, B => AO1_71_Y, C => AO1_40_Y, 
        Y => AO1_52_Y);
    MAJ3_36 : MAJ3
      port map(A => AND2_76_Y, B => PP7_17_net, C => PP5_21_net, 
        Y => MAJ3_36_Y);
    XOR2_57 : XOR2
      port map(A => DataB(9), B => DataB(10), Y => XOR2_57_Y);
    MX2_80 : MX2
      port map(A => AND2_263_Y, B => BUFF_69_Y, S => NOR2_14_Y, 
        Y => MX2_80_Y);
    AND2_PP8_3_inst : AND2
      port map(A => DataB(15), B => BUFF_70_Y, Y => PP8_3_net);
    XOR2_Mult_0_inst : XOR2
      port map(A => XOR2_61_Y, B => DataB(1), Y => Mult(0));
    AO1_41 : AO1
      port map(A => AND2_323_Y, B => AO1_71_Y, C => AO1_40_Y, 
        Y => AO1_41_Y);
    AO1_82 : AO1
      port map(A => AND2_318_Y, B => AO1_25_Y, C => AO1_1_Y, Y => 
        AO1_82_Y);
    AND2_1 : AND2
      port map(A => AND2_65_Y, B => AND2_88_Y, Y => AND2_1_Y);
    XOR2_PP4_12_inst : XOR2
      port map(A => MX2_110_Y, B => BUFF_61_Y, Y => PP4_12_net);
    MX2_67 : MX2
      port map(A => AND2_204_Y, B => BUFF_12_Y, S => NOR2_1_Y, 
        Y => MX2_67_Y);
    XOR2_PP5_14_inst : XOR2
      port map(A => MX2_112_Y, B => BUFF_78_Y, Y => PP5_14_net);
    AND2_7 : AND2
      port map(A => AND2_60_Y, B => AND2_165_Y, Y => AND2_7_Y);
    MAJ3_13 : MAJ3
      port map(A => PP8_5_net, B => PP5_11_net, C => PP2_17_net, 
        Y => MAJ3_13_Y);
    MAJ3_103 : MAJ3
      port map(A => MAJ3_4_Y, B => PP8_13_net, C => PP6_17_net, 
        Y => MAJ3_103_Y);
    AND2_204 : AND2
      port map(A => XOR2_53_Y, B => BUFF_60_Y, Y => AND2_204_Y);
    XOR3_17 : XOR3
      port map(A => PP3_14_net, B => PP0_20_net, C => PP6_8_net, 
        Y => XOR3_17_Y);
    MAJ3_47 : MAJ3
      port map(A => XOR3_34_Y, B => MAJ3_19_Y, C => MAJ3_116_Y, 
        Y => MAJ3_47_Y);
    XOR2_PP3_1_inst : XOR2
      port map(A => MX2_161_Y, B => BUFF_28_Y, Y => PP3_1_net);
    XOR2_PP0_6_inst : XOR2
      port map(A => MX2_129_Y, B => BUFF_52_Y, Y => PP0_6_net);
    AND2_100 : AND2
      port map(A => XOR2_53_Y, B => BUFF_33_Y, Y => AND2_100_Y);
    MAJ3_105 : MAJ3
      port map(A => S_3_net, B => PP3_1_net, C => PP2_3_net, Y => 
        MAJ3_105_Y);
    XOR2_15 : XOR2
      port map(A => SumA_22_net, B => SumB_22_net, Y => XOR2_15_Y);
    AND2_43 : AND2
      port map(A => XOR2_13_Y, B => BUFF_26_Y, Y => AND2_43_Y);
    XOR2_PP0_17_inst : XOR2
      port map(A => MX2_45_Y, B => BUFF_4_Y, Y => PP0_17_net);
    MAJ3_SumA_31_inst : MAJ3
      port map(A => XOR3_61_Y, B => MAJ3_86_Y, C => XOR3_104_Y, 
        Y => SumA_31_net);
    MAJ3_6 : MAJ3
      port map(A => PP6_9_net, B => PP3_15_net, C => PP0_21_net, 
        Y => MAJ3_6_Y);
    AO1_67 : AO1
      port map(A => XOR2_72_Y, B => AND2_133_Y, C => AND2_8_Y, 
        Y => AO1_67_Y);
    AND2_223 : AND2
      port map(A => XOR2_64_Y, B => BUFF_51_Y, Y => AND2_223_Y);
    BUFF_5 : BUFF
      port map(A => DataA(18), Y => BUFF_5_Y);
    MAJ3_SumA_21_inst : MAJ3
      port map(A => XOR3_79_Y, B => MAJ3_71_Y, C => XOR3_35_Y, 
        Y => SumA_21_net);
    AND2_217 : AND2
      port map(A => SumA_4_net, B => SumB_4_net, Y => AND2_217_Y);
    MX2_29 : MX2
      port map(A => AND2_284_Y, B => BUFF_81_Y, S => NOR2_11_Y, 
        Y => MX2_29_Y);
    MAJ3_5 : MAJ3
      port map(A => XOR3_109_Y, B => XOR3_73_Y, C => MAJ3_102_Y, 
        Y => MAJ3_5_Y);
    BUFF_58 : BUFF
      port map(A => DataA(14), Y => BUFF_58_Y);
    XOR2_85 : XOR2
      port map(A => SumA_20_net, B => SumB_20_net, Y => XOR2_85_Y);
    MX2_4 : MX2
      port map(A => AND2_12_Y, B => BUFF_75_Y, S => NOR2_20_Y, 
        Y => MX2_4_Y);
    XOR2_PP2_16_inst : XOR2
      port map(A => MX2_151_Y, B => BUFF_14_Y, Y => PP2_16_net);
    XOR2_106 : XOR2
      port map(A => PP7_22_net, B => VCC_1_net, Y => XOR2_106_Y);
    AND2_188 : AND2
      port map(A => AND2_170_Y, B => AND2_64_Y, Y => AND2_188_Y);
    AND2_144 : AND2
      port map(A => DataB(0), B => BUFF_53_Y, Y => AND2_144_Y);
    XOR2_Mult_23_inst : XOR2
      port map(A => XOR2_20_Y, B => AO1_77_Y, Y => Mult(23));
    AND2_PP8_4_inst : AND2
      port map(A => DataB(15), B => BUFF_11_Y, Y => PP8_4_net);
    XOR3_SumB_22_inst : XOR3
      port map(A => MAJ3_81_Y, B => XOR3_67_Y, C => XOR3_63_Y, 
        Y => SumB_22_net);
    NOR2_20 : NOR2
      port map(A => XOR2_59_Y, B => XNOR2_17_Y, Y => NOR2_20_Y);
    AND2_162 : AND2
      port map(A => XOR2_109_Y, B => BUFF_58_Y, Y => AND2_162_Y);
    XOR2_PP5_17_inst : XOR2
      port map(A => MX2_82_Y, B => BUFF_43_Y, Y => PP5_17_net);
    XOR2_PP2_2_inst : XOR2
      port map(A => MX2_149_Y, B => BUFF_62_Y, Y => PP2_2_net);
    MX2_149 : MX2
      port map(A => AND2_96_Y, B => BUFF_40_Y, S => NOR2_19_Y, 
        Y => MX2_149_Y);
    XOR3_92 : XOR3
      port map(A => MAJ3_88_Y, B => XOR2_19_Y, C => XOR3_72_Y, 
        Y => XOR3_92_Y);
    AND2_231 : AND2
      port map(A => XOR2_83_Y, B => BUFF_9_Y, Y => AND2_231_Y);
    AND2_216 : AND2
      port map(A => XOR2_105_Y, B => BUFF_23_Y, Y => AND2_216_Y);
    AND2_63 : AND2
      port map(A => AND2_225_Y, B => XOR2_107_Y, Y => AND2_63_Y);
    XOR2_PP1_0_inst : XOR2
      port map(A => XOR2_98_Y, B => DataB(3), Y => PP1_0_net);
    MX2_117 : MX2
      port map(A => AND2_330_Y, B => BUFF_50_Y, S => NOR2_3_Y, 
        Y => MX2_117_Y);
    NOR2_1 : NOR2
      port map(A => XOR2_53_Y, B => XNOR2_4_Y, Y => NOR2_1_Y);
    NOR2_17 : NOR2
      port map(A => XOR2_57_Y, B => XNOR2_3_Y, Y => NOR2_17_Y);
    BUFF_19 : BUFF
      port map(A => DataB(9), Y => BUFF_19_Y);
    AO1_68 : AO1
      port map(A => AND2_301_Y, B => AO1_23_Y, C => AO1_54_Y, 
        Y => AO1_68_Y);
    XNOR2_8 : XNOR2
      port map(A => DataB(4), B => BUFF_14_Y, Y => XNOR2_8_Y);
    BUFF_82 : BUFF
      port map(A => DataA(13), Y => BUFF_82_Y);
    AND2_109 : AND2
      port map(A => DataB(0), B => BUFF_34_Y, Y => AND2_109_Y);
    MAJ3_10 : MAJ3
      port map(A => PP5_19_net, B => PP4_21_net, C => E_3_net, 
        Y => MAJ3_10_Y);
    XOR3_113 : XOR3
      port map(A => XOR3_95_Y, B => MAJ3_28_Y, C => XOR3_17_Y, 
        Y => XOR3_113_Y);
    AND2_123 : AND2
      port map(A => AND2_304_Y, B => AND2_39_Y, Y => AND2_123_Y);
    XOR2_PP1_22_inst : XOR2
      port map(A => AND2_111_Y, B => BUFF_74_Y, Y => PP1_22_net);
    MAJ3_26 : MAJ3
      port map(A => PP7_6_net, B => PP4_12_net, C => PP1_18_net, 
        Y => MAJ3_26_Y);
    NOR2_8 : NOR2
      port map(A => XOR2_81_Y, B => XNOR2_8_Y, Y => NOR2_8_Y);
    XOR3_41 : XOR3
      port map(A => PP4_21_net, B => E_3_net, C => PP5_19_net, 
        Y => XOR3_41_Y);
    MX2_32 : MX2
      port map(A => AND2_167_Y, B => BUFF_54_Y, S => NOR2_0_Y, 
        Y => MX2_32_Y);
    XOR3_61 : XOR3
      port map(A => MAJ3_94_Y, B => MAJ3_22_Y, C => XOR3_87_Y, 
        Y => XOR3_61_Y);
    AND2_141 : AND2
      port map(A => XOR2_62_Y, B => BUFF_65_Y, Y => AND2_141_Y);
    AND2_239 : AND2
      port map(A => XOR2_6_Y, B => BUFF_70_Y, Y => AND2_239_Y);
    AO1_74 : AO1
      port map(A => AND2_267_Y, B => AO1_98_Y, C => AO1_26_Y, 
        Y => AO1_74_Y);
    MX2_104 : MX2
      port map(A => AND2_86_Y, B => BUFF_5_Y, S => NOR2_14_Y, 
        Y => MX2_104_Y);
    AND2_320 : AND2
      port map(A => XOR2_6_Y, B => BUFF_68_Y, Y => AND2_320_Y);
    AND2_272 : AND2
      port map(A => XOR2_101_Y, B => XOR2_43_Y, Y => AND2_272_Y);
    AND2_95 : AND2
      port map(A => SumA_9_net, B => SumB_9_net, Y => AND2_95_Y);
    XOR2_22 : XOR2
      port map(A => SumA_16_net, B => SumB_16_net, Y => XOR2_22_Y);
    MX2_86 : MX2
      port map(A => AND2_210_Y, B => BUFF_55_Y, S => NOR2_19_Y, 
        Y => MX2_86_Y);
    MX2_11 : MX2
      port map(A => AND2_275_Y, B => BUFF_15_Y, S => NOR2_0_Y, 
        Y => MX2_11_Y);
    MX2_153 : MX2
      port map(A => AND2_3_Y, B => BUFF_68_Y, S => NOR2_16_Y, 
        Y => MX2_153_Y);
    AND2_27 : AND2
      port map(A => DataB(0), B => BUFF_56_Y, Y => AND2_27_Y);
    AND2_267 : AND2
      port map(A => XOR2_11_Y, B => XOR2_80_Y, Y => AND2_267_Y);
    MAJ3_49 : MAJ3
      port map(A => XOR3_87_Y, B => MAJ3_94_Y, C => MAJ3_22_Y, 
        Y => MAJ3_49_Y);
    BUFF_29 : BUFF
      port map(A => DataA(5), Y => BUFF_29_Y);
    XOR2_32 : XOR2
      port map(A => SumA_8_net, B => SumB_8_net, Y => XOR2_32_Y);
    MAJ3_48 : MAJ3
      port map(A => XOR3_99_Y, B => MAJ3_17_Y, C => AND2_259_Y, 
        Y => MAJ3_48_Y);
    AND2_14 : AND2
      port map(A => DataB(0), B => BUFF_86_Y, Y => AND2_14_Y);
    XOR3_96 : XOR3
      port map(A => MAJ3_47_Y, B => MAJ3_70_Y, C => XOR3_26_Y, 
        Y => XOR3_96_Y);
    MAJ3_76 : MAJ3
      port map(A => PP6_20_net, B => PP5_22_net, C => VCC_1_net, 
        Y => MAJ3_76_Y);
    XOR2_PP6_1_inst : XOR2
      port map(A => MX2_114_Y, B => BUFF_35_Y, Y => PP6_1_net);
    XOR2_Mult_20_inst : XOR2
      port map(A => XOR2_89_Y, B => AO1_86_Y, Y => Mult(20));
    AND2_74 : AND2
      port map(A => XOR2_85_Y, B => XOR2_30_Y, Y => AND2_74_Y);
    AND2_82 : AND2
      port map(A => XOR2_90_Y, B => BUFF_15_Y, Y => AND2_82_Y);
    AND2_58 : AND2
      port map(A => XOR2_33_Y, B => BUFF_15_Y, Y => AND2_58_Y);
    XOR2_10 : XOR2
      port map(A => PP6_16_net, B => PP5_18_net, Y => XOR2_10_Y);
    MX2_18 : MX2
      port map(A => AND2_24_Y, B => BUFF_6_Y, S => NOR2_8_Y, Y => 
        MX2_18_Y);
    AND2_245 : AND2
      port map(A => DataB(0), B => BUFF_73_Y, Y => AND2_245_Y);
    XOR3_28 : XOR3
      port map(A => MAJ3_11_Y, B => MAJ3_25_Y, C => XOR3_11_Y, 
        Y => XOR3_28_Y);
    XNOR2_9 : XNOR2
      port map(A => DataB(8), B => BUFF_61_Y, Y => XNOR2_9_Y);
    MAJ3_87 : MAJ3
      port map(A => XOR3_14_Y, B => MAJ3_92_Y, C => PP7_0_net, 
        Y => MAJ3_87_Y);
    XOR2_PP3_6_inst : XOR2
      port map(A => MX2_140_Y, B => BUFF_28_Y, Y => PP3_6_net);
    AO1_20 : AO1
      port map(A => AND2_36_Y, B => AO1_42_Y, C => AO1_75_Y, Y => 
        AO1_20_Y);
    BUFF_72 : BUFF
      port map(A => DataA(9), Y => BUFF_72_Y);
    AND2_266 : AND2
      port map(A => AND2_253_Y, B => AND2_123_Y, Y => AND2_266_Y);
    XOR3_110 : XOR3
      port map(A => XOR3_31_Y, B => MAJ3_110_Y, C => XOR3_0_Y, 
        Y => XOR3_110_Y);
    XOR2_PP1_13_inst : XOR2
      port map(A => MX2_74_Y, B => BUFF_27_Y, Y => PP1_13_net);
    XOR3_38 : XOR3
      port map(A => MAJ3_41_Y, B => MAJ3_53_Y, C => XOR3_78_Y, 
        Y => XOR3_38_Y);
    MX2_126 : MX2
      port map(A => AND2_119_Y, B => BUFF_34_Y, S => AND2A_2_Y, 
        Y => MX2_126_Y);
    XOR2_80 : XOR2
      port map(A => SumA_33_net, B => SumB_33_net, Y => XOR2_80_Y);
    MX2_125 : MX2
      port map(A => AND2_193_Y, B => BUFF_84_Y, S => NOR2_1_Y, 
        Y => MX2_125_Y);
    XOR2_Mult_22_inst : XOR2
      port map(A => XOR2_25_Y, B => AO1_46_Y, Y => Mult(22));
    MX2_73 : MX2
      port map(A => AND2_141_Y, B => BUFF_13_Y, S => NOR2_3_Y, 
        Y => MX2_73_Y);
    XNOR2_12 : XNOR2
      port map(A => DataB(4), B => BUFF_62_Y, Y => XNOR2_12_Y);
    AND2_S_4_inst : AND2
      port map(A => XOR2_0_Y, B => DataB(9), Y => S_4_net);
    XOR2_26 : XOR2
      port map(A => SumA_15_net, B => SumB_15_net, Y => XOR2_26_Y);
    AND2_283 : AND2
      port map(A => SumA_22_net, B => SumB_22_net, Y => 
        AND2_283_Y);
    AO1_79 : AO1
      port map(A => AND2_130_Y, B => AO1_15_Y, C => AO1_8_Y, Y => 
        AO1_79_Y);
    AND2_308 : AND2
      port map(A => AND2_170_Y, B => AND2_130_Y, Y => AND2_308_Y);
    XOR2_PP2_1_inst : XOR2
      port map(A => MX2_58_Y, B => BUFF_62_Y, Y => PP2_1_net);
    AND2_212 : AND2
      port map(A => XOR2_28_Y, B => BUFF_31_Y, Y => AND2_212_Y);
    XOR2_36 : XOR2
      port map(A => DataB(7), B => DataB(8), Y => XOR2_36_Y);
    XOR2_PP7_16_inst : XOR2
      port map(A => MX2_5_Y, B => BUFF_83_Y, Y => PP7_16_net);
    MX2_44 : MX2
      port map(A => AND2_50_Y, B => BUFF_89_Y, S => NOR2_4_Y, 
        Y => MX2_44_Y);
    AND2_21 : AND2
      port map(A => AND2_65_Y, B => AND2_88_Y, Y => AND2_21_Y);
    BUFF_34 : BUFF
      port map(A => DataA(13), Y => BUFF_34_Y);
    MAJ3_35 : MAJ3
      port map(A => PP2_8_net, B => PP1_10_net, C => PP0_12_net, 
        Y => MAJ3_35_Y);
    XOR2_PP2_10_inst : XOR2
      port map(A => MX2_103_Y, B => BUFF_57_Y, Y => PP2_10_net);
    AO1_57 : AO1
      port map(A => XOR2_51_Y, B => AND2_120_Y, C => AND2_195_Y, 
        Y => AO1_57_Y);
    MX2_63 : MX2
      port map(A => AND2_108_Y, B => BUFF_15_Y, S => NOR2_7_Y, 
        Y => MX2_63_Y);
    XOR2_PP7_21_inst : XOR2
      port map(A => MX2_76_Y, B => BUFF_83_Y, Y => PP7_21_net);
    MX2_39 : MX2
      port map(A => AND2_254_Y, B => BUFF_76_Y, S => NOR2_16_Y, 
        Y => MX2_39_Y);
    MX2_148 : MX2
      port map(A => AND2_43_Y, B => BUFF_32_Y, S => NOR2_11_Y, 
        Y => MX2_148_Y);
    MX2_101 : MX2
      port map(A => AND2_181_Y, B => BUFF_48_Y, S => NOR2_20_Y, 
        Y => MX2_101_Y);
    AND2_192 : AND2
      port map(A => XOR2_18_Y, B => BUFF_20_Y, Y => AND2_192_Y);
    XOR3_54 : XOR3
      port map(A => PP3_20_net, B => VCC_1_net, C => PP5_16_net, 
        Y => XOR3_54_Y);
    AND2_3 : AND2
      port map(A => XOR2_6_Y, B => BUFF_30_Y, Y => AND2_3_Y);
    XOR2_PP1_6_inst : XOR2
      port map(A => MX2_30_Y, B => BUFF_36_Y, Y => PP1_6_net);
    AO1_87 : AO1
      port map(A => XOR2_96_Y, B => AO1_26_Y, C => AND2_120_Y, 
        Y => AO1_87_Y);
    XOR3_SumB_10_inst : XOR3
      port map(A => MAJ3_114_Y, B => XOR3_76_Y, C => XOR3_84_Y, 
        Y => SumB_10_net);
    AND2_PP8_17_inst : AND2
      port map(A => DataB(15), B => BUFF_54_Y, Y => PP8_17_net);
    XOR2_PP3_16_inst : XOR2
      port map(A => MX2_4_Y, B => BUFF_67_Y, Y => PP3_16_net);
    AND2_S_6_inst : AND2
      port map(A => XOR2_3_Y, B => DataB(13), Y => S_6_net);
    XOR2_Mult_33_inst : XOR2
      port map(A => XOR2_42_Y, B => AO1_98_Y, Y => Mult(33));
    AND2_220 : AND2
      port map(A => XOR2_13_Y, B => BUFF_32_Y, Y => AND2_220_Y);
    MX2_164 : MX2
      port map(A => AND2_326_Y, B => BUFF_76_Y, S => NOR2_9_Y, 
        Y => MX2_164_Y);
    XOR2_102 : XOR2
      port map(A => SumA_24_net, B => SumB_24_net, Y => 
        XOR2_102_Y);
    XOR2_PP7_3_inst : XOR2
      port map(A => MX2_52_Y, B => BUFF_44_Y, Y => PP7_3_net);
    MAJ3_114 : MAJ3
      port map(A => XOR3_37_Y, B => MAJ3_95_Y, C => AND2_306_Y, 
        Y => MAJ3_114_Y);
    MX2_152 : MX2
      port map(A => AND2_162_Y, B => BUFF_60_Y, S => NOR2_10_Y, 
        Y => MX2_152_Y);
    AND2_183 : AND2
      port map(A => XOR2_58_Y, B => BUFF_23_Y, Y => AND2_183_Y);
    MAJ3_66 : MAJ3
      port map(A => PP8_4_net, B => PP5_10_net, C => PP2_16_net, 
        Y => MAJ3_66_Y);
    AND2_178 : AND2
      port map(A => XOR2_53_Y, B => BUFF_25_Y, Y => AND2_178_Y);
    MAJ3_56 : MAJ3
      port map(A => XOR3_66_Y, B => MAJ3_42_Y, C => MAJ3_5_Y, 
        Y => MAJ3_56_Y);
    AO1_58 : AO1
      port map(A => AND2_268_Y, B => AO1_24_Y, C => AO1_91_Y, 
        Y => AO1_58_Y);
    XOR2_PP3_4_inst : XOR2
      port map(A => MX2_98_Y, B => BUFF_28_Y, Y => PP3_4_net);
    MAJ3_89 : MAJ3
      port map(A => XOR2_77_Y, B => PP8_18_net, C => PP7_20_net, 
        Y => MAJ3_89_Y);
    AO1_25 : AO1
      port map(A => AND2_172_Y, B => AO1_95_Y, C => AO1_21_Y, 
        Y => AO1_25_Y);
    MAJ3_88 : MAJ3
      port map(A => PP4_6_net, B => PP2_10_net, C => PP0_14_net, 
        Y => MAJ3_88_Y);
    MAJ3_SumA_15_inst : MAJ3
      port map(A => XOR3_53_Y, B => MAJ3_117_Y, C => XOR3_93_Y, 
        Y => SumA_15_net);
    XOR2_78 : XOR2
      port map(A => SumA_30_net, B => SumB_30_net, Y => XOR2_78_Y);
    AND2_PP8_19_inst : AND2
      port map(A => DataB(15), B => BUFF_15_Y, Y => PP8_19_net);
    AO1_88 : AO1
      port map(A => XOR2_76_Y, B => AND2_217_Y, C => AND2_122_Y, 
        Y => AO1_88_Y);
    XOR2_PP6_22_inst : XOR2
      port map(A => AND2_124_Y, B => BUFF_71_Y, Y => PP6_22_net);
    AND2_297 : AND2
      port map(A => AND2_135_Y, B => XOR2_101_Y, Y => AND2_297_Y);
    AND2_93 : AND2
      port map(A => XOR2_81_Y, B => BUFF_0_Y, Y => AND2_93_Y);
    AND2_262 : AND2
      port map(A => NOR2_14_Y, B => BUFF_42_Y, Y => AND2_262_Y);
    BUFF_86 : BUFF
      port map(A => DataA(15), Y => BUFF_86_Y);
    MAJ3_SumA_28_inst : MAJ3
      port map(A => XOR3_81_Y, B => MAJ3_67_Y, C => XOR3_27_Y, 
        Y => SumA_28_net);
    AND2A_0 : AND2A
      port map(A => DataB(0), B => BUFF_4_Y, Y => AND2A_0_Y);
    XOR3_74 : XOR3
      port map(A => PP5_7_net, B => PP2_13_net, C => PP8_1_net, 
        Y => XOR3_74_Y);
    XOR2_51 : XOR2
      port map(A => SumA_35_net, B => SumB_35_net, Y => XOR2_51_Y);
    AND2_26 : AND2
      port map(A => XOR2_53_Y, B => BUFF_58_Y, Y => AND2_26_Y);
    XOR3_9 : XOR3
      port map(A => MAJ3_64_Y, B => PP8_12_net, C => XOR3_18_Y, 
        Y => XOR3_9_Y);
    MAJ3_33 : MAJ3
      port map(A => MAJ3_76_Y, B => AND2_249_Y, C => PP8_17_net, 
        Y => MAJ3_33_Y);
    XOR2_104 : XOR2
      port map(A => SumA_20_net, B => SumB_20_net, Y => 
        XOR2_104_Y);
    AND2_88 : AND2
      port map(A => XOR2_9_Y, B => XOR2_54_Y, Y => AND2_88_Y);
    MAJ3_25 : MAJ3
      port map(A => XOR3_25_Y, B => XOR2_44_Y, C => PP6_1_net, 
        Y => MAJ3_25_Y);
    AND2_228 : AND2
      port map(A => AND2_253_Y, B => AND2_222_Y, Y => AND2_228_Y);
    XOR2_PP4_8_inst : XOR2
      port map(A => MX2_93_Y, B => BUFF_61_Y, Y => PP4_8_net);
    XOR2_111 : XOR2
      port map(A => PP0_1_net, B => S_0_net, Y => XOR2_111_Y);
    XOR2_Mult_30_inst : XOR2
      port map(A => XOR2_52_Y, B => AO1_2_Y, Y => Mult(30));
    AND2_296 : AND2
      port map(A => XOR2_64_Y, B => BUFF_70_Y, Y => AND2_296_Y);
    XOR3_11 : XOR3
      port map(A => MAJ3_92_Y, B => PP7_0_net, C => XOR3_14_Y, 
        Y => XOR3_11_Y);
    AND2_S_0_inst : AND2
      port map(A => XOR2_61_Y, B => DataB(1), Y => S_0_net);
    MX2_109 : MX2
      port map(A => AND2_243_Y, B => BUFF_79_Y, S => NOR2_14_Y, 
        Y => MX2_109_Y);
    BUFF_54 : BUFF
      port map(A => DataA(17), Y => BUFF_54_Y);
    XOR3_42 : XOR3
      port map(A => MAJ3_21_Y, B => MAJ3_107_Y, C => XOR3_50_Y, 
        Y => XOR3_42_Y);
    XOR3_62 : XOR3
      port map(A => PP5_1_net, B => PP3_5_net, C => XOR2_24_Y, 
        Y => XOR3_62_Y);
    AND2_118 : AND2
      port map(A => XOR2_78_Y, B => XOR2_23_Y, Y => AND2_118_Y);
    MX2_161 : MX2
      port map(A => AND2_6_Y, B => BUFF_24_Y, S => NOR2_5_Y, Y => 
        MX2_161_Y);
    XOR2_13 : XOR2
      port map(A => DataB(3), B => DataB(4), Y => XOR2_13_Y);
    XOR2_2 : XOR2
      port map(A => DataB(7), B => DataB(8), Y => XOR2_2_Y);
    MX2_87 : MX2
      port map(A => AND2_37_Y, B => BUFF_25_Y, S => NOR2_10_Y, 
        Y => MX2_87_Y);
    XOR3_55 : XOR3
      port map(A => MAJ3_6_Y, B => MAJ3_13_Y, C => XOR3_51_Y, 
        Y => XOR3_55_Y);
    XOR2_Mult_19_inst : XOR2
      port map(A => XOR2_7_Y, B => AO1_61_Y, Y => Mult(19));
    BUFF_42 : BUFF
      port map(A => DataA(21), Y => BUFF_42_Y);
    AND2_57 : AND2
      port map(A => XOR2_33_Y, B => BUFF_17_Y, Y => AND2_57_Y);
    MX2_71 : MX2
      port map(A => AND2_23_Y, B => BUFF_45_Y, S => NOR2_0_Y, 
        Y => MX2_71_Y);
    XOR3_107 : XOR3
      port map(A => MAJ3_80_Y, B => MAJ3_98_Y, C => XOR3_102_Y, 
        Y => XOR3_107_Y);
    MAJ3_75 : MAJ3
      port map(A => PP8_6_net, B => PP5_12_net, C => PP2_18_net, 
        Y => MAJ3_75_Y);
    AND2_34 : AND2
      port map(A => XOR2_83_Y, B => BUFF_82_Y, Y => AND2_34_Y);
    XOR2_3 : XOR2
      port map(A => AND2_132_Y, B => BUFF_35_Y, Y => XOR2_3_Y);
    XOR2_Mult_32_inst : XOR2
      port map(A => XOR2_1_Y, B => AO1_65_Y, Y => Mult(32));
    XOR2_PP7_10_inst : XOR2
      port map(A => MX2_44_Y, B => BUFF_38_Y, Y => PP7_10_net);
    XOR2_19 : XOR2
      port map(A => PP7_1_net, B => PP6_3_net, Y => XOR2_19_Y);
    AND2_102 : AND2
      port map(A => AND2_203_Y, B => AND2_172_Y, Y => AND2_102_Y);
    AO1_2 : AO1
      port map(A => AND2_20_Y, B => AO1_15_Y, C => AO1_39_Y, Y => 
        AO1_2_Y);
    XOR2_PP3_7_inst : XOR2
      port map(A => MX2_124_Y, B => BUFF_28_Y, Y => PP3_7_net);
    XOR2_83 : XOR2
      port map(A => DataB(13), B => DataB(14), Y => XOR2_83_Y);
    MAJ3_30 : MAJ3
      port map(A => PP6_14_net, B => PP4_18_net, C => PP2_22_net, 
        Y => MAJ3_30_Y);
    BUFF_76 : BUFF
      port map(A => DataA(6), Y => BUFF_76_Y);
    XNOR2_3 : XNOR2
      port map(A => DataB(10), B => BUFF_43_Y, Y => XNOR2_3_Y);
    AO1_61 : AO1
      port map(A => AND2_65_Y, B => AO1_83_Y, C => AO1_96_Y, Y => 
        AO1_61_Y);
    XOR2_Mult_27_inst : XOR2
      port map(A => XOR2_99_Y, B => AO1_37_Y, Y => Mult(27));
    XOR2_68 : XOR2
      port map(A => SumA_17_net, B => SumB_17_net, Y => XOR2_68_Y);
    MX2_61 : MX2
      port map(A => AND2_313_Y, B => BUFF_60_Y, S => NOR2_13_Y, 
        Y => MX2_61_Y);
    XOR2_PP0_4_inst : XOR2
      port map(A => MX2_106_Y, B => BUFF_52_Y, Y => PP0_4_net);
    MX2_78 : MX2
      port map(A => AND2_137_Y, B => BUFF_58_Y, S => NOR2_13_Y, 
        Y => MX2_78_Y);
    MAJ3_92 : MAJ3
      port map(A => PP2_9_net, B => PP1_11_net, C => PP0_13_net, 
        Y => MAJ3_92_Y);
    XOR2_89 : XOR2
      port map(A => SumA_19_net, B => SumB_19_net, Y => XOR2_89_Y);
    XOR2_PP3_10_inst : XOR2
      port map(A => MX2_130_Y, B => BUFF_16_Y, Y => PP3_10_net);
    XOR2_PP1_8_inst : XOR2
      port map(A => MX2_77_Y, B => BUFF_27_Y, Y => PP1_8_net);
    XOR2_PP7_4_inst : XOR2
      port map(A => MX2_118_Y, B => BUFF_44_Y, Y => PP7_4_net);
    AND2_280 : AND2
      port map(A => XOR2_16_Y, B => BUFF_86_Y, Y => AND2_280_Y);
    BUFF_9 : BUFF
      port map(A => DataA(12), Y => BUFF_9_Y);
    AND2_273 : AND2
      port map(A => XOR2_83_Y, B => BUFF_64_Y, Y => AND2_273_Y);
    MAJ3_23 : MAJ3
      port map(A => XOR3_49_Y, B => MAJ3_46_Y, C => MAJ3_68_Y, 
        Y => MAJ3_23_Y);
    AO1_33 : AO1
      port map(A => AND2_36_Y, B => AO1_93_Y, C => AO1_75_Y, Y => 
        AO1_33_Y);
    BUFF_35 : BUFF
      port map(A => DataB(13), Y => BUFF_35_Y);
    AND2_126 : AND2
      port map(A => XOR2_18_Y, B => BUFF_3_Y, Y => AND2_126_Y);
    XOR2_PP3_9_inst : XOR2
      port map(A => MX2_144_Y, B => BUFF_16_Y, Y => PP3_9_net);
    XOR2_PP6_11_inst : XOR2
      port map(A => MX2_48_Y, B => BUFF_22_Y, Y => PP6_11_net);
    XOR3_46 : XOR3
      port map(A => PP1_10_net, B => PP0_12_net, C => PP2_8_net, 
        Y => XOR3_46_Y);
    BUFF_30 : BUFF
      port map(A => DataA(1), Y => BUFF_30_Y);
    XOR3_66 : XOR3
      port map(A => XOR3_74_Y, B => MAJ3_100_Y, C => XOR3_39_Y, 
        Y => XOR3_66_Y);
    MX2_68 : MX2
      port map(A => AND2_153_Y, B => BUFF_1_Y, S => NOR2_12_Y, 
        Y => MX2_68_Y);
    MX2_25 : MX2
      port map(A => AND2_84_Y, B => BUFF_70_Y, S => NOR2_9_Y, 
        Y => MX2_25_Y);
    XOR3_SumB_14_inst : XOR3
      port map(A => MAJ3_117_Y, B => XOR3_93_Y, C => XOR3_53_Y, 
        Y => SumB_14_net);
    XOR2_17 : XOR2
      port map(A => DataB(11), B => DataB(12), Y => XOR2_17_Y);
    XOR2_113 : XOR2
      port map(A => SumA_11_net, B => SumB_11_net, Y => 
        XOR2_113_Y);
    XOR3_SumB_30_inst : XOR3
      port map(A => MAJ3_86_Y, B => XOR3_104_Y, C => XOR3_61_Y, 
        Y => SumB_30_net);
    XOR3_75 : XOR3
      port map(A => PP5_15_net, B => PP2_21_net, C => PP8_9_net, 
        Y => XOR3_75_Y);
    XOR3_SumB_15_inst : XOR3
      port map(A => MAJ3_93_Y, B => XOR3_13_Y, C => XOR3_114_Y, 
        Y => SumB_15_net);
    AND2_207 : AND2
      port map(A => XOR2_105_Y, B => BUFF_21_Y, Y => AND2_207_Y);
    XOR2_PP0_15_inst : XOR2
      port map(A => MX2_75_Y, B => BUFF_46_Y, Y => PP0_15_net);
    AND2_154 : AND2
      port map(A => AND2_73_Y, B => AND2_36_Y, Y => AND2_154_Y);
    AND2_335 : AND2
      port map(A => XOR2_28_Y, B => BUFF_18_Y, Y => AND2_335_Y);
    XOR2_PP0_22_inst : XOR2
      port map(A => AND2_138_Y, B => BUFF_4_Y, Y => PP0_22_net);
    AND2_145 : AND2
      port map(A => XOR2_17_Y, B => BUFF_45_Y, Y => AND2_145_Y);
    AND2_168 : AND2
      port map(A => XOR2_105_Y, B => BUFF_40_Y, Y => AND2_168_Y);
    AND2_51 : AND2
      port map(A => AND2_73_Y, B => AND2_36_Y, Y => AND2_51_Y);
    AO1_10 : AO1
      port map(A => XOR2_85_Y, B => AO1_99_Y, C => AND2_5_Y, Y => 
        AO1_10_Y);
    XOR2_87 : XOR2
      port map(A => SumA_23_net, B => SumB_23_net, Y => XOR2_87_Y);
    XOR2_PP5_8_inst : XOR2
      port map(A => MX2_125_Y, B => BUFF_78_Y, Y => PP5_8_net);
    AO1_32 : AO1
      port map(A => XOR2_66_Y, B => AO1_0_Y, C => AND2_331_Y, 
        Y => AO1_32_Y);
    MAJ3_73 : MAJ3
      port map(A => PP7_4_net, B => PP4_10_net, C => PP1_16_net, 
        Y => MAJ3_73_Y);
    AND2_292 : AND2
      port map(A => XOR2_16_Y, B => BUFF_26_Y, Y => AND2_292_Y);
    NOR2_18 : NOR2
      port map(A => XOR2_58_Y, B => XNOR2_16_Y, Y => NOR2_18_Y);
    XOR2_PP6_7_inst : XOR2
      port map(A => MX2_164_Y, B => BUFF_35_Y, Y => PP6_7_net);
    AO1_76 : AO1
      port map(A => AND2_222_Y, B => AO1_50_Y, C => AO1_12_Y, 
        Y => AO1_76_Y);
    BUFF_1 : BUFF
      port map(A => DataA(7), Y => BUFF_1_Y);
    MAJ3_14 : MAJ3
      port map(A => XOR3_9_Y, B => MAJ3_29_Y, C => MAJ3_48_Y, 
        Y => MAJ3_14_Y);
    INV_E_2_inst : INV
      port map(A => DataB(5), Y => E_2_net);
    AND2_173 : AND2
      port map(A => SumA_7_net, B => SumB_7_net, Y => AND2_173_Y);
    AND2_29 : AND2
      port map(A => XOR2_59_Y, B => BUFF_39_Y, Y => AND2_29_Y);
    AND2_327 : AND2
      port map(A => AND2_60_Y, B => AND2_305_Y, Y => AND2_327_Y);
    AND2_206 : AND2
      port map(A => XOR2_57_Y, B => BUFF_48_Y, Y => AND2_206_Y);
    BUFF_18 : BUFF
      port map(A => DataA(3), Y => BUFF_18_Y);
    XOR2_PP0_18_inst : XOR2
      port map(A => MX2_56_Y, B => BUFF_4_Y, Y => PP0_18_net);
    AND2_244 : AND2
      port map(A => AND2_277_Y, B => AND2_152_Y, Y => AND2_244_Y);
    XOR2_PP5_15_inst : XOR2
      port map(A => MX2_92_Y, B => BUFF_78_Y, Y => PP5_15_net);
    AND2_PP8_12_inst : AND2
      port map(A => DataB(15), B => BUFF_9_Y, Y => PP8_12_net);
    MX2_40 : MX2
      port map(A => AND2_160_Y, B => BUFF_63_Y, S => NOR2_5_Y, 
        Y => MX2_40_Y);
    AND2_140 : AND2
      port map(A => AND2_78_Y, B => AND2_268_Y, Y => AND2_140_Y);
    AND2_288 : AND2
      port map(A => AND2_102_Y, B => AND2_179_Y, Y => AND2_288_Y);
    XOR2_PP1_5_inst : XOR2
      port map(A => MX2_163_Y, B => BUFF_36_Y, Y => PP1_5_net);
    MAJ3_20 : MAJ3
      port map(A => PP7_3_net, B => PP4_9_net, C => PP1_15_net, 
        Y => MAJ3_20_Y);
    MAJ3_65 : MAJ3
      port map(A => PP8_15_net, B => PP6_19_net, C => E_4_net, 
        Y => MAJ3_65_Y);
    AND2_151 : AND2
      port map(A => DataB(0), B => BUFF_85_Y, Y => AND2_151_Y);
    MAJ3_55 : MAJ3
      port map(A => PP7_10_net, B => PP4_16_net, C => PP1_22_net, 
        Y => MAJ3_55_Y);
    XOR3_50 : XOR3
      port map(A => MAJ3_17_Y, B => AND2_259_Y, C => XOR3_99_Y, 
        Y => XOR3_50_Y);
    AND2_213 : AND2
      port map(A => DataB(0), B => BUFF_41_Y, Y => AND2_213_Y);
    XOR2_PP6_14_inst : XOR2
      port map(A => MX2_162_Y, B => BUFF_22_Y, Y => PP6_14_net);
    MX2_108 : MX2
      port map(A => AND2_91_Y, B => BUFF_29_Y, S => NOR2_9_Y, 
        Y => MX2_108_Y);
    XOR2_PP1_3_inst : XOR2
      port map(A => MX2_69_Y, B => BUFF_36_Y, Y => PP1_3_net);
    XOR3_SumB_21_inst : XOR3
      port map(A => MAJ3_43_Y, B => XOR3_55_Y, C => XOR3_12_Y, 
        Y => SumB_21_net);
    XOR2_PP2_5_inst : XOR2
      port map(A => MX2_36_Y, B => BUFF_62_Y, Y => PP2_5_net);
    XOR3_SumB_9_inst : XOR3
      port map(A => MAJ3_99_Y, B => XOR3_40_Y, C => XOR3_97_Y, 
        Y => SumB_9_net);
    XOR2_PP2_7_inst : XOR2
      port map(A => MX2_53_Y, B => BUFF_62_Y, Y => PP2_7_net);
    XOR2_PP5_18_inst : XOR2
      port map(A => MX2_49_Y, B => BUFF_43_Y, Y => PP5_18_net);
    XOR2_PP1_19_inst : XOR2
      port map(A => MX2_50_Y, B => BUFF_74_Y, Y => PP1_19_net);
    BUFF_2 : BUFF
      port map(A => DataA(11), Y => BUFF_2_Y);
    AND2_15 : AND2
      port map(A => SumA_17_net, B => SumB_17_net, Y => AND2_15_Y);
    AND2_87 : AND2
      port map(A => DataB(0), B => BUFF_23_Y, Y => AND2_87_Y);
    AO1_90 : AO1
      port map(A => AND2_327_Y, B => AO1_48_Y, C => AO1_35_Y, 
        Y => AO1_90_Y);
    XOR2_PP4_21_inst : XOR2
      port map(A => MX2_60_Y, B => BUFF_19_Y, Y => PP4_21_net);
    BUFF_28 : BUFF
      port map(A => DataB(7), Y => BUFF_28_Y);
    XOR2_PP4_4_inst : XOR2
      port map(A => MX2_134_Y, B => BUFF_66_Y, Y => PP4_4_net);
    AND2_75 : AND2
      port map(A => AND2_74_Y, B => XOR2_15_Y, Y => AND2_75_Y);
    AND2_127 : AND2
      port map(A => XOR2_53_Y, B => BUFF_75_Y, Y => AND2_127_Y);
    AO1_24 : AO1
      port map(A => AND2_301_Y, B => AO1_23_Y, C => AO1_54_Y, 
        Y => AO1_24_Y);
    AND2_321 : AND2
      port map(A => XOR2_65_Y, B => BUFF_84_Y, Y => AND2_321_Y);
    BUFF_0 : BUFF
      port map(A => DataA(18), Y => BUFF_0_Y);
    MAJ3_70 : MAJ3
      port map(A => XOR3_39_Y, B => XOR3_74_Y, C => MAJ3_100_Y, 
        Y => MAJ3_70_Y);
    XOR3_105 : XOR3
      port map(A => MAJ3_62_Y, B => MAJ3_7_Y, C => XOR3_54_Y, 
        Y => XOR3_105_Y);
    BUFF_55 : BUFF
      port map(A => DataA(3), Y => BUFF_55_Y);
    AND2_255 : AND2
      port map(A => DataB(0), B => BUFF_20_Y, Y => AND2_255_Y);
    AND2_56 : AND2
      port map(A => DataB(0), B => BUFF_6_Y, Y => AND2_56_Y);
    BUFF_50 : BUFF
      port map(A => DataA(2), Y => BUFF_50_Y);
    XOR2_PP2_9_inst : XOR2
      port map(A => MX2_148_Y, B => BUFF_57_Y, Y => PP2_9_net);
    AND2_149 : AND2
      port map(A => AND2_85_Y, B => AND2_136_Y, Y => AND2_149_Y);
    XOR2_PP6_17_inst : XOR2
      port map(A => MX2_12_Y, B => BUFF_71_Y, Y => PP6_17_net);
    MX2_143 : MX2
      port map(A => AND2_273_Y, B => BUFF_82_Y, S => NOR2_4_Y, 
        Y => MX2_143_Y);
    XOR2_PP1_12_inst : XOR2
      port map(A => MX2_102_Y, B => BUFF_27_Y, Y => PP1_12_net);
    XOR3_SumB_26_inst : XOR3
      port map(A => MAJ3_108_Y, B => XOR3_19_Y, C => XOR3_42_Y, 
        Y => SumB_26_net);
    XOR2_52 : XOR2
      port map(A => SumA_29_net, B => SumB_29_net, Y => XOR2_52_Y);
    AND2_113 : AND2
      port map(A => XOR2_109_Y, B => BUFF_12_Y, Y => AND2_113_Y);
    AO1_15 : AO1
      port map(A => AND2_327_Y, B => AO1_20_Y, C => AO1_35_Y, 
        Y => AO1_15_Y);
    XNOR2_6 : XNOR2
      port map(A => DataB(8), B => BUFF_19_Y, Y => XNOR2_6_Y);
    AND2_334 : AND2
      port map(A => XOR2_57_Y, B => BUFF_79_Y, Y => AND2_334_Y);
    MAJ3_SumA_13_inst : MAJ3
      port map(A => XOR3_70_Y, B => MAJ3_1_Y, C => XOR3_106_Y, 
        Y => SumA_13_net);
    XOR3_84 : XOR3
      port map(A => MAJ3_84_Y, B => MAJ3_18_Y, C => XOR3_62_Y, 
        Y => XOR3_84_Y);
    XOR2_Mult_37_inst : XOR2
      port map(A => XOR2_82_Y, B => AO1_85_Y, Y => Mult(37));
    XOR3_70 : XOR3
      port map(A => MAJ3_69_Y, B => MAJ3_106_Y, C => XOR3_85_Y, 
        Y => XOR3_70_Y);
    MX2_83 : MX2
      port map(A => AND2_333_Y, B => BUFF_55_Y, S => NOR2_18_Y, 
        Y => MX2_83_Y);
    AO1_51 : AO1
      port map(A => AND2_301_Y, B => AO1_23_Y, C => AO1_54_Y, 
        Y => AO1_51_Y);
    MAJ3_SumA_6_inst : MAJ3
      port map(A => XOR3_6_Y, B => AND2_9_Y, C => PP3_0_net, Y => 
        SumA_6_net);
    MX2_120 : MX2
      port map(A => AND2_294_Y, B => BUFF_75_Y, S => NOR2_14_Y, 
        Y => MX2_120_Y);
    XOR3_12 : XOR3
      port map(A => MAJ3_40_Y, B => MAJ3_2_Y, C => XOR3_83_Y, 
        Y => XOR3_12_Y);
    AND2_310 : AND2
      port map(A => XOR2_28_Y, B => BUFF_13_Y, Y => AND2_310_Y);
    MAJ3_63 : MAJ3
      port map(A => PP8_1_net, B => PP5_7_net, C => PP2_13_net, 
        Y => MAJ3_63_Y);
    BUFF_46 : BUFF
      port map(A => DataB(1), Y => BUFF_46_Y);
    XOR3_4 : XOR3
      port map(A => PP5_22_net, B => VCC_1_net, C => PP6_20_net, 
        Y => XOR3_4_Y);
    AND2_186 : AND2
      port map(A => XOR2_65_Y, B => BUFF_31_Y, Y => AND2_186_Y);
    MAJ3_53 : MAJ3
      port map(A => XOR3_0_Y, B => XOR3_31_Y, C => MAJ3_110_Y, 
        Y => MAJ3_53_Y);
    XOR3_6 : XOR3
      port map(A => PP1_4_net, B => PP0_6_net, C => PP2_2_net, 
        Y => XOR3_6_Y);
    AO1_100 : AO1
      port map(A => XOR2_27_Y, B => AND2_235_Y, C => AND2_95_Y, 
        Y => AO1_100_Y);
    AND2_263 : AND2
      port map(A => XOR2_2_Y, B => BUFF_48_Y, Y => AND2_263_Y);
    XOR2_94 : XOR2
      port map(A => SumA_28_net, B => SumB_28_net, Y => XOR2_94_Y);
    AO1_81 : AO1
      port map(A => AND2_103_Y, B => AO1_51_Y, C => AO1_27_Y, 
        Y => AO1_81_Y);
    AND2_202 : AND2
      port map(A => AND2_51_Y, B => AND2_316_Y, Y => AND2_202_Y);
    AND2_81 : AND2
      port map(A => NOR2_20_Y, B => BUFF_42_Y, Y => AND2_81_Y);
    AND2_198 : AND2
      port map(A => AND2_19_Y, B => XOR2_39_Y, Y => AND2_198_Y);
    MX2_46 : MX2
      port map(A => AND2_178_Y, B => BUFF_72_Y, S => NOR2_1_Y, 
        Y => MX2_46_Y);
    AND2_20 : AND2
      port map(A => AND2_304_Y, B => AND2_198_Y, Y => AND2_20_Y);
    AND2_270 : AND2
      port map(A => AND2_102_Y, B => AND2_318_Y, Y => AND2_270_Y);
    AND2_134 : AND2
      port map(A => PP6_16_net, B => PP5_18_net, Y => AND2_134_Y);
    MX2_35 : MX2
      port map(A => AND2_201_Y, B => BUFF_77_Y, S => NOR2_8_Y, 
        Y => MX2_35_Y);
    AO1_29 : AO1
      port map(A => AND2_232_Y, B => AO1_62_Y, C => AO1_100_Y, 
        Y => AO1_29_Y);
    AO1_103 : AO1
      port map(A => XOR2_107_Y, B => AO1_67_Y, C => AND2_22_Y, 
        Y => AO1_103_Y);
    XOR3_SumB_34_inst : XOR3
      port map(A => MAJ3_89_Y, B => AND2_55_Y, C => XOR3_16_Y, 
        Y => SumB_34_net);
    INV_E_1_inst : INV
      port map(A => DataB(3), Y => E_1_net);
    XOR2_56 : XOR2
      port map(A => SumA_34_net, B => SumB_34_net, Y => XOR2_56_Y);
    XNOR2_5 : XNOR2
      port map(A => DataB(10), B => BUFF_87_Y, Y => XNOR2_5_Y);
    AO1_95 : AO1
      port map(A => AND2_327_Y, B => AO1_20_Y, C => AO1_35_Y, 
        Y => AO1_95_Y);
    XOR3_SumB_35_inst : XOR3
      port map(A => XOR2_106_Y, B => PP8_20_net, C => MAJ3_45_Y, 
        Y => SumB_35_net);
    AND2_163 : AND2
      port map(A => PP7_1_net, B => PP6_3_net, Y => AND2_163_Y);
    MAJ3_4 : MAJ3
      port map(A => PP4_20_net, B => PP3_22_net, C => VCC_1_net, 
        Y => MAJ3_4_Y);
    XOR3_16 : XOR3
      port map(A => PP7_21_net, B => E_6_net, C => PP8_19_net, 
        Y => XOR3_16_Y);
    MAJ3_60 : MAJ3
      port map(A => XOR3_102_Y, B => MAJ3_80_Y, C => MAJ3_98_Y, 
        Y => MAJ3_60_Y);
    XOR2_PP2_0_inst : XOR2
      port map(A => XOR2_35_Y, B => DataB(5), Y => PP2_0_net);
    MAJ3_50 : MAJ3
      port map(A => XOR3_85_Y, B => MAJ3_69_Y, C => MAJ3_106_Y, 
        Y => MAJ3_50_Y);
    AO1_1 : AO1
      port map(A => XOR2_112_Y, B => AO1_80_Y, C => AND2_261_Y, 
        Y => AO1_1_Y);
    AND2_131 : AND2
      port map(A => AND2_21_Y, B => AND2_75_Y, Y => AND2_131_Y);
    XOR2_PP4_11_inst : XOR2
      port map(A => MX2_2_Y, B => BUFF_61_Y, Y => PP4_11_net);
    XOR2_PP7_1_inst : XOR2
      port map(A => MX2_153_Y, B => BUFF_44_Y, Y => PP7_1_net);
    XOR2_PP5_20_inst : XOR2
      port map(A => MX2_47_Y, B => BUFF_43_Y, Y => PP5_20_net);
    BUFF_83 : BUFF
      port map(A => DataB(15), Y => BUFF_83_Y);
    BUFF_81 : BUFF
      port map(A => DataA(10), Y => BUFF_81_Y);
    AO1_101 : AO1
      port map(A => AND2_229_Y, B => AO1_41_Y, C => AO1_69_Y, 
        Y => AO1_101_Y);
    MX2_142 : MX2
      port map(A => AND2_145_Y, B => BUFF_64_Y, S => NOR2_12_Y, 
        Y => MX2_142_Y);
    MAJ3_116 : MAJ3
      port map(A => PP8_0_net, B => PP5_6_net, C => PP2_12_net, 
        Y => MAJ3_116_Y);
    AO1_37 : AO1
      port map(A => AND2_123_Y, B => AO1_50_Y, C => AO1_3_Y, Y => 
        AO1_37_Y);
    MAJ3_117 : MAJ3
      port map(A => XOR3_11_Y, B => MAJ3_11_Y, C => MAJ3_25_Y, 
        Y => MAJ3_117_Y);
    XOR2_100 : XOR2
      port map(A => SumA_15_net, B => SumB_15_net, Y => 
        XOR2_100_Y);
    XOR3_85 : XOR3
      port map(A => XOR2_44_Y, B => PP6_1_net, C => XOR3_25_Y, 
        Y => XOR3_85_Y);
    MX2_134 : MX2
      port map(A => AND2_157_Y, B => BUFF_18_Y, S => NOR2_3_Y, 
        Y => MX2_134_Y);
    XOR3_53 : XOR3
      port map(A => MAJ3_59_Y, B => MAJ3_87_Y, C => XOR3_92_Y, 
        Y => XOR3_53_Y);
    MX2_2 : MX2
      port map(A => AND2_269_Y, B => BUFF_25_Y, S => NOR2_13_Y, 
        Y => MX2_2_Y);
    AND2_278 : AND2
      port map(A => AND2_128_Y, B => AND2_232_Y, Y => AND2_278_Y);
    XOR2_PP4_9_inst : XOR2
      port map(A => MX2_21_Y, B => BUFF_61_Y, Y => PP4_9_net);
    MX2_156 : MX2
      port map(A => AND2_0_Y, B => BUFF_80_Y, S => NOR2_11_Y, 
        Y => MX2_156_Y);
    AND2_187 : AND2
      port map(A => XOR2_90_Y, B => BUFF_54_Y, Y => AND2_187_Y);
    XOR2_PP2_13_inst : XOR2
      port map(A => MX2_8_Y, B => BUFF_57_Y, Y => PP2_13_net);
    XNOR2_14 : XNOR2
      port map(A => DataB(6), B => BUFF_16_Y, Y => XNOR2_14_Y);
    AND2_13 : AND2
      port map(A => SumA_3_net, B => SumB_3_net, Y => AND2_13_Y);
    AND2_210 : AND2
      port map(A => XOR2_105_Y, B => BUFF_73_Y, Y => AND2_210_Y);
    AND2_86 : AND2
      port map(A => XOR2_2_Y, B => BUFF_79_Y, Y => AND2_86_Y);
    AND2_336 : AND2
      port map(A => XOR2_90_Y, B => BUFF_8_Y, Y => AND2_336_Y);
    AND2_73 : AND2
      port map(A => AND2_225_Y, B => AND2_309_Y, Y => AND2_73_Y);
    MX2_155 : MX2
      port map(A => AND2_300_Y, B => BUFF_24_Y, S => NOR2_6_Y, 
        Y => MX2_155_Y);
    MAJ3_102 : MAJ3
      port map(A => PP5_5_net, B => PP3_9_net, C => PP1_13_net, 
        Y => MAJ3_102_Y);
    AND2_59 : AND2
      port map(A => XOR2_13_Y, B => BUFF_86_Y, Y => AND2_59_Y);
    XOR3_59 : XOR3
      port map(A => PP1_7_net, B => PP0_9_net, C => PP2_5_net, 
        Y => XOR3_59_Y);
    MAJ3_91 : MAJ3
      port map(A => PP6_5_net, B => PP3_11_net, C => PP0_17_net, 
        Y => MAJ3_91_Y);
    AO1_40 : AO1
      port map(A => XOR2_91_Y, B => AND2_125_Y, C => AND2_52_Y, 
        Y => AO1_40_Y);
    AND2_235 : AND2
      port map(A => SumA_8_net, B => SumB_8_net, Y => AND2_235_Y);
    XOR2_95 : XOR2
      port map(A => SumA_29_net, B => SumB_29_net, Y => XOR2_95_Y);
    MAJ3_101 : MAJ3
      port map(A => PP7_11_net, B => PP4_17_net, C => E_1_net, 
        Y => MAJ3_101_Y);
    AND2_322 : AND2
      port map(A => XOR2_90_Y, B => BUFF_49_Y, Y => AND2_322_Y);
    AO1_38 : AO1
      port map(A => AND2_75_Y, B => AO1_99_Y, C => AO1_102_Y, 
        Y => AO1_38_Y);
    AO1_9 : AO1
      port map(A => AND2_53_Y, B => AO1_50_Y, C => AO1_68_Y, Y => 
        AO1_9_Y);
    XOR2_11 : XOR2
      port map(A => SumA_32_net, B => SumB_32_net, Y => XOR2_11_Y);
    MX2_81 : MX2
      port map(A => AND2_57_Y, B => BUFF_10_Y, S => NOR2_0_Y, 
        Y => MX2_81_Y);
    MX2_52 : MX2
      port map(A => AND2_239_Y, B => BUFF_51_Y, S => NOR2_16_Y, 
        Y => MX2_52_Y);
    XOR2_PP4_14_inst : XOR2
      port map(A => MX2_61_Y, B => BUFF_61_Y, Y => PP4_14_net);
    BUFF_62 : BUFF
      port map(A => DataB(5), Y => BUFF_62_Y);
    XOR2_PP1_21_inst : XOR2
      port map(A => MX2_122_Y, B => BUFF_74_Y, Y => PP1_21_net);
    AND2_35 : AND2
      port map(A => XOR2_6_Y, B => BUFF_29_Y, Y => AND2_35_Y);
    AND2_293 : AND2
      port map(A => XOR2_16_Y, B => BUFF_34_Y, Y => AND2_293_Y);
    AND2_108 : AND2
      port map(A => XOR2_90_Y, B => BUFF_10_Y, Y => AND2_108_Y);
    XOR2_48 : XOR2
      port map(A => SumA_7_net, B => SumB_7_net, Y => XOR2_48_Y);
    BUFF_73 : BUFF
      port map(A => DataA(4), Y => BUFF_73_Y);
    XOR2_PP3_3_inst : XOR2
      port map(A => MX2_38_Y, B => BUFF_28_Y, Y => PP3_3_net);
    BUFF_71 : BUFF
      port map(A => DataB(13), Y => BUFF_71_Y);
    MAJ3_34 : MAJ3
      port map(A => PP6_6_net, B => PP3_12_net, C => PP0_18_net, 
        Y => MAJ3_34_Y);
    XOR3_57 : XOR3
      port map(A => PP3_9_net, B => PP1_13_net, C => PP5_5_net, 
        Y => XOR3_57_Y);
    XOR2_81 : XOR2
      port map(A => DataB(3), B => DataB(4), Y => XOR2_81_Y);
    MX2_92 : MX2
      port map(A => AND2_127_Y, B => BUFF_58_Y, S => NOR2_1_Y, 
        Y => MX2_92_Y);
    AND2_329 : AND2
      port map(A => XOR2_6_Y, B => BUFF_51_Y, Y => AND2_329_Y);
    XOR2_PP3_8_inst : XOR2
      port map(A => MX2_79_Y, B => BUFF_16_Y, Y => PP3_8_net);
    XOR3_73 : XOR3
      port map(A => PP5_6_net, B => PP2_12_net, C => PP8_0_net, 
        Y => XOR3_73_Y);
    NOR2_9 : NOR2
      port map(A => XOR2_64_Y, B => XNOR2_0_Y, Y => NOR2_9_Y);
    XOR2_PP0_3_inst : XOR2
      port map(A => MX2_41_Y, B => BUFF_52_Y, Y => PP0_3_net);
    MX2_88 : MX2
      port map(A => AND2_231_Y, B => BUFF_2_Y, S => NOR2_4_Y, 
        Y => MX2_88_Y);
    BUFF_14 : BUFF
      port map(A => DataB(5), Y => BUFF_14_Y);
    MAJ3_SumA_16_inst : MAJ3
      port map(A => XOR3_114_Y, B => MAJ3_93_Y, C => XOR3_13_Y, 
        Y => SumA_16_net);
    XOR3_24 : XOR3
      port map(A => XOR3_43_Y, B => MAJ3_26_Y, C => XOR3_20_Y, 
        Y => XOR3_24_Y);
    MAJ3_109 : MAJ3
      port map(A => PP8_2_net, B => PP5_8_net, C => PP2_14_net, 
        Y => MAJ3_109_Y);
    AND2_218 : AND2
      port map(A => AND2_51_Y, B => AND2_327_Y, Y => AND2_218_Y);
    XOR3_79 : XOR3
      port map(A => MAJ3_52_Y, B => MAJ3_113_Y, C => XOR3_24_Y, 
        Y => XOR3_79_Y);
    XOR2_5 : XOR2
      port map(A => SumA_26_net, B => SumB_26_net, Y => XOR2_5_Y);
    AND2_176 : AND2
      port map(A => XOR2_57_Y, B => BUFF_69_Y, Y => AND2_176_Y);
    MAJ3_8 : MAJ3
      port map(A => PP5_4_net, B => PP3_8_net, C => PP1_12_net, 
        Y => MAJ3_8_Y);
    AND2_260 : AND2
      port map(A => AND2_253_Y, B => AND2_53_Y, Y => AND2_260_Y);
    XOR2_PP0_8_inst : XOR2
      port map(A => MX2_22_Y, B => BUFF_46_Y, Y => PP0_8_net);
    XOR2_PP4_17_inst : XOR2
      port map(A => MX2_80_Y, B => BUFF_19_Y, Y => PP4_17_net);
    MAJ3_SumA_27_inst : MAJ3
      port map(A => XOR3_42_Y, B => MAJ3_108_Y, C => XOR3_19_Y, 
        Y => SumA_27_net);
    XOR2_PP4_6_inst : XOR2
      port map(A => MX2_158_Y, B => BUFF_66_Y, Y => PP4_6_net);
    XOR3_34 : XOR3
      port map(A => PP4_9_net, B => PP1_15_net, C => PP7_3_net, 
        Y => XOR3_34_Y);
    XNOR2_17 : XNOR2
      port map(A => DataB(6), B => BUFF_67_Y, Y => XNOR2_17_Y);
    MX2_131 : MX2
      port map(A => AND2_176_Y, B => BUFF_75_Y, S => NOR2_17_Y, 
        Y => MX2_131_Y);
    XOR2_Mult_25_inst : XOR2
      port map(A => XOR2_37_Y, B => AO1_9_Y, Y => Mult(25));
    AND2_193 : AND2
      port map(A => XOR2_53_Y, B => BUFF_37_Y, Y => AND2_193_Y);
    XOR3_1 : XOR3
      port map(A => PP4_18_net, B => PP2_22_net, C => PP6_14_net, 
        Y => XOR3_1_Y);
    AND2_333 : AND2
      port map(A => XOR2_58_Y, B => BUFF_73_Y, Y => AND2_333_Y);
    AO1_14 : AO1
      port map(A => AND2_131_Y, B => AO1_50_Y, C => AO1_38_Y, 
        Y => AO1_14_Y);
    XOR3_80 : XOR3
      port map(A => MAJ3_12_Y, B => MAJ3_27_Y, C => XOR3_88_Y, 
        Y => XOR3_80_Y);
    MX2_103 : MX2
      port map(A => AND2_185_Y, B => BUFF_26_Y, S => NOR2_11_Y, 
        Y => MX2_103_Y);
    AO1_45 : AO1
      port map(A => XOR2_41_Y, B => AO1_100_Y, C => AND2_315_Y, 
        Y => AO1_45_Y);
    AND2_155 : AND2
      port map(A => XOR2_65_Y, B => BUFF_50_Y, Y => AND2_155_Y);
    BUFF_24 : BUFF
      port map(A => DataA(0), Y => BUFF_24_Y);
    MAJ3_SumA_29_inst : MAJ3
      port map(A => XOR3_107_Y, B => MAJ3_14_Y, C => XOR3_86_Y, 
        Y => SumA_29_net);
    XOR2_112 : XOR2
      port map(A => SumA_36_net, B => SumB_36_net, Y => 
        XOR2_112_Y);
    XOR3_SumB_29_inst : XOR3
      port map(A => MAJ3_60_Y, B => XOR3_69_Y, C => XOR3_77_Y, 
        Y => SumB_29_net);
    AND2_142 : AND2
      port map(A => XOR2_13_Y, B => BUFF_34_Y, Y => AND2_142_Y);
    XOR3_77 : XOR3
      port map(A => MAJ3_103_Y, B => MAJ3_118_Y, C => XOR3_68_Y, 
        Y => XOR3_77_Y);
    XOR2_PP0_7_inst : XOR2
      port map(A => MX2_15_Y, B => BUFF_52_Y, Y => PP0_7_net);
    MX2_47 : MX2
      port map(A => AND2_71_Y, B => BUFF_79_Y, S => NOR2_17_Y, 
        Y => MX2_47_Y);
    XOR2_90 : XOR2
      port map(A => DataB(13), B => DataB(14), Y => XOR2_90_Y);
    AND2_50 : AND2
      port map(A => XOR2_83_Y, B => BUFF_88_Y, Y => AND2_50_Y);
    XOR2_Mult_1_inst : XOR2
      port map(A => PP0_1_net, B => S_0_net, Y => Mult(1));
    MX2_24 : MX2
      port map(A => AND2_336_Y, B => BUFF_54_Y, S => NOR2_7_Y, 
        Y => MX2_24_Y);
    XOR2_PP7_13_inst : XOR2
      port map(A => MX2_157_Y, B => BUFF_38_Y, Y => PP7_13_net);
    XNOR2_18 : XNOR2
      port map(A => DataB(8), B => BUFF_66_Y, Y => XNOR2_18_Y);
    AND2_254 : AND2
      port map(A => XOR2_6_Y, B => BUFF_1_Y, Y => AND2_254_Y);
    AND2_PP8_11_inst : AND2
      port map(A => DataB(15), B => BUFF_2_Y, Y => PP8_11_net);
    MAJ3_SumA_8_inst : MAJ3
      port map(A => XOR3_108_Y, B => MAJ3_105_Y, C => XOR3_30_Y, 
        Y => SumA_8_net);
    MX2_114 : MX2
      port map(A => AND2_67_Y, B => BUFF_68_Y, S => NOR2_9_Y, 
        Y => MX2_114_Y);
    AND2_150 : AND2
      port map(A => DataB(0), B => BUFF_0_Y, Y => AND2_150_Y);
    MAJ3_24 : MAJ3
      port map(A => PP6_15_net, B => PP4_19_net, C => E_2_net, 
        Y => MAJ3_24_Y);
    MX2_59 : MX2
      port map(A => AND2_116_Y, B => BUFF_2_Y, S => NOR2_12_Y, 
        Y => MX2_59_Y);
    AND2_89 : AND2
      port map(A => SumA_28_net, B => SumB_28_net, Y => AND2_89_Y);
    AND2_268 : AND2
      port map(A => AND2_277_Y, B => AND2_49_Y, Y => AND2_268_Y);
    AND2_116 : AND2
      port map(A => XOR2_17_Y, B => BUFF_9_Y, Y => AND2_116_Y);
    MX2_127 : MX2
      port map(A => AND2_40_Y, B => BUFF_56_Y, S => AND2A_1_Y, 
        Y => MX2_127_Y);
    XOR2_PP3_13_inst : XOR2
      port map(A => MX2_119_Y, B => BUFF_16_Y, Y => PP3_13_net);
    MAJ3_46 : MAJ3
      port map(A => XOR3_51_Y, B => MAJ3_6_Y, C => MAJ3_13_Y, 
        Y => MAJ3_46_Y);
    MX2_3 : MX2
      port map(A => AND2_28_Y, B => BUFF_86_Y, S => NOR2_2_Y, 
        Y => MX2_3_Y);
    AO1_26 : AO1
      port map(A => XOR2_80_Y, B => AND2_47_Y, C => AND2_328_Y, 
        Y => AO1_26_Y);
    MX2_99 : MX2
      port map(A => AND2_109_Y, B => BUFF_47_Y, S => AND2A_2_Y, 
        Y => MX2_99_Y);
    AO1_94 : AO1
      port map(A => AND2_164_Y, B => AO1_15_Y, C => AO1_30_Y, 
        Y => AO1_94_Y);
    XOR2_74 : XOR2
      port map(A => SumA_30_net, B => SumB_30_net, Y => XOR2_74_Y);
    AND2_203 : AND2
      port map(A => AND2_154_Y, B => AND2_327_Y, Y => AND2_203_Y);
    AND2_247 : AND2
      port map(A => XOR2_58_Y, B => BUFF_85_Y, Y => AND2_247_Y);
    NOR2_11 : NOR2
      port map(A => XOR2_13_Y, B => XNOR2_11_Y, Y => NOR2_11_Y);
    AO1_19 : AO1
      port map(A => AND2_297_Y, B => AO1_62_Y, C => AO1_49_Y, 
        Y => AO1_19_Y);
    AND2_177 : AND2
      port map(A => XOR2_83_Y, B => BUFF_59_Y, Y => AND2_177_Y);
    XOR2_PP7_6_inst : XOR2
      port map(A => MX2_64_Y, B => BUFF_44_Y, Y => PP7_6_net);
    XOR3_25 : XOR3
      port map(A => PP1_11_net, B => PP0_13_net, C => PP2_9_net, 
        Y => XOR3_25_Y);
    AND2_42 : AND2
      port map(A => XOR2_13_Y, B => BUFF_7_Y, Y => AND2_42_Y);
    MAJ3_74 : MAJ3
      port map(A => XOR3_110_Y, B => MAJ3_111_Y, C => MAJ3_119_Y, 
        Y => MAJ3_74_Y);
    MX2_139 : MX2
      port map(A => AND2_33_Y, B => BUFF_59_Y, S => NOR2_12_Y, 
        Y => MX2_139_Y);
    AND2_33 : AND2
      port map(A => XOR2_17_Y, B => BUFF_89_Y, Y => AND2_33_Y);
    XOR3_35 : XOR3
      port map(A => MAJ3_44_Y, B => MAJ3_66_Y, C => XOR3_8_Y, 
        Y => XOR3_35_Y);
    AO1_4 : AO1
      port map(A => XOR2_9_Y, B => AO1_96_Y, C => AND2_66_Y, Y => 
        AO1_4_Y);
    NOR2_10 : NOR2
      port map(A => XOR2_109_Y, B => XNOR2_14_Y, Y => NOR2_10_Y);
    AND2_159 : AND2
      port map(A => PP7_22_net, B => VCC_1_net, Y => AND2_159_Y);
    MX2_12 : MX2
      port map(A => AND2_148_Y, B => BUFF_49_Y, S => NOR2_0_Y, 
        Y => MX2_12_Y);
    AND2_317 : AND2
      port map(A => AND2_170_Y, B => AND2_20_Y, Y => AND2_317_Y);
    AND2_246 : AND2
      port map(A => AND2_203_Y, B => AND2_172_Y, Y => AND2_246_Y);
    AND2_2 : AND2
      port map(A => XOR2_81_Y, B => BUFF_77_Y, Y => AND2_2_Y);
    MX2_102 : MX2
      port map(A => AND2_182_Y, B => BUFF_80_Y, S => NOR2_15_Y, 
        Y => MX2_102_Y);
    XOR2_PP6_21_inst : XOR2
      port map(A => MX2_81_Y, B => BUFF_71_Y, Y => PP6_21_net);
    XOR3_SumB_6_inst : XOR3
      port map(A => MAJ3_9_Y, B => XOR2_69_Y, C => XOR3_65_Y, 
        Y => SumB_6_net);
    XOR3_117 : XOR3
      port map(A => MAJ3_112_Y, B => MAJ3_0_Y, C => XOR3_33_Y, 
        Y => XOR3_117_Y);
    MX2_163 : MX2
      port map(A => AND2_247_Y, B => BUFF_73_Y, S => NOR2_18_Y, 
        Y => MX2_163_Y);
    BUFF_87 : BUFF
      port map(A => DataB(11), Y => BUFF_87_Y);
    AND2_221 : AND2
      port map(A => DataB(0), B => BUFF_3_Y, Y => AND2_221_Y);
    BUFF_43 : BUFF
      port map(A => DataB(11), Y => BUFF_43_Y);
    AND2_62 : AND2
      port map(A => XOR2_36_Y, B => BUFF_12_Y, Y => AND2_62_Y);
    XOR2_107 : XOR2
      port map(A => S_1_net, B => SumB_2_net, Y => XOR2_107_Y);
    BUFF_41 : BUFF
      port map(A => DataA(17), Y => BUFF_41_Y);
    AND2_103 : AND2
      port map(A => AND2_39_Y, B => XOR2_5_Y, Y => AND2_103_Y);
    MAJ3_97 : MAJ3
      port map(A => XOR3_118_Y, B => MAJ3_54_Y, C => MAJ3_115_Y, 
        Y => MAJ3_97_Y);
    XOR2_PP5_0_inst : XOR2
      port map(A => XOR2_88_Y, B => DataB(11), Y => PP5_0_net);
    XOR2_PP6_15_inst : XOR2
      port map(A => MX2_142_Y, B => BUFF_22_Y, Y => PP6_15_net);
    AND2_290 : AND2
      port map(A => AND2_128_Y, B => AND2_252_Y, Y => AND2_290_Y);
    BUFF_66 : BUFF
      port map(A => DataB(9), Y => BUFF_66_Y);
    XNOR2_1 : XNOR2
      port map(A => DataB(14), B => BUFF_38_Y, Y => XNOR2_1_Y);
    XOR2_PP7_7_inst : XOR2
      port map(A => MX2_39_Y, B => BUFF_44_Y, Y => PP7_7_net);
    MAJ3_SumA_11_inst : MAJ3
      port map(A => XOR3_84_Y, B => MAJ3_114_Y, C => XOR3_76_Y, 
        Y => SumA_11_net);
    AND2_PP8_0_inst : AND2
      port map(A => DataB(15), B => BUFF_68_Y, Y => PP8_0_net);
    MAJ3_SumA_34_inst : MAJ3
      port map(A => XOR3_119_Y, B => MAJ3_33_Y, C => MAJ3_16_Y, 
        Y => SumA_34_net);
    AND2_166 : AND2
      port map(A => SumA_13_net, B => SumB_13_net, Y => 
        AND2_166_Y);
    MX2_111 : MX2
      port map(A => AND2_233_Y, B => BUFF_20_Y, S => NOR2_8_Y, 
        Y => MX2_111_Y);
    BUFF_15 : BUFF
      port map(A => DataA(19), Y => BUFF_15_Y);
    MAJ3_SumA_24_inst : MAJ3
      port map(A => XOR3_21_Y, B => MAJ3_23_Y, C => XOR3_100_Y, 
        Y => SumA_24_net);
    AO1_99 : AO1
      port map(A => AND2_88_Y, B => AO1_96_Y, C => AO1_7_Y, Y => 
        AO1_99_Y);
    BUFF_10 : BUFF
      port map(A => DataA(20), Y => BUFF_10_Y);
    AND2_PP8_10_inst : AND2
      port map(A => DataB(15), B => BUFF_88_Y, Y => PP8_10_net);
    AND2_300 : AND2
      port map(A => XOR2_65_Y, B => BUFF_63_Y, Y => AND2_300_Y);
    XOR2_PP0_16_inst : XOR2
      port map(A => MX2_16_Y, B => BUFF_4_Y, Y => PP0_16_net);
    XOR2_Mult_35_inst : XOR2
      port map(A => XOR2_56_Y, B => AO1_74_Y, Y => Mult(35));
    XOR2_12 : XOR2
      port map(A => SumA_9_net, B => SumB_9_net, Y => XOR2_12_Y);
    NOR2_13 : NOR2
      port map(A => XOR2_36_Y, B => XNOR2_9_Y, Y => NOR2_13_Y);
    AND2_117 : AND2
      port map(A => AND2_218_Y, B => AND2_68_Y, Y => AND2_117_Y);
    AND2_311 : AND2
      port map(A => XOR2_58_Y, B => BUFF_21_Y, Y => AND2_311_Y);
    AND2_229 : AND2
      port map(A => XOR2_39_Y, B => XOR2_95_Y, Y => AND2_229_Y);
    XOR2_PP6_18_inst : XOR2
      port map(A => MX2_32_Y, B => BUFF_71_Y, Y => PP6_18_net);
    AND2_135 : AND2
      port map(A => AND2_232_Y, B => AND2_121_Y, Y => AND2_135_Y);
    MAJ3_110 : MAJ3
      port map(A => PP7_9_net, B => PP4_15_net, C => PP1_21_net, 
        Y => MAJ3_110_Y);
    XOR2_64 : XOR2
      port map(A => DataB(11), B => DataB(12), Y => XOR2_64_Y);
    AND2_80 : AND2
      port map(A => AND2_253_Y, B => AND2_131_Y, Y => AND2_80_Y);
    XOR2_82 : XOR2
      port map(A => SumA_36_net, B => SumB_36_net, Y => XOR2_82_Y);
    XOR3_83 : XOR3
      port map(A => XOR3_32_Y, B => MAJ3_83_Y, C => XOR3_71_Y, 
        Y => XOR3_83_Y);
    XOR2_PP5_16_inst : XOR2
      port map(A => MX2_131_Y, B => BUFF_43_Y, Y => PP5_16_net);
    MAJ3_86 : MAJ3
      port map(A => XOR3_68_Y, B => MAJ3_103_Y, C => MAJ3_118_Y, 
        Y => MAJ3_86_Y);
    XOR2_75 : XOR2
      port map(A => SumA_23_net, B => SumB_23_net, Y => XOR2_75_Y);
    XOR2_Mult_5_inst : XOR2
      port map(A => XOR2_73_Y, B => AO1_93_Y, Y => Mult(5));
    BUFF_25 : BUFF
      port map(A => DataA(10), Y => BUFF_25_Y);
    BUFF_20 : BUFF
      port map(A => DataA(19), Y => BUFF_20_Y);
    BUFF_77 : BUFF
      port map(A => DataA(16), Y => BUFF_77_Y);
    AND2_234 : AND2
      port map(A => XOR2_109_Y, B => BUFF_72_Y, Y => AND2_234_Y);
    MAJ3_64 : MAJ3
      port map(A => PP7_13_net, B => PP5_17_net, C => PP3_21_net, 
        Y => MAJ3_64_Y);
    XOR3_20 : XOR3
      port map(A => PP3_15_net, B => PP0_21_net, C => PP6_9_net, 
        Y => XOR3_20_Y);
    AND2_298 : AND2
      port map(A => AND2_218_Y, B => AND2_324_Y, Y => AND2_298_Y);
    XOR3_89 : XOR3
      port map(A => MAJ3_57_Y, B => MAJ3_82_Y, C => XOR3_113_Y, 
        Y => XOR3_89_Y);
    MAJ3_54 : MAJ3
      port map(A => XOR3_57_Y, B => MAJ3_8_Y, C => S_7_net, Y => 
        MAJ3_54_Y);
    MAJ3_12 : MAJ3
      port map(A => PP6_12_net, B => PP3_18_net, C => DataB(1), 
        Y => MAJ3_12_Y);
    XOR2_PP2_19_inst : XOR2
      port map(A => MX2_167_Y, B => BUFF_14_Y, Y => PP2_19_net);
    AND2_130 : AND2
      port map(A => AND2_304_Y, B => AND2_19_Y, Y => AND2_130_Y);
    MX2_34 : MX2
      port map(A => AND2_296_Y, B => BUFF_51_Y, S => NOR2_9_Y, 
        Y => MX2_34_Y);
    XOR2_Mult_7_inst : XOR2
      port map(A => XOR2_14_Y, B => AO1_6_Y, Y => Mult(7));
    AO1_31 : AO1
      port map(A => XOR2_92_Y, B => AO1_93_Y, C => AND2_217_Y, 
        Y => AO1_31_Y);
    XOR2_93 : XOR2
      port map(A => SumA_5_net, B => SumB_5_net, Y => XOR2_93_Y);
    AND2_SumA_3_inst : AND2
      port map(A => PP1_1_net, B => PP0_3_net, Y => SumA_3_net);
    XOR2_PP7_5_inst : XOR2
      port map(A => MX2_137_Y, B => BUFF_44_Y, Y => PP7_5_net);
    MX2_19 : MX2
      port map(A => AND2_334_Y, B => BUFF_5_Y, S => NOR2_17_Y, 
        Y => MX2_19_Y);
    MX2_43 : MX2
      port map(A => AND2_221_Y, B => BUFF_6_Y, S => AND2A_0_Y, 
        Y => MX2_43_Y);
    XOR3_30 : XOR3
      port map(A => PP1_6_net, B => PP0_8_net, C => PP2_4_net, 
        Y => XOR3_30_Y);
    XOR2_16 : XOR2
      port map(A => DataB(1), B => DataB(2), Y => XOR2_16_Y);
    MAJ3_99 : MAJ3
      port map(A => MAJ3_72_Y, B => XOR2_70_Y, C => S_4_net, Y => 
        MAJ3_99_Y);
    XOR2_99 : XOR2
      port map(A => SumA_26_net, B => SumB_26_net, Y => XOR2_99_Y);
    AND2_242 : AND2
      port map(A => AND2_85_Y, B => AND2_36_Y, Y => AND2_242_Y);
    MX2_138 : MX2
      port map(A => AND2_93_Y, B => BUFF_41_Y, S => NOR2_8_Y, 
        Y => MX2_138_Y);
    MAJ3_98 : MAJ3
      port map(A => XOR3_18_Y, B => MAJ3_64_Y, C => PP8_12_net, 
        Y => MAJ3_98_Y);
    AND2_PP8_18_inst : AND2
      port map(A => DataB(15), B => BUFF_8_Y, Y => PP8_18_net);
    NOR2_7 : NOR2
      port map(A => XOR2_90_Y, B => XNOR2_13_Y, Y => NOR2_7_Y);
    XOR2_PP4_2_inst : XOR2
      port map(A => MX2_165_Y, B => BUFF_66_Y, Y => PP4_2_net);
    XOR3_51 : XOR3
      port map(A => PP4_14_net, B => PP1_20_net, C => PP7_8_net, 
        Y => XOR3_51_Y);
    AND2_24 : AND2
      port map(A => XOR2_81_Y, B => BUFF_3_Y, Y => AND2_24_Y);
    XOR2_PP2_12_inst : XOR2
      port map(A => MX2_156_Y, B => BUFF_57_Y, Y => PP2_12_net);
    AND2_48 : AND2
      port map(A => DataB(0), B => BUFF_77_Y, Y => AND2_48_Y);
    MX2_162 : MX2
      port map(A => AND2_32_Y, B => BUFF_82_Y, S => NOR2_12_Y, 
        Y => MX2_162_Y);
    AO1_44 : AO1
      port map(A => AND2_118_Y, B => AO1_69_Y, C => AO1_53_Y, 
        Y => AO1_44_Y);
    XOR2_Mult_26_inst : XOR2
      port map(A => XOR2_55_Y, B => AO1_76_Y, Y => Mult(26));
    XOR2_86 : XOR2
      port map(A => SumA_16_net, B => SumB_16_net, Y => XOR2_86_Y);
    AND2_167 : AND2
      port map(A => XOR2_33_Y, B => BUFF_8_Y, Y => AND2_167_Y);
    XOR3_SumB_12_inst : XOR3
      port map(A => MAJ3_1_Y, B => XOR3_106_Y, C => XOR3_70_Y, 
        Y => SumB_12_net);
    XOR2_Mult_18_inst : XOR2
      port map(A => XOR2_68_Y, B => AO1_89_Y, Y => Mult(18));
    MX2_119 : MX2
      port map(A => AND2_107_Y, B => BUFF_12_Y, S => NOR2_10_Y, 
        Y => MX2_119_Y);
    XOR3_87 : XOR3
      port map(A => PP7_17_net, B => PP5_21_net, C => AND2_76_Y, 
        Y => XOR3_87_Y);
    XOR3_SumB_3_inst : XOR3
      port map(A => PP1_2_net, B => PP0_4_net, C => PP2_0_net, 
        Y => SumB_3_net);
    MX2_150 : MX2
      port map(A => AND2_56_Y, B => BUFF_20_Y, S => AND2A_0_Y, 
        Y => MX2_150_Y);
    AO1_60 : AO1
      port map(A => AND2_121_Y, B => AO1_100_Y, C => AO1_66_Y, 
        Y => AO1_60_Y);
    XOR2_PP0_21_inst : XOR2
      port map(A => MX2_43_Y, B => BUFF_4_Y, Y => PP0_21_net);
    AND2_200 : AND2
      port map(A => AND2_85_Y, B => XOR2_92_Y, Y => AND2_200_Y);
    MAJ3_SumA_30_inst : MAJ3
      port map(A => XOR3_77_Y, B => MAJ3_60_Y, C => XOR3_69_Y, 
        Y => SumA_30_net);
    AND2_139 : AND2
      port map(A => XOR2_15_Y, B => XOR2_87_Y, Y => AND2_139_Y);
    MAJ3_45 : MAJ3
      port map(A => PP8_19_net, B => PP7_21_net, C => E_6_net, 
        Y => MAJ3_45_Y);
    MAJ3_SumA_20_inst : MAJ3
      port map(A => XOR3_89_Y, B => MAJ3_51_Y, C => XOR3_115_Y, 
        Y => SumA_20_net);
    MX2_20 : MX2
      port map(A => AND2_100_Y, B => BUFF_25_Y, S => NOR2_1_Y, 
        Y => MX2_20_Y);
    MX2_146 : MX2
      port map(A => AND2_282_Y, B => BUFF_13_Y, S => NOR2_6_Y, 
        Y => MX2_146_Y);
    XOR2_97 : XOR2
      port map(A => SumA_3_net, B => SumB_3_net, Y => XOR2_97_Y);
    AND2_281 : AND2
      port map(A => SumA_29_net, B => SumB_29_net, Y => 
        AND2_281_Y);
    AND2_68 : AND2
      port map(A => AND2_21_Y, B => XOR2_85_Y, Y => AND2_68_Y);
    XOR3_115 : XOR3
      port map(A => MAJ3_15_Y, B => MAJ3_31_Y, C => XOR3_101_Y, 
        Y => XOR3_115_Y);
    XOR2_PP3_20_inst : XOR2
      port map(A => MX2_115_Y, B => BUFF_67_Y, Y => PP3_20_net);
    XOR3_98 : XOR3
      port map(A => MAJ3_38_Y, B => MAJ3_90_Y, C => XOR3_105_Y, 
        Y => XOR3_98_Y);
    MX2_145 : MX2
      port map(A => AND2_286_Y, B => BUFF_50_Y, S => NOR2_6_Y, 
        Y => MX2_145_Y);
    AND2_196 : AND2
      port map(A => AND2_128_Y, B => AND2_135_Y, Y => AND2_196_Y);
    XOR2_65 : XOR2
      port map(A => DataB(9), B => DataB(10), Y => XOR2_65_Y);
    XOR2_PP6_0_inst : XOR2
      port map(A => XOR2_3_Y, B => DataB(13), Y => PP6_0_net);
    NOR2_16 : NOR2
      port map(A => XOR2_6_Y, B => XNOR2_19_Y, Y => NOR2_16_Y);
    XOR2_PP0_10_inst : XOR2
      port map(A => MX2_128_Y, B => BUFF_46_Y, Y => PP0_10_net);
    XOR3_SumB_8_inst : XOR3
      port map(A => MAJ3_39_Y, B => XOR3_59_Y, C => XOR3_10_Y, 
        Y => SumB_8_net);
    INV_E_3_inst : INV
      port map(A => DataB(7), Y => E_3_net);
    XOR3_71 : XOR3
      port map(A => PP3_16_net, B => PP0_22_net, C => PP6_10_net, 
        Y => XOR3_71_Y);
    XOR2_70 : XOR2
      port map(A => PP4_1_net, B => PP3_3_net, Y => XOR2_70_Y);
    MAJ3_SumA_32_inst : MAJ3
      port map(A => XOR3_112_Y, B => MAJ3_49_Y, C => XOR3_4_Y, 
        Y => SumA_32_net);
    XOR2_PP6_2_inst : XOR2
      port map(A => MX2_89_Y, B => BUFF_35_Y, Y => PP6_2_net);
    MAJ3_SumA_22_inst : MAJ3
      port map(A => XOR3_12_Y, B => MAJ3_43_Y, C => XOR3_55_Y, 
        Y => SumA_22_net);
    AND2_289 : AND2
      port map(A => AND2_85_Y, B => AND2_171_Y, Y => AND2_289_Y);
    AO1_49 : AO1
      port map(A => XOR2_101_Y, B => AO1_72_Y, C => AND2_248_Y, 
        Y => AO1_49_Y);
    AO1_16 : AO1
      port map(A => XOR2_48_Y, B => AND2_189_Y, C => AND2_173_Y, 
        Y => AO1_16_Y);
    AO1_73 : AO1
      port map(A => AND2_21_Y, B => AO1_90_Y, C => AO1_99_Y, Y => 
        AO1_73_Y);
    XOR2_PP2_20_inst : XOR2
      port map(A => MX2_111_Y, B => BUFF_14_Y, Y => PP2_20_net);
    MX2_72 : MX2
      port map(A => AND2_156_Y, B => BUFF_39_Y, S => NOR2_20_Y, 
        Y => MX2_72_Y);
    AND2_5 : AND2
      port map(A => SumA_20_net, B => SumB_20_net, Y => AND2_5_Y);
    BUFF_89 : BUFF
      port map(A => DataA(9), Y => BUFF_89_Y);
    AND2_92 : AND2
      port map(A => XOR2_16_Y, B => BUFF_81_Y, Y => AND2_92_Y);
    XOR2_28 : XOR2
      port map(A => DataB(5), B => DataB(6), Y => XOR2_28_Y);
    AND2_208 : AND2
      port map(A => AND2_218_Y, B => AND2_21_Y, Y => AND2_208_Y);
    NOR2_6 : NOR2
      port map(A => XOR2_65_Y, B => XNOR2_5_Y, Y => NOR2_6_Y);
    XOR2_PP5_10_inst : XOR2
      port map(A => MX2_46_Y, B => BUFF_78_Y, Y => PP5_10_net);
    XOR2_38 : XOR2
      port map(A => PP4_22_net, B => VCC_1_net, Y => XOR2_38_Y);
    BUFF_32 : BUFF
      port map(A => DataA(8), Y => BUFF_32_Y);
    AND2_312 : AND2
      port map(A => XOR2_2_Y, B => BUFF_42_Y, Y => AND2_312_Y);
    AND2_PP8_7_inst : AND2
      port map(A => DataB(15), B => BUFF_1_Y, Y => PP8_7_net);
    XOR2_PP7_19_inst : XOR2
      port map(A => MX2_55_Y, B => BUFF_83_Y, Y => PP7_19_net);
    MX2_62 : MX2
      port map(A => AND2_220_Y, B => BUFF_21_Y, S => NOR2_11_Y, 
        Y => MX2_62_Y);
    MAJ3_43 : MAJ3
      port map(A => XOR3_24_Y, B => MAJ3_52_Y, C => MAJ3_113_Y, 
        Y => MAJ3_43_Y);
    AO1_65 : AO1
      port map(A => AND2_140_Y, B => AO1_95_Y, C => AO1_58_Y, 
        Y => AO1_65_Y);
    XOR2_PP4_15_inst : XOR2
      port map(A => MX2_78_Y, B => BUFF_61_Y, Y => PP4_15_net);
    XOR3_104 : XOR3
      port map(A => PP6_19_net, B => E_4_net, C => PP8_15_net, 
        Y => XOR3_104_Y);
    XOR2_PP1_11_inst : XOR2
      port map(A => MX2_107_Y, B => BUFF_27_Y, Y => PP1_11_net);
    AND2_148 : AND2
      port map(A => XOR2_33_Y, B => BUFF_54_Y, Y => AND2_148_Y);
    XOR3_108 : XOR3
      port map(A => PP4_0_net, B => PP3_2_net, C => AND2_46_Y, 
        Y => XOR3_108_Y);
    AO1_72 : AO1
      port map(A => AND2_121_Y, B => AO1_100_Y, C => AO1_66_Y, 
        Y => AO1_72_Y);
    AND2_152 : AND2
      port map(A => AND2_229_Y, B => AND2_118_Y, Y => AND2_152_Y);
    XOR2_1 : XOR2
      port map(A => SumA_31_net, B => SumB_31_net, Y => XOR2_1_Y);
    XOR2_PP3_19_inst : XOR2
      port map(A => MX2_132_Y, B => BUFF_67_Y, Y => PP3_19_net);
    AND2_319 : AND2
      port map(A => XOR2_53_Y, B => BUFF_72_Y, Y => AND2_319_Y);
    MX2_41 : MX2
      port map(A => AND2_105_Y, B => BUFF_53_Y, S => AND2A_1_Y, 
        Y => MX2_41_Y);
    BUFF_47 : BUFF
      port map(A => DataA(12), Y => BUFF_47_Y);
    XOR3_SumB_7_inst : XOR3
      port map(A => MAJ3_105_Y, B => XOR3_30_Y, C => XOR3_108_Y, 
        Y => SumB_7_net);
    XOR2_PP7_12_inst : XOR2
      port map(A => MX2_88_Y, B => BUFF_38_Y, Y => PP7_12_net);
    XOR3_23 : XOR3
      port map(A => MAJ3_34_Y, B => MAJ3_109_Y, C => XOR3_82_Y, 
        Y => XOR3_23_Y);
    MAJ3_SumA_18_inst : MAJ3
      port map(A => XOR3_96_Y, B => MAJ3_56_Y, C => XOR3_48_Y, 
        Y => SumA_18_net);
    MX2_118 : MX2
      port map(A => AND2_4_Y, B => BUFF_70_Y, S => NOR2_16_Y, 
        Y => MX2_118_Y);
    XOR2_PP1_7_inst : XOR2
      port map(A => MX2_160_Y, B => BUFF_36_Y, Y => PP1_7_net);
    AO1_96 : AO1
      port map(A => XOR2_47_Y, B => AND2_97_Y, C => AND2_15_Y, 
        Y => AO1_96_Y);
    XOR2_PP4_18_inst : XOR2
      port map(A => MX2_141_Y, B => BUFF_19_Y, Y => PP4_18_net);
    XOR2_8 : XOR2
      port map(A => SumA_33_net, B => SumB_33_net, Y => XOR2_8_Y);
    MAJ3_SumA_5_inst : MAJ3
      port map(A => XOR2_45_Y, B => S_2_net, C => PP2_1_net, Y => 
        SumA_5_net);
    MAJ3_85 : MAJ3
      port map(A => PP6_11_net, B => PP3_17_net, C => DataB(1), 
        Y => MAJ3_85_Y);
    XOR2_105 : XOR2
      port map(A => DataB(3), B => DataB(4), Y => XOR2_105_Y);
    AND2_197 : AND2
      port map(A => XOR2_90_Y, B => BUFF_17_Y, Y => AND2_197_Y);
    MX2_26 : MX2
      port map(A => AND2_279_Y, B => BUFF_20_Y, S => NOR2_2_Y, 
        Y => MX2_26_Y);
    XOR3_29 : XOR3
      port map(A => PP3_17_net, B => DataB(1), C => PP6_11_net, 
        Y => XOR3_29_Y);
    MX2_48 : MX2
      port map(A => AND2_211_Y, B => BUFF_88_Y, S => NOR2_12_Y, 
        Y => MX2_48_Y);
    MX2_55 : MX2
      port map(A => AND2_82_Y, B => BUFF_8_Y, S => NOR2_7_Y, Y => 
        MX2_55_Y);
    XOR3_33 : XOR3
      port map(A => XOR3_2_Y, B => MAJ3_73_Y, C => XOR3_103_Y, 
        Y => XOR3_33_Y);
    XOR2_Mult_36_inst : XOR2
      port map(A => XOR2_21_Y, B => AO1_34_Y, Y => Mult(36));
    XOR2_PP3_12_inst : XOR2
      port map(A => MX2_85_Y, B => BUFF_16_Y, Y => PP3_12_net);
    BUFF_79 : BUFF
      port map(A => DataA(19), Y => BUFF_79_Y);
    XOR2_Mult_11_inst : XOR2
      port map(A => XOR2_29_Y, B => AO1_29_Y, Y => Mult(11));
    XOR2_60 : XOR2
      port map(A => SumA_25_net, B => SumB_25_net, Y => XOR2_60_Y);
    XOR2_110 : XOR2
      port map(A => SumA_7_net, B => SumB_7_net, Y => XOR2_110_Y);
    MAJ3_40 : MAJ3
      port map(A => XOR3_8_Y, B => MAJ3_44_Y, C => MAJ3_66_Y, 
        Y => MAJ3_40_Y);
    XOR3_39 : XOR3
      port map(A => PP3_11_net, B => PP0_17_net, C => PP6_5_net, 
        Y => XOR3_39_Y);
    MAJ3_113 : MAJ3
      port map(A => XOR3_17_Y, B => XOR3_95_Y, C => MAJ3_28_Y, 
        Y => MAJ3_113_Y);
    AND2_257 : AND2
      port map(A => AND2_246_Y, B => AND2_267_Y, Y => AND2_257_Y);
    AND2_106 : AND2
      port map(A => SumA_30_net, B => SumB_30_net, Y => 
        AND2_106_Y);
    MX2_95 : MX2
      port map(A => AND2_280_Y, B => BUFF_7_Y, S => NOR2_15_Y, 
        Y => MX2_95_Y);
    XOR3_SumB_32_inst : XOR3
      port map(A => MAJ3_96_Y, B => XOR3_15_Y, C => XOR3_47_Y, 
        Y => SumB_32_net);
    XOR2_PP5_5_inst : XOR2
      port map(A => MX2_146_Y, B => BUFF_87_Y, Y => PP5_5_net);
    XOR2_PP1_14_inst : XOR2
      port map(A => MX2_105_Y, B => BUFF_27_Y, Y => PP1_14_net);
    AO1_50 : AO1
      port map(A => AND2_327_Y, B => AO1_20_Y, C => AO1_35_Y, 
        Y => AO1_50_Y);
    XOR2_Mult_9_inst : XOR2
      port map(A => XOR2_40_Y, B => AO1_33_Y, Y => Mult(9));
    MAJ3_115 : MAJ3
      port map(A => XOR3_72_Y, B => MAJ3_88_Y, C => XOR2_19_Y, 
        Y => MAJ3_115_Y);
    AND2_47 : AND2
      port map(A => SumA_32_net, B => SumB_32_net, Y => AND2_47_Y);
    MAJ3_SumA_4_inst : MAJ3
      port map(A => PP2_0_net, B => PP1_2_net, C => PP0_4_net, 
        Y => SumA_4_net);
    MX2_79 : MX2
      port map(A => AND2_256_Y, B => BUFF_84_Y, S => NOR2_10_Y, 
        Y => MX2_79_Y);
    AO1_80 : AO1
      port map(A => AND2_41_Y, B => AO1_26_Y, C => AO1_57_Y, Y => 
        AO1_80_Y);
    XOR3_109 : XOR3
      port map(A => PP3_10_net, B => PP0_16_net, C => PP6_4_net, 
        Y => XOR3_109_Y);
    MX2_30 : MX2
      port map(A => AND2_183_Y, B => BUFF_85_Y, S => NOR2_18_Y, 
        Y => MX2_30_Y);
    XOR3_27 : XOR3
      port map(A => XOR2_10_Y, B => PP7_14_net, C => MAJ3_24_Y, 
        Y => XOR3_27_Y);
    AND2_54 : AND2
      port map(A => SumA_15_net, B => SumB_15_net, Y => AND2_54_Y);
    XNOR2_10 : XNOR2
      port map(A => DataB(2), B => BUFF_74_Y, Y => XNOR2_10_Y);
    AO1_6 : AO1
      port map(A => AND2_171_Y, B => AO1_93_Y, C => AO1_88_Y, 
        Y => AO1_6_Y);
    BUFF_52 : BUFF
      port map(A => DataB(1), Y => BUFF_52_Y);
    AND2_256 : AND2
      port map(A => XOR2_109_Y, B => BUFF_37_Y, Y => AND2_256_Y);
    XOR2_PP4_5_inst : XOR2
      port map(A => MX2_73_Y, B => BUFF_66_Y, Y => PP4_5_net);
    AND2_S_5_inst : AND2
      port map(A => XOR2_88_Y, B => DataB(11), Y => S_5_net);
    XOR3_52 : XOR3
      port map(A => PP3_8_net, B => PP1_12_net, C => PP5_4_net, 
        Y => XOR3_52_Y);
    MX2_69 : MX2
      port map(A => AND2_99_Y, B => BUFF_53_Y, S => NOR2_18_Y, 
        Y => MX2_69_Y);
    AND2_325 : AND2
      port map(A => XOR2_67_Y, B => XOR2_48_Y, Y => AND2_325_Y);
    XOR2_PP3_2_inst : XOR2
      port map(A => MX2_40_Y, B => BUFF_28_Y, Y => PP3_2_net);
    XOR3_37 : XOR3
      port map(A => PP3_4_net, B => PP1_8_net, C => PP5_0_net, 
        Y => XOR3_37_Y);
    XOR2_108 : XOR2
      port map(A => SumA_3_net, B => SumB_3_net, Y => XOR2_108_Y);
    MAJ3_108 : MAJ3
      port map(A => XOR3_105_Y, B => MAJ3_38_Y, C => MAJ3_90_Y, 
        Y => MAJ3_108_Y);
    AND2_271 : AND2
      port map(A => DataB(0), B => BUFF_21_Y, Y => AND2_271_Y);
    AND2_67 : AND2
      port map(A => XOR2_64_Y, B => BUFF_30_Y, Y => AND2_67_Y);
    XOR2_Mult_14_inst : XOR2
      port map(A => XOR2_4_Y, B => AO1_19_Y, Y => Mult(14));
    MAJ3_32 : MAJ3
      port map(A => XOR2_24_Y, B => PP5_1_net, C => PP3_5_net, 
        Y => MAJ3_32_Y);
    XOR2_PP5_7_inst : XOR2
      port map(A => MX2_133_Y, B => BUFF_87_Y, Y => PP5_7_net);
    AND2_PP8_5_inst : AND2
      port map(A => DataB(15), B => BUFF_29_Y, Y => PP8_5_net);
    AND2_8 : AND2
      port map(A => PP0_2_net, B => PP1_0_net, Y => AND2_8_Y);
    AND2_307 : AND2
      port map(A => XOR2_58_Y, B => BUFF_40_Y, Y => AND2_307_Y);
    BUFF_63 : BUFF
      port map(A => DataA(1), Y => BUFF_63_Y);
    XOR2_PP1_17_inst : XOR2
      port map(A => MX2_14_Y, B => BUFF_74_Y, Y => PP1_17_net);
    BUFF_61 : BUFF
      port map(A => DataB(9), Y => BUFF_61_Y);
    MAJ3_83 : MAJ3
      port map(A => PP7_7_net, B => PP4_13_net, C => PP1_19_net, 
        Y => MAJ3_83_Y);
    MAJ3_0 : MAJ3
      port map(A => XOR3_60_Y, B => XOR3_3_Y, C => MAJ3_20_Y, 
        Y => MAJ3_0_Y);
    XNOR2_11 : XNOR2
      port map(A => DataB(4), B => BUFF_57_Y, Y => XNOR2_11_Y);
    AND2_98 : AND2
      port map(A => XOR2_62_Y, B => BUFF_31_Y, Y => AND2_98_Y);
    NOR2_0 : NOR2
      port map(A => XOR2_33_Y, B => XNOR2_7_Y, Y => NOR2_0_Y);
    MAJ3_11 : MAJ3
      port map(A => MAJ3_35_Y, B => S_6_net, C => PP5_3_net, Y => 
        MAJ3_11_Y);
    AND2_243 : AND2
      port map(A => XOR2_2_Y, B => BUFF_39_Y, Y => AND2_243_Y);
    XOR2_73 : XOR2
      port map(A => SumA_4_net, B => SumB_4_net, Y => XOR2_73_Y);
    XOR3_SumB_23_inst : XOR3
      port map(A => MAJ3_23_Y, B => XOR3_100_Y, C => XOR3_21_Y, 
        Y => SumB_23_net);
    XOR2_PP7_2_inst : XOR2
      port map(A => MX2_91_Y, B => BUFF_44_Y, Y => PP7_2_net);
    AND2_279 : AND2
      port map(A => XOR2_18_Y, B => BUFF_6_Y, Y => AND2_279_Y);
    AND2_41 : AND2
      port map(A => XOR2_96_Y, B => XOR2_51_Y, Y => AND2_41_Y);
    XOR2_79 : XOR2
      port map(A => PP8_10_net, B => PP7_12_net, Y => XOR2_79_Y);
    XOR2_44 : XOR2
      port map(A => PP4_5_net, B => PP3_7_net, Y => XOR2_44_Y);
    MX2_106 : MX2
      port map(A => AND2_245_Y, B => BUFF_55_Y, S => AND2A_1_Y, 
        Y => MX2_106_Y);
    AND2_S_1_inst : AND2
      port map(A => XOR2_98_Y, B => DataB(3), Y => S_1_net);
    AO1_55 : AO1
      port map(A => AND2_252_Y, B => AO1_62_Y, C => AO1_45_Y, 
        Y => AO1_55_Y);
    AND2_132 : AND2
      port map(A => XOR2_64_Y, B => BUFF_68_Y, Y => AND2_132_Y);
    XOR3_56 : XOR3
      port map(A => MAJ3_42_Y, B => MAJ3_5_Y, C => XOR3_66_Y, 
        Y => XOR3_56_Y);
    AND2_107 : AND2
      port map(A => XOR2_109_Y, B => BUFF_60_Y, Y => AND2_107_Y);
    XOR2_PP1_4_inst : XOR2
      port map(A => MX2_83_Y, B => BUFF_36_Y, Y => PP1_4_net);
    MX2_157 : MX2
      port map(A => AND2_34_Y, B => BUFF_9_Y, S => NOR2_4_Y, Y => 
        MX2_157_Y);
    AND2_301 : AND2
      port map(A => AND2_74_Y, B => AND2_139_Y, Y => AND2_301_Y);
    MX2_133 : MX2
      port map(A => AND2_321_Y, B => BUFF_31_Y, S => NOR2_6_Y, 
        Y => MX2_133_Y);
    XOR3_72 : XOR3
      port map(A => PP2_11_net, B => PP0_15_net, C => PP4_7_net, 
        Y => XOR3_72_Y);
    AND2_S_7_inst : AND2
      port map(A => XOR2_46_Y, B => DataB(15), Y => S_7_net);
    NOR2_19 : NOR2
      port map(A => XOR2_105_Y, B => XNOR2_12_Y, Y => NOR2_19_Y);
    MX2_105 : MX2
      port map(A => AND2_72_Y, B => BUFF_34_Y, S => NOR2_15_Y, 
        Y => MX2_105_Y);
    XOR3_48 : XOR3
      port map(A => MAJ3_91_Y, B => MAJ3_63_Y, C => XOR3_90_Y, 
        Y => XOR3_48_Y);
    XOR3_81 : XOR3
      port map(A => MAJ3_29_Y, B => MAJ3_48_Y, C => XOR3_9_Y, 
        Y => XOR3_81_Y);
    XOR3_68 : XOR3
      port map(A => PP8_14_net, B => PP6_18_net, C => MAJ3_10_Y, 
        Y => XOR3_68_Y);
    BUFF_36 : BUFF
      port map(A => DataB(3), Y => BUFF_36_Y);
    AO1_85 : AO1
      port map(A => AND2_224_Y, B => AO1_25_Y, C => AO1_80_Y, 
        Y => AO1_85_Y);
    AND2_211 : AND2
      port map(A => XOR2_17_Y, B => BUFF_2_Y, Y => AND2_211_Y);
    AND2_61 : AND2
      port map(A => XOR2_58_Y, B => BUFF_53_Y, Y => AND2_61_Y);
    XOR3_106 : XOR3
      port map(A => S_6_net, B => PP5_3_net, C => MAJ3_35_Y, Y => 
        XOR3_106_Y);
    MAJ3_80 : MAJ3
      port map(A => MAJ3_24_Y, B => XOR2_10_Y, C => PP7_14_net, 
        Y => MAJ3_80_Y);
    AND2_143 : AND2
      port map(A => AND2_203_Y, B => AND2_140_Y, Y => AND2_143_Y);
    XOR3_102 : XOR3
      port map(A => AND2_134_Y, B => PP7_15_net, C => XOR3_41_Y, 
        Y => XOR3_102_Y);
    XOR3_SumB_27_inst : XOR3
      port map(A => MAJ3_67_Y, B => XOR3_27_Y, C => XOR3_81_Y, 
        Y => SumB_27_net);
    XOR2_77 : XOR2
      port map(A => PP6_22_net, B => VCC_1_net, Y => XOR2_77_Y);
    AO1_46 : AO1
      port map(A => AND2_68_Y, B => AO1_90_Y, C => AO1_10_Y, Y => 
        AO1_46_Y);
    XOR2_91 : XOR2
      port map(A => SumA_27_net, B => SumB_27_net, Y => XOR2_91_Y);
    MAJ3_22 : MAJ3
      port map(A => MAJ3_10_Y, B => PP8_14_net, C => PP6_18_net, 
        Y => MAJ3_22_Y);
    MX2_36 : MX2
      port map(A => AND2_237_Y, B => BUFF_73_Y, S => NOR2_19_Y, 
        Y => MX2_36_Y);
    AND2_324 : AND2
      port map(A => AND2_65_Y, B => XOR2_9_Y, Y => AND2_324_Y);
    AO1_77 : AO1
      port map(A => AND2_295_Y, B => AO1_90_Y, C => AO1_70_Y, 
        Y => AO1_77_Y);
    AND2_252 : AND2
      port map(A => AND2_232_Y, B => XOR2_41_Y, Y => AND2_252_Y);
    AND2_PP8_2_inst : AND2
      port map(A => DataB(15), B => BUFF_51_Y, Y => PP8_2_net);
    MX2_15 : MX2
      port map(A => AND2_271_Y, B => BUFF_23_Y, S => AND2A_1_Y, 
        Y => MX2_15_Y);
    AND2_237 : AND2
      port map(A => XOR2_105_Y, B => BUFF_85_Y, Y => AND2_237_Y);
    AND2_219 : AND2
      port map(A => AND2_102_Y, B => AND2_224_Y, Y => AND2_219_Y);
    BUFF_49 : BUFF
      port map(A => DataA(16), Y => BUFF_49_Y);
    AND2_25 : AND2
      port map(A => SumA_24_net, B => SumB_24_net, Y => AND2_25_Y);
    AO1_64 : AO1
      port map(A => AND2_136_Y, B => AO1_93_Y, C => AO1_13_Y, 
        Y => AO1_64_Y);
    AND2_S_2_inst : AND2
      port map(A => XOR2_35_Y, B => DataB(5), Y => S_2_net);
    XOR2_63 : XOR2
      port map(A => SumA_12_net, B => SumB_12_net, Y => XOR2_63_Y);
    AND2_46 : AND2
      port map(A => PP1_5_net, B => PP0_7_net, Y => AND2_46_Y);
    XOR3_76 : XOR3
      port map(A => PP4_3_net, B => PP2_7_net, C => S_5_net, Y => 
        XOR3_76_Y);
    AND2_84 : AND2
      port map(A => XOR2_64_Y, B => BUFF_11_Y, Y => AND2_84_Y);
    XOR2_PP7_20_inst : XOR2
      port map(A => MX2_63_Y, B => BUFF_83_Y, Y => PP7_20_net);
    NOR2_14 : NOR2
      port map(A => XOR2_2_Y, B => XNOR2_6_Y, Y => NOR2_14_Y);
    XOR2_69 : XOR2
      port map(A => PP1_5_net, B => PP0_7_net, Y => XOR2_69_Y);
    MX2_27 : MX2
      port map(A => AND2_147_Y, B => BUFF_18_Y, S => NOR2_6_Y, 
        Y => MX2_27_Y);
    AND2_PP8_1_inst : AND2
      port map(A => DataB(15), B => BUFF_30_Y, Y => PP8_1_net);
    MAJ3_72 : MAJ3
      port map(A => PP2_4_net, B => PP1_6_net, C => PP0_8_net, 
        Y => MAJ3_72_Y);
    AND2_236 : AND2
      port map(A => XOR2_17_Y, B => BUFF_88_Y, Y => AND2_236_Y);
    AO1_78 : AO1
      port map(A => XOR2_97_Y, B => AND2_22_Y, C => AND2_13_Y, 
        Y => AO1_78_Y);
    AO1_5 : AO1
      port map(A => AND2_64_Y, B => AO1_15_Y, C => AO1_81_Y, Y => 
        AO1_5_Y);
    AND2_124 : AND2
      port map(A => NOR2_0_Y, B => BUFF_17_Y, Y => AND2_124_Y);
    XOR2_45 : XOR2
      port map(A => PP1_3_net, B => PP0_5_net, Y => XOR2_45_Y);
    XOR2_PP6_16_inst : XOR2
      port map(A => MX2_71_Y, B => BUFF_71_Y, Y => PP6_16_net);
    AND2_261 : AND2
      port map(A => SumA_36_net, B => SumB_36_net, Y => 
        AND2_261_Y);
    AND2_66 : AND2
      port map(A => SumA_18_net, B => SumB_18_net, Y => AND2_66_Y);
    AO1_8 : AO1
      port map(A => AND2_19_Y, B => AO1_51_Y, C => AO1_52_Y, Y => 
        AO1_8_Y);
    XOR2_PP2_3_inst : XOR2
      port map(A => MX2_96_Y, B => BUFF_62_Y, Y => PP2_3_net);
    MX2_140 : MX2
      port map(A => AND2_212_Y, B => BUFF_65_Y, S => NOR2_5_Y, 
        Y => MX2_140_Y);
    MX2_166 : MX2
      port map(A => AND2_264_Y, B => BUFF_12_Y, S => NOR2_13_Y, 
        Y => MX2_166_Y);
    MX2_5 : MX2
      port map(A => AND2_322_Y, B => BUFF_45_Y, S => NOR2_7_Y, 
        Y => MX2_5_Y);
    MX2_132 : MX2
      port map(A => AND2_169_Y, B => BUFF_5_Y, S => NOR2_20_Y, 
        Y => MX2_132_Y);
    XOR2_PP5_22_inst : XOR2
      port map(A => AND2_30_Y, B => BUFF_43_Y, Y => PP5_22_net);
    XOR3_SumB_11_inst : XOR3
      port map(A => MAJ3_79_Y, B => XOR3_91_Y, C => XOR3_22_Y, 
        Y => SumB_11_net);
    MX2_165 : MX2
      port map(A => AND2_199_Y, B => BUFF_63_Y, S => NOR2_3_Y, 
        Y => MX2_165_Y);
    BUFF_56 : BUFF
      port map(A => DataA(0), Y => BUFF_56_Y);
    XOR2_67 : XOR2
      port map(A => SumA_6_net, B => SumB_6_net, Y => XOR2_67_Y);
    XOR3_0 : XOR3
      port map(A => PP3_18_net, B => DataB(1), C => PP6_12_net, 
        Y => XOR3_0_Y);
    AND2_121 : AND2
      port map(A => XOR2_41_Y, B => XOR2_113_Y, Y => AND2_121_Y);
    AND2_PP8_14_inst : AND2
      port map(A => DataB(15), B => BUFF_64_Y, Y => PP8_14_net);
    MX2_9 : MX2
      port map(A => AND2_230_Y, B => BUFF_32_Y, S => AND2A_2_Y, 
        Y => MX2_9_Y);
    XOR2_Mult_4_inst : XOR2
      port map(A => XOR2_108_Y, B => AO1_103_Y, Y => Mult(4));
    MX2_82 : MX2
      port map(A => AND2_206_Y, B => BUFF_69_Y, S => NOR2_17_Y, 
        Y => MX2_82_Y);
    AND2_269 : AND2
      port map(A => XOR2_36_Y, B => BUFF_33_Y, Y => AND2_269_Y);
    AO1_69 : AO1
      port map(A => XOR2_95_Y, B => AND2_89_Y, C => AND2_281_Y, 
        Y => AO1_69_Y);
    NOR2_4 : NOR2
      port map(A => XOR2_83_Y, B => XNOR2_1_Y, Y => NOR2_4_Y);
    AND2_97 : AND2
      port map(A => SumA_16_net, B => SumB_16_net, Y => AND2_97_Y);
    XOR3_5 : XOR3
      port map(A => PP6_0_net, B => PP4_4_net, C => XOR3_46_Y, 
        Y => XOR3_5_Y);
    XOR3_SumB_5_inst : XOR3
      port map(A => AND2_9_Y, B => PP3_0_net, C => XOR3_6_Y, Y => 
        SumB_5_net);
    AND2_240 : AND2
      port map(A => XOR2_2_Y, B => BUFF_5_Y, Y => AND2_240_Y);
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
-- DESDIR:D:/Work/marmote/projects/FIR_SRAM/smartgen\mult
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IP4X3M1
-- SMARTGEN_PACKAGE:fg484
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTHA:22
-- WIDTHB:16
-- REPRESENTATION:UNSIGNED
-- CLK_EDGE:RISE
-- MAXPGEN:0
-- PIPES:0
-- INST_FA:1
-- HYBRID:0
-- DEBUG:0

-- _End_Comments_

