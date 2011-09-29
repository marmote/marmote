library IEEE;
use IEEE.std_logic_1164.all;

entity INBUF_MSS is
    generic (
        ACT_PIN    : string := "";
        ACT_CONFIG : integer := 0 );
    port(
        PAD : in  std_logic;
        Y   : out std_logic);
end INBUF_MSS;

architecture DEF_ARCH of INBUF_MSS is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
    attribute black_box_pad_pin : string; 
    attribute black_box_pad_pin of DEF_ARCH: architecture is "PAD"; 
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity OUTBUF_MSS is
    generic (
        ACT_PIN    : string := "";
        ACT_CONFIG : integer := 0 );
    port(
        D   : in  std_logic;
        PAD : out std_logic);
end OUTBUF_MSS;

architecture DEF_ARCH of OUTBUF_MSS is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
    attribute black_box_pad_pin : string; 
    attribute black_box_pad_pin of DEF_ARCH: architecture is "PAD"; 
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity TRIBUFF_MSS is
    generic (
        ACT_PIN    : string := "";
        ACT_CONFIG : integer := 0 );
    port(
        D   : in  std_logic;
        E   : in  std_logic;
        PAD : out std_logic);
end TRIBUFF_MSS;

architecture DEF_ARCH of TRIBUFF_MSS is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
    attribute black_box_pad_pin : string; 
    attribute black_box_pad_pin of DEF_ARCH: architecture is "PAD"; 
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity BIBUF_MSS is
    generic (
        ACT_PIN    : string := "";
        ACT_CONFIG : integer := 0 );
    port(
        D   : in    std_logic;
        E   : in    std_logic;
        PAD : inout std_logic;
        Y   : out   std_logic);
end BIBUF_MSS;

architecture DEF_ARCH of BIBUF_MSS is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
    attribute black_box_pad_pin : string; 
    attribute black_box_pad_pin of DEF_ARCH: architecture is "PAD"; 
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity BIBUF_OPEND_MSS is
    generic (
        ACT_PIN    : string := "";
        ACT_CONFIG : integer := 0 );
    port(
        E   : in    std_logic;
        PAD : inout std_logic;
        Y   : out   std_logic);
end BIBUF_OPEND_MSS;

architecture DEF_ARCH of BIBUF_OPEND_MSS is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
    attribute black_box_pad_pin : string; 
    attribute black_box_pad_pin of DEF_ARCH: architecture is "PAD"; 
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity INBUF_MCCC is
    generic (
        ACT_PIN    : string := "";
        ACT_CONFIG : integer := 0 );
    port(
        PAD : in  std_logic;
        Y   : out std_logic);
end INBUF_MCCC;

architecture DEF_ARCH of INBUF_MCCC is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
    attribute black_box_pad_pin : string; 
    attribute black_box_pad_pin of DEF_ARCH: architecture is "PAD"; 
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity INBUF_LVPECL_MCCC is
    generic (
        ACT_PIN    : string := "" );
    port(
        PADP : in  std_logic;
        PADN : in  std_logic;
        Y    : out std_logic);
end INBUF_LVPECL_MCCC;

architecture DEF_ARCH of INBUF_LVPECL_MCCC is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
    attribute black_box_pad_pin : string; 
    attribute black_box_pad_pin of DEF_ARCH: architecture is "PADP, PADN"; 
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity INBUF_LVDS_MCCC is
    generic (
        ACT_PIN    : string := "" );
    port(
        PADP : in  std_logic;
        PADN : in  std_logic;
        Y    : out std_logic);
end INBUF_LVDS_MCCC;

architecture DEF_ARCH of INBUF_LVDS_MCCC is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
    attribute black_box_pad_pin : string; 
    attribute black_box_pad_pin of DEF_ARCH: architecture is "PADP, PADN"; 
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity MSSINT is
    port(
        Y : out std_logic;
        A : in  std_logic);
end MSSINT;

