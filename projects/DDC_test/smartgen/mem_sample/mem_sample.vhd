-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity mem_sample is 
    port( WD : in std_logic_vector(21 downto 0); RD : out 
        std_logic_vector(21 downto 0);WEN, REN : in std_logic; 
        WADDR : in std_logic_vector(8 downto 0); RADDR : in 
        std_logic_vector(8 downto 0);RWCLK, RESET : in std_logic
        ) ;
end mem_sample;


architecture DEF_ARCH of  mem_sample is

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component OR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component BUFF
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component RAM512X18
    generic (MEMORYFILE:string := "");

        port(RADDR8, RADDR7, RADDR6, RADDR5, RADDR4, RADDR3, 
        RADDR2, RADDR1, RADDR0, WADDR8, WADDR7, WADDR6, WADDR5, 
        WADDR4, WADDR3, WADDR2, WADDR1, WADDR0, WD17, WD16, WD15, 
        WD14, WD13, WD12, WD11, WD10, WD9, WD8, WD7, WD6, WD5, 
        WD4, WD3, WD2, WD1, WD0, RW0, RW1, WW0, WW1, PIPE, REN, 
        WEN, RCLK, WCLK, RESET : in std_logic := 'U'; RD17, RD16, 
        RD15, RD14, RD13, RD12, RD11, RD10, RD9, RD8, RD7, RD6, 
        RD5, RD4, RD3, RD2, RD1, RD0 : out std_logic) ;
    end component;

    component DFN1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal WEAP, WEBP, RESETP, ADDRA_FF2_0_net, ADDRB_FF2_0_net, 
        ENABLE_ADDRA_0_net, ENABLE_ADDRA_1_net, 
        ENABLE_ADDRB_0_net, ENABLE_ADDRB_1_net, BLKA_EN_0_net, 
        BLKB_EN_0_net, BLKA_EN_1_net, BLKB_EN_1_net, 
        QX_TEMPR0_0_net, QX_TEMPR0_1_net, QX_TEMPR0_2_net, 
        QX_TEMPR0_3_net, QX_TEMPR0_4_net, QX_TEMPR0_5_net, 
        QX_TEMPR0_6_net, QX_TEMPR0_7_net, QX_TEMPR0_8_net, 
        QX_TEMPR0_9_net, QX_TEMPR0_10_net, QX_TEMPR1_0_net, 
        QX_TEMPR1_1_net, QX_TEMPR1_2_net, QX_TEMPR1_3_net, 
        QX_TEMPR1_4_net, QX_TEMPR1_5_net, QX_TEMPR1_6_net, 
        QX_TEMPR1_7_net, QX_TEMPR1_8_net, QX_TEMPR1_9_net, 
        QX_TEMPR1_10_net, QX_TEMPR0_11_net, QX_TEMPR0_12_net, 
        QX_TEMPR0_13_net, QX_TEMPR0_14_net, QX_TEMPR0_15_net, 
        QX_TEMPR0_16_net, QX_TEMPR0_17_net, QX_TEMPR0_18_net, 
        QX_TEMPR0_19_net, QX_TEMPR0_20_net, QX_TEMPR0_21_net, 
        QX_TEMPR1_11_net, QX_TEMPR1_12_net, QX_TEMPR1_13_net, 
        QX_TEMPR1_14_net, QX_TEMPR1_15_net, QX_TEMPR1_16_net, 
        QX_TEMPR1_17_net, QX_TEMPR1_18_net, QX_TEMPR1_19_net, 
        QX_TEMPR1_20_net, QX_TEMPR1_21_net, VCC_1_net, GND_1_net : std_logic ;
    begin   

    VCC_2_net : VCC port map(Y => VCC_1_net);
    GND_2_net : GND port map(Y => GND_1_net);
    MX2_RD_20_inst : MX2
      port map(A => QX_TEMPR0_20_net, B => QX_TEMPR1_20_net, S => 
        ADDRB_FF2_0_net, Y => RD(20));
    MX2_RD_4_inst : MX2
      port map(A => QX_TEMPR0_4_net, B => QX_TEMPR1_4_net, S => 
        ADDRB_FF2_0_net, Y => RD(4));
    INV_ENABLE_ADDRB_1_inst : INV
      port map(A => RADDR(8), Y => ENABLE_ADDRB_1_net);
    MX2_RD_3_inst : MX2
      port map(A => QX_TEMPR0_3_net, B => QX_TEMPR1_3_net, S => 
        ADDRB_FF2_0_net, Y => RD(3));
    MX2_RD_6_inst : MX2
      port map(A => QX_TEMPR0_6_net, B => QX_TEMPR1_6_net, S => 
        ADDRB_FF2_0_net, Y => RD(6));
    MX2_RD_19_inst : MX2
      port map(A => QX_TEMPR0_19_net, B => QX_TEMPR1_19_net, S => 
        ADDRB_FF2_0_net, Y => RD(19));
    MX2_RD_16_inst : MX2
      port map(A => QX_TEMPR0_16_net, B => QX_TEMPR1_16_net, S => 
        ADDRB_FF2_0_net, Y => RD(16));
    MX2_RD_21_inst : MX2
      port map(A => QX_TEMPR0_21_net, B => QX_TEMPR1_21_net, S => 
        ADDRB_FF2_0_net, Y => RD(21));
    ORB_GATE_1_inst : OR2
      port map(A => ENABLE_ADDRB_1_net, B => WEBP, Y => 
        BLKB_EN_1_net);
    MX2_RD_12_inst : MX2
      port map(A => QX_TEMPR0_12_net, B => QX_TEMPR1_12_net, S => 
        ADDRB_FF2_0_net, Y => RD(12));
    ORA_GATE_1_inst : OR2
      port map(A => ENABLE_ADDRA_1_net, B => WEAP, Y => 
        BLKA_EN_1_net);
    RESETBUBBLE : INV
      port map(A => RESET, Y => RESETP);
    MX2_RD_5_inst : MX2
      port map(A => QX_TEMPR0_5_net, B => QX_TEMPR1_5_net, S => 
        ADDRB_FF2_0_net, Y => RD(5));
    MX2_RD_2_inst : MX2
      port map(A => QX_TEMPR0_2_net, B => QX_TEMPR1_2_net, S => 
        ADDRB_FF2_0_net, Y => RD(2));
    BUFF_ENABLE_ADDRB_0_inst : BUFF
      port map(A => RADDR(8), Y => ENABLE_ADDRB_0_net);
    mem_sample_R1C0 : RAM512X18
      port map(RADDR8 => GND_1_net, RADDR7 => RADDR(7), RADDR6 => 
        RADDR(6), RADDR5 => RADDR(5), RADDR4 => RADDR(4), 
        RADDR3 => RADDR(3), RADDR2 => RADDR(2), RADDR1 => 
        RADDR(1), RADDR0 => RADDR(0), WADDR8 => GND_1_net, 
        WADDR7 => WADDR(7), WADDR6 => WADDR(6), WADDR5 => 
        WADDR(5), WADDR4 => WADDR(4), WADDR3 => WADDR(3), 
        WADDR2 => WADDR(2), WADDR1 => WADDR(1), WADDR0 => 
        WADDR(0), WD17 => GND_1_net, WD16 => GND_1_net, WD15 => 
        GND_1_net, WD14 => GND_1_net, WD13 => GND_1_net, WD12 => 
        GND_1_net, WD11 => GND_1_net, WD10 => WD(10), WD9 => 
        WD(9), WD8 => WD(8), WD7 => WD(7), WD6 => WD(6), WD5 => 
        WD(5), WD4 => WD(4), WD3 => WD(3), WD2 => WD(2), WD1 => 
        WD(1), WD0 => WD(0), RW0 => GND_1_net, RW1 => VCC_1_net, 
        WW0 => GND_1_net, WW1 => VCC_1_net, PIPE => GND_1_net, 
        REN => BLKB_EN_1_net, WEN => BLKA_EN_1_net, RCLK => RWCLK, 
        WCLK => RWCLK, RESET => RESETP, RD17 => OPEN , RD16 => 
        OPEN , RD15 => OPEN , RD14 => OPEN , RD13 => OPEN , 
        RD12 => OPEN , RD11 => OPEN , RD10 => QX_TEMPR1_10_net, 
        RD9 => QX_TEMPR1_9_net, RD8 => QX_TEMPR1_8_net, RD7 => 
        QX_TEMPR1_7_net, RD6 => QX_TEMPR1_6_net, RD5 => 
        QX_TEMPR1_5_net, RD4 => QX_TEMPR1_4_net, RD3 => 
        QX_TEMPR1_3_net, RD2 => QX_TEMPR1_2_net, RD1 => 
        QX_TEMPR1_1_net, RD0 => QX_TEMPR1_0_net);
    INV_ENABLE_ADDRA_1_inst : INV
      port map(A => WADDR(8), Y => ENABLE_ADDRA_1_net);
    mem_sample_R1C1 : RAM512X18
      port map(RADDR8 => GND_1_net, RADDR7 => RADDR(7), RADDR6 => 
        RADDR(6), RADDR5 => RADDR(5), RADDR4 => RADDR(4), 
        RADDR3 => RADDR(3), RADDR2 => RADDR(2), RADDR1 => 
        RADDR(1), RADDR0 => RADDR(0), WADDR8 => GND_1_net, 
        WADDR7 => WADDR(7), WADDR6 => WADDR(6), WADDR5 => 
        WADDR(5), WADDR4 => WADDR(4), WADDR3 => WADDR(3), 
        WADDR2 => WADDR(2), WADDR1 => WADDR(1), WADDR0 => 
        WADDR(0), WD17 => GND_1_net, WD16 => GND_1_net, WD15 => 
        GND_1_net, WD14 => GND_1_net, WD13 => GND_1_net, WD12 => 
        GND_1_net, WD11 => GND_1_net, WD10 => WD(21), WD9 => 
        WD(20), WD8 => WD(19), WD7 => WD(18), WD6 => WD(17), 
        WD5 => WD(16), WD4 => WD(15), WD3 => WD(14), WD2 => 
        WD(13), WD1 => WD(12), WD0 => WD(11), RW0 => GND_1_net, 
        RW1 => VCC_1_net, WW0 => GND_1_net, WW1 => VCC_1_net, 
        PIPE => GND_1_net, REN => BLKB_EN_1_net, WEN => 
        BLKA_EN_1_net, RCLK => RWCLK, WCLK => RWCLK, RESET => 
        RESETP, RD17 => OPEN , RD16 => OPEN , RD15 => OPEN , 
        RD14 => OPEN , RD13 => OPEN , RD12 => OPEN , RD11 => 
        OPEN , RD10 => QX_TEMPR1_21_net, RD9 => QX_TEMPR1_20_net, 
        RD8 => QX_TEMPR1_19_net, RD7 => QX_TEMPR1_18_net, RD6 => 
        QX_TEMPR1_17_net, RD5 => QX_TEMPR1_16_net, RD4 => 
        QX_TEMPR1_15_net, RD3 => QX_TEMPR1_14_net, RD2 => 
        QX_TEMPR1_13_net, RD1 => QX_TEMPR1_12_net, RD0 => 
        QX_TEMPR1_11_net);
    MX2_RD_1_inst : MX2
      port map(A => QX_TEMPR0_1_net, B => QX_TEMPR1_1_net, S => 
        ADDRB_FF2_0_net, Y => RD(1));
    AFF1_0_inst : DFN1
      port map(D => WADDR(8), CLK => RWCLK, Q => ADDRA_FF2_0_net);
    MX2_RD_7_inst : MX2
      port map(A => QX_TEMPR0_7_net, B => QX_TEMPR1_7_net, S => 
        ADDRB_FF2_0_net, Y => RD(7));
    WEBUBBLEB : INV
      port map(A => REN, Y => WEBP);
    MX2_RD_18_inst : MX2
      port map(A => QX_TEMPR0_18_net, B => QX_TEMPR1_18_net, S => 
        ADDRB_FF2_0_net, Y => RD(18));
    BFF1_0_inst : DFN1
      port map(D => RADDR(8), CLK => RWCLK, Q => ADDRB_FF2_0_net);
    ORB_GATE_0_inst : OR2
      port map(A => ENABLE_ADDRB_0_net, B => WEBP, Y => 
        BLKB_EN_0_net);
    BUFF_ENABLE_ADDRA_0_inst : BUFF
      port map(A => WADDR(8), Y => ENABLE_ADDRA_0_net);
    MX2_RD_9_inst : MX2
      port map(A => QX_TEMPR0_9_net, B => QX_TEMPR1_9_net, S => 
        ADDRB_FF2_0_net, Y => RD(9));
    ORA_GATE_0_inst : OR2
      port map(A => ENABLE_ADDRA_0_net, B => WEAP, Y => 
        BLKA_EN_0_net);
    MX2_RD_0_inst : MX2
      port map(A => QX_TEMPR0_0_net, B => QX_TEMPR1_0_net, S => 
        ADDRB_FF2_0_net, Y => RD(0));
    MX2_RD_15_inst : MX2
      port map(A => QX_TEMPR0_15_net, B => QX_TEMPR1_15_net, S => 
        ADDRB_FF2_0_net, Y => RD(15));
    MX2_RD_17_inst : MX2
      port map(A => QX_TEMPR0_17_net, B => QX_TEMPR1_17_net, S => 
        ADDRB_FF2_0_net, Y => RD(17));
    MX2_RD_8_inst : MX2
      port map(A => QX_TEMPR0_8_net, B => QX_TEMPR1_8_net, S => 
        ADDRB_FF2_0_net, Y => RD(8));
    MX2_RD_10_inst : MX2
      port map(A => QX_TEMPR0_10_net, B => QX_TEMPR1_10_net, S => 
        ADDRB_FF2_0_net, Y => RD(10));
    MX2_RD_14_inst : MX2
      port map(A => QX_TEMPR0_14_net, B => QX_TEMPR1_14_net, S => 
        ADDRB_FF2_0_net, Y => RD(14));
    WEBUBBLEA : INV
      port map(A => WEN, Y => WEAP);
    mem_sample_R0C0 : RAM512X18
      port map(RADDR8 => GND_1_net, RADDR7 => RADDR(7), RADDR6 => 
        RADDR(6), RADDR5 => RADDR(5), RADDR4 => RADDR(4), 
        RADDR3 => RADDR(3), RADDR2 => RADDR(2), RADDR1 => 
        RADDR(1), RADDR0 => RADDR(0), WADDR8 => GND_1_net, 
        WADDR7 => WADDR(7), WADDR6 => WADDR(6), WADDR5 => 
        WADDR(5), WADDR4 => WADDR(4), WADDR3 => WADDR(3), 
        WADDR2 => WADDR(2), WADDR1 => WADDR(1), WADDR0 => 
        WADDR(0), WD17 => GND_1_net, WD16 => GND_1_net, WD15 => 
        GND_1_net, WD14 => GND_1_net, WD13 => GND_1_net, WD12 => 
        GND_1_net, WD11 => GND_1_net, WD10 => WD(10), WD9 => 
        WD(9), WD8 => WD(8), WD7 => WD(7), WD6 => WD(6), WD5 => 
        WD(5), WD4 => WD(4), WD3 => WD(3), WD2 => WD(2), WD1 => 
        WD(1), WD0 => WD(0), RW0 => GND_1_net, RW1 => VCC_1_net, 
        WW0 => GND_1_net, WW1 => VCC_1_net, PIPE => GND_1_net, 
        REN => BLKB_EN_0_net, WEN => BLKA_EN_0_net, RCLK => RWCLK, 
        WCLK => RWCLK, RESET => RESETP, RD17 => OPEN , RD16 => 
        OPEN , RD15 => OPEN , RD14 => OPEN , RD13 => OPEN , 
        RD12 => OPEN , RD11 => OPEN , RD10 => QX_TEMPR0_10_net, 
        RD9 => QX_TEMPR0_9_net, RD8 => QX_TEMPR0_8_net, RD7 => 
        QX_TEMPR0_7_net, RD6 => QX_TEMPR0_6_net, RD5 => 
        QX_TEMPR0_5_net, RD4 => QX_TEMPR0_4_net, RD3 => 
        QX_TEMPR0_3_net, RD2 => QX_TEMPR0_2_net, RD1 => 
        QX_TEMPR0_1_net, RD0 => QX_TEMPR0_0_net);
    MX2_RD_11_inst : MX2
      port map(A => QX_TEMPR0_11_net, B => QX_TEMPR1_11_net, S => 
        ADDRB_FF2_0_net, Y => RD(11));
    MX2_RD_13_inst : MX2
      port map(A => QX_TEMPR0_13_net, B => QX_TEMPR1_13_net, S => 
        ADDRB_FF2_0_net, Y => RD(13));
    mem_sample_R0C1 : RAM512X18
      port map(RADDR8 => GND_1_net, RADDR7 => RADDR(7), RADDR6 => 
        RADDR(6), RADDR5 => RADDR(5), RADDR4 => RADDR(4), 
        RADDR3 => RADDR(3), RADDR2 => RADDR(2), RADDR1 => 
        RADDR(1), RADDR0 => RADDR(0), WADDR8 => GND_1_net, 
        WADDR7 => WADDR(7), WADDR6 => WADDR(6), WADDR5 => 
        WADDR(5), WADDR4 => WADDR(4), WADDR3 => WADDR(3), 
        WADDR2 => WADDR(2), WADDR1 => WADDR(1), WADDR0 => 
        WADDR(0), WD17 => GND_1_net, WD16 => GND_1_net, WD15 => 
        GND_1_net, WD14 => GND_1_net, WD13 => GND_1_net, WD12 => 
        GND_1_net, WD11 => GND_1_net, WD10 => WD(21), WD9 => 
        WD(20), WD8 => WD(19), WD7 => WD(18), WD6 => WD(17), 
        WD5 => WD(16), WD4 => WD(15), WD3 => WD(14), WD2 => 
        WD(13), WD1 => WD(12), WD0 => WD(11), RW0 => GND_1_net, 
        RW1 => VCC_1_net, WW0 => GND_1_net, WW1 => VCC_1_net, 
        PIPE => GND_1_net, REN => BLKB_EN_0_net, WEN => 
        BLKA_EN_0_net, RCLK => RWCLK, WCLK => RWCLK, RESET => 
        RESETP, RD17 => OPEN , RD16 => OPEN , RD15 => OPEN , 
        RD14 => OPEN , RD13 => OPEN , RD12 => OPEN , RD11 => 
        OPEN , RD10 => QX_TEMPR0_21_net, RD9 => QX_TEMPR0_20_net, 
        RD8 => QX_TEMPR0_19_net, RD7 => QX_TEMPR0_18_net, RD6 => 
        QX_TEMPR0_17_net, RD5 => QX_TEMPR0_16_net, RD4 => 
        QX_TEMPR0_15_net, RD3 => QX_TEMPR0_14_net, RD2 => 
        QX_TEMPR0_13_net, RD1 => QX_TEMPR0_12_net, RD0 => 
        QX_TEMPR0_11_net);
end DEF_ARCH;

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.2.16
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:SmartFusion
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_RAM
-- LPM_HINT:TWO
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:D:/Work/marmote/projects/DDC_test/smartgen\mem_sample
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IP4X3M1
-- SMARTGEN_PACKAGE:fg484
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WWIDTH:22
-- WDEPTH:512
-- RWIDTH:22
-- RDEPTH:512
-- CLKS:1
-- CLOCK_PN:RWCLK
-- RESET_PN:RESET
-- RESET_POLARITY:1
-- INIT_RAM:F
-- DEFAULT_WORD:0x000000
-- CASCADE:1
-- WCLK_EDGE:RISE
-- PMODE2:0
-- DATA_IN_PN:WD
-- WADDRESS_PN:WADDR
-- WE_PN:WEN
-- DATA_OUT_PN:RD
-- RADDRESS_PN:RADDR
-- RE_PN:REN
-- WE_POLARITY:1
-- RE_POLARITY:1
-- PTYPE:1

-- _End_Comments_

