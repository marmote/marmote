-- Version: 9.1 SP1 9.1.1.7

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity uC is

    port( GLC         : out   std_logic;
          MAINXIN     : in    std_logic;
          MAC_0_RXD   : in    std_logic_vector(1 downto 0);
          MAC_0_TXD   : out   std_logic_vector(1 downto 0);
          MAC_0_MDIO  : inout std_logic := 'Z';
          MAC_0_CRSDV : in    std_logic;
          MAC_0_RXER  : in    std_logic;
          MAC_0_TXEN  : out   std_logic;
          MAC_0_MDC   : out   std_logic;
          MSS_RESET_N : in    std_logic
        );

end uC;

architecture DEF_ARCH of uC is 

  component OUTBUF_MSS
    generic (ACT_CONFIG:integer := 0; ACT_PIN:string := "");

    port( D   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component BIBUF_MSS
    generic (ACT_CONFIG:integer := 0; ACT_PIN:string := "");

    port( PAD : inout   std_logic;
          D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component INBUF_MSS
    generic (ACT_CONFIG:integer := 0; ACT_PIN:string := "");

    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component MSS_APB
    generic (ACT_CONFIG:integer := 0; ACT_DIE:string := ""; 
        ACT_FCLK:integer := 0; ACT_PKG:string := "");

    port( MSSPADDR       : out   std_logic_vector(19 downto 0);
          MSSPWDATA      : out   std_logic_vector(31 downto 0);
          MSSPWRITE      : out   std_logic;
          MSSPSEL        : out   std_logic;
          MSSPENABLE     : out   std_logic;
          MSSPRDATA      : in    std_logic_vector(31 downto 0) := (others => 'U');
          MSSPREADY      : in    std_logic := 'U';
          MSSPSLVERR     : in    std_logic := 'U';
          FABPADDR       : in    std_logic_vector(31 downto 0) := (others => 'U');
          FABPWDATA      : in    std_logic_vector(31 downto 0) := (others => 'U');
          FABPWRITE      : in    std_logic := 'U';
          FABPSEL        : in    std_logic := 'U';
          FABPENABLE     : in    std_logic := 'U';
          FABPRDATA      : out   std_logic_vector(31 downto 0);
          FABPREADY      : out   std_logic;
          FABPSLVERR     : out   std_logic;
          SYNCCLKFDBK    : in    std_logic := 'U';
          CALIBOUT       : out   std_logic;
          CALIBIN        : in    std_logic := 'U';
          FABINT         : in    std_logic := 'U';
          MSSINT         : out   std_logic_vector(7 downto 0);
          WDINT          : out   std_logic;
          F2MRESETn      : in    std_logic := 'U';
          DMAREADY       : in    std_logic_vector(1 downto 0) := (others => 'U');
          RXEV           : in    std_logic := 'U';
          VRON           : in    std_logic := 'U';
          M2FRESETn      : out   std_logic;
          DEEPSLEEP      : out   std_logic;
          SLEEP          : out   std_logic;
          TXEV           : out   std_logic;
          GPI            : in    std_logic_vector(31 downto 0) := (others => 'U');
          GPO            : out   std_logic_vector(31 downto 0);
          UART0CTSn      : in    std_logic := 'U';
          UART0DSRn      : in    std_logic := 'U';
          UART0RIn       : in    std_logic := 'U';
          UART0DCDn      : in    std_logic := 'U';
          UART0RTSn      : out   std_logic;
          UART0DTRn      : out   std_logic;
          UART1CTSn      : in    std_logic := 'U';
          UART1DSRn      : in    std_logic := 'U';
          UART1RIn       : in    std_logic := 'U';
          UART1DCDn      : in    std_logic := 'U';
          UART1RTSn      : out   std_logic;
          UART1DTRn      : out   std_logic;
          I2C0SMBUSNI    : in    std_logic := 'U';
          I2C0SMBALERTNI : in    std_logic := 'U';
          I2C0BCLK       : in    std_logic := 'U';
          I2C0SMBUSNO    : out   std_logic;
          I2C0SMBALERTNO : out   std_logic;
          I2C1SMBUSNI    : in    std_logic := 'U';
          I2C1SMBALERTNI : in    std_logic := 'U';
          I2C1BCLK       : in    std_logic := 'U';
          I2C1SMBUSNO    : out   std_logic;
          I2C1SMBALERTNO : out   std_logic;
          MACM2FTXD      : out   std_logic_vector(1 downto 0);
          MACF2MRXD      : in    std_logic_vector(1 downto 0) := (others => 'U');
          MACM2FTXEN     : out   std_logic;
          MACF2MCRSDV    : in    std_logic := 'U';
          MACF2MRXER     : in    std_logic := 'U';
          MACF2MMDI      : in    std_logic := 'U';
          MACM2FMDO      : out   std_logic;
          MACM2FMDEN     : out   std_logic;
          MACM2FMDC      : out   std_logic;
          FABSDD0D       : in    std_logic := 'U';
          FABSDD1D       : in    std_logic := 'U';
          FABSDD2D       : in    std_logic := 'U';
          FABSDD0CLK     : in    std_logic := 'U';
          FABSDD1CLK     : in    std_logic := 'U';
          FABSDD2CLK     : in    std_logic := 'U';
          FABACETRIG     : in    std_logic := 'U';
          ACEFLAGS       : out   std_logic_vector(31 downto 0);
          CMP0           : out   std_logic;
          CMP1           : out   std_logic;
          CMP2           : out   std_logic;
          CMP3           : out   std_logic;
          CMP4           : out   std_logic;
          CMP5           : out   std_logic;
          CMP6           : out   std_logic;
          CMP7           : out   std_logic;
          CMP8           : out   std_logic;
          CMP9           : out   std_logic;
          CMP10          : out   std_logic;
          CMP11          : out   std_logic;
          LVTTL0EN       : in    std_logic := 'U';
          LVTTL1EN       : in    std_logic := 'U';
          LVTTL2EN       : in    std_logic := 'U';
          LVTTL3EN       : in    std_logic := 'U';
          LVTTL4EN       : in    std_logic := 'U';
          LVTTL5EN       : in    std_logic := 'U';
          LVTTL6EN       : in    std_logic := 'U';
          LVTTL7EN       : in    std_logic := 'U';
          LVTTL8EN       : in    std_logic := 'U';
          LVTTL9EN       : in    std_logic := 'U';
          LVTTL10EN      : in    std_logic := 'U';
          LVTTL11EN      : in    std_logic := 'U';
          LVTTL0         : out   std_logic;
          LVTTL1         : out   std_logic;
          LVTTL2         : out   std_logic;
          LVTTL3         : out   std_logic;
          LVTTL4         : out   std_logic;
          LVTTL5         : out   std_logic;
          LVTTL6         : out   std_logic;
          LVTTL7         : out   std_logic;
          LVTTL8         : out   std_logic;
          LVTTL9         : out   std_logic;
          LVTTL10        : out   std_logic;
          LVTTL11        : out   std_logic;
          PUFABn         : out   std_logic;
          VCC15GOOD      : out   std_logic;
          VCC33GOOD      : out   std_logic;
          FCLK           : in    std_logic := 'U';
          MACCLKCCC      : in    std_logic := 'U';
          RCOSC          : in    std_logic := 'U';
          MACCLK         : in    std_logic := 'U';
          PLLLOCK        : in    std_logic := 'U';
          MSSRESETn      : in    std_logic := 'U';
          GPOE           : out   std_logic_vector(31 downto 0);
          SPI0DO         : out   std_logic;
          SPI0DOE        : out   std_logic;
          SPI0DI         : in    std_logic := 'U';
          SPI0CLKI       : in    std_logic := 'U';
          SPI0CLKO       : out   std_logic;
          SPI0MODE       : out   std_logic;
          SPI0SSI        : in    std_logic := 'U';
          SPI0SSO        : out   std_logic_vector(7 downto 0);
          UART0TXD       : out   std_logic;
          UART0RXD       : in    std_logic := 'U';
          I2C0SDAI       : in    std_logic := 'U';
          I2C0SDAO       : out   std_logic;
          I2C0SCLI       : in    std_logic := 'U';
          I2C0SCLO       : out   std_logic;
          SPI1DO         : out   std_logic;
          SPI1DOE        : out   std_logic;
          SPI1DI         : in    std_logic := 'U';
          SPI1CLKI       : in    std_logic := 'U';
          SPI1CLKO       : out   std_logic;
          SPI1MODE       : out   std_logic;
          SPI1SSI        : in    std_logic := 'U';
          SPI1SSO        : out   std_logic_vector(7 downto 0);
          UART1TXD       : out   std_logic;
          UART1RXD       : in    std_logic := 'U';
          I2C1SDAI       : in    std_logic := 'U';
          I2C1SDAO       : out   std_logic;
          I2C1SCLI       : in    std_logic := 'U';
          I2C1SCLO       : out   std_logic;
          MACTXD         : out   std_logic_vector(1 downto 0);
          MACRXD         : in    std_logic_vector(1 downto 0) := (others => 'U');
          MACTXEN        : out   std_logic;
          MACCRSDV       : in    std_logic := 'U';
          MACRXER        : in    std_logic := 'U';
          MACMDI         : in    std_logic := 'U';
          MACMDO         : out   std_logic;
          MACMDEN        : out   std_logic;
          MACMDC         : out   std_logic;
          EMCCLK         : out   std_logic;
          EMCCLKRTN      : in    std_logic := 'U';
          EMCRDB         : in    std_logic_vector(15 downto 0) := (others => 'U');
          EMCAB          : out   std_logic_vector(25 downto 0);
          EMCWDB         : out   std_logic_vector(15 downto 0);
          EMCRWn         : out   std_logic;
          EMCCS0n        : out   std_logic;
          EMCCS1n        : out   std_logic;
          EMCOEN0n       : out   std_logic;
          EMCOEN1n       : out   std_logic;
          EMCBYTEN       : out   std_logic_vector(1 downto 0);
          EMCDBOE        : out   std_logic;
          ADC0           : in    std_logic := 'U';
          ADC1           : in    std_logic := 'U';
          ADC2           : in    std_logic := 'U';
          ADC3           : in    std_logic := 'U';
          ADC4           : in    std_logic := 'U';
          ADC5           : in    std_logic := 'U';
          ADC6           : in    std_logic := 'U';
          ADC7           : in    std_logic := 'U';
          ADC8           : in    std_logic := 'U';
          ADC9           : in    std_logic := 'U';
          ADC10          : in    std_logic := 'U';
          ADC11          : in    std_logic := 'U';
          SDD0           : out   std_logic;
          SDD1           : out   std_logic;
          SDD2           : out   std_logic;
          ABPS0          : in    std_logic := 'U';
          ABPS1          : in    std_logic := 'U';
          ABPS2          : in    std_logic := 'U';
          ABPS3          : in    std_logic := 'U';
          ABPS4          : in    std_logic := 'U';
          ABPS5          : in    std_logic := 'U';
          ABPS6          : in    std_logic := 'U';
          ABPS7          : in    std_logic := 'U';
          ABPS8          : in    std_logic := 'U';
          ABPS9          : in    std_logic := 'U';
          ABPS10         : in    std_logic := 'U';
          ABPS11         : in    std_logic := 'U';
          TM0            : in    std_logic := 'U';
          TM1            : in    std_logic := 'U';
          TM2            : in    std_logic := 'U';
          TM3            : in    std_logic := 'U';
          TM4            : in    std_logic := 'U';
          TM5            : in    std_logic := 'U';
          CM0            : in    std_logic := 'U';
          CM1            : in    std_logic := 'U';
          CM2            : in    std_logic := 'U';
          CM3            : in    std_logic := 'U';
          CM4            : in    std_logic := 'U';
          CM5            : in    std_logic := 'U';
          GNDTM0         : in    std_logic := 'U';
          GNDTM1         : in    std_logic := 'U';
          GNDTM2         : in    std_logic := 'U';
          VAREF0         : in    std_logic := 'U';
          VAREF1         : in    std_logic := 'U';
          VAREF2         : in    std_logic := 'U';
          VAREFOUT       : out   std_logic;
          GNDVAREF       : in    std_logic := 'U';
          PUn            : in    std_logic := 'U'
        );
  end component;

  component uC_tmp_MSS_CCC_0_MSS_CCC
    port( CLKA           : in    std_logic := 'U';
          CLKA_PAD       : in    std_logic := 'U';
          CLKA_PADP      : in    std_logic := 'U';
          CLKA_PADN      : in    std_logic := 'U';
          CLKB           : in    std_logic := 'U';
          CLKB_PAD       : in    std_logic := 'U';
          CLKB_PADP      : in    std_logic := 'U';
          CLKB_PADN      : in    std_logic := 'U';
          CLKC           : in    std_logic := 'U';
          CLKC_PAD       : in    std_logic := 'U';
          CLKC_PADP      : in    std_logic := 'U';
          CLKC_PADN      : in    std_logic := 'U';
          GLA            : out   std_logic;
          GLB            : out   std_logic;
          GLC            : out   std_logic;
          FAB_CLK        : out   std_logic;
          YB             : out   std_logic;
          YC             : out   std_logic;
          MAINXIN        : in    std_logic := 'U';
          LPXIN          : in    std_logic := 'U';
          FAB_LOCK       : out   std_logic;
          MAC_CLK        : in    std_logic := 'U';
          RCOSC_CLKOUT   : out   std_logic;
          MAINXIN_CLKOUT : out   std_logic;
          LPXIN_CLKOUT   : out   std_logic;
          GLA0           : out   std_logic;
          MSS_LOCK       : out   std_logic;
          MAC_CLK_CCC    : out   std_logic;
          MAC_CLK_IO     : out   std_logic
        );
  end component;

    signal MSS_ADLIB_INST_EMCCLK, MSS_ADLIB_INST_FCLK, 
        MSS_ADLIB_INST_MACCLK, MSS_ADLIB_INST_MACCLKCCC, 
        MSS_ADLIB_INST_PLLLOCK, MSS_MAC_0_CRSDV_Y, 
        MSS_MAC_0_MDC_D, MSS_MAC_0_MDIO_D, MSS_MAC_0_MDIO_E, 
        MSS_MAC_0_MDIO_Y, MSS_MAC_0_RXD_0_Y, MSS_MAC_0_RXD_1_Y, 
        MSS_MAC_0_RXER_Y, MSS_MAC_0_TXD_0_D, MSS_MAC_0_TXD_1_D, 
        MSS_MAC_0_TXEN_D, MSS_RESET_0_MSS_RESET_N_Y, GND_net, 
        VCC_net : std_logic;
    signal nc228, nc203, nc216, nc194, nc151, nc23, nc175, nc250, 
        nc58, nc116, nc74, nc133, nc238, nc167, nc84, nc39, nc72, 
        nc212, nc205, nc82, nc145, nc181, nc160, nc57, nc156, 
        nc125, nc211, nc73, nc107, nc66, nc83, nc9, nc171, nc54, 
        nc135, nc41, nc100, nc52, nc186, nc29, nc118, nc60, nc141, 
        nc193, nc214, nc240, nc45, nc53, nc121, nc176, nc220, 
        nc158, nc209, nc246, nc162, nc11, nc131, nc96, nc79, 
        nc226, nc146, nc230, nc89, nc119, nc48, nc213, nc126, 
        nc195, nc188, nc242, nc15, nc236, nc102, nc3, nc207, nc47, 
        nc90, nc222, nc159, nc136, nc241, nc178, nc215, nc59, 
        nc221, nc232, nc18, nc44, nc117, nc189, nc164, nc148, 
        nc42, nc231, nc191, nc17, nc2, nc110, nc128, nc244, nc43, 
        nc179, nc157, nc36, nc224, nc61, nc104, nc138, nc14, 
        nc150, nc196, nc234, nc149, nc12, nc219, nc30, nc243, 
        nc187, nc65, nc7, nc129, nc8, nc223, nc13, nc180, nc26, 
        nc177, nc139, nc245, nc233, nc163, nc112, nc68, nc49, 
        nc217, nc170, nc91, nc225, nc5, nc20, nc198, nc147, nc67, 
        nc152, nc127, nc103, nc235, nc76, nc208, nc140, nc86, 
        nc95, nc120, nc165, nc137, nc64, nc19, nc70, nc182, nc62, 
        nc199, nc80, nc130, nc98, nc249, nc114, nc56, nc105, nc63, 
        nc172, nc229, nc97, nc161, nc31, nc154, nc50, nc239, 
        nc142, nc247, nc94, nc197, nc122, nc35, nc4, nc227, nc92, 
        nc101, nc184, nc200, nc190, nc166, nc132, nc21, nc237, 
        nc93, nc69, nc206, nc174, nc38, nc113, nc218, nc106, nc25, 
        nc1, nc37, nc202, nc144, nc153, nc46, nc71, nc124, nc81, 
        nc201, nc168, nc34, nc28, nc115, nc192, nc134, nc32, nc40, 
        nc99, nc75, nc183, nc85, nc27, nc108, nc16, nc155, nc51, 
        nc33, nc204, nc173, nc169, nc78, nc24, nc88, nc111, nc55, 
        nc10, nc22, nc210, nc185, nc143, nc248, nc77, nc6, nc109, 
        nc87, nc123 : std_logic;

begin 


    MSS_MAC_0_MDC : OUTBUF_MSS
      generic map(ACT_CONFIG => 0, ACT_PIN => "AA3")

      port map(D => MSS_MAC_0_MDC_D, PAD => MAC_0_MDC);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    MSS_MAC_0_TXD_1 : OUTBUF_MSS
      generic map(ACT_CONFIG => 0, ACT_PIN => "W5")

      port map(D => MSS_MAC_0_TXD_1_D, PAD => MAC_0_TXD(1));
    
    MSS_MAC_0_TXD_0 : OUTBUF_MSS
      generic map(ACT_CONFIG => 0, ACT_PIN => "AA5")

      port map(D => MSS_MAC_0_TXD_0_D, PAD => MAC_0_TXD(0));
    
    MSS_MAC_0_MDIO : BIBUF_MSS
      generic map(ACT_CONFIG => 0, ACT_PIN => "V4")

      port map(PAD => MAC_0_MDIO, D => MSS_MAC_0_MDIO_D, E => 
        MSS_MAC_0_MDIO_E, Y => MSS_MAC_0_MDIO_Y);
    
    MSS_MAC_0_CRSDV : INBUF_MSS
      generic map(ACT_CONFIG => 0, ACT_PIN => "W4")

      port map(PAD => MAC_0_CRSDV, Y => MSS_MAC_0_CRSDV_Y);
    
    \VCC\ : VCC
      port map(Y => VCC_net);
    
    MSS_MAC_0_RXER : INBUF_MSS
      generic map(ACT_CONFIG => 0, ACT_PIN => "AA4")

      port map(PAD => MAC_0_RXER, Y => MSS_MAC_0_RXER_Y);
    
    MSS_MAC_0_RXD_0 : INBUF_MSS
      generic map(ACT_CONFIG => 0, ACT_PIN => "V5")

      port map(PAD => MAC_0_RXD(0), Y => MSS_MAC_0_RXD_0_Y);
    
    MSS_ADLIB_INST : MSS_APB
      generic map(ACT_CONFIG => 0, ACT_DIE => "IP4X3M1",
         ACT_FCLK => 100000000, ACT_PKG => "fg484")

      port map(MSSPADDR(19) => nc228, MSSPADDR(18) => nc203, 
        MSSPADDR(17) => nc216, MSSPADDR(16) => nc194, 
        MSSPADDR(15) => nc151, MSSPADDR(14) => nc23, MSSPADDR(13)
         => nc175, MSSPADDR(12) => nc250, MSSPADDR(11) => nc58, 
        MSSPADDR(10) => nc116, MSSPADDR(9) => nc74, MSSPADDR(8)
         => nc133, MSSPADDR(7) => nc238, MSSPADDR(6) => nc167, 
        MSSPADDR(5) => nc84, MSSPADDR(4) => nc39, MSSPADDR(3) => 
        nc72, MSSPADDR(2) => nc212, MSSPADDR(1) => nc205, 
        MSSPADDR(0) => nc82, MSSPWDATA(31) => nc145, 
        MSSPWDATA(30) => nc181, MSSPWDATA(29) => nc160, 
        MSSPWDATA(28) => nc57, MSSPWDATA(27) => nc156, 
        MSSPWDATA(26) => nc125, MSSPWDATA(25) => nc211, 
        MSSPWDATA(24) => nc73, MSSPWDATA(23) => nc107, 
        MSSPWDATA(22) => nc66, MSSPWDATA(21) => nc83, 
        MSSPWDATA(20) => nc9, MSSPWDATA(19) => nc171, 
        MSSPWDATA(18) => nc54, MSSPWDATA(17) => nc135, 
        MSSPWDATA(16) => nc41, MSSPWDATA(15) => nc100, 
        MSSPWDATA(14) => nc52, MSSPWDATA(13) => nc186, 
        MSSPWDATA(12) => nc29, MSSPWDATA(11) => nc118, 
        MSSPWDATA(10) => nc60, MSSPWDATA(9) => nc141, 
        MSSPWDATA(8) => nc193, MSSPWDATA(7) => nc214, 
        MSSPWDATA(6) => nc240, MSSPWDATA(5) => nc45, MSSPWDATA(4)
         => nc53, MSSPWDATA(3) => nc121, MSSPWDATA(2) => nc176, 
        MSSPWDATA(1) => nc220, MSSPWDATA(0) => nc158, MSSPWRITE
         => OPEN, MSSPSEL => OPEN, MSSPENABLE => OPEN, 
        MSSPRDATA(31) => GND_net, MSSPRDATA(30) => GND_net, 
        MSSPRDATA(29) => GND_net, MSSPRDATA(28) => GND_net, 
        MSSPRDATA(27) => GND_net, MSSPRDATA(26) => GND_net, 
        MSSPRDATA(25) => GND_net, MSSPRDATA(24) => GND_net, 
        MSSPRDATA(23) => GND_net, MSSPRDATA(22) => GND_net, 
        MSSPRDATA(21) => GND_net, MSSPRDATA(20) => GND_net, 
        MSSPRDATA(19) => GND_net, MSSPRDATA(18) => GND_net, 
        MSSPRDATA(17) => GND_net, MSSPRDATA(16) => GND_net, 
        MSSPRDATA(15) => GND_net, MSSPRDATA(14) => GND_net, 
        MSSPRDATA(13) => GND_net, MSSPRDATA(12) => GND_net, 
        MSSPRDATA(11) => GND_net, MSSPRDATA(10) => GND_net, 
        MSSPRDATA(9) => GND_net, MSSPRDATA(8) => GND_net, 
        MSSPRDATA(7) => GND_net, MSSPRDATA(6) => GND_net, 
        MSSPRDATA(5) => GND_net, MSSPRDATA(4) => GND_net, 
        MSSPRDATA(3) => GND_net, MSSPRDATA(2) => GND_net, 
        MSSPRDATA(1) => GND_net, MSSPRDATA(0) => GND_net, 
        MSSPREADY => VCC_net, MSSPSLVERR => GND_net, FABPADDR(31)
         => GND_net, FABPADDR(30) => GND_net, FABPADDR(29) => 
        GND_net, FABPADDR(28) => GND_net, FABPADDR(27) => GND_net, 
        FABPADDR(26) => GND_net, FABPADDR(25) => GND_net, 
        FABPADDR(24) => GND_net, FABPADDR(23) => GND_net, 
        FABPADDR(22) => GND_net, FABPADDR(21) => GND_net, 
        FABPADDR(20) => GND_net, FABPADDR(19) => GND_net, 
        FABPADDR(18) => GND_net, FABPADDR(17) => GND_net, 
        FABPADDR(16) => GND_net, FABPADDR(15) => GND_net, 
        FABPADDR(14) => GND_net, FABPADDR(13) => GND_net, 
        FABPADDR(12) => GND_net, FABPADDR(11) => GND_net, 
        FABPADDR(10) => GND_net, FABPADDR(9) => GND_net, 
        FABPADDR(8) => GND_net, FABPADDR(7) => GND_net, 
        FABPADDR(6) => GND_net, FABPADDR(5) => GND_net, 
        FABPADDR(4) => GND_net, FABPADDR(3) => GND_net, 
        FABPADDR(2) => GND_net, FABPADDR(1) => GND_net, 
        FABPADDR(0) => GND_net, FABPWDATA(31) => GND_net, 
        FABPWDATA(30) => GND_net, FABPWDATA(29) => GND_net, 
        FABPWDATA(28) => GND_net, FABPWDATA(27) => GND_net, 
        FABPWDATA(26) => GND_net, FABPWDATA(25) => GND_net, 
        FABPWDATA(24) => GND_net, FABPWDATA(23) => GND_net, 
        FABPWDATA(22) => GND_net, FABPWDATA(21) => GND_net, 
        FABPWDATA(20) => GND_net, FABPWDATA(19) => GND_net, 
        FABPWDATA(18) => GND_net, FABPWDATA(17) => GND_net, 
        FABPWDATA(16) => GND_net, FABPWDATA(15) => GND_net, 
        FABPWDATA(14) => GND_net, FABPWDATA(13) => GND_net, 
        FABPWDATA(12) => GND_net, FABPWDATA(11) => GND_net, 
        FABPWDATA(10) => GND_net, FABPWDATA(9) => GND_net, 
        FABPWDATA(8) => GND_net, FABPWDATA(7) => GND_net, 
        FABPWDATA(6) => GND_net, FABPWDATA(5) => GND_net, 
        FABPWDATA(4) => GND_net, FABPWDATA(3) => GND_net, 
        FABPWDATA(2) => GND_net, FABPWDATA(1) => GND_net, 
        FABPWDATA(0) => GND_net, FABPWRITE => GND_net, FABPSEL
         => GND_net, FABPENABLE => GND_net, FABPRDATA(31) => 
        nc209, FABPRDATA(30) => nc246, FABPRDATA(29) => nc162, 
        FABPRDATA(28) => nc11, FABPRDATA(27) => nc131, 
        FABPRDATA(26) => nc96, FABPRDATA(25) => nc79, 
        FABPRDATA(24) => nc226, FABPRDATA(23) => nc146, 
        FABPRDATA(22) => nc230, FABPRDATA(21) => nc89, 
        FABPRDATA(20) => nc119, FABPRDATA(19) => nc48, 
        FABPRDATA(18) => nc213, FABPRDATA(17) => nc126, 
        FABPRDATA(16) => nc195, FABPRDATA(15) => nc188, 
        FABPRDATA(14) => nc242, FABPRDATA(13) => nc15, 
        FABPRDATA(12) => nc236, FABPRDATA(11) => nc102, 
        FABPRDATA(10) => nc3, FABPRDATA(9) => nc207, FABPRDATA(8)
         => nc47, FABPRDATA(7) => nc90, FABPRDATA(6) => nc222, 
        FABPRDATA(5) => nc159, FABPRDATA(4) => nc136, 
        FABPRDATA(3) => nc241, FABPRDATA(2) => nc178, 
        FABPRDATA(1) => nc215, FABPRDATA(0) => nc59, FABPREADY
         => OPEN, FABPSLVERR => OPEN, SYNCCLKFDBK => GND_net, 
        CALIBOUT => OPEN, CALIBIN => GND_net, FABINT => GND_net, 
        MSSINT(7) => nc221, MSSINT(6) => nc232, MSSINT(5) => nc18, 
        MSSINT(4) => nc44, MSSINT(3) => nc117, MSSINT(2) => nc189, 
        MSSINT(1) => nc164, MSSINT(0) => nc148, WDINT => OPEN, 
        F2MRESETn => VCC_net, DMAREADY(1) => GND_net, DMAREADY(0)
         => GND_net, RXEV => GND_net, VRON => GND_net, M2FRESETn
         => OPEN, DEEPSLEEP => OPEN, SLEEP => OPEN, TXEV => OPEN, 
        GPI(31) => GND_net, GPI(30) => GND_net, GPI(29) => 
        GND_net, GPI(28) => GND_net, GPI(27) => GND_net, GPI(26)
         => GND_net, GPI(25) => GND_net, GPI(24) => GND_net, 
        GPI(23) => GND_net, GPI(22) => GND_net, GPI(21) => 
        GND_net, GPI(20) => GND_net, GPI(19) => GND_net, GPI(18)
         => GND_net, GPI(17) => GND_net, GPI(16) => GND_net, 
        GPI(15) => GND_net, GPI(14) => GND_net, GPI(13) => 
        GND_net, GPI(12) => GND_net, GPI(11) => GND_net, GPI(10)
         => GND_net, GPI(9) => GND_net, GPI(8) => GND_net, GPI(7)
         => GND_net, GPI(6) => GND_net, GPI(5) => GND_net, GPI(4)
         => GND_net, GPI(3) => GND_net, GPI(2) => GND_net, GPI(1)
         => GND_net, GPI(0) => GND_net, GPO(31) => nc42, GPO(30)
         => nc231, GPO(29) => nc191, GPO(28) => nc17, GPO(27) => 
        nc2, GPO(26) => nc110, GPO(25) => nc128, GPO(24) => nc244, 
        GPO(23) => nc43, GPO(22) => nc179, GPO(21) => nc157, 
        GPO(20) => nc36, GPO(19) => nc224, GPO(18) => nc61, 
        GPO(17) => nc104, GPO(16) => nc138, GPO(15) => nc14, 
        GPO(14) => nc150, GPO(13) => nc196, GPO(12) => nc234, 
        GPO(11) => nc149, GPO(10) => nc12, GPO(9) => nc219, 
        GPO(8) => nc30, GPO(7) => nc243, GPO(6) => nc187, GPO(5)
         => nc65, GPO(4) => nc7, GPO(3) => nc129, GPO(2) => nc8, 
        GPO(1) => nc223, GPO(0) => nc13, UART0CTSn => GND_net, 
        UART0DSRn => GND_net, UART0RIn => GND_net, UART0DCDn => 
        GND_net, UART0RTSn => OPEN, UART0DTRn => OPEN, UART1CTSn
         => GND_net, UART1DSRn => GND_net, UART1RIn => GND_net, 
        UART1DCDn => GND_net, UART1RTSn => OPEN, UART1DTRn => 
        OPEN, I2C0SMBUSNI => GND_net, I2C0SMBALERTNI => GND_net, 
        I2C0BCLK => GND_net, I2C0SMBUSNO => OPEN, I2C0SMBALERTNO
         => OPEN, I2C1SMBUSNI => GND_net, I2C1SMBALERTNI => 
        GND_net, I2C1BCLK => GND_net, I2C1SMBUSNO => OPEN, 
        I2C1SMBALERTNO => OPEN, MACM2FTXD(1) => nc180, 
        MACM2FTXD(0) => nc26, MACF2MRXD(1) => GND_net, 
        MACF2MRXD(0) => GND_net, MACM2FTXEN => OPEN, MACF2MCRSDV
         => GND_net, MACF2MRXER => GND_net, MACF2MMDI => GND_net, 
        MACM2FMDO => OPEN, MACM2FMDEN => OPEN, MACM2FMDC => OPEN, 
        FABSDD0D => GND_net, FABSDD1D => GND_net, FABSDD2D => 
        GND_net, FABSDD0CLK => GND_net, FABSDD1CLK => GND_net, 
        FABSDD2CLK => GND_net, FABACETRIG => GND_net, 
        ACEFLAGS(31) => nc177, ACEFLAGS(30) => nc139, 
        ACEFLAGS(29) => nc245, ACEFLAGS(28) => nc233, 
        ACEFLAGS(27) => nc163, ACEFLAGS(26) => nc112, 
        ACEFLAGS(25) => nc68, ACEFLAGS(24) => nc49, ACEFLAGS(23)
         => nc217, ACEFLAGS(22) => nc170, ACEFLAGS(21) => nc91, 
        ACEFLAGS(20) => nc225, ACEFLAGS(19) => nc5, ACEFLAGS(18)
         => nc20, ACEFLAGS(17) => nc198, ACEFLAGS(16) => nc147, 
        ACEFLAGS(15) => nc67, ACEFLAGS(14) => nc152, ACEFLAGS(13)
         => nc127, ACEFLAGS(12) => nc103, ACEFLAGS(11) => nc235, 
        ACEFLAGS(10) => nc76, ACEFLAGS(9) => nc208, ACEFLAGS(8)
         => nc140, ACEFLAGS(7) => nc86, ACEFLAGS(6) => nc95, 
        ACEFLAGS(5) => nc120, ACEFLAGS(4) => nc165, ACEFLAGS(3)
         => nc137, ACEFLAGS(2) => nc64, ACEFLAGS(1) => nc19, 
        ACEFLAGS(0) => nc70, CMP0 => OPEN, CMP1 => OPEN, CMP2 => 
        OPEN, CMP3 => OPEN, CMP4 => OPEN, CMP5 => OPEN, CMP6 => 
        OPEN, CMP7 => OPEN, CMP8 => OPEN, CMP9 => OPEN, CMP10 => 
        OPEN, CMP11 => OPEN, LVTTL0EN => GND_net, LVTTL1EN => 
        GND_net, LVTTL2EN => GND_net, LVTTL3EN => GND_net, 
        LVTTL4EN => GND_net, LVTTL5EN => GND_net, LVTTL6EN => 
        GND_net, LVTTL7EN => GND_net, LVTTL8EN => GND_net, 
        LVTTL9EN => GND_net, LVTTL10EN => GND_net, LVTTL11EN => 
        GND_net, LVTTL0 => OPEN, LVTTL1 => OPEN, LVTTL2 => OPEN, 
        LVTTL3 => OPEN, LVTTL4 => OPEN, LVTTL5 => OPEN, LVTTL6
         => OPEN, LVTTL7 => OPEN, LVTTL8 => OPEN, LVTTL9 => OPEN, 
        LVTTL10 => OPEN, LVTTL11 => OPEN, PUFABn => OPEN, 
        VCC15GOOD => OPEN, VCC33GOOD => OPEN, FCLK => 
        MSS_ADLIB_INST_FCLK, MACCLKCCC => 
        MSS_ADLIB_INST_MACCLKCCC, RCOSC => GND_net, MACCLK => 
        MSS_ADLIB_INST_MACCLK, PLLLOCK => MSS_ADLIB_INST_PLLLOCK, 
        MSSRESETn => MSS_RESET_0_MSS_RESET_N_Y, GPOE(31) => nc182, 
        GPOE(30) => nc62, GPOE(29) => nc199, GPOE(28) => nc80, 
        GPOE(27) => nc130, GPOE(26) => nc98, GPOE(25) => nc249, 
        GPOE(24) => nc114, GPOE(23) => nc56, GPOE(22) => nc105, 
        GPOE(21) => nc63, GPOE(20) => nc172, GPOE(19) => nc229, 
        GPOE(18) => nc97, GPOE(17) => nc161, GPOE(16) => nc31, 
        GPOE(15) => nc154, GPOE(14) => nc50, GPOE(13) => nc239, 
        GPOE(12) => nc142, GPOE(11) => nc247, GPOE(10) => nc94, 
        GPOE(9) => nc197, GPOE(8) => nc122, GPOE(7) => nc35, 
        GPOE(6) => nc4, GPOE(5) => nc227, GPOE(4) => nc92, 
        GPOE(3) => nc101, GPOE(2) => nc184, GPOE(1) => nc200, 
        GPOE(0) => nc190, SPI0DO => OPEN, SPI0DOE => OPEN, SPI0DI
         => GND_net, SPI0CLKI => GND_net, SPI0CLKO => OPEN, 
        SPI0MODE => OPEN, SPI0SSI => GND_net, SPI0SSO(7) => nc166, 
        SPI0SSO(6) => nc132, SPI0SSO(5) => nc21, SPI0SSO(4) => 
        nc237, SPI0SSO(3) => nc93, SPI0SSO(2) => nc69, SPI0SSO(1)
         => nc206, SPI0SSO(0) => nc174, UART0TXD => OPEN, 
        UART0RXD => GND_net, I2C0SDAI => GND_net, I2C0SDAO => 
        OPEN, I2C0SCLI => GND_net, I2C0SCLO => OPEN, SPI1DO => 
        OPEN, SPI1DOE => OPEN, SPI1DI => GND_net, SPI1CLKI => 
        GND_net, SPI1CLKO => OPEN, SPI1MODE => OPEN, SPI1SSI => 
        GND_net, SPI1SSO(7) => nc38, SPI1SSO(6) => nc113, 
        SPI1SSO(5) => nc218, SPI1SSO(4) => nc106, SPI1SSO(3) => 
        nc25, SPI1SSO(2) => nc1, SPI1SSO(1) => nc37, SPI1SSO(0)
         => nc202, UART1TXD => OPEN, UART1RXD => GND_net, 
        I2C1SDAI => GND_net, I2C1SDAO => OPEN, I2C1SCLI => 
        GND_net, I2C1SCLO => OPEN, MACTXD(1) => MSS_MAC_0_TXD_1_D, 
        MACTXD(0) => MSS_MAC_0_TXD_0_D, MACRXD(1) => 
        MSS_MAC_0_RXD_1_Y, MACRXD(0) => MSS_MAC_0_RXD_0_Y, 
        MACTXEN => MSS_MAC_0_TXEN_D, MACCRSDV => 
        MSS_MAC_0_CRSDV_Y, MACRXER => MSS_MAC_0_RXER_Y, MACMDI
         => MSS_MAC_0_MDIO_Y, MACMDO => MSS_MAC_0_MDIO_D, MACMDEN
         => MSS_MAC_0_MDIO_E, MACMDC => MSS_MAC_0_MDC_D, EMCCLK
         => MSS_ADLIB_INST_EMCCLK, EMCCLKRTN => 
        MSS_ADLIB_INST_EMCCLK, EMCRDB(15) => GND_net, EMCRDB(14)
         => GND_net, EMCRDB(13) => GND_net, EMCRDB(12) => GND_net, 
        EMCRDB(11) => GND_net, EMCRDB(10) => GND_net, EMCRDB(9)
         => GND_net, EMCRDB(8) => GND_net, EMCRDB(7) => GND_net, 
        EMCRDB(6) => GND_net, EMCRDB(5) => GND_net, EMCRDB(4) => 
        GND_net, EMCRDB(3) => GND_net, EMCRDB(2) => GND_net, 
        EMCRDB(1) => GND_net, EMCRDB(0) => GND_net, EMCAB(25) => 
        nc144, EMCAB(24) => nc153, EMCAB(23) => nc46, EMCAB(22)
         => nc71, EMCAB(21) => nc124, EMCAB(20) => nc81, 
        EMCAB(19) => nc201, EMCAB(18) => nc168, EMCAB(17) => nc34, 
        EMCAB(16) => nc28, EMCAB(15) => nc115, EMCAB(14) => nc192, 
        EMCAB(13) => nc134, EMCAB(12) => nc32, EMCAB(11) => nc40, 
        EMCAB(10) => nc99, EMCAB(9) => nc75, EMCAB(8) => nc183, 
        EMCAB(7) => nc85, EMCAB(6) => nc27, EMCAB(5) => nc108, 
        EMCAB(4) => nc16, EMCAB(3) => nc155, EMCAB(2) => nc51, 
        EMCAB(1) => nc33, EMCAB(0) => nc204, EMCWDB(15) => nc173, 
        EMCWDB(14) => nc169, EMCWDB(13) => nc78, EMCWDB(12) => 
        nc24, EMCWDB(11) => nc88, EMCWDB(10) => nc111, EMCWDB(9)
         => nc55, EMCWDB(8) => nc10, EMCWDB(7) => nc22, EMCWDB(6)
         => nc210, EMCWDB(5) => nc185, EMCWDB(4) => nc143, 
        EMCWDB(3) => nc248, EMCWDB(2) => nc77, EMCWDB(1) => nc6, 
        EMCWDB(0) => nc109, EMCRWn => OPEN, EMCCS0n => OPEN, 
        EMCCS1n => OPEN, EMCOEN0n => OPEN, EMCOEN1n => OPEN, 
        EMCBYTEN(1) => nc87, EMCBYTEN(0) => nc123, EMCDBOE => 
        OPEN, ADC0 => GND_net, ADC1 => GND_net, ADC2 => GND_net, 
        ADC3 => GND_net, ADC4 => GND_net, ADC5 => GND_net, ADC6
         => GND_net, ADC7 => GND_net, ADC8 => GND_net, ADC9 => 
        GND_net, ADC10 => GND_net, ADC11 => GND_net, SDD0 => OPEN, 
        SDD1 => OPEN, SDD2 => OPEN, ABPS0 => GND_net, ABPS1 => 
        GND_net, ABPS2 => GND_net, ABPS3 => GND_net, ABPS4 => 
        GND_net, ABPS5 => GND_net, ABPS6 => GND_net, ABPS7 => 
        GND_net, ABPS8 => GND_net, ABPS9 => GND_net, ABPS10 => 
        GND_net, ABPS11 => GND_net, TM0 => GND_net, TM1 => 
        GND_net, TM2 => GND_net, TM3 => GND_net, TM4 => GND_net, 
        TM5 => GND_net, CM0 => GND_net, CM1 => GND_net, CM2 => 
        GND_net, CM3 => GND_net, CM4 => GND_net, CM5 => GND_net, 
        GNDTM0 => GND_net, GNDTM1 => GND_net, GNDTM2 => GND_net, 
        VAREF0 => GND_net, VAREF1 => GND_net, VAREF2 => GND_net, 
        VAREFOUT => OPEN, GNDVAREF => GND_net, PUn => GND_net);
    
    MSS_MAC_0_TXEN : OUTBUF_MSS
      generic map(ACT_CONFIG => 0, ACT_PIN => "Y4")

      port map(D => MSS_MAC_0_TXEN_D, PAD => MAC_0_TXEN);
    
    MSS_MAC_0_RXD_1 : INBUF_MSS
      generic map(ACT_CONFIG => 0, ACT_PIN => "U5")

      port map(PAD => MAC_0_RXD(1), Y => MSS_MAC_0_RXD_1_Y);
    
    MSS_CCC_0 : uC_tmp_MSS_CCC_0_MSS_CCC
      port map(CLKA => GND_net, CLKA_PAD => GND_net, CLKA_PADP
         => GND_net, CLKA_PADN => GND_net, CLKB => GND_net, 
        CLKB_PAD => GND_net, CLKB_PADP => GND_net, CLKB_PADN => 
        GND_net, CLKC => GND_net, CLKC_PAD => GND_net, CLKC_PADP
         => GND_net, CLKC_PADN => GND_net, GLA => OPEN, GLB => 
        OPEN, GLC => GLC, FAB_CLK => OPEN, YB => OPEN, YC => OPEN, 
        MAINXIN => MAINXIN, LPXIN => GND_net, FAB_LOCK => OPEN, 
        MAC_CLK => GND_net, RCOSC_CLKOUT => OPEN, MAINXIN_CLKOUT
         => OPEN, LPXIN_CLKOUT => OPEN, GLA0 => 
        MSS_ADLIB_INST_FCLK, MSS_LOCK => MSS_ADLIB_INST_PLLLOCK, 
        MAC_CLK_CCC => MSS_ADLIB_INST_MACCLKCCC, MAC_CLK_IO => 
        MSS_ADLIB_INST_MACCLK);
    
    MSS_RESET_0_MSS_RESET_N : INBUF_MSS
      generic map(ACT_CONFIG => 0, ACT_PIN => "R1")

      port map(PAD => MSS_RESET_N, Y => MSS_RESET_0_MSS_RESET_N_Y);
    

end DEF_ARCH; 
