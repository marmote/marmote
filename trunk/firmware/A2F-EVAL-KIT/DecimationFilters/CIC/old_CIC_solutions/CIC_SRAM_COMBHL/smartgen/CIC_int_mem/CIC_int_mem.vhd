-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity CIC_int_mem is 
    port( WD : in std_logic_vector(53 downto 0); RD : out 
        std_logic_vector(53 downto 0);WEN, REN : in std_logic; 
        WADDR : in std_logic_vector(2 downto 0); RADDR : in 
        std_logic_vector(2 downto 0);RWCLK, RESET : in std_logic
        ) ;
end CIC_int_mem;


architecture DEF_ARCH of  CIC_int_mem is

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

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal WEAP, WEBP, RESETP, VCC_1_net, GND_1_net : std_logic ;
    begin   

    VCC_2_net : VCC port map(Y => VCC_1_net);
    GND_2_net : GND port map(Y => GND_1_net);
    CIC_int_mem_R0C1 : RAM512X18
      generic map(MEMORYFILE => "CIC_int_mem_R0C1.mem")

      port map(RADDR8 => GND_1_net, RADDR7 => GND_1_net, 
        RADDR6 => GND_1_net, RADDR5 => GND_1_net, RADDR4 => 
        GND_1_net, RADDR3 => GND_1_net, RADDR2 => RADDR(2), 
        RADDR1 => RADDR(1), RADDR0 => RADDR(0), WADDR8 => 
        GND_1_net, WADDR7 => GND_1_net, WADDR6 => GND_1_net, 
        WADDR5 => GND_1_net, WADDR4 => GND_1_net, WADDR3 => 
        GND_1_net, WADDR2 => WADDR(2), WADDR1 => WADDR(1), 
        WADDR0 => WADDR(0), WD17 => WD(35), WD16 => WD(34), 
        WD15 => WD(33), WD14 => WD(32), WD13 => WD(31), WD12 => 
        WD(30), WD11 => WD(29), WD10 => WD(28), WD9 => WD(27), 
        WD8 => WD(26), WD7 => WD(25), WD6 => WD(24), WD5 => 
        WD(23), WD4 => WD(22), WD3 => WD(21), WD2 => WD(20), 
        WD1 => WD(19), WD0 => WD(18), RW0 => GND_1_net, RW1 => 
        VCC_1_net, WW0 => GND_1_net, WW1 => VCC_1_net, PIPE => 
        GND_1_net, REN => WEBP, WEN => WEAP, RCLK => RWCLK, 
        WCLK => RWCLK, RESET => RESETP, RD17 => RD(35), RD16 => 
        RD(34), RD15 => RD(33), RD14 => RD(32), RD13 => RD(31), 
        RD12 => RD(30), RD11 => RD(29), RD10 => RD(28), RD9 => 
        RD(27), RD8 => RD(26), RD7 => RD(25), RD6 => RD(24), 
        RD5 => RD(23), RD4 => RD(22), RD3 => RD(21), RD2 => 
        RD(20), RD1 => RD(19), RD0 => RD(18));
    RESETBUBBLE : INV
      port map(A => RESET, Y => RESETP);
    WEBUBBLEB : INV
      port map(A => REN, Y => WEBP);
    CIC_int_mem_R0C2 : RAM512X18
      generic map(MEMORYFILE => "CIC_int_mem_R0C2.mem")

      port map(RADDR8 => GND_1_net, RADDR7 => GND_1_net, 
        RADDR6 => GND_1_net, RADDR5 => GND_1_net, RADDR4 => 
        GND_1_net, RADDR3 => GND_1_net, RADDR2 => RADDR(2), 
        RADDR1 => RADDR(1), RADDR0 => RADDR(0), WADDR8 => 
        GND_1_net, WADDR7 => GND_1_net, WADDR6 => GND_1_net, 
        WADDR5 => GND_1_net, WADDR4 => GND_1_net, WADDR3 => 
        GND_1_net, WADDR2 => WADDR(2), WADDR1 => WADDR(1), 
        WADDR0 => WADDR(0), WD17 => WD(53), WD16 => WD(52), 
        WD15 => WD(51), WD14 => WD(50), WD13 => WD(49), WD12 => 
        WD(48), WD11 => WD(47), WD10 => WD(46), WD9 => WD(45), 
        WD8 => WD(44), WD7 => WD(43), WD6 => WD(42), WD5 => 
        WD(41), WD4 => WD(40), WD3 => WD(39), WD2 => WD(38), 
        WD1 => WD(37), WD0 => WD(36), RW0 => GND_1_net, RW1 => 
        VCC_1_net, WW0 => GND_1_net, WW1 => VCC_1_net, PIPE => 
        GND_1_net, REN => WEBP, WEN => WEAP, RCLK => RWCLK, 
        WCLK => RWCLK, RESET => RESETP, RD17 => RD(53), RD16 => 
        RD(52), RD15 => RD(51), RD14 => RD(50), RD13 => RD(49), 
        RD12 => RD(48), RD11 => RD(47), RD10 => RD(46), RD9 => 
        RD(45), RD8 => RD(44), RD7 => RD(43), RD6 => RD(42), 
        RD5 => RD(41), RD4 => RD(40), RD3 => RD(39), RD2 => 
        RD(38), RD1 => RD(37), RD0 => RD(36));
    WEBUBBLEA : INV
      port map(A => WEN, Y => WEAP);
    CIC_int_mem_R0C0 : RAM512X18
      generic map(MEMORYFILE => "CIC_int_mem_R0C0.mem")

      port map(RADDR8 => GND_1_net, RADDR7 => GND_1_net, 
        RADDR6 => GND_1_net, RADDR5 => GND_1_net, RADDR4 => 
        GND_1_net, RADDR3 => GND_1_net, RADDR2 => RADDR(2), 
        RADDR1 => RADDR(1), RADDR0 => RADDR(0), WADDR8 => 
        GND_1_net, WADDR7 => GND_1_net, WADDR6 => GND_1_net, 
        WADDR5 => GND_1_net, WADDR4 => GND_1_net, WADDR3 => 
        GND_1_net, WADDR2 => WADDR(2), WADDR1 => WADDR(1), 
        WADDR0 => WADDR(0), WD17 => WD(17), WD16 => WD(16), 
        WD15 => WD(15), WD14 => WD(14), WD13 => WD(13), WD12 => 
        WD(12), WD11 => WD(11), WD10 => WD(10), WD9 => WD(9), 
        WD8 => WD(8), WD7 => WD(7), WD6 => WD(6), WD5 => WD(5), 
        WD4 => WD(4), WD3 => WD(3), WD2 => WD(2), WD1 => WD(1), 
        WD0 => WD(0), RW0 => GND_1_net, RW1 => VCC_1_net, WW0 => 
        GND_1_net, WW1 => VCC_1_net, PIPE => GND_1_net, REN => 
        WEBP, WEN => WEAP, RCLK => RWCLK, WCLK => RWCLK, RESET => 
        RESETP, RD17 => RD(17), RD16 => RD(16), RD15 => RD(15), 
        RD14 => RD(14), RD13 => RD(13), RD12 => RD(12), RD11 => 
        RD(11), RD10 => RD(10), RD9 => RD(9), RD8 => RD(8), 
        RD7 => RD(7), RD6 => RD(6), RD5 => RD(5), RD4 => RD(4), 
        RD3 => RD(3), RD2 => RD(2), RD1 => RD(1), RD0 => RD(0));
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
-- DESDIR:D:/Work/marmote/projects/CIC_SRAM_COMBHL/smartgen\CIC_int_mem
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IP4X3M1
-- SMARTGEN_PACKAGE:fg484
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WWIDTH:54
-- WDEPTH:5
-- RWIDTH:54
-- RDEPTH:5
-- CLKS:1
-- CLOCK_PN:RWCLK
-- RESET_PN:RESET
-- RESET_POLARITY:1
-- INIT_RAM:T
-- DEFAULT_WORD:0x00000000000000
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