architecture DEF_ARCH of MSSINT is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity MSS_ALL is

  generic (
    ACT_CONFIG : integer := 0;
    ACT_FCLK   : integer := 0;
    ACT_DIE    : string := "";
    ACT_PKG    : string := "");

   port (      
      HMADDR        : out std_logic_vector(19 downto 0);
      HMWDATA       : out std_logic_vector(31 downto 0);
      HMTRANS       : out std_logic;
      HMSIZE        : out std_logic_vector(1 downto 0);
      HMMASTLOCK    : out std_logic;
      HMAHBWRITE    : out std_logic;
      HMRDATA       : in std_logic_vector(31 downto 0);
      HMAHBREADY    : in std_logic;
      HMRESP        : in std_logic;
      FMADDR        : in std_logic_vector(31 downto 0);
      FMWDATA       : in std_logic_vector(31 downto 0);
      FMTRANS       : in std_logic;
      FMSIZE        : in std_logic_vector(1 downto 0);
      FMMASTLOCK    : in std_logic;
      FMAHBWRITE    : in std_logic;
      FMAHBSEL      : in std_logic;
      FMAHBREADY    : in std_logic;
      FMRDATA       : out std_logic_vector(31 downto 0);
      FMREADYOUT    : out std_logic;
      FMRESP        : out std_logic;
      HMPSEL        : out std_logic;
      HMPENABLE     : out std_logic;
      HMPWRITE      : out std_logic;
      FMPSLVERR     : out std_logic;
      HMPREADY      : in std_logic;
      HMPSLVERR     : in std_logic;
      FMPSEL        : in std_logic;
      FMPENABLE     : in std_logic;
      FMPWRITE      : in std_logic;
      FMPREADY      : out std_logic;
      SYNCCLKFDBK     : in std_logic;
      CALIBOUT        : out std_logic;
      CALIBIN         : in std_logic;
      FABINT          : in std_logic;
      MSSINT          : out std_logic_vector(7 downto 0);
      WDINT           : out std_logic;
      F2MRESETn       : in std_logic;
      DMAREADY        : in std_logic_vector(1 downto 0);
      RXEV            : in std_logic;
      VRON            : in std_logic;
      M2FRESETn       : out std_logic;
      DEEPSLEEP       : out std_logic;
      SLEEP           : out std_logic;
      TXEV            : out std_logic;
      UART0CTSn       : in std_logic;
      UART0DSRn       : in std_logic;
      UART0RIn        : in std_logic;
      UART0DCDn       : in std_logic;
      UART0RTSn       : out std_logic;
      UART0DTRn       : out std_logic;
      UART1CTSn       : in std_logic;
      UART1DSRn       : in std_logic;
      UART1RIn        : in std_logic;
      UART1DCDn       : in std_logic;
      UART1RTSn       : out std_logic;
      UART1DTRn       : out std_logic;
      I2C0SMBUSNI     : in std_logic;
      I2C0SMBALERTNI  : in std_logic;
      I2C0BCLK        : in std_logic;
      I2C0SMBUSNO     : out std_logic;
      I2C0SMBALERTNO  : out std_logic;
      I2C1SMBUSNI     : in std_logic;
      I2C1SMBALERTNI  : in std_logic;
      I2C1BCLK        : in std_logic;
      I2C1SMBUSNO     : out std_logic;
      I2C1SMBALERTNO  : out std_logic;
      MACM2FTXD       : out std_logic_vector(1 downto 0);
      MACF2MRXD       : in std_logic_vector(1 downto 0);
      MACM2FTXEN      : out std_logic;
      MACF2MCRSDV     : in std_logic;
      MACF2MRXER      : in std_logic;
      MACF2MMDI       : in std_logic;
      MACM2FMDO       : out std_logic;
      MACM2FMDEN      : out std_logic;
      MACM2FMDC       : out std_logic;
      FABSDD0D        : in std_logic;
      FABSDD1D        : in std_logic;
      FABSDD2D        : in std_logic;
      FABSDD0CLK      : in std_logic;
      FABSDD1CLK      : in std_logic;
      FABSDD2CLK      : in std_logic;
      FABACETRIG      : in std_logic;
      ACEFLAGS        : out std_logic_vector(31 downto 0);
      CMP0            : out std_logic;
      CMP1            : out std_logic;
      CMP2            : out std_logic;
      CMP3            : out std_logic;
      CMP4            : out std_logic;
      CMP5            : out std_logic;
      CMP6            : out std_logic;
      CMP7            : out std_logic;
      CMP8            : out std_logic;
      CMP9            : out std_logic;
      CMP10           : out std_logic;
      CMP11           : out std_logic;
      LVTTL0EN        : in std_logic;
      LVTTL1EN        : in std_logic;
      LVTTL2EN        : in std_logic;
      LVTTL3EN        : in std_logic;
      LVTTL4EN        : in std_logic;
      LVTTL5EN        : in std_logic;
      LVTTL6EN        : in std_logic;
      LVTTL7EN        : in std_logic;
      LVTTL8EN        : in std_logic;
      LVTTL9EN        : in std_logic;
      LVTTL10EN       : in std_logic;
      LVTTL11EN       : in std_logic;
      LVTTL0          : out std_logic;
      LVTTL1          : out std_logic;
      LVTTL2          : out std_logic;
      LVTTL3          : out std_logic;
      LVTTL4          : out std_logic;
      LVTTL5          : out std_logic;
      LVTTL6          : out std_logic;
      LVTTL7          : out std_logic;
      LVTTL8          : out std_logic;
      LVTTL9          : out std_logic;
      LVTTL10         : out std_logic;
      LVTTL11         : out std_logic;
      PUFABn          : out std_logic;
      VCC15GOOD       : out std_logic;
      VCC33GOOD       : out std_logic;
      FCLK            : in std_logic;
      MACCLKCCC       : in std_logic;
      RCOSC           : in std_logic;
      MACCLK          : in std_logic;
      PLLLOCK         : in std_logic;
      MSSRESETn       : in std_logic;
      GPI             : in std_logic_vector(31 downto 0);
      GPO             : out std_logic_vector(31 downto 0);
      GPOE            : out std_logic_vector(31 downto 0);
      SPI0DO          : out std_logic;
      SPI0DOE         : out std_logic;
      SPI0DI          : in std_logic;
      SPI0CLKI        : in std_logic;
      SPI0CLKO        : out std_logic;
      SPI0MODE        : out std_logic;
      SPI0SSI         : in std_logic;
      SPI0SSO         : out std_logic_vector(7 downto 0);
      UART0TXD        : out std_logic;
      UART0RXD        : in std_logic;
      I2C0SDAI        : in std_logic;
      I2C0SDAO        : out std_logic;
      I2C0SCLI        : in std_logic;
      I2C0SCLO        : out std_logic;
      SPI1DO          : out std_logic;
      SPI1DOE         : out std_logic;
      SPI1DI          : in std_logic;
      SPI1CLKI        : in std_logic;
      SPI1CLKO        : out std_logic;
      SPI1MODE        : out std_logic;
      SPI1SSI         : in std_logic;
      SPI1SSO         : out std_logic_vector(7 downto 0);
      UART1TXD        : out std_logic;
      UART1RXD        : in std_logic;
      I2C1SDAI        : in std_logic;
      I2C1SDAO        : out std_logic;
      I2C1SCLI        : in std_logic;
      I2C1SCLO        : out std_logic;
      MACTXD          : out std_logic_vector(1 downto 0);
      MACRXD          : in std_logic_vector(1 downto 0);
      MACTXEN         : out std_logic;
      MACCRSDV        : in std_logic;
      MACRXER         : in std_logic;
      MACMDI          : in std_logic;
      MACMDO          : out std_logic;
      MACMDEN         : out std_logic;
      MACMDC          : out std_logic;
      EMCCLK          : out std_logic;
      EMCCLKRTN       : in std_logic;
      EMCRDB          : in std_logic_vector(15 downto 0);
      EMCAB           : out std_logic_vector(25 downto 0);
      EMCWDB          : out std_logic_vector(15 downto 0);
      EMCRWn          : out std_logic;
      EMCCS0n         : out std_logic;
      EMCCS1n         : out std_logic;
      EMCOEN0n        : out std_logic;
      EMCOEN1n        : out std_logic;
      EMCBYTEN        : out std_logic_vector(1 downto 0);
      EMCDBOE         : out std_logic;
      ADC0            : in std_logic;
      ADC1            : in std_logic;
      ADC2            : in std_logic;
      ADC3            : in std_logic;
      ADC4            : in std_logic;
      ADC5            : in std_logic;
      ADC6            : in std_logic;
      ADC7            : in std_logic;
      ADC8            : in std_logic;
      ADC9            : in std_logic;
      ADC10           : in std_logic;
      ADC11           : in std_logic;
      SDD0            : out std_logic;
      SDD1            : out std_logic;
      SDD2            : out std_logic;
      ABPS0           : in std_logic;
      ABPS1           : in std_logic;
      ABPS2           : in std_logic;
      ABPS3           : in std_logic;
      ABPS4           : in std_logic;
      ABPS5           : in std_logic;
      ABPS6           : in std_logic;
      ABPS7           : in std_logic;
      ABPS8           : in std_logic;
      ABPS9           : in std_logic;
      ABPS10          : in std_logic;
      ABPS11          : in std_logic;
      TM0             : in std_logic;
      TM1             : in std_logic;
      TM2             : in std_logic;
      TM3             : in std_logic;
      TM4             : in std_logic;
      TM5             : in std_logic;
      CM0             : in std_logic;
      CM1             : in std_logic;
      CM2             : in std_logic;
      CM3             : in std_logic;
      CM4             : in std_logic;
      CM5             : in std_logic;
      GNDTM0          : in std_logic;
      GNDTM1          : in std_logic;
      GNDTM2          : in std_logic;
      VAREF0          : in std_logic;
      VAREF1          : in std_logic;
      VAREF2          : in std_logic;
      VAREFOUT        : out std_logic;
      GNDVAREF        : in std_logic;
      PUn             : in std_logic
   );
