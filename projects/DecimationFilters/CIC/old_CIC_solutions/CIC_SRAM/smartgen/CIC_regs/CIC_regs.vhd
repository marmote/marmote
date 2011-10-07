-- Version: 9.1 SP2 9.1.2.16

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity CIC_regs is 
    port( DINA : in std_logic_vector(46 downto 0); DOUTA : out 
        std_logic_vector(46 downto 0); DINB : in 
        std_logic_vector(46 downto 0); DOUTB : out 
        std_logic_vector(46 downto 0); ADDRA : in 
        std_logic_vector(3 downto 0); ADDRB : in 
        std_logic_vector(3 downto 0);RWA, RWB, BLKA, BLKB, CLKAB, 
        RESET : in std_logic) ;
end CIC_regs;


architecture DEF_ARCH of  CIC_regs is

    component RAM4K9
    generic (MEMORYFILE:string := "");

        port(ADDRA11, ADDRA10, ADDRA9, ADDRA8, ADDRA7, ADDRA6, 
        ADDRA5, ADDRA4, ADDRA3, ADDRA2, ADDRA1, ADDRA0, ADDRB11, 
        ADDRB10, ADDRB9, ADDRB8, ADDRB7, ADDRB6, ADDRB5, ADDRB4, 
        ADDRB3, ADDRB2, ADDRB1, ADDRB0, DINA8, DINA7, DINA6, 
        DINA5, DINA4, DINA3, DINA2, DINA1, DINA0, DINB8, DINB7, 
        DINB6, DINB5, DINB4, DINB3, DINB2, DINB1, DINB0, WIDTHA0, 
        WIDTHA1, WIDTHB0, WIDTHB1, PIPEA, PIPEB, WMODEA, WMODEB, 
        BLKA, BLKB, WENA, WENB, CLKA, CLKB, RESET : in std_logic := 
        'U'; DOUTA8, DOUTA7, DOUTA6, DOUTA5, DOUTA4, DOUTA3, 
        DOUTA2, DOUTA1, DOUTA0, DOUTB8, DOUTB7, DOUTB6, DOUTB5, 
        DOUTB4, DOUTB3, DOUTB2, DOUTB1, DOUTB0 : out std_logic) ;
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

    signal RESETP, VCC_1_net, GND_1_net : std_logic ;
    begin   

    VCC_2_net : VCC port map(Y => VCC_1_net);
    GND_2_net : GND port map(Y => GND_1_net);
    CIC_regs_R0C0 : RAM4K9
      generic map(MEMORYFILE => "CIC_regs_R0C0.mem")

      port map(ADDRA11 => GND_1_net, ADDRA10 => GND_1_net, 
        ADDRA9 => GND_1_net, ADDRA8 => GND_1_net, ADDRA7 => 
        GND_1_net, ADDRA6 => GND_1_net, ADDRA5 => GND_1_net, 
        ADDRA4 => GND_1_net, ADDRA3 => ADDRA(3), ADDRA2 => 
        ADDRA(2), ADDRA1 => ADDRA(1), ADDRA0 => ADDRA(0), 
        ADDRB11 => GND_1_net, ADDRB10 => GND_1_net, ADDRB9 => 
        GND_1_net, ADDRB8 => GND_1_net, ADDRB7 => GND_1_net, 
        ADDRB6 => GND_1_net, ADDRB5 => GND_1_net, ADDRB4 => 
        GND_1_net, ADDRB3 => ADDRB(3), ADDRB2 => ADDRB(2), 
        ADDRB1 => ADDRB(1), ADDRB0 => ADDRB(0), DINA8 => 
        GND_1_net, DINA7 => DINA(7), DINA6 => DINA(6), DINA5 => 
        DINA(5), DINA4 => DINA(4), DINA3 => DINA(3), DINA2 => 
        DINA(2), DINA1 => DINA(1), DINA0 => DINA(0), DINB8 => 
        GND_1_net, DINB7 => DINB(7), DINB6 => DINB(6), DINB5 => 
        DINB(5), DINB4 => DINB(4), DINB3 => DINB(3), DINB2 => 
        DINB(2), DINB1 => DINB(1), DINB0 => DINB(0), WIDTHA0 => 
        VCC_1_net, WIDTHA1 => VCC_1_net, WIDTHB0 => VCC_1_net, 
        WIDTHB1 => VCC_1_net, PIPEA => GND_1_net, PIPEB => 
        GND_1_net, WMODEA => GND_1_net, WMODEB => GND_1_net, 
        BLKA => BLKA, BLKB => BLKB, WENA => RWA, WENB => RWB, 
        CLKA => CLKAB, CLKB => CLKAB, RESET => RESETP, DOUTA8 => 
        OPEN , DOUTA7 => DOUTA(7), DOUTA6 => DOUTA(6), DOUTA5 => 
        DOUTA(5), DOUTA4 => DOUTA(4), DOUTA3 => DOUTA(3), 
        DOUTA2 => DOUTA(2), DOUTA1 => DOUTA(1), DOUTA0 => 
        DOUTA(0), DOUTB8 => OPEN , DOUTB7 => DOUTB(7), DOUTB6 => 
        DOUTB(6), DOUTB5 => DOUTB(5), DOUTB4 => DOUTB(4), 
        DOUTB3 => DOUTB(3), DOUTB2 => DOUTB(2), DOUTB1 => 
        DOUTB(1), DOUTB0 => DOUTB(0));
    RESETBUBBLE : INV
      port map(A => RESET, Y => RESETP);
    CIC_regs_R0C4 : RAM4K9
      generic map(MEMORYFILE => "CIC_regs_R0C4.mem")

      port map(ADDRA11 => GND_1_net, ADDRA10 => GND_1_net, 
        ADDRA9 => GND_1_net, ADDRA8 => GND_1_net, ADDRA7 => 
        GND_1_net, ADDRA6 => GND_1_net, ADDRA5 => GND_1_net, 
        ADDRA4 => GND_1_net, ADDRA3 => ADDRA(3), ADDRA2 => 
        ADDRA(2), ADDRA1 => ADDRA(1), ADDRA0 => ADDRA(0), 
        ADDRB11 => GND_1_net, ADDRB10 => GND_1_net, ADDRB9 => 
        GND_1_net, ADDRB8 => GND_1_net, ADDRB7 => GND_1_net, 
        ADDRB6 => GND_1_net, ADDRB5 => GND_1_net, ADDRB4 => 
        GND_1_net, ADDRB3 => ADDRB(3), ADDRB2 => ADDRB(2), 
        ADDRB1 => ADDRB(1), ADDRB0 => ADDRB(0), DINA8 => 
        GND_1_net, DINA7 => DINA(39), DINA6 => DINA(38), DINA5 => 
        DINA(37), DINA4 => DINA(36), DINA3 => DINA(35), DINA2 => 
        DINA(34), DINA1 => DINA(33), DINA0 => DINA(32), DINB8 => 
        GND_1_net, DINB7 => DINB(39), DINB6 => DINB(38), DINB5 => 
        DINB(37), DINB4 => DINB(36), DINB3 => DINB(35), DINB2 => 
        DINB(34), DINB1 => DINB(33), DINB0 => DINB(32), 
        WIDTHA0 => VCC_1_net, WIDTHA1 => VCC_1_net, WIDTHB0 => 
        VCC_1_net, WIDTHB1 => VCC_1_net, PIPEA => GND_1_net, 
        PIPEB => GND_1_net, WMODEA => GND_1_net, WMODEB => 
        GND_1_net, BLKA => BLKA, BLKB => BLKB, WENA => RWA, 
        WENB => RWB, CLKA => CLKAB, CLKB => CLKAB, RESET => 
        RESETP, DOUTA8 => OPEN , DOUTA7 => DOUTA(39), DOUTA6 => 
        DOUTA(38), DOUTA5 => DOUTA(37), DOUTA4 => DOUTA(36), 
        DOUTA3 => DOUTA(35), DOUTA2 => DOUTA(34), DOUTA1 => 
        DOUTA(33), DOUTA0 => DOUTA(32), DOUTB8 => OPEN , 
        DOUTB7 => DOUTB(39), DOUTB6 => DOUTB(38), DOUTB5 => 
        DOUTB(37), DOUTB4 => DOUTB(36), DOUTB3 => DOUTB(35), 
        DOUTB2 => DOUTB(34), DOUTB1 => DOUTB(33), DOUTB0 => 
        DOUTB(32));
    CIC_regs_R0C5 : RAM4K9
      generic map(MEMORYFILE => "CIC_regs_R0C5.mem")

      port map(ADDRA11 => GND_1_net, ADDRA10 => GND_1_net, 
        ADDRA9 => GND_1_net, ADDRA8 => GND_1_net, ADDRA7 => 
        GND_1_net, ADDRA6 => GND_1_net, ADDRA5 => GND_1_net, 
        ADDRA4 => GND_1_net, ADDRA3 => ADDRA(3), ADDRA2 => 
        ADDRA(2), ADDRA1 => ADDRA(1), ADDRA0 => ADDRA(0), 
        ADDRB11 => GND_1_net, ADDRB10 => GND_1_net, ADDRB9 => 
        GND_1_net, ADDRB8 => GND_1_net, ADDRB7 => GND_1_net, 
        ADDRB6 => GND_1_net, ADDRB5 => GND_1_net, ADDRB4 => 
        GND_1_net, ADDRB3 => ADDRB(3), ADDRB2 => ADDRB(2), 
        ADDRB1 => ADDRB(1), ADDRB0 => ADDRB(0), DINA8 => 
        GND_1_net, DINA7 => GND_1_net, DINA6 => DINA(46), 
        DINA5 => DINA(45), DINA4 => DINA(44), DINA3 => DINA(43), 
        DINA2 => DINA(42), DINA1 => DINA(41), DINA0 => DINA(40), 
        DINB8 => GND_1_net, DINB7 => GND_1_net, DINB6 => DINB(46), 
        DINB5 => DINB(45), DINB4 => DINB(44), DINB3 => DINB(43), 
        DINB2 => DINB(42), DINB1 => DINB(41), DINB0 => DINB(40), 
        WIDTHA0 => VCC_1_net, WIDTHA1 => VCC_1_net, WIDTHB0 => 
        VCC_1_net, WIDTHB1 => VCC_1_net, PIPEA => GND_1_net, 
        PIPEB => GND_1_net, WMODEA => GND_1_net, WMODEB => 
        GND_1_net, BLKA => BLKA, BLKB => BLKB, WENA => RWA, 
        WENB => RWB, CLKA => CLKAB, CLKB => CLKAB, RESET => 
        RESETP, DOUTA8 => OPEN , DOUTA7 => OPEN , DOUTA6 => 
        DOUTA(46), DOUTA5 => DOUTA(45), DOUTA4 => DOUTA(44), 
        DOUTA3 => DOUTA(43), DOUTA2 => DOUTA(42), DOUTA1 => 
        DOUTA(41), DOUTA0 => DOUTA(40), DOUTB8 => OPEN , 
        DOUTB7 => OPEN , DOUTB6 => DOUTB(46), DOUTB5 => DOUTB(45), 
        DOUTB4 => DOUTB(44), DOUTB3 => DOUTB(43), DOUTB2 => 
        DOUTB(42), DOUTB1 => DOUTB(41), DOUTB0 => DOUTB(40));
    CIC_regs_R0C1 : RAM4K9
      generic map(MEMORYFILE => "CIC_regs_R0C1.mem")

      port map(ADDRA11 => GND_1_net, ADDRA10 => GND_1_net, 
        ADDRA9 => GND_1_net, ADDRA8 => GND_1_net, ADDRA7 => 
        GND_1_net, ADDRA6 => GND_1_net, ADDRA5 => GND_1_net, 
        ADDRA4 => GND_1_net, ADDRA3 => ADDRA(3), ADDRA2 => 
        ADDRA(2), ADDRA1 => ADDRA(1), ADDRA0 => ADDRA(0), 
        ADDRB11 => GND_1_net, ADDRB10 => GND_1_net, ADDRB9 => 
        GND_1_net, ADDRB8 => GND_1_net, ADDRB7 => GND_1_net, 
        ADDRB6 => GND_1_net, ADDRB5 => GND_1_net, ADDRB4 => 
        GND_1_net, ADDRB3 => ADDRB(3), ADDRB2 => ADDRB(2), 
        ADDRB1 => ADDRB(1), ADDRB0 => ADDRB(0), DINA8 => 
        GND_1_net, DINA7 => DINA(15), DINA6 => DINA(14), DINA5 => 
        DINA(13), DINA4 => DINA(12), DINA3 => DINA(11), DINA2 => 
        DINA(10), DINA1 => DINA(9), DINA0 => DINA(8), DINB8 => 
        GND_1_net, DINB7 => DINB(15), DINB6 => DINB(14), DINB5 => 
        DINB(13), DINB4 => DINB(12), DINB3 => DINB(11), DINB2 => 
        DINB(10), DINB1 => DINB(9), DINB0 => DINB(8), WIDTHA0 => 
        VCC_1_net, WIDTHA1 => VCC_1_net, WIDTHB0 => VCC_1_net, 
        WIDTHB1 => VCC_1_net, PIPEA => GND_1_net, PIPEB => 
        GND_1_net, WMODEA => GND_1_net, WMODEB => GND_1_net, 
        BLKA => BLKA, BLKB => BLKB, WENA => RWA, WENB => RWB, 
        CLKA => CLKAB, CLKB => CLKAB, RESET => RESETP, DOUTA8 => 
        OPEN , DOUTA7 => DOUTA(15), DOUTA6 => DOUTA(14), 
        DOUTA5 => DOUTA(13), DOUTA4 => DOUTA(12), DOUTA3 => 
        DOUTA(11), DOUTA2 => DOUTA(10), DOUTA1 => DOUTA(9), 
        DOUTA0 => DOUTA(8), DOUTB8 => OPEN , DOUTB7 => DOUTB(15), 
        DOUTB6 => DOUTB(14), DOUTB5 => DOUTB(13), DOUTB4 => 
        DOUTB(12), DOUTB3 => DOUTB(11), DOUTB2 => DOUTB(10), 
        DOUTB1 => DOUTB(9), DOUTB0 => DOUTB(8));
    CIC_regs_R0C2 : RAM4K9
      generic map(MEMORYFILE => "CIC_regs_R0C2.mem")

      port map(ADDRA11 => GND_1_net, ADDRA10 => GND_1_net, 
        ADDRA9 => GND_1_net, ADDRA8 => GND_1_net, ADDRA7 => 
        GND_1_net, ADDRA6 => GND_1_net, ADDRA5 => GND_1_net, 
        ADDRA4 => GND_1_net, ADDRA3 => ADDRA(3), ADDRA2 => 
        ADDRA(2), ADDRA1 => ADDRA(1), ADDRA0 => ADDRA(0), 
        ADDRB11 => GND_1_net, ADDRB10 => GND_1_net, ADDRB9 => 
        GND_1_net, ADDRB8 => GND_1_net, ADDRB7 => GND_1_net, 
        ADDRB6 => GND_1_net, ADDRB5 => GND_1_net, ADDRB4 => 
        GND_1_net, ADDRB3 => ADDRB(3), ADDRB2 => ADDRB(2), 
        ADDRB1 => ADDRB(1), ADDRB0 => ADDRB(0), DINA8 => 
        GND_1_net, DINA7 => DINA(23), DINA6 => DINA(22), DINA5 => 
        DINA(21), DINA4 => DINA(20), DINA3 => DINA(19), DINA2 => 
        DINA(18), DINA1 => DINA(17), DINA0 => DINA(16), DINB8 => 
        GND_1_net, DINB7 => DINB(23), DINB6 => DINB(22), DINB5 => 
        DINB(21), DINB4 => DINB(20), DINB3 => DINB(19), DINB2 => 
        DINB(18), DINB1 => DINB(17), DINB0 => DINB(16), 
        WIDTHA0 => VCC_1_net, WIDTHA1 => VCC_1_net, WIDTHB0 => 
        VCC_1_net, WIDTHB1 => VCC_1_net, PIPEA => GND_1_net, 
        PIPEB => GND_1_net, WMODEA => GND_1_net, WMODEB => 
        GND_1_net, BLKA => BLKA, BLKB => BLKB, WENA => RWA, 
        WENB => RWB, CLKA => CLKAB, CLKB => CLKAB, RESET => 
        RESETP, DOUTA8 => OPEN , DOUTA7 => DOUTA(23), DOUTA6 => 
        DOUTA(22), DOUTA5 => DOUTA(21), DOUTA4 => DOUTA(20), 
        DOUTA3 => DOUTA(19), DOUTA2 => DOUTA(18), DOUTA1 => 
        DOUTA(17), DOUTA0 => DOUTA(16), DOUTB8 => OPEN , 
        DOUTB7 => DOUTB(23), DOUTB6 => DOUTB(22), DOUTB5 => 
        DOUTB(21), DOUTB4 => DOUTB(20), DOUTB3 => DOUTB(19), 
        DOUTB2 => DOUTB(18), DOUTB1 => DOUTB(17), DOUTB0 => 
        DOUTB(16));
    CIC_regs_R0C3 : RAM4K9
      generic map(MEMORYFILE => "CIC_regs_R0C3.mem")

      port map(ADDRA11 => GND_1_net, ADDRA10 => GND_1_net, 
        ADDRA9 => GND_1_net, ADDRA8 => GND_1_net, ADDRA7 => 
        GND_1_net, ADDRA6 => GND_1_net, ADDRA5 => GND_1_net, 
        ADDRA4 => GND_1_net, ADDRA3 => ADDRA(3), ADDRA2 => 
        ADDRA(2), ADDRA1 => ADDRA(1), ADDRA0 => ADDRA(0), 
        ADDRB11 => GND_1_net, ADDRB10 => GND_1_net, ADDRB9 => 
        GND_1_net, ADDRB8 => GND_1_net, ADDRB7 => GND_1_net, 
        ADDRB6 => GND_1_net, ADDRB5 => GND_1_net, ADDRB4 => 
        GND_1_net, ADDRB3 => ADDRB(3), ADDRB2 => ADDRB(2), 
        ADDRB1 => ADDRB(1), ADDRB0 => ADDRB(0), DINA8 => 
        GND_1_net, DINA7 => DINA(31), DINA6 => DINA(30), DINA5 => 
        DINA(29), DINA4 => DINA(28), DINA3 => DINA(27), DINA2 => 
        DINA(26), DINA1 => DINA(25), DINA0 => DINA(24), DINB8 => 
        GND_1_net, DINB7 => DINB(31), DINB6 => DINB(30), DINB5 => 
        DINB(29), DINB4 => DINB(28), DINB3 => DINB(27), DINB2 => 
        DINB(26), DINB1 => DINB(25), DINB0 => DINB(24), 
        WIDTHA0 => VCC_1_net, WIDTHA1 => VCC_1_net, WIDTHB0 => 
        VCC_1_net, WIDTHB1 => VCC_1_net, PIPEA => GND_1_net, 
        PIPEB => GND_1_net, WMODEA => GND_1_net, WMODEB => 
        GND_1_net, BLKA => BLKA, BLKB => BLKB, WENA => RWA, 
        WENB => RWB, CLKA => CLKAB, CLKB => CLKAB, RESET => 
        RESETP, DOUTA8 => OPEN , DOUTA7 => DOUTA(31), DOUTA6 => 
        DOUTA(30), DOUTA5 => DOUTA(29), DOUTA4 => DOUTA(28), 
        DOUTA3 => DOUTA(27), DOUTA2 => DOUTA(26), DOUTA1 => 
        DOUTA(25), DOUTA0 => DOUTA(24), DOUTB8 => OPEN , 
        DOUTB7 => DOUTB(31), DOUTB6 => DOUTB(30), DOUTB5 => 
        DOUTB(29), DOUTB4 => DOUTB(28), DOUTB3 => DOUTB(27), 
        DOUTB2 => DOUTB(26), DOUTB1 => DOUTB(25), DOUTB0 => 
        DOUTB(24));
