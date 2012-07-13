-- Version: 10.0 SP2 10.0.20.2

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity fifo_256x16 is

    port( DATA   : in    std_logic_vector(15 downto 0);
          Q      : out   std_logic_vector(15 downto 0);
          WE     : in    std_logic;
          RE     : in    std_logic;
          WCLOCK : in    std_logic;
          RCLOCK : in    std_logic;
          FULL   : out   std_logic;
          EMPTY  : out   std_logic;
          RESET  : in    std_logic;
          AEMPTY : out   std_logic;
          AFULL  : out   std_logic
        );

end fifo_256x16;

architecture DEF_ARCH of fifo_256x16 is 

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component FIFO4K18
    port( AEVAL11 : in    std_logic := 'U';
          AEVAL10 : in    std_logic := 'U';
          AEVAL9  : in    std_logic := 'U';
          AEVAL8  : in    std_logic := 'U';
          AEVAL7  : in    std_logic := 'U';
          AEVAL6  : in    std_logic := 'U';
          AEVAL5  : in    std_logic := 'U';
          AEVAL4  : in    std_logic := 'U';
          AEVAL3  : in    std_logic := 'U';
          AEVAL2  : in    std_logic := 'U';
          AEVAL1  : in    std_logic := 'U';
          AEVAL0  : in    std_logic := 'U';
          AFVAL11 : in    std_logic := 'U';
          AFVAL10 : in    std_logic := 'U';
          AFVAL9  : in    std_logic := 'U';
          AFVAL8  : in    std_logic := 'U';
          AFVAL7  : in    std_logic := 'U';
          AFVAL6  : in    std_logic := 'U';
          AFVAL5  : in    std_logic := 'U';
          AFVAL4  : in    std_logic := 'U';
          AFVAL3  : in    std_logic := 'U';
          AFVAL2  : in    std_logic := 'U';
          AFVAL1  : in    std_logic := 'U';
          AFVAL0  : in    std_logic := 'U';
          WD17    : in    std_logic := 'U';
          WD16    : in    std_logic := 'U';
          WD15    : in    std_logic := 'U';
          WD14    : in    std_logic := 'U';
          WD13    : in    std_logic := 'U';
          WD12    : in    std_logic := 'U';
          WD11    : in    std_logic := 'U';
          WD10    : in    std_logic := 'U';
          WD9     : in    std_logic := 'U';
          WD8     : in    std_logic := 'U';
          WD7     : in    std_logic := 'U';
          WD6     : in    std_logic := 'U';
          WD5     : in    std_logic := 'U';
          WD4     : in    std_logic := 'U';
          WD3     : in    std_logic := 'U';
          WD2     : in    std_logic := 'U';
          WD1     : in    std_logic := 'U';
          WD0     : in    std_logic := 'U';
          WW0     : in    std_logic := 'U';
          WW1     : in    std_logic := 'U';
          WW2     : in    std_logic := 'U';
          RW0     : in    std_logic := 'U';
          RW1     : in    std_logic := 'U';
          RW2     : in    std_logic := 'U';
          RPIPE   : in    std_logic := 'U';
          WEN     : in    std_logic := 'U';
          REN     : in    std_logic := 'U';
          WBLK    : in    std_logic := 'U';
          RBLK    : in    std_logic := 'U';
          WCLK    : in    std_logic := 'U';
          RCLK    : in    std_logic := 'U';
          RESET   : in    std_logic := 'U';
          ESTOP   : in    std_logic := 'U';
          FSTOP   : in    std_logic := 'U';
          RD17    : out   std_logic;
          RD16    : out   std_logic;
          RD15    : out   std_logic;
          RD14    : out   std_logic;
          RD13    : out   std_logic;
          RD12    : out   std_logic;
          RD11    : out   std_logic;
          RD10    : out   std_logic;
          RD9     : out   std_logic;
          RD8     : out   std_logic;
          RD7     : out   std_logic;
          RD6     : out   std_logic;
          RD5     : out   std_logic;
          RD4     : out   std_logic;
          RD3     : out   std_logic;
          RD2     : out   std_logic;
          RD1     : out   std_logic;
          RD0     : out   std_logic;
          FULL    : out   std_logic;
          AFULL   : out   std_logic;
          EMPTY   : out   std_logic;
          AEMPTY  : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal WEBP, RESETP, \VCC\, \GND\ : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;

begin 

    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;

    RESETBUBBLEA : INV
      port map(A => RESET, Y => RESETP);
    
    FIFOBLOCK0 : FIFO4K18
      port map(AEVAL11 => \GND\, AEVAL10 => \GND\, AEVAL9 => 
        \GND\, AEVAL8 => \VCC\, AEVAL7 => \GND\, AEVAL6 => \GND\, 
        AEVAL5 => \GND\, AEVAL4 => \GND\, AEVAL3 => \GND\, AEVAL2
         => \GND\, AEVAL1 => \GND\, AEVAL0 => \GND\, AFVAL11 => 
        \GND\, AFVAL10 => \VCC\, AFVAL9 => \GND\, AFVAL8 => \GND\, 
        AFVAL7 => \GND\, AFVAL6 => \GND\, AFVAL5 => \GND\, AFVAL4
         => \GND\, AFVAL3 => \GND\, AFVAL2 => \GND\, AFVAL1 => 
        \GND\, AFVAL0 => \GND\, WD17 => \GND\, WD16 => \GND\, 
        WD15 => DATA(15), WD14 => DATA(14), WD13 => DATA(13), 
        WD12 => DATA(12), WD11 => DATA(11), WD10 => DATA(10), WD9
         => DATA(9), WD8 => DATA(8), WD7 => DATA(7), WD6 => 
        DATA(6), WD5 => DATA(5), WD4 => DATA(4), WD3 => DATA(3), 
        WD2 => DATA(2), WD1 => DATA(1), WD0 => DATA(0), WW0 => 
        \GND\, WW1 => \GND\, WW2 => \VCC\, RW0 => \GND\, RW1 => 
        \GND\, RW2 => \VCC\, RPIPE => \GND\, WEN => WEBP, REN => 
        RE, WBLK => \GND\, RBLK => \GND\, WCLK => WCLOCK, RCLK
         => RCLOCK, RESET => RESETP, ESTOP => \VCC\, FSTOP => 
        \VCC\, RD17 => OPEN, RD16 => OPEN, RD15 => Q(15), RD14
         => Q(14), RD13 => Q(13), RD12 => Q(12), RD11 => Q(11), 
        RD10 => Q(10), RD9 => Q(9), RD8 => Q(8), RD7 => Q(7), RD6
         => Q(6), RD5 => Q(5), RD4 => Q(4), RD3 => Q(3), RD2 => 
        Q(2), RD1 => Q(1), RD0 => Q(0), FULL => FULL, AFULL => 
        AFULL, EMPTY => EMPTY, AEMPTY => AEMPTY);
    
    WEBUBBLEA : INV
      port map(A => WE, Y => WEBP);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:10.0.20.2
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:PA3SOC2
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_FIFO
-- LPM_HINT:NONE
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:D:/firmware/MainBoard/FIFOGen/smartgen\fifo_256x16
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:IP6X5M2
-- SMARTGEN_PACKAGE:fg256
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WWIDTH:16
-- RWIDTH:16
-- WDEPTH:256
-- RDEPTH:256
-- WE_POLARITY:1
-- RE_POLARITY:1
-- RCLK_EDGE:RISE
-- WCLK_EDGE:RISE
-- PMODE1:0
-- FLAGS:STATIC
-- AFVAL:64
-- AEVAL:16
-- ESTOP:NO
-- FSTOP:NO
-- AFVAL:64
-- AEVAL:16
-- AFFLAG_UNITS:WW
-- AEFLAG_UNITS:RW
-- DATA_IN_PN:DATA
-- DATA_OUT_PN:Q
-- WE_PN:WE
-- RE_PN:RE
-- WCLOCK_PN:WCLOCK
-- RCLOCK_PN:RCLOCK
-- ACLR_PN:RESET
-- FF_PN:FULL
-- EF_PN:EMPTY
-- AF_PN:AFULL
-- AE_PN:AEMPTY
-- AF_PORT_PN:AFVAL
-- AE_PORT_PN:AEVAL
-- RESET_POLARITY:1

-- _End_Comments_

