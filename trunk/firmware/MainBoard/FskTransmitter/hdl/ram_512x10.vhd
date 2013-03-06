-- Version: 10.1 SP3 10.1.3.1

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity RAM_512x10 is

    port( WDATA : in    std_logic_vector(9 downto 0);
          RDATA : out   std_logic_vector(9 downto 0);
          WEN   : in    std_logic;
          REN   : in    std_logic;
          WADDR : in    std_logic_vector(8 downto 0);
          RADDR : in    std_logic_vector(8 downto 0);
          CLK   : in    std_logic;
          RST   : in    std_logic
        );

end RAM_512x10;

architecture DEF_ARCH of RAM_512x10 is 

  component MX2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component OR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OR2A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component BUFF
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1E1C0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component RAM512X18
    generic (MEMORYFILE:string := "");

    port( RADDR8 : in    std_logic := 'U';
          RADDR7 : in    std_logic := 'U';
          RADDR6 : in    std_logic := 'U';
          RADDR5 : in    std_logic := 'U';
          RADDR4 : in    std_logic := 'U';
          RADDR3 : in    std_logic := 'U';
          RADDR2 : in    std_logic := 'U';
          RADDR1 : in    std_logic := 'U';
          RADDR0 : in    std_logic := 'U';
          WADDR8 : in    std_logic := 'U';
          WADDR7 : in    std_logic := 'U';
          WADDR6 : in    std_logic := 'U';
          WADDR5 : in    std_logic := 'U';
          WADDR4 : in    std_logic := 'U';
          WADDR3 : in    std_logic := 'U';
          WADDR2 : in    std_logic := 'U';
          WADDR1 : in    std_logic := 'U';
          WADDR0 : in    std_logic := 'U';
          WD17   : in    std_logic := 'U';
          WD16   : in    std_logic := 'U';
          WD15   : in    std_logic := 'U';
          WD14   : in    std_logic := 'U';
          WD13   : in    std_logic := 'U';
          WD12   : in    std_logic := 'U';
          WD11   : in    std_logic := 'U';
          WD10   : in    std_logic := 'U';
          WD9    : in    std_logic := 'U';
          WD8    : in    std_logic := 'U';
          WD7    : in    std_logic := 'U';
          WD6    : in    std_logic := 'U';
          WD5    : in    std_logic := 'U';
          WD4    : in    std_logic := 'U';
          WD3    : in    std_logic := 'U';
          WD2    : in    std_logic := 'U';
          WD1    : in    std_logic := 'U';
          WD0    : in    std_logic := 'U';
          RW0    : in    std_logic := 'U';
          RW1    : in    std_logic := 'U';
          WW0    : in    std_logic := 'U';
          WW1    : in    std_logic := 'U';
          PIPE   : in    std_logic := 'U';
          REN    : in    std_logic := 'U';
          WEN    : in    std_logic := 'U';
          RCLK   : in    std_logic := 'U';
          WCLK   : in    std_logic := 'U';
          RESET  : in    std_logic := 'U';
          RD17   : out   std_logic;
          RD16   : out   std_logic;
          RD15   : out   std_logic;
          RD14   : out   std_logic;
          RD13   : out   std_logic;
          RD12   : out   std_logic;
          RD11   : out   std_logic;
          RD10   : out   std_logic;
          RD9    : out   std_logic;
          RD8    : out   std_logic;
          RD7    : out   std_logic;
          RD6    : out   std_logic;
          RD5    : out   std_logic;
          RD4    : out   std_logic;
          RD3    : out   std_logic;
          RD2    : out   std_logic;
          RD1    : out   std_logic;
          RD0    : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal WEAP, WEBP, RESETP, \ADDRA_FF2[0]\, \ADDRB_FF1[0]\, 
        \ADDRB_FF2[0]\, \READB_EN_2[0]\, \ENABLE_ADDRA[0]\, 
        \ENABLE_ADDRA[1]\, \ENABLE_ADDRB[0]\, \ENABLE_ADDRB[1]\, 
        \BLKA_EN[0]\, \BLKB_EN[0]\, \BLKA_EN[1]\, \BLKB_EN[1]\, 
        \READA_EN[0]\, \READB_EN[0]\, \READA_EN[1]\, 
        \READB_EN[1]\, \READB_EN_2[1]\, \QX_TEMPR0[0]\, 
        \QX_TEMPR0[1]\, \QX_TEMPR0[2]\, \QX_TEMPR0[3]\, 
        \QX_TEMPR0[4]\, \QX_TEMPR0[5]\, \QX_TEMPR0[6]\, 
        \QX_TEMPR0[7]\, \QX_TEMPR0[8]\, \QX_TEMPR0[9]\, 
        \QX_TEMPR1[0]\, \QX_TEMPR1[1]\, \QX_TEMPR1[2]\, 
        \QX_TEMPR1[3]\, \QX_TEMPR1[4]\, \QX_TEMPR1[5]\, 
        \QX_TEMPR1[6]\, \QX_TEMPR1[7]\, \QX_TEMPR1[8]\, 
        \QX_TEMPR1[9]\, \VCC\, \GND\ : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;

begin 

    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;

    \MX2_RDATA[4]\ : MX2
      port map(A => \QX_TEMPR0[4]\, B => \QX_TEMPR1[4]\, S => 
        \ADDRB_FF2[0]\, Y => RDATA(4));
    
    \MX2_RDATA[0]\ : MX2
      port map(A => \QX_TEMPR0[0]\, B => \QX_TEMPR1[0]\, S => 
        \ADDRB_FF2[0]\, Y => RDATA(0));
    
    \INV_ENABLE_ADDRB[1]\ : INV
      port map(A => RADDR(8), Y => \ENABLE_ADDRB[1]\);
    
    \MX2_RDATA[5]\ : MX2
      port map(A => \QX_TEMPR0[5]\, B => \QX_TEMPR1[5]\, S => 
        \ADDRB_FF2[0]\, Y => RDATA(5));
    
    \READEN_BFF1[0]\ : DFN1
      port map(D => \READB_EN[0]\, CLK => CLK, Q => 
        \READB_EN_2[0]\);
    
    \MX2_RDATA[2]\ : MX2
      port map(A => \QX_TEMPR0[2]\, B => \QX_TEMPR1[2]\, S => 
        \ADDRB_FF2[0]\, Y => RDATA(2));
    
    \MX2_RDATA[8]\ : MX2
      port map(A => \QX_TEMPR0[8]\, B => \QX_TEMPR1[8]\, S => 
        \ADDRB_FF2[0]\, Y => RDATA(8));
    
    \ORB_GATE[1]\ : OR2
      port map(A => \ENABLE_ADDRB[1]\, B => WEBP, Y => 
        \BLKB_EN[1]\);
    
    \MX2_RDATA[7]\ : MX2
      port map(A => \QX_TEMPR0[7]\, B => \QX_TEMPR1[7]\, S => 
        \ADDRB_FF2[0]\, Y => RDATA(7));
    
    \MX2_RDATA[6]\ : MX2
      port map(A => \QX_TEMPR0[6]\, B => \QX_TEMPR1[6]\, S => 
        \ADDRB_FF2[0]\, Y => RDATA(6));
    
    \ORA_GATE[1]\ : OR2
      port map(A => \ENABLE_ADDRA[1]\, B => WEAP, Y => 
        \BLKA_EN[1]\);
    
    \ORA_READ_EN_GATE[1]\ : OR2A
      port map(A => WEAP, B => \ENABLE_ADDRA[1]\, Y => 
        \READA_EN[1]\);
    
    \ORB_READ_EN_GATE[1]\ : OR2A
      port map(A => WEBP, B => \ENABLE_ADDRB[1]\, Y => 
        \READB_EN[1]\);
    
    RESETBUBBLE : INV
      port map(A => RST, Y => RESETP);
    
    \BUFF_ENABLE_ADDRB[0]\ : BUFF
      port map(A => RADDR(8), Y => \ENABLE_ADDRB[0]\);
    
    \ORA_READ_EN_GATE[0]\ : OR2A
      port map(A => WEAP, B => \ENABLE_ADDRA[0]\, Y => 
        \READA_EN[0]\);
    
    \ORB_READ_EN_GATE[0]\ : OR2A
      port map(A => WEBP, B => \ENABLE_ADDRB[0]\, Y => 
        \READB_EN[0]\);
    
    \INV_ENABLE_ADDRA[1]\ : INV
      port map(A => WADDR(8), Y => \ENABLE_ADDRA[1]\);
    
    \MX2_RDATA[1]\ : MX2
      port map(A => \QX_TEMPR0[1]\, B => \QX_TEMPR1[1]\, S => 
        \ADDRB_FF2[0]\, Y => RDATA(1));
    
    \MX2_RDATA[9]\ : MX2
      port map(A => \QX_TEMPR0[9]\, B => \QX_TEMPR1[9]\, S => 
        \ADDRB_FF2[0]\, Y => RDATA(9));
    
    \BFF2[0]\ : DFN1E1C0
      port map(D => \ADDRB_FF1[0]\, CLK => CLK, CLR => RESETP, E
         => \READB_EN_2[0]\, Q => \ADDRB_FF2[0]\);
    
    \AFF1[0]\ : DFN1E1C0
      port map(D => WADDR(8), CLK => CLK, CLR => RESETP, E => 
        \READA_EN[0]\, Q => \ADDRA_FF2[0]\);
    
    WEBUBBLEB : INV
      port map(A => REN, Y => WEBP);
    
    \BFF1[0]\ : DFN1
      port map(D => RADDR(8), CLK => CLK, Q => \ADDRB_FF1[0]\);
    
    \BUFF_ENABLE_ADDRA[0]\ : BUFF
      port map(A => WADDR(8), Y => \ENABLE_ADDRA[0]\);
    
    \ORB_GATE[0]\ : OR2
      port map(A => \ENABLE_ADDRB[0]\, B => WEBP, Y => 
        \BLKB_EN[0]\);
    
    \ORA_GATE[0]\ : OR2
      port map(A => \ENABLE_ADDRA[0]\, B => WEAP, Y => 
        \BLKA_EN[0]\);
    
    RAM_512x8_R1C0 : RAM512X18
      port map(RADDR8 => \GND\, RADDR7 => RADDR(7), RADDR6 => 
        RADDR(6), RADDR5 => RADDR(5), RADDR4 => RADDR(4), RADDR3
         => RADDR(3), RADDR2 => RADDR(2), RADDR1 => RADDR(1), 
        RADDR0 => RADDR(0), WADDR8 => \GND\, WADDR7 => WADDR(7), 
        WADDR6 => WADDR(6), WADDR5 => WADDR(5), WADDR4 => 
        WADDR(4), WADDR3 => WADDR(3), WADDR2 => WADDR(2), WADDR1
         => WADDR(1), WADDR0 => WADDR(0), WD17 => \GND\, WD16 => 
        \GND\, WD15 => \GND\, WD14 => \GND\, WD13 => \GND\, WD12
         => \GND\, WD11 => \GND\, WD10 => \GND\, WD9 => WDATA(9), 
        WD8 => WDATA(8), WD7 => WDATA(7), WD6 => WDATA(6), WD5
         => WDATA(5), WD4 => WDATA(4), WD3 => WDATA(3), WD2 => 
        WDATA(2), WD1 => WDATA(1), WD0 => WDATA(0), RW0 => \GND\, 
        RW1 => \VCC\, WW0 => \GND\, WW1 => \VCC\, PIPE => \VCC\, 
        REN => \BLKB_EN[1]\, WEN => \BLKA_EN[1]\, RCLK => CLK, 
        WCLK => CLK, RESET => RESETP, RD17 => OPEN, RD16 => OPEN, 
        RD15 => OPEN, RD14 => OPEN, RD13 => OPEN, RD12 => OPEN, 
        RD11 => OPEN, RD10 => OPEN, RD9 => \QX_TEMPR1[9]\, RD8
         => \QX_TEMPR1[8]\, RD7 => \QX_TEMPR1[7]\, RD6 => 
        \QX_TEMPR1[6]\, RD5 => \QX_TEMPR1[5]\, RD4 => 
        \QX_TEMPR1[4]\, RD3 => \QX_TEMPR1[3]\, RD2 => 
        \QX_TEMPR1[2]\, RD1 => \QX_TEMPR1[1]\, RD0 => 
        \QX_TEMPR1[0]\);
    
    \READEN_BFF1[1]\ : DFN1
      port map(D => \READB_EN[1]\, CLK => CLK, Q => 
        \READB_EN_2[1]\);
    
    \MX2_RDATA[3]\ : MX2
      port map(A => \QX_TEMPR0[3]\, B => \QX_TEMPR1[3]\, S => 
        \ADDRB_FF2[0]\, Y => RDATA(3));
    
    WEBUBBLEA : INV
      port map(A => WEN, Y => WEAP);
    
    RAM_512x8_R0C0 : RAM512X18
      port map(RADDR8 => \GND\, RADDR7 => RADDR(7), RADDR6 => 
        RADDR(6), RADDR5 => RADDR(5), RADDR4 => RADDR(4), RADDR3
         => RADDR(3), RADDR2 => RADDR(2), RADDR1 => RADDR(1), 
        RADDR0 => RADDR(0), WADDR8 => \GND\, WADDR7 => WADDR(7), 
        WADDR6 => WADDR(6), WADDR5 => WADDR(5), WADDR4 => 
        WADDR(4), WADDR3 => WADDR(3), WADDR2 => WADDR(2), WADDR1
         => WADDR(1), WADDR0 => WADDR(0), WD17 => \GND\, WD16 => 
        \GND\, WD15 => \GND\, WD14 => \GND\, WD13 => \GND\, WD12
         => \GND\, WD11 => \GND\, WD10 => \GND\, WD9 => WDATA(9), 
        WD8 => WDATA(8), WD7 => WDATA(7), WD6 => WDATA(6), WD5
         => WDATA(5), WD4 => WDATA(4), WD3 => WDATA(3), WD2 => 
        WDATA(2), WD1 => WDATA(1), WD0 => WDATA(0), RW0 => \GND\, 
        RW1 => \VCC\, WW0 => \GND\, WW1 => \VCC\, PIPE => \VCC\, 
        REN => \BLKB_EN[0]\, WEN => \BLKA_EN[0]\, RCLK => CLK, 
        WCLK => CLK, RESET => RESETP, RD17 => OPEN, RD16 => OPEN, 
        RD15 => OPEN, RD14 => OPEN, RD13 => OPEN, RD12 => OPEN, 
        RD11 => OPEN, RD10 => OPEN, RD9 => \QX_TEMPR0[9]\, RD8
         => \QX_TEMPR0[8]\, RD7 => \QX_TEMPR0[7]\, RD6 => 
        \QX_TEMPR0[6]\, RD5 => \QX_TEMPR0[5]\, RD4 => 
        \QX_TEMPR0[4]\, RD3 => \QX_TEMPR0[3]\, RD2 => 
        \QX_TEMPR0[2]\, RD1 => \QX_TEMPR0[1]\, RD0 => 
        \QX_TEMPR0[0]\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:10.1.3.1
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:PA3SOC2
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_RAM
-- LPM_HINT:TWO
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:D:/firmware/MainBoard/FskTransmitter/smartgen\RAM_512x10
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:IP6X5M2
-- SMARTGEN_PACKAGE:fg256
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WWIDTH:10
-- WDEPTH:512
-- RWIDTH:10
-- RDEPTH:512
-- CLKS:1
-- CLOCK_PN:CLK
-- RESET_PN:RST
-- RESET_POLARITY:1
-- INIT_RAM:F
-- DEFAULT_WORD:0x000
-- CASCADE:1
-- WCLK_EDGE:RISE
-- PMODE2:1
-- DATA_IN_PN:WDATA
-- WADDRESS_PN:WADDR
-- WE_PN:WEN
-- DATA_OUT_PN:RDATA
-- RADDRESS_PN:RADDR
-- RE_PN:REN
-- WE_POLARITY:1
-- RE_POLARITY:1
-- PTYPE:1

-- _End_Comments_