end DEF_ARCH;

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.2.16
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:SmartFusion
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_RAM
-- LPM_HINT:DUAL
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/Users/babjak/Desktop/CIC_SRAM/smartgen\CIC_regs
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IP4X3M1
-- SMARTGEN_PACKAGE:fg484
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WWIDTH:47
-- WDEPTH:15
-- RWIDTH:47
-- RDEPTH:15
-- CLKS:1
-- CLOCK_PN:CLKAB
-- RESET_PN:RESET
-- RESET_POLARITY:1
-- INIT_RAM:T
-- DEFAULT_WORD:0x000000000000
-- CASCADE:1
-- WCLK_EDGE:RISE
-- WMODE1:0
-- WMODE2:0
-- PMODE1:0
-- PMODE2:0
-- DATAA_IN_PN:DINA
-- DATAA_OUT_PN:DOUTA
-- ADDRESSA_PN:ADDRA
-- RWA_PN:RWA
-- BLKA_PN:BLKA
-- DATAB_IN_PN:DINB
-- DATAB_OUT_PN:DOUTB
-- ADDRESSB_PN:ADDRB
-- RWB_PN:RWB
-- BLKB_PN:BLKB
-- WE_POLARITY:0
-- RE_POLARITY:0
-- PTYPE:2

-- _End_Comments_