end MSS_ALL;

architecture DEF_ARCH of MSS_ALL is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity MSS_XTLOSC is

    port (
         XTL    : in    std_logic;
         CLKOUT : out   std_logic 
         );        

end MSS_XTLOSC;

architecture DEF_ARCH of MSS_XTLOSC is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
    attribute black_box_pad_pin : string; 
    attribute black_box_pad_pin of DEF_ARCH: architecture is "XTL"; 
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity MSS_LPXTLOSC is

    port (
         LPXIN  : in    std_logic;
         CLKOUT : out   std_logic 
         );        

end MSS_LPXTLOSC;

architecture DEF_ARCH of MSS_LPXTLOSC is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
    attribute black_box_pad_pin : string; 
    attribute black_box_pad_pin of DEF_ARCH: architecture is "LPXIN"; 
begin 
end DEF_ARCH;

library IEEE;
use IEEE.std_logic_1164.all;

entity MSS_CCC is

  generic (
    VCOFREQUENCY : real := 0.0 );

  port (
    CLKA         : in    std_logic;
    EXTFB        : in    std_logic;
    GLA          : out   std_logic;
    GLAMSS       : out   std_logic;
    LOCK         : out   std_logic;
    LOCKMSS      : out   std_logic;
    CLKB         : in    std_logic;
    GLB          : out   std_logic;
    YB           : out   std_logic;
    CLKC         : in    std_logic;
    GLC          : out   std_logic;
    YC           : out   std_logic;
    MACCLK       : out   std_logic;
    OADIV        : in    std_logic_vector(4 downto 0);
    OADIVHALF    : in    std_logic;
    OAMUX        : in    std_logic_vector(2 downto 0);
    BYPASSA      : in    std_logic;
    DLYGLA       : in    std_logic_vector(4 downto 0);
    DLYGLAMSS    : in    std_logic_vector(4 downto 0);
    DLYGLAFAB    : in    std_logic_vector(4 downto 0);
    OBDIV        : in    std_logic_vector(4 downto 0);
    OBDIVHALF    : in    std_logic;
    OBMUX        : in    std_logic_vector(2 downto 0);
    BYPASSB      : in    std_logic;
    DLYGLB       : in    std_logic_vector(4 downto 0);
    OCDIV        : in    std_logic_vector(4 downto 0);
    OCDIVHALF    : in    std_logic;
    OCMUX        : in    std_logic_vector(2 downto 0);
    BYPASSC      : in    std_logic;
    DLYGLC       : in    std_logic_vector(4 downto 0);
    FINDIV       : in    std_logic_vector(6 downto 0);
    FBDIV        : in    std_logic_vector(6 downto 0);
    FBDLY        : in    std_logic_vector(4 downto 0);
    FBSEL        : in    std_logic_vector(1 downto 0);
    XDLYSEL      : in    std_logic;
    GLMUXSEL     : in    std_logic_vector(1 downto 0);
    GLMUXCFG     : in    std_logic_vector(1 downto 0)
   );
  
end MSS_CCC;

architecture DEF_ARCH of MSS_CCC is 
    attribute syn_black_box : boolean;
    attribute syn_black_box of DEF_ARCH : architecture is true;
begin 
end DEF_ARCH;
