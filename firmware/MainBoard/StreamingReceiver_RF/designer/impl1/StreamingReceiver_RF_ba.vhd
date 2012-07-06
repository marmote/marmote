-- Version: 10.0 SP2 10.0.20.2
-- File used only for Simulation

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity StreamingReceiver_RF is

    port( SPI_1_DO        : out   std_logic;
          SPI_1_SS        : inout std_logic := 'Z';
          SPI_1_CLK       : inout std_logic := 'Z';
          SPI_1_DI        : in    std_logic;
          MSS_RESET_N     : in    std_logic;
          RXTX            : out   std_logic;
          ANTSEL          : out   std_logic;
          RXHP            : out   std_logic;
          nSHDN           : out   std_logic;
          LD              : in    std_logic;
          MAINXIN         : in    std_logic;
          AFE2_CLK_pin    : out   std_logic;
          AFE2_SHDN_n_pin : out   std_logic;
          AFE2_T_R_n_pin  : out   std_logic;
          USB_CLK_pin     : in    std_logic;
          USB_TXE_n_pin   : in    std_logic;
          USB_WR_n_pin    : out   std_logic;
          USB_OE_n_pin    : out   std_logic;
          USB_RD_n_pin    : out   std_logic;
          USB_SIWU_N      : out   std_logic;
          USB_RXF_n_pin   : in    std_logic;
          DATA_pin        : inout std_logic_vector(9 downto 0) := (others => 'Z');
          USB_DATA_pin    : inout std_logic_vector(7 downto 0) := (others => 'Z')
        );

end StreamingReceiver_RF;

architecture DEF_ARCH of StreamingReceiver_RF is 

  component OA1C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component MSS_IF
    port( PIN4    : in    std_logic := 'U';
          PIN5    : in    std_logic := 'U';
          PIN6    : in    std_logic := 'U';
          PIN1    : out   std_logic;
          PIN2    : out   std_logic;
          PIN3    : out   std_logic;
          PIN4INT : out   std_logic;
          PIN5INT : out   std_logic;
          PIN6INT : out   std_logic;
          PIN1INT : in    std_logic := 'U';
          PIN2INT : in    std_logic := 'U';
          PIN3INT : in    std_logic := 'U'
        );
  end component;

  component NOR2B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOPAD_BI
    port( D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Y   : out   std_logic;
          PAD : inout   std_logic
        );
  end component;

  component DFN1C0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component MX2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component NOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1E1
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component NOR3C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AX1C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component XOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AO1D
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AOI1
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOTRI_OB_EB
    port( D    : in    std_logic := 'U';
          E    : in    std_logic := 'U';
          DOUT : out   std_logic;
          EOUT : out   std_logic
        );
  end component;

  component OA1A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AND2A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AND2
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

  component AO1B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component XA1
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OR2B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component NOR2A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOBI_IRE_OB_EB
    port( D    : in    std_logic := 'U';
          E    : in    std_logic := 'U';
          ICE  : in    std_logic := 'U';
          ICLK : in    std_logic := 'U';
          YIN  : in    std_logic := 'U';
          DOUT : out   std_logic;
          EOUT : out   std_logic;
          Y    : out   std_logic
        );
  end component;

  component NOR3A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component MSS_APB_IP
    generic (ACT_CONFIG:integer := 0; ACT_FCLK:integer := 0; 
        ACT_DIE:string := ""; ACT_PKG:string := "");

    port( FCLK           : in    std_logic := 'U';
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
          PUn            : in    std_logic := 'U';
          MSSPADDR       : out   std_logic_vector(19 downto 0);
          MSSPWDATA      : out   std_logic_vector(31 downto 0);
          MSSPRDATA      : in    std_logic_vector(31 downto 0) := (others => 'U');
          FABPADDR       : in    std_logic_vector(31 downto 0) := (others => 'U');
          FABPWDATA      : in    std_logic_vector(31 downto 0) := (others => 'U');
          FABPRDATA      : out   std_logic_vector(31 downto 0);
          DMAREADY       : in    std_logic_vector(1 downto 0) := (others => 'U');
          MSSINT         : out   std_logic_vector(7 downto 0);
          GPI            : in    std_logic_vector(31 downto 0) := (others => 'U');
          GPO            : out   std_logic_vector(31 downto 0);
          MACM2FTXD      : out   std_logic_vector(1 downto 0);
          MACF2MRXD      : in    std_logic_vector(1 downto 0) := (others => 'U');
          ACEFLAGS       : out   std_logic_vector(31 downto 0);
          UART0CTSn      : in    std_logic := 'U';
          UART0DSRn      : in    std_logic := 'U';
          UART0RTSn      : out   std_logic;
          UART0DTRn      : out   std_logic;
          UART0RIn       : in    std_logic := 'U';
          UART0DCDn      : in    std_logic := 'U';
          UART1CTSn      : in    std_logic := 'U';
          UART1DSRn      : in    std_logic := 'U';
          UART1RIn       : in    std_logic := 'U';
          UART1DCDn      : in    std_logic := 'U';
          I2C0SMBALERTNO : out   std_logic;
          I2C0BCLK       : in    std_logic := 'U';
          I2C0SMBALERTNI : in    std_logic := 'U';
          I2C0SMBUSNI    : in    std_logic := 'U';
          I2C1SMBALERTNO : out   std_logic;
          I2C1BCLK       : in    std_logic := 'U';
          I2C1SMBALERTNI : in    std_logic := 'U';
          I2C1SMBUSNI    : in    std_logic := 'U';
          UART1RTSn      : out   std_logic;
          UART1DTRn      : out   std_logic;
          TXEV           : out   std_logic;
          RXEV           : in    std_logic := 'U';
          VRON           : in    std_logic := 'U';
          MACM2FTXEN     : out   std_logic;
          MACF2MCRSDV    : in    std_logic := 'U';
          MACM2FMDEN     : out   std_logic;
          MACF2MRXER     : in    std_logic := 'U';
          MACM2FMDO      : out   std_logic;
          MACF2MMDI      : in    std_logic := 'U';
          MACM2FMDC      : out   std_logic;
          I2C0SMBUSNO    : out   std_logic;
          I2C1SMBUSNO    : out   std_logic;
          CALIBOUT       : out   std_logic;
          CALIBIN        : in    std_logic := 'U';
          LVTTL0         : out   std_logic;
          LVTTL1         : out   std_logic;
          LVTTL2         : out   std_logic;
          LVTTL0EN       : in    std_logic := 'U';
          LVTTL1EN       : in    std_logic := 'U';
          LVTTL2EN       : in    std_logic := 'U';
          LVTTL3         : out   std_logic;
          LVTTL4         : out   std_logic;
          LVTTL5         : out   std_logic;
          LVTTL3EN       : in    std_logic := 'U';
          LVTTL4EN       : in    std_logic := 'U';
          LVTTL5EN       : in    std_logic := 'U';
          LVTTL6         : out   std_logic;
          LVTTL7         : out   std_logic;
          LVTTL8         : out   std_logic;
          LVTTL6EN       : in    std_logic := 'U';
          LVTTL7EN       : in    std_logic := 'U';
          LVTTL8EN       : in    std_logic := 'U';
          LVTTL9         : out   std_logic;
          LVTTL10        : out   std_logic;
          LVTTL11        : out   std_logic;
          LVTTL9EN       : in    std_logic := 'U';
          LVTTL10EN      : in    std_logic := 'U';
          LVTTL11EN      : in    std_logic := 'U';
          CMP0           : out   std_logic;
          CMP1           : out   std_logic;
          CMP2           : out   std_logic;
          CMP3           : out   std_logic;
          CMP4           : out   std_logic;
          CMP5           : out   std_logic;
          FABSDD0D       : in    std_logic := 'U';
          FABSDD1D       : in    std_logic := 'U';
          FABSDD2D       : in    std_logic := 'U';
          CMP6           : out   std_logic;
          CMP7           : out   std_logic;
          CMP8           : out   std_logic;
          FABACETRIG     : in    std_logic := 'U';
          CMP9           : out   std_logic;
          FABSDD0CLK     : in    std_logic := 'U';
          FABSDD1CLK     : in    std_logic := 'U';
          FABSDD2CLK     : in    std_logic := 'U';
          VCC15GOOD      : out   std_logic;
          VCC33GOOD      : out   std_logic;
          PUFABn         : out   std_logic;
          MSSPREADY      : in    std_logic := 'U';
          MSSPSLVERR     : in    std_logic := 'U';
          MSSPSEL        : out   std_logic;
          MSSPENABLE     : out   std_logic;
          MSSPWRITE      : out   std_logic;
          FABPSEL        : in    std_logic := 'U';
          FABPENABLE     : in    std_logic := 'U';
          FABPWRITE      : in    std_logic := 'U';
          FABPREADY      : out   std_logic;
          FABPSLVERR     : out   std_logic;
          DEEPSLEEP      : out   std_logic;
          SLEEP          : out   std_logic;
          M2FRESETn      : out   std_logic;
          WDINT          : out   std_logic;
          FABINT         : in    std_logic := 'U';
          F2MRESETn      : in    std_logic := 'U';
          SYNCCLKFDBK    : in    std_logic := 'U';
          CMP10          : out   std_logic;
          CMP11          : out   std_logic
        );
  end component;

  component IOIN_IB
    port( YIN : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component OA1
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOPAD_TRI
    port( D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component MSS_CCC_GL_IF
    port( PIN2    : in    std_logic := 'U';
          PIN3    : in    std_logic := 'U';
          PIN4    : in    std_logic := 'U';
          PIN1    : out   std_logic;
          PIN5    : out   std_logic;
          PIN2INT : out   std_logic;
          PIN3INT : out   std_logic;
          PIN4INT : out   std_logic;
          PIN1INT : in    std_logic := 'U';
          PIN5INT : in    std_logic := 'U'
        );
  end component;

  component IOBI_ID_OD_EB
    port( DR   : in    std_logic := 'U';
          DF   : in    std_logic := 'U';
          CLR  : in    std_logic := 'U';
          E    : in    std_logic := 'U';
          ICLK : in    std_logic := 'U';
          OCLK : in    std_logic := 'U';
          YIN  : in    std_logic := 'U';
          DOUT : out   std_logic;
          EOUT : out   std_logic;
          YR   : out   std_logic;
          YF   : out   std_logic
        );
  end component;

  component NOR3B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
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

  component IOPAD_IN
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component OR3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component NOR3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component MSS_XTLOSC
    port( XTL    : in    std_logic := 'U';
          CLKOUT : out   std_logic
        );
  end component;

  component OR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1P0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          PRE : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component MX2A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1C1
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component AND3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component MSS_CCC_IF
    port( PIN2    : in    std_logic := 'U';
          PIN3    : in    std_logic := 'U';
          PIN4    : in    std_logic := 'U';
          PIN1    : out   std_logic;
          PIN2INT : out   std_logic;
          PIN3INT : out   std_logic;
          PIN4INT : out   std_logic;
          PIN1INT : in    std_logic := 'U'
        );
  end component;

  component MSS_CCC_IP
    generic (VCOFREQUENCY:real := 0.0);

    port( CLKA      : in    std_logic := 'U';
          EXTFB     : in    std_logic := 'U';
          GLA       : out   std_logic;
          GLAMSS    : out   std_logic;
          LOCK      : out   std_logic;
          LOCKMSS   : out   std_logic;
          CLKB      : in    std_logic := 'U';
          GLB       : out   std_logic;
          YB        : out   std_logic;
          CLKC      : in    std_logic := 'U';
          GLC       : out   std_logic;
          YC        : out   std_logic;
          MACCLK    : out   std_logic;
          SDIN      : in    std_logic := 'U';
          SCLK      : in    std_logic := 'U';
          SSHIFT    : in    std_logic := 'U';
          SUPDATE   : in    std_logic := 'U';
          MODE      : in    std_logic := 'U';
          SDOUT     : out   std_logic;
          PLLEN     : in    std_logic := 'U';
          OADIV     : in    std_logic_vector(4 downto 0) := (others => 'U');
          OADIVHALF : in    std_logic := 'U';
          OADIVRST  : in    std_logic := 'U';
          OAMUX     : in    std_logic_vector(2 downto 0) := (others => 'U');
          BYPASSA   : in    std_logic := 'U';
          DLYGLA    : in    std_logic_vector(4 downto 0) := (others => 'U');
          DLYGLAMSS : in    std_logic_vector(4 downto 0) := (others => 'U');
          DLYGLAFAB : in    std_logic_vector(4 downto 0) := (others => 'U');
          OBDIV     : in    std_logic_vector(4 downto 0) := (others => 'U');
          OBDIVHALF : in    std_logic := 'U';
          OBDIVRST  : in    std_logic := 'U';
          OBMUX     : in    std_logic_vector(2 downto 0) := (others => 'U');
          BYPASSB   : in    std_logic := 'U';
          DLYGLB    : in    std_logic_vector(4 downto 0) := (others => 'U');
          OCDIV     : in    std_logic_vector(4 downto 0) := (others => 'U');
          OCDIVHALF : in    std_logic := 'U';
          OCDIVRST  : in    std_logic := 'U';
          OCMUX     : in    std_logic_vector(2 downto 0) := (others => 'U');
          BYPASSC   : in    std_logic := 'U';
          DLYGLC    : in    std_logic_vector(4 downto 0) := (others => 'U');
          FINDIV    : in    std_logic_vector(6 downto 0) := (others => 'U');
          FBDIV     : in    std_logic_vector(6 downto 0) := (others => 'U');
          FBDLY     : in    std_logic_vector(4 downto 0) := (others => 'U');
          FBSEL     : in    std_logic_vector(1 downto 0) := (others => 'U');
          XDLYSEL   : in    std_logic := 'U';
          VCOSEL    : in    std_logic_vector(2 downto 0) := (others => 'U');
          GLMUXINT  : in    std_logic := 'U';
          GLMUXSEL  : in    std_logic_vector(1 downto 0) := (others => 'U');
          GLMUXCFG  : in    std_logic_vector(1 downto 0) := (others => 'U')
        );
  end component;

  component OR3B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFI1P0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          PRE : in    std_logic := 'U';
          QN  : out   std_logic
        );
  end component;

  component OR3A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CLKSRC
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component XNOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OA1B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OR3C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOTRI_ORP_EB
    port( D    : in    std_logic := 'U';
          PRE  : in    std_logic := 'U';
          E    : in    std_logic := 'U';
          OCLK : in    std_logic := 'U';
          DOUT : out   std_logic;
          EOUT : out   std_logic
        );
  end component;

  component AO1A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1P1
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          PRE : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal StreamingReceiver_RF_MSS_0_M2F_RESET_N, 
        AFE_IF_0_RX_Q9to9, AFE_IF_0_RX_I9to9, 
        SAMPLE_APB_0_READ_SUCCESSFUL, USB_FIFO_IF_0_FROM_USB_RDY, 
        \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[0]\\\, 
        \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[1]\\\, 
        \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[2]\\\, 
        \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[3]\\\, 
        \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[4]\\\, 
        \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[5]\\\, 
        \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[6]\\\, 
        \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[7]\\\, FAB_CLK, 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[0]\\\, 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[1]\\\, 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[2]\\\, 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[3]\\\, 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[4]\\\, 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[5]\\\, 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[6]\\\, 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[7]\\\, 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[8]\\\, 
        SAMPLE_APB_0_SMPL_RDY, 
        StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PSELx, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[0]\\\, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[1]\\\, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[2]\\\, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[3]\\\, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[4]\\\, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[5]\\\, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[6]\\\, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[7]\\\, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[8]\\\, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[9]\\\, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[10]\\\, 
        \\\CoreAPB3_0_APBmslave0_PADDR_[11]\\\, INV_2_Y, 
        \\\AFE_IF_0_RX_I8to0_[0]\\\, \\\AFE_IF_0_RX_I8to0_[1]\\\, 
        \\\AFE_IF_0_RX_I8to0_[2]\\\, \\\AFE_IF_0_RX_I8to0_[3]\\\, 
        \\\AFE_IF_0_RX_I8to0_[4]\\\, \\\AFE_IF_0_RX_I8to0_[5]\\\, 
        \\\AFE_IF_0_RX_I8to0_[6]\\\, \\\AFE_IF_0_RX_I8to0_[7]\\\, 
        \\\AFE_IF_0_RX_I8to0_[8]\\\, INV_0_Y, 
        \\\AFE_IF_0_RX_Q8to0_[0]\\\, \\\AFE_IF_0_RX_Q8to0_[1]\\\, 
        \\\AFE_IF_0_RX_Q8to0_[2]\\\, \\\AFE_IF_0_RX_Q8to0_[3]\\\, 
        \\\AFE_IF_0_RX_Q8to0_[4]\\\, \\\AFE_IF_0_RX_Q8to0_[5]\\\, 
        \\\AFE_IF_0_RX_Q8to0_[6]\\\, \\\AFE_IF_0_RX_Q8to0_[7]\\\, 
        \\\AFE_IF_0_RX_Q8to0_[8]\\\, INV_1_Y, N_17, N_19, N_21, 
        N_23, N_25, N_27, PRDATA_6_i, PRDATA_7_i, PRDATA_10_i, 
        N_42, LD_c, AFE2_CLK_pin_c, USB_TXE_n_pin_c, 
        USB_WR_n_pin_c, USB_OE_n_pin_c, USB_RD_n_pin_c, 
        USB_RXF_n_pin_c, \CoreAPB3_0.CAPB3iool_1[0]\, 
        \CoreAPB3_0.CAPB3iool_2[0]\, 
        SAMPLE_APB_0_READ_SUCCESSFUL_i, INV_2_Y_0, 
        \USB_FIFO_IF_0/s_STORE_SAMPLES\, 
        \USB_FIFO_IF_0/sample_FIFO_0_EMPTY\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[1]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[2]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[3]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[4]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[5]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[6]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[7]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[22]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[25]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[27]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[12]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[14]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[16]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[26]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[28]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[30]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[29]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[0]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[15]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[18]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[19]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[20]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[21]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[23]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[24]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[8]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[10]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[31]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[9]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[11]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[13]\\\\\, 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[17]\\\\\, 
        \USB_FIFO_IF_0/sample_FIFO_0_AEMPTY\, 
        \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, 
        \USB_FIFO_IF_0/WEAP\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[3]\, 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, 
        \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_2\, 
        \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_1\, 
        \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_3\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state\, 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state\, 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_oe_3_2\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_0_sqmuxa\, 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_2[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_1[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_TMP[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[1]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_12[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[2]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[4]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_11[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/N_6\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[1]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[0]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/N_4\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[3]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_FINC_E[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_oe_3_i\, 
        \USB_FIFO_IF_0/USB_IF_0/s_oe_3\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8_i[3]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[17]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[17]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[13]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[13]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[11]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[11]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[9]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[9]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[31]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[31]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[10]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[10]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[8]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[8]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[24]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[24]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[23]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[23]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[21]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[21]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[20]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[20]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[19]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[19]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[18]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[18]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[15]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[15]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[29]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[29]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[30]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[30]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[28]\, 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[28]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[26]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[26]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[16]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[16]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[14]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[14]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[12]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[12]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[27]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[27]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[25]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[25]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[22]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[22]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[7]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[7]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[6]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[6]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[5]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[5]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[4]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[4]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[3]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[3]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[2]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[2]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state_2\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[4]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[3]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[2]\, 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_oe_3_4\, 
        \USB_FIFO_IF_0/USB_IF_0/un5_s_read_from_usb_reg_full\, 
        \USB_FIFO_IF_0/USB_IF_0/s_oe_3_3\, 
        \USB_FIFO_IF_0/USB_IF_0/s_oe_3_1\, 
        \USB_FIFO_IF_0/USB_IF_0/un5_s_temp_reg_state_0\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[0]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state_0\, 
        \USB_FIFO_IF_0/USB_IF_0/un45_s_temp_reg_state_4\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[3]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/un45_s_temp_reg_state_2\, 
        \USB_FIFO_IF_0/USB_IF_0/un45_s_temp_reg_state_3\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[6]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[5]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[5]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[6]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[2]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[4]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/un5_s_read_from_usb_reg_full_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL\, 
        \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state_5\, 
        \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state_2\, 
        \USB_FIFO_IF_0/USB_IF_0/un5_s_temp_reg_state\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[29]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[29]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_0_sqmuxa\, 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR[0]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR[1]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[0]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[1]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[2]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[2]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[3]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[3]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[4]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[4]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[5]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[5]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[6]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[6]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[7]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[7]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[15]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[15]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[18]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[18]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[19]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[19]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[20]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[20]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[21]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[21]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[22]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[22]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[23]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[23]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[24]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[24]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[25]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[25]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[27]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[27]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[8]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[8]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[10]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[10]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[12]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[12]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[14]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[14]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[16]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[16]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[26]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[26]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[28]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[28]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[30]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[30]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[31]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[31]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[9]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[9]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[11]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[11]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[13]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[13]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[17]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[17]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, 
        \USB_FIFO_IF_0/USB_IF_0/READ_FROM_USB_REG_0_sqmuxa\, 
        \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL_1_sqmuxa\, 
        \USB_FIFO_IF_0/USB_IF_0/FROM_USB_RDY_2\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[29]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[29]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_2_sqmuxa\, 
        \USB_FIFO_IF_0/USB_IF_0/un27_s_temp_reg_state\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/I_27\, 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_0_sqmuxa_1\, 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_partial_sum[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[6]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[5]\, 
        \USB_FIFO_IF_0/USB_IF_0/I_29\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[4]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[3]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[2]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_0_sqmuxa_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[2]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[17]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[13]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[11]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[9]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[17]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[13]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[11]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[9]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[31]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[30]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[28]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[26]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[16]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[14]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[12]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[10]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[8]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[31]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[30]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[28]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[26]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[16]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[14]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[12]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[10]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[8]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[27]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[25]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[24]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[23]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[22]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[21]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[20]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[19]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[18]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[15]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[27]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[25]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[24]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[23]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[22]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[21]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[20]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[19]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[18]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[15]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[7]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[6]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[5]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[4]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[3]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[2]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n31\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[30]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c29\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[31]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n30\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n29\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c28\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[29]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n28\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c26\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[28]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n27\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n26\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c24\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[26]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n25\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n24\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c22\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[24]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n23\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n22\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c20\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[22]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n21\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n20\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c18\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[20]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n19\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n18\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c16\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[18]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n17\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n16\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c14\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[16]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n15\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n14\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c12\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[14]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n13\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n12\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c10\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[12]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n11\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n10\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c8\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[10]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n9\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n8\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c6\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[8]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n7\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n6\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c4\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[6]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n5\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n4\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c2\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[4]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n3\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n2\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[0]_net_1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[2]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_e0\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n1\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[6]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[5]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[4]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[3]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[2]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/I_4\, 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_partial_sum_0[0]\, 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR_3[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_partial_sum[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/N_2\, 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_FINC_E[1]\, 
        \USB_FIFO_IF_0/USB_IF_0/N_3\, 
        \USB_FIFO_IF_0/USB_IF_0/N_5\, 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\AEMPTYX_I[1]\\\\\, 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\EMPTYX_I[1]\\\\\, 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\FULLX_I[1]\\\\\, 
        \USB_FIFO_IF_0/sample_FIFO_0/READ_ENABLE_I\, 
        \USB_FIFO_IF_0/sample_FIFO_0/WRITE_ENABLE_I\, 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\AEMPTYX_I[0]\\\\\, 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\EMPTYX_I[0]\\\\\, 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\FULLX_I[0]\\\\\, 
        \AFE_IF_0/s_tx_q[0]\, \AFE_IF_0/s_tx_q[1]\, 
        \AFE_IF_0/s_tx_q[2]\, \AFE_IF_0/s_tx_q[3]\, 
        \AFE_IF_0/s_tx_q[4]\, \AFE_IF_0/s_tx_q[5]\, 
        \AFE_IF_0/s_tx_q[6]\, \AFE_IF_0/s_tx_q[7]\, 
        \AFE_IF_0/s_tx_q[8]\, \AFE_IF_0/s_tx_q[9]\, 
        \StreamingReceiver_RF_MSS_0/CoreAPB3_0_APBmslave0_PWRITE\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST_EMCCLK\, 
        \StreamingReceiver_RF_MSS_0/MSS_RESET_0_MSS_RESET_N_Y\, 
        \StreamingReceiver_RF_MSS_0/MSSINT_GPO_14_A\, 
        \StreamingReceiver_RF_MSS_0/MSS_GPIO_0_GPIO_28_OUT_D\, 
        \StreamingReceiver_RF_MSS_0/GLA0\, 
        \StreamingReceiver_RF_MSS_0/MSSINT_GPO_13_A\, 
        \StreamingReceiver_RF_MSS_0/MSSINT_GPO_15_A\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST_PLLLOCK\, 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_CLK_Y\, 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_CLK_D\, 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_DI_Y\, 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_DO_D\, 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_DO_E\, 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_SS_E\, 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_SS_Y\, 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_SS_D\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/N_CLKA_XTLOSC\, 
        \SAMPLE_APB_0/un8_pwrite_5\, \SAMPLE_APB_0/un8_pwrite_3\, 
        \SAMPLE_APB_0/un8_pwrite_4\, \SAMPLE_APB_0/un8_pwrite_1\, 
        \SAMPLE_APB_0/s_REG_FULL_0_sqmuxa\, 
        \SAMPLE_APB_0/s_REG_FULL\, \SAMPLE_APB_0/un8_pwrite_i_0\, 
        \SAMPLE_APB_0/N_41\, \SAMPLE_APB_0/REG[6]_net_1\, 
        \SAMPLE_APB_0/N_39\, \SAMPLE_APB_0/REG[4]_net_1\, 
        \SAMPLE_APB_0/N_37\, \SAMPLE_APB_0/REG[2]_net_1\, 
        \SAMPLE_APB_0/N_35\, \SAMPLE_APB_0/REG[0]_net_1\, 
        \SAMPLE_APB_0/N_15\, \SAMPLE_APB_0/REG[7]_net_1\, 
        \SAMPLE_APB_0/N_13\, \SAMPLE_APB_0/REG[5]_net_1\, 
        \SAMPLE_APB_0/N_11\, \SAMPLE_APB_0/REG[3]_net_1\, 
        \SAMPLE_APB_0/N_9\, \SAMPLE_APB_0/REG[1]_net_1\, 
        \SAMPLE_APB_0/N_7\, \SAMPLE_APB_0/s_REG_FULL_1_sqmuxa\, 
        \SAMPLE_APB_0/REG_0_sqmuxa\, 
        \AFE_IF_0/g_DDR_INTERFACE.3.u_BIBUF_LVCMOS33/U0/NET1\, 
        \AFE_IF_0/g_DDR_INTERFACE.3.u_BIBUF_LVCMOS33/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.3.u_BIBUF_LVCMOS33/U0/NET3\, 
        \AFE_IF_0/g_DDR_INTERFACE.6.u_BIBUF_LVCMOS33/U0/NET1\, 
        \AFE_IF_0/g_DDR_INTERFACE.6.u_BIBUF_LVCMOS33/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.6.u_BIBUF_LVCMOS33/U0/NET3\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.2.u_BIBUF_LVCMOS33/U0/NET1\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.2.u_BIBUF_LVCMOS33/U0/NET2\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.2.u_BIBUF_LVCMOS33/U0/NET3\, 
        \USB_TXE_n_pin_pad/U0/NET1\, 
        \AFE_IF_0/g_DDR_INTERFACE.2.u_BIBUF_LVCMOS33/U0/NET1\, 
        \AFE_IF_0/g_DDR_INTERFACE.2.u_BIBUF_LVCMOS33/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.2.u_BIBUF_LVCMOS33/U0/NET3\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.6.u_BIBUF_LVCMOS33/U0/NET1\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.6.u_BIBUF_LVCMOS33/U0/NET2\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.6.u_BIBUF_LVCMOS33/U0/NET3\, 
        \AFE2_SHDN_n_pin_pad/U0/NET1\, 
        \AFE2_SHDN_n_pin_pad/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.1.u_BIBUF_LVCMOS33/U0/NET1\, 
        \AFE_IF_0/g_DDR_INTERFACE.1.u_BIBUF_LVCMOS33/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.1.u_BIBUF_LVCMOS33/U0/NET3\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[16]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[17]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[18]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[16]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[17]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[18]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[19]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[20]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[21]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[19]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[20]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[21]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[22]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[23]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[24]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[22]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[23]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[24]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[25]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[26]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[27]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[25]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[26]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[27]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[29]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[30]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[28]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[29]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[30]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[31]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI0SSO[1]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI0SSO[2]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[31]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0CTSnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0DSRnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI0SSO[3]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0RTSnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0DTRnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0RInINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0DCDnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1CTSnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[1]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[2]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[3]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1DSRnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1RInINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1DCDnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[4]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[5]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBALERTNOINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0BCLKINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBALERTNIINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBUSNIINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[6]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[7]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBALERTNOINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1BCLKINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBALERTNIINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBUSNIINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[12]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[12]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[13]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[13]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[14]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[14]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[15]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[15]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1RTSnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1DTRnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/TXEVINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/RXEVINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/VRONINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBUSNOINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBUSNOINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CALIBOUTINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CALIBININT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[0]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[1]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[2]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[0]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[1]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[2]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[3]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[4]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[5]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[3]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[4]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[5]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[6]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[7]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[8]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[6]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[7]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[8]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[9]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[10]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[11]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[9]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[10]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[11]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[12]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[13]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[14]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[12]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[13]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[14]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[15]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[16]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[17]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[15]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[16]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[17]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[18]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[19]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[0]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPREADYINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPSLVERRINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[0]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[1]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[2]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[3]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[1]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[2]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[3]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[4]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[5]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[6]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[4]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[5]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[6]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[7]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[8]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[9]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[7]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[8]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[9]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[10]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[11]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[12]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[10]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[11]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[12]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[13]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[14]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[15]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[13]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[14]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[15]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPSELINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPENABLEINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWRITEINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPSELINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPENABLEINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWRITEINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPREADYINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPSLVERRINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/DEEPSLEEPINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[18]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[19]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[20]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SLEEPINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[0]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[1]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[21]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[22]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[23]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[2]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[3]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[4]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[24]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[25]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[26]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[5]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/M2FRESETnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[6]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[27]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[28]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[29]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[0]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[7]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/WDINTINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[30]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[31]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[0]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[1]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[2]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[3]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[1]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[2]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[3]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[4]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[5]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[6]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[4]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[5]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[6]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[7]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[8]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[9]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[7]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[8]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[9]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[10]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[11]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[12]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[10]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[11]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[12]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[13]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[14]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[15]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[13]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[14]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[15]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[16]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[17]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[18]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[16]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[17]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[18]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[19]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[20]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[21]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[19]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[20]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[21]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[22]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[23]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[24]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[22]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[23]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[24]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[25]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[26]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[27]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[25]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[26]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[27]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[28]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[29]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[30]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[28]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[29]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[30]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[31]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[31]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABINTINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/F2MRESETnINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/DMAREADY[0]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/DMAREADY[1]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[16]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[17]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[18]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[16]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[17]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[18]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[19]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[20]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[21]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[19]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[20]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[21]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[22]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[23]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[24]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[22]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[23]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[24]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[25]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[26]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[27]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[25]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[26]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[27]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[28]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[29]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[30]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[28]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[29]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[30]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[31]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SYNCCLKFDBKINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[31]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL0INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL1INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL2INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL0ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL1ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL2ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL3INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL4INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL5INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL3ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL4ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL5ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL6INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL7INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL8INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL6ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL7ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL8ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL9INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL10INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL11INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL9ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL10ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL11ENINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP0INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP1INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP2INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP3INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP4INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP5INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD0DINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD1DINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD2DINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP6INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP7INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP8INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABACETRIGINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP9INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD0CLKINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD1CLKINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD2CLKINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[0]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[1]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[2]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[3]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[4]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[5]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[6]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[7]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[8]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[9]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[10]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[11]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[12]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[13]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[14]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[15]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[16]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[17]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[18]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[19]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[20]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[21]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[22]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[23]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[24]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[25]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[26]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[27]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[28]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[29]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[30]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[31]INT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/VCC15GOODINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/VCC33GOODINT_NET\, 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/PUFABnINT_NET\, 
        GLMUXINT_GND, \AFE2_CLK_pin_pad/U0/NET1\, 
        \AFE2_CLK_pin_pad/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.0.u_BIBUF_LVCMOS33/U0/NET1\, 
        \AFE_IF_0/g_DDR_INTERFACE.0.u_BIBUF_LVCMOS33/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.0.u_BIBUF_LVCMOS33/U0/NET3\, 
        \USB_RXF_n_pin_pad/U0/NET1\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.3.u_BIBUF_LVCMOS33/U0/NET1\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.3.u_BIBUF_LVCMOS33/U0/NET2\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.3.u_BIBUF_LVCMOS33/U0/NET3\, 
        \AFE_IF_0/g_DDR_INTERFACE.4.u_BIBUF_LVCMOS33/U0/NET1\, 
        \AFE_IF_0/g_DDR_INTERFACE.4.u_BIBUF_LVCMOS33/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.4.u_BIBUF_LVCMOS33/U0/NET3\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.1.u_BIBUF_LVCMOS33/U0/NET1\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.1.u_BIBUF_LVCMOS33/U0/NET2\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.1.u_BIBUF_LVCMOS33/U0/NET3\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.4.u_BIBUF_LVCMOS33/U0/NET1\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.4.u_BIBUF_LVCMOS33/U0/NET2\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.4.u_BIBUF_LVCMOS33/U0/NET3\, 
        \AFE_IF_0/g_DDR_INTERFACE.7.u_BIBUF_LVCMOS33/U0/NET1\, 
        \AFE_IF_0/g_DDR_INTERFACE.7.u_BIBUF_LVCMOS33/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.7.u_BIBUF_LVCMOS33/U0/NET3\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.5.u_BIBUF_LVCMOS33/U0/NET1\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.5.u_BIBUF_LVCMOS33/U0/NET2\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.5.u_BIBUF_LVCMOS33/U0/NET3\, 
        \AFE_IF_0/g_DDR_INTERFACE.8.u_BIBUF_LVCMOS33/U0/NET1\, 
        \AFE_IF_0/g_DDR_INTERFACE.8.u_BIBUF_LVCMOS33/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.8.u_BIBUF_LVCMOS33/U0/NET3\, 
        \AFE_IF_0/g_DDR_INTERFACE.5.u_BIBUF_LVCMOS33/U0/NET1\, 
        \AFE_IF_0/g_DDR_INTERFACE.5.u_BIBUF_LVCMOS33/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.5.u_BIBUF_LVCMOS33/U0/NET3\, 
        \RXHP_pad/U0/NET1\, \RXHP_pad/U0/NET2\, \LD_pad/U0/NET1\, 
        \USB_OE_n_pin_pad/U0/NET1\, \USB_OE_n_pin_pad/U0/NET2\, 
        \nSHDN_pad/U0/NET1\, \nSHDN_pad/U0/NET2\, 
        \AFE2_T_R_n_pin_pad/U0/NET1\, 
        \AFE2_T_R_n_pin_pad/U0/NET2\, 
        \USB_FIFO_IF_0/USB_IF_0/u_USB_CLKBUF/U0/NET1\, 
        \USB_SIWU_N_pad/U0/NET1\, \USB_SIWU_N_pad/U0/NET2\, 
        \USB_RD_n_pin_pad/U0/NET1\, \USB_RD_n_pin_pad/U0/NET2\, 
        \ANTSEL_pad/U0/NET1\, \ANTSEL_pad/U0/NET2\, 
        \USB_WR_n_pin_pad/U0/NET1\, \USB_WR_n_pin_pad/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.9.u_BIBUF_LVCMOS33/U0/NET1\, 
        \AFE_IF_0/g_DDR_INTERFACE.9.u_BIBUF_LVCMOS33/U0/NET2\, 
        \AFE_IF_0/g_DDR_INTERFACE.9.u_BIBUF_LVCMOS33/U0/NET3\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.7.u_BIBUF_LVCMOS33/U0/NET1\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.7.u_BIBUF_LVCMOS33/U0/NET2\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.7.u_BIBUF_LVCMOS33/U0/NET3\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SDIN_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SCLK_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SSHIFT_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SDOUT_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/EXTFB_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/GLA_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/LOCK_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/CLKB_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/GLB_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/YB_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/MODE_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/CLKC_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SUPDATE_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/GLC_INT\, 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/YC_INT\, 
        PLLEN_VCC, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.0.u_BIBUF_LVCMOS33/U0/NET1\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.0.u_BIBUF_LVCMOS33/U0/NET2\, 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.0.u_BIBUF_LVCMOS33/U0/NET3\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[22]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[14]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[30]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[6]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[26]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]/Y\, 
        \SAMPLE_APB_0/s_REG_FULL/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[20]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[18]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_STORE_SAMPLES/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[8]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[6]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[9]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[2]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[4]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[3]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[3]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[12]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[22]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[5]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[8]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[15]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[25]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[1]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[24]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[2]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[17]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[12]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[27]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[11]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[21]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[7]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[28]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[10]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[2]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[20]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[13]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[4]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[23]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[16]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[10]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[0]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[29]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[4]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]/Y\, 
        \SAMPLE_APB_0/s_READ_SUCCESSFUL/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[31]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[14]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[24]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[31]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[16]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[26]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[18]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[28]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[19]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[30]/Y\, 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[29]/Y\, 
        AFLSDF_VCC, AFLSDF_GND : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;
    signal nc47, nc34, nc89, nc70, nc60, nc74, nc64, nc9, nc92, 
        nc91, nc13, nc23, nc55, nc80, nc33, nc84, nc16, nc26, 
        nc45, nc73, nc58, nc63, nc27, nc17, nc36, nc48, nc37, nc5, 
        nc52, nc76, nc51, nc66, nc77, nc67, nc4, nc42, nc83, nc41, 
        nc90, nc94, nc86, nc59, nc25, nc15, nc87, nc35, nc49, 
        nc28, nc18, nc75, nc65, nc38, nc93, nc1, nc2, nc50, nc22, 
        nc12, nc21, nc11, nc78, nc54, nc68, nc3, nc32, nc40, nc31, 
        nc96, nc44, nc7, nc97, nc85, nc72, nc6, nc71, nc62, nc61, 
        nc19, nc29, nc88, nc53, nc39, nc8, nc82, nc81, nc79, nc43, 
        nc69, nc56, nc20, nc10, nc57, nc95, nc24, nc14, nc46, 
        nc30 : std_logic;

begin 

    GLMUXINT_GND <= GND_power_net1;
    AFLSDF_GND <= GND_power_net1;
    PLLEN_VCC <= VCC_power_net1;
    AFLSDF_VCC <= VCC_power_net1;

    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[29]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[29]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[29]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[29]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_5\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[26]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[25]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[27]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[25]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[26]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[27]INT_NET\);
    
    \SAMPLE_APB_0/PRDATA_1_RNO[8]\ : NOR2B
      port map(A => \SAMPLE_APB_0/un8_pwrite_i_0\, B => N_42, Y
         => \SAMPLE_APB_0/s_REG_FULL_1_sqmuxa\);
    
    \AFE_IF_0/g_DDR_INTERFACE.9.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \AFE_IF_0/g_DDR_INTERFACE.9.u_BIBUF_LVCMOS33/U0/NET1\, E
         => \AFE_IF_0/g_DDR_INTERFACE.9.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \AFE_IF_0/g_DDR_INTERFACE.9.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => DATA_pin(9));
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[2]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[2]/Y\, CLK => 
        \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[2]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[11]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[11]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[11]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[11]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_68\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL10ENINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL9ENINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL11ENINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL9INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL10INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL11INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNO[0]\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_0_sqmuxa_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_partial_sum[0]\, S
         => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[24]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n24\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[24]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[24]/Y\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_9\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1RInINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1DSRnINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1DCDnINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[1]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[2]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[3]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[25]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[25]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[25]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[15]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[15]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[15]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[19]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[19]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[19]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[6]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[6]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[6]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[0]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_2_sqmuxa\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]/Y\);
    
    \SAMPLE_APB_0/REG[6]\ : DFN1E1
      port map(D => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[6]\\\, 
        CLK => FAB_CLK, E => \SAMPLE_APB_0/REG_0_sqmuxa\, Q => 
        \SAMPLE_APB_0/REG[6]_net_1\);
    
    \SAMPLE_APB_0/p_REG_READ.un8_pwrite_3\ : NOR2
      port map(A => \\\CoreAPB3_0_APBmslave0_PADDR_[6]\\\, B => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[7]\\\, Y => 
        \SAMPLE_APB_0/un8_pwrite_3\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[4]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[4]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[4]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[4]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[17]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[17]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[17]\);
    
    \USB_FIFO_IF_0/USB_IF_0/un2_s_from_adc_smpl_cntr_I_11\ : 
        NOR2B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[3]_net_1\, B
         => \USB_FIFO_IF_0/USB_IF_0/DWACT_FINC_E[0]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/N_4\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNISKKN2[28]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c26\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[28]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c28\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[28]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[28]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[28]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[28]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c26\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[28]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n28\);
    
    \SAMPLE_APB_0/s_REG_FULL_RNITC9T\ : NOR2B
      port map(A => StreamingReceiver_RF_MSS_0_M2F_RESET_N, B => 
        \SAMPLE_APB_0/s_REG_FULL_0_sqmuxa\, Y => 
        \SAMPLE_APB_0/REG_0_sqmuxa\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n21\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[1]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[0]_net_1\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[31]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n31\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[31]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[31]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[15]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[15]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[15]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[15]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNIUIU8[3]\ : 
        AOI1
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un45_s_temp_reg_state_4\, B => 
        \USB_FIFO_IF_0/USB_IF_0/un45_s_temp_reg_state_3\, C => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa\);
    
    \USB_FIFO_IF_0/USB_IF_0/FROM_USB_RDY\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/FROM_USB_RDY_2\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        USB_FIFO_IF_0_FROM_USB_RDY);
    
    \USB_WR_n_pin_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => USB_WR_n_pin_c, E => PLLEN_VCC, DOUT => 
        \USB_WR_n_pin_pad/U0/NET1\, EOUT => 
        \USB_WR_n_pin_pad/U0/NET2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[27]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[27]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[27]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[17]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[17]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[17]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[17]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_80\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[14]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[15]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[16]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[4]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_0_sqmuxa\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[4]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_2_sqmuxa\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[4]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[7]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[7]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[7]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[7]\);
    
    \SAMPLE_APB_0/REG[3]\ : DFN1E1
      port map(D => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[3]\\\, 
        CLK => FAB_CLK, E => \SAMPLE_APB_0/REG_0_sqmuxa\, Q => 
        \SAMPLE_APB_0/REG[3]_net_1\);
    
    \USB_FIFO_IF_0/sample_FIFO_0/READ_AND\ : AND2A
      port map(A => \USB_FIFO_IF_0/sample_FIFO_0_EMPTY\, B => 
        \USB_FIFO_IF_0/WEAP\, Y => 
        \USB_FIFO_IF_0/sample_FIFO_0/READ_ENABLE_I\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[0]\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/I_4\, CLK => 
        AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[0]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNO\ : INV
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_oe_3\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_oe_3_i\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[2]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[2]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[2]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[2]/Y\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.7.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.7.u_BIBUF_LVCMOS33/U0/NET1\, 
        E => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.7.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.7.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => USB_DATA_pin(7));
    
    \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_I_1\ : 
        AND2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[0]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_TMP[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[28]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[28]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[28]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[28]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[28]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[28]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[28]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNO[3]\ : XA1
      port map(A => \USB_FIFO_IF_0/USB_IF_0/N_5\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[3]_net_1\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[3]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNI85EB[0]\ : 
        OR2B
      port map(A => \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNI9CFI1[16]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c14\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[16]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c16\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[23]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[23]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[23]\);
    
    \CoreAPB3_0/CAPB3O1II/PRDATA_2_i\ : NOR3C
      port map(A => \CoreAPB3_0.CAPB3iool_1[0]\, B => 
        \CoreAPB3_0.CAPB3iool_2[0]\, C => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[2]\\\, Y => N_21);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNI6OCK[0]\ : NOR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_0_sqmuxa\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[23]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[23]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[23]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[23]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[14]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[14]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[14]_net_1\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA_0_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_IRE_OB_EB
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[24]_net_1\, 
        E => USB_OE_n_pin_c, ICE => 
        \USB_FIFO_IF_0/USB_IF_0/READ_FROM_USB_REG_0_sqmuxa\, ICLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, YIN => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.0.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.0.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.0.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[0]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR_RNI09P51[1]\ : 
        NOR3A
      port map(A => \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR[0]_net_1\, C
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR[1]_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_0_sqmuxa\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_CORE\ : 
        MSS_APB_IP
      generic map(ACT_CONFIG => 0, ACT_FCLK => 8000000,
         ACT_DIE => "IP6X5M2", ACT_PKG => "fg256")

      port map(FCLK => \StreamingReceiver_RF_MSS_0/GLA0\, 
        MACCLKCCC => GLMUXINT_GND, RCOSC => GLMUXINT_GND, MACCLK
         => GLMUXINT_GND, PLLLOCK => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST_PLLLOCK\, 
        MSSRESETn => 
        \StreamingReceiver_RF_MSS_0/MSS_RESET_0_MSS_RESET_N_Y\, 
        GPOE(31) => nc47, GPOE(30) => nc34, GPOE(29) => nc89, 
        GPOE(28) => nc70, GPOE(27) => nc60, GPOE(26) => nc74, 
        GPOE(25) => nc64, GPOE(24) => nc9, GPOE(23) => nc92, 
        GPOE(22) => nc91, GPOE(21) => nc13, GPOE(20) => nc23, 
        GPOE(19) => nc55, GPOE(18) => nc80, GPOE(17) => nc33, 
        GPOE(16) => nc84, GPOE(15) => nc16, GPOE(14) => nc26, 
        GPOE(13) => nc45, GPOE(12) => nc73, GPOE(11) => nc58, 
        GPOE(10) => nc63, GPOE(9) => nc27, GPOE(8) => nc17, 
        GPOE(7) => nc36, GPOE(6) => nc48, GPOE(5) => nc37, 
        GPOE(4) => nc5, GPOE(3) => nc52, GPOE(2) => nc76, GPOE(1)
         => nc51, GPOE(0) => nc66, SPI0DO => OPEN, SPI0DOE => 
        OPEN, SPI0DI => GLMUXINT_GND, SPI0CLKI => GLMUXINT_GND, 
        SPI0CLKO => OPEN, SPI0MODE => OPEN, SPI0SSI => 
        GLMUXINT_GND, SPI0SSO(7) => nc77, SPI0SSO(6) => nc67, 
        SPI0SSO(5) => nc4, SPI0SSO(4) => nc42, SPI0SSO(3) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI0SSO[3]INT_NET\, 
        SPI0SSO(2) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI0SSO[2]INT_NET\, 
        SPI0SSO(1) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI0SSO[1]INT_NET\, 
        SPI0SSO(0) => nc83, UART0TXD => OPEN, UART0RXD => 
        GLMUXINT_GND, I2C0SDAI => GLMUXINT_GND, I2C0SDAO => OPEN, 
        I2C0SCLI => GLMUXINT_GND, I2C0SCLO => OPEN, SPI1DO => 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_DO_D\, SPI1DOE => 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_DO_E\, SPI1DI => 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_DI_Y\, SPI1CLKI => 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_CLK_Y\, SPI1CLKO
         => \StreamingReceiver_RF_MSS_0/MSS_SPI_1_CLK_D\, 
        SPI1MODE => \StreamingReceiver_RF_MSS_0/MSS_SPI_1_SS_E\, 
        SPI1SSI => \StreamingReceiver_RF_MSS_0/MSS_SPI_1_SS_Y\, 
        SPI1SSO(7) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[7]INT_NET\, 
        SPI1SSO(6) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[6]INT_NET\, 
        SPI1SSO(5) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[5]INT_NET\, 
        SPI1SSO(4) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[4]INT_NET\, 
        SPI1SSO(3) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[3]INT_NET\, 
        SPI1SSO(2) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[2]INT_NET\, 
        SPI1SSO(1) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[1]INT_NET\, 
        SPI1SSO(0) => \StreamingReceiver_RF_MSS_0/MSS_SPI_1_SS_D\, 
        UART1TXD => OPEN, UART1RXD => GLMUXINT_GND, I2C1SDAI => 
        GLMUXINT_GND, I2C1SDAO => OPEN, I2C1SCLI => GLMUXINT_GND, 
        I2C1SCLO => OPEN, MACTXD(1) => nc41, MACTXD(0) => nc90, 
        MACRXD(1) => GLMUXINT_GND, MACRXD(0) => GLMUXINT_GND, 
        MACTXEN => OPEN, MACCRSDV => GLMUXINT_GND, MACRXER => 
        GLMUXINT_GND, MACMDI => GLMUXINT_GND, MACMDO => OPEN, 
        MACMDEN => OPEN, MACMDC => OPEN, EMCCLK => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST_EMCCLK\, 
        EMCCLKRTN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST_EMCCLK\, 
        EMCRDB(15) => GLMUXINT_GND, EMCRDB(14) => GLMUXINT_GND, 
        EMCRDB(13) => GLMUXINT_GND, EMCRDB(12) => GLMUXINT_GND, 
        EMCRDB(11) => GLMUXINT_GND, EMCRDB(10) => GLMUXINT_GND, 
        EMCRDB(9) => GLMUXINT_GND, EMCRDB(8) => GLMUXINT_GND, 
        EMCRDB(7) => GLMUXINT_GND, EMCRDB(6) => GLMUXINT_GND, 
        EMCRDB(5) => GLMUXINT_GND, EMCRDB(4) => GLMUXINT_GND, 
        EMCRDB(3) => GLMUXINT_GND, EMCRDB(2) => GLMUXINT_GND, 
        EMCRDB(1) => GLMUXINT_GND, EMCRDB(0) => GLMUXINT_GND, 
        EMCAB(25) => nc94, EMCAB(24) => nc86, EMCAB(23) => nc59, 
        EMCAB(22) => nc25, EMCAB(21) => nc15, EMCAB(20) => nc87, 
        EMCAB(19) => nc35, EMCAB(18) => nc49, EMCAB(17) => nc28, 
        EMCAB(16) => nc18, EMCAB(15) => nc75, EMCAB(14) => nc65, 
        EMCAB(13) => nc38, EMCAB(12) => nc93, EMCAB(11) => nc1, 
        EMCAB(10) => nc2, EMCAB(9) => nc50, EMCAB(8) => nc22, 
        EMCAB(7) => nc12, EMCAB(6) => nc21, EMCAB(5) => nc11, 
        EMCAB(4) => nc78, EMCAB(3) => nc54, EMCAB(2) => nc68, 
        EMCAB(1) => nc3, EMCAB(0) => nc32, EMCWDB(15) => nc40, 
        EMCWDB(14) => nc31, EMCWDB(13) => nc96, EMCWDB(12) => 
        nc44, EMCWDB(11) => nc7, EMCWDB(10) => nc97, EMCWDB(9)
         => nc85, EMCWDB(8) => nc72, EMCWDB(7) => nc6, EMCWDB(6)
         => nc71, EMCWDB(5) => nc62, EMCWDB(4) => nc61, EMCWDB(3)
         => nc19, EMCWDB(2) => nc29, EMCWDB(1) => nc88, EMCWDB(0)
         => nc53, EMCRWn => OPEN, EMCCS0n => OPEN, EMCCS1n => 
        OPEN, EMCOEN0n => OPEN, EMCOEN1n => OPEN, EMCBYTEN(1) => 
        nc39, EMCBYTEN(0) => nc8, EMCDBOE => OPEN, ADC0 => 
        GLMUXINT_GND, ADC1 => GLMUXINT_GND, ADC2 => GLMUXINT_GND, 
        ADC3 => GLMUXINT_GND, ADC4 => GLMUXINT_GND, ADC5 => 
        GLMUXINT_GND, ADC6 => GLMUXINT_GND, ADC7 => GLMUXINT_GND, 
        ADC8 => GLMUXINT_GND, ADC9 => GLMUXINT_GND, ADC10 => 
        GLMUXINT_GND, ADC11 => GLMUXINT_GND, SDD0 => OPEN, SDD1
         => OPEN, SDD2 => OPEN, ABPS0 => GLMUXINT_GND, ABPS1 => 
        GLMUXINT_GND, ABPS2 => GLMUXINT_GND, ABPS3 => 
        GLMUXINT_GND, ABPS4 => GLMUXINT_GND, ABPS5 => 
        GLMUXINT_GND, ABPS6 => GLMUXINT_GND, ABPS7 => 
        GLMUXINT_GND, ABPS8 => GLMUXINT_GND, ABPS9 => 
        GLMUXINT_GND, ABPS10 => GLMUXINT_GND, ABPS11 => 
        GLMUXINT_GND, TM0 => GLMUXINT_GND, TM1 => GLMUXINT_GND, 
        TM2 => GLMUXINT_GND, TM3 => GLMUXINT_GND, TM4 => 
        GLMUXINT_GND, TM5 => GLMUXINT_GND, CM0 => GLMUXINT_GND, 
        CM1 => GLMUXINT_GND, CM2 => GLMUXINT_GND, CM3 => 
        GLMUXINT_GND, CM4 => GLMUXINT_GND, CM5 => GLMUXINT_GND, 
        GNDTM0 => GLMUXINT_GND, GNDTM1 => GLMUXINT_GND, GNDTM2
         => GLMUXINT_GND, VAREF0 => GLMUXINT_GND, VAREF1 => 
        GLMUXINT_GND, VAREF2 => GLMUXINT_GND, VAREFOUT => OPEN, 
        GNDVAREF => GLMUXINT_GND, PUn => GLMUXINT_GND, 
        MSSPADDR(19) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[19]INT_NET\, 
        MSSPADDR(18) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[18]INT_NET\, 
        MSSPADDR(17) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[17]INT_NET\, 
        MSSPADDR(16) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[16]INT_NET\, 
        MSSPADDR(15) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[15]INT_NET\, 
        MSSPADDR(14) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[14]INT_NET\, 
        MSSPADDR(13) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[13]INT_NET\, 
        MSSPADDR(12) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[12]INT_NET\, 
        MSSPADDR(11) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[11]INT_NET\, 
        MSSPADDR(10) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[10]INT_NET\, 
        MSSPADDR(9) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[9]INT_NET\, 
        MSSPADDR(8) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[8]INT_NET\, 
        MSSPADDR(7) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[7]INT_NET\, 
        MSSPADDR(6) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[6]INT_NET\, 
        MSSPADDR(5) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[5]INT_NET\, 
        MSSPADDR(4) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[4]INT_NET\, 
        MSSPADDR(3) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[3]INT_NET\, 
        MSSPADDR(2) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[2]INT_NET\, 
        MSSPADDR(1) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[1]INT_NET\, 
        MSSPADDR(0) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[0]INT_NET\, 
        MSSPWDATA(31) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[31]INT_NET\, 
        MSSPWDATA(30) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[30]INT_NET\, 
        MSSPWDATA(29) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[29]INT_NET\, 
        MSSPWDATA(28) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[28]INT_NET\, 
        MSSPWDATA(27) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[27]INT_NET\, 
        MSSPWDATA(26) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[26]INT_NET\, 
        MSSPWDATA(25) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[25]INT_NET\, 
        MSSPWDATA(24) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[24]INT_NET\, 
        MSSPWDATA(23) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[23]INT_NET\, 
        MSSPWDATA(22) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[22]INT_NET\, 
        MSSPWDATA(21) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[21]INT_NET\, 
        MSSPWDATA(20) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[20]INT_NET\, 
        MSSPWDATA(19) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[19]INT_NET\, 
        MSSPWDATA(18) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[18]INT_NET\, 
        MSSPWDATA(17) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[17]INT_NET\, 
        MSSPWDATA(16) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[16]INT_NET\, 
        MSSPWDATA(15) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[15]INT_NET\, 
        MSSPWDATA(14) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[14]INT_NET\, 
        MSSPWDATA(13) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[13]INT_NET\, 
        MSSPWDATA(12) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[12]INT_NET\, 
        MSSPWDATA(11) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[11]INT_NET\, 
        MSSPWDATA(10) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[10]INT_NET\, 
        MSSPWDATA(9) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[9]INT_NET\, 
        MSSPWDATA(8) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[8]INT_NET\, 
        MSSPWDATA(7) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[7]INT_NET\, 
        MSSPWDATA(6) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[6]INT_NET\, 
        MSSPWDATA(5) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[5]INT_NET\, 
        MSSPWDATA(4) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[4]INT_NET\, 
        MSSPWDATA(3) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[3]INT_NET\, 
        MSSPWDATA(2) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[2]INT_NET\, 
        MSSPWDATA(1) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[1]INT_NET\, 
        MSSPWDATA(0) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[0]INT_NET\, 
        MSSPRDATA(31) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[31]INT_NET\, 
        MSSPRDATA(30) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[30]INT_NET\, 
        MSSPRDATA(29) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[29]INT_NET\, 
        MSSPRDATA(28) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[28]INT_NET\, 
        MSSPRDATA(27) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[27]INT_NET\, 
        MSSPRDATA(26) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[26]INT_NET\, 
        MSSPRDATA(25) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[25]INT_NET\, 
        MSSPRDATA(24) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[24]INT_NET\, 
        MSSPRDATA(23) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[23]INT_NET\, 
        MSSPRDATA(22) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[22]INT_NET\, 
        MSSPRDATA(21) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[21]INT_NET\, 
        MSSPRDATA(20) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[20]INT_NET\, 
        MSSPRDATA(19) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[19]INT_NET\, 
        MSSPRDATA(18) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[18]INT_NET\, 
        MSSPRDATA(17) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[17]INT_NET\, 
        MSSPRDATA(16) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[16]INT_NET\, 
        MSSPRDATA(15) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[15]INT_NET\, 
        MSSPRDATA(14) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[14]INT_NET\, 
        MSSPRDATA(13) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[13]INT_NET\, 
        MSSPRDATA(12) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[12]INT_NET\, 
        MSSPRDATA(11) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[11]INT_NET\, 
        MSSPRDATA(10) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[10]INT_NET\, 
        MSSPRDATA(9) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[9]INT_NET\, 
        MSSPRDATA(8) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[8]INT_NET\, 
        MSSPRDATA(7) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[7]INT_NET\, 
        MSSPRDATA(6) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[6]INT_NET\, 
        MSSPRDATA(5) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[5]INT_NET\, 
        MSSPRDATA(4) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[4]INT_NET\, 
        MSSPRDATA(3) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[3]INT_NET\, 
        MSSPRDATA(2) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[2]INT_NET\, 
        MSSPRDATA(1) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[1]INT_NET\, 
        MSSPRDATA(0) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[0]INT_NET\, 
        FABPADDR(31) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[31]INT_NET\, 
        FABPADDR(30) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[30]INT_NET\, 
        FABPADDR(29) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[29]INT_NET\, 
        FABPADDR(28) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[28]INT_NET\, 
        FABPADDR(27) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[27]INT_NET\, 
        FABPADDR(26) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[26]INT_NET\, 
        FABPADDR(25) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[25]INT_NET\, 
        FABPADDR(24) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[24]INT_NET\, 
        FABPADDR(23) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[23]INT_NET\, 
        FABPADDR(22) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[22]INT_NET\, 
        FABPADDR(21) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[21]INT_NET\, 
        FABPADDR(20) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[20]INT_NET\, 
        FABPADDR(19) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[19]INT_NET\, 
        FABPADDR(18) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[18]INT_NET\, 
        FABPADDR(17) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[17]INT_NET\, 
        FABPADDR(16) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[16]INT_NET\, 
        FABPADDR(15) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[15]INT_NET\, 
        FABPADDR(14) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[14]INT_NET\, 
        FABPADDR(13) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[13]INT_NET\, 
        FABPADDR(12) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[12]INT_NET\, 
        FABPADDR(11) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[11]INT_NET\, 
        FABPADDR(10) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[10]INT_NET\, 
        FABPADDR(9) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[9]INT_NET\, 
        FABPADDR(8) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[8]INT_NET\, 
        FABPADDR(7) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[7]INT_NET\, 
        FABPADDR(6) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[6]INT_NET\, 
        FABPADDR(5) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[5]INT_NET\, 
        FABPADDR(4) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[4]INT_NET\, 
        FABPADDR(3) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[3]INT_NET\, 
        FABPADDR(2) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[2]INT_NET\, 
        FABPADDR(1) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[1]INT_NET\, 
        FABPADDR(0) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[0]INT_NET\, 
        FABPWDATA(31) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[31]INT_NET\, 
        FABPWDATA(30) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[30]INT_NET\, 
        FABPWDATA(29) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[29]INT_NET\, 
        FABPWDATA(28) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[28]INT_NET\, 
        FABPWDATA(27) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[27]INT_NET\, 
        FABPWDATA(26) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[26]INT_NET\, 
        FABPWDATA(25) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[25]INT_NET\, 
        FABPWDATA(24) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[24]INT_NET\, 
        FABPWDATA(23) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[23]INT_NET\, 
        FABPWDATA(22) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[22]INT_NET\, 
        FABPWDATA(21) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[21]INT_NET\, 
        FABPWDATA(20) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[20]INT_NET\, 
        FABPWDATA(19) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[19]INT_NET\, 
        FABPWDATA(18) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[18]INT_NET\, 
        FABPWDATA(17) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[17]INT_NET\, 
        FABPWDATA(16) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[16]INT_NET\, 
        FABPWDATA(15) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[15]INT_NET\, 
        FABPWDATA(14) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[14]INT_NET\, 
        FABPWDATA(13) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[13]INT_NET\, 
        FABPWDATA(12) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[12]INT_NET\, 
        FABPWDATA(11) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[11]INT_NET\, 
        FABPWDATA(10) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[10]INT_NET\, 
        FABPWDATA(9) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[9]INT_NET\, 
        FABPWDATA(8) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[8]INT_NET\, 
        FABPWDATA(7) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[7]INT_NET\, 
        FABPWDATA(6) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[6]INT_NET\, 
        FABPWDATA(5) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[5]INT_NET\, 
        FABPWDATA(4) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[4]INT_NET\, 
        FABPWDATA(3) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[3]INT_NET\, 
        FABPWDATA(2) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[2]INT_NET\, 
        FABPWDATA(1) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[1]INT_NET\, 
        FABPWDATA(0) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[0]INT_NET\, 
        FABPRDATA(31) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[31]INT_NET\, 
        FABPRDATA(30) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[30]INT_NET\, 
        FABPRDATA(29) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[29]INT_NET\, 
        FABPRDATA(28) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[28]INT_NET\, 
        FABPRDATA(27) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[27]INT_NET\, 
        FABPRDATA(26) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[26]INT_NET\, 
        FABPRDATA(25) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[25]INT_NET\, 
        FABPRDATA(24) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[24]INT_NET\, 
        FABPRDATA(23) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[23]INT_NET\, 
        FABPRDATA(22) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[22]INT_NET\, 
        FABPRDATA(21) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[21]INT_NET\, 
        FABPRDATA(20) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[20]INT_NET\, 
        FABPRDATA(19) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[19]INT_NET\, 
        FABPRDATA(18) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[18]INT_NET\, 
        FABPRDATA(17) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[17]INT_NET\, 
        FABPRDATA(16) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[16]INT_NET\, 
        FABPRDATA(15) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[15]INT_NET\, 
        FABPRDATA(14) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[14]INT_NET\, 
        FABPRDATA(13) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[13]INT_NET\, 
        FABPRDATA(12) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[12]INT_NET\, 
        FABPRDATA(11) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[11]INT_NET\, 
        FABPRDATA(10) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[10]INT_NET\, 
        FABPRDATA(9) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[9]INT_NET\, 
        FABPRDATA(8) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[8]INT_NET\, 
        FABPRDATA(7) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[7]INT_NET\, 
        FABPRDATA(6) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[6]INT_NET\, 
        FABPRDATA(5) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[5]INT_NET\, 
        FABPRDATA(4) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[4]INT_NET\, 
        FABPRDATA(3) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[3]INT_NET\, 
        FABPRDATA(2) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[2]INT_NET\, 
        FABPRDATA(1) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[1]INT_NET\, 
        FABPRDATA(0) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[0]INT_NET\, 
        DMAREADY(1) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/DMAREADY[1]INT_NET\, 
        DMAREADY(0) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/DMAREADY[0]INT_NET\, 
        MSSINT(7) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[7]INT_NET\, 
        MSSINT(6) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[6]INT_NET\, 
        MSSINT(5) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[5]INT_NET\, 
        MSSINT(4) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[4]INT_NET\, 
        MSSINT(3) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[3]INT_NET\, 
        MSSINT(2) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[2]INT_NET\, 
        MSSINT(1) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[1]INT_NET\, 
        MSSINT(0) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[0]INT_NET\, 
        GPI(31) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[31]INT_NET\, 
        GPI(30) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[30]INT_NET\, 
        GPI(29) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[29]INT_NET\, 
        GPI(28) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[28]INT_NET\, 
        GPI(27) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[27]INT_NET\, 
        GPI(26) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[26]INT_NET\, 
        GPI(25) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[25]INT_NET\, 
        GPI(24) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[24]INT_NET\, 
        GPI(23) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[23]INT_NET\, 
        GPI(22) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[22]INT_NET\, 
        GPI(21) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[21]INT_NET\, 
        GPI(20) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[20]INT_NET\, 
        GPI(19) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[19]INT_NET\, 
        GPI(18) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[18]INT_NET\, 
        GPI(17) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[17]INT_NET\, 
        GPI(16) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[16]INT_NET\, 
        GPI(15) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[15]INT_NET\, 
        GPI(14) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[14]INT_NET\, 
        GPI(13) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[13]INT_NET\, 
        GPI(12) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[12]INT_NET\, 
        GPI(11) => GLMUXINT_GND, GPI(10) => GLMUXINT_GND, GPI(9)
         => GLMUXINT_GND, GPI(8) => GLMUXINT_GND, GPI(7) => 
        GLMUXINT_GND, GPI(6) => GLMUXINT_GND, GPI(5) => 
        GLMUXINT_GND, GPI(4) => GLMUXINT_GND, GPI(3) => 
        GLMUXINT_GND, GPI(2) => GLMUXINT_GND, GPI(1) => 
        GLMUXINT_GND, GPI(0) => GLMUXINT_GND, GPO(31) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[31]INT_NET\, 
        GPO(30) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[30]INT_NET\, 
        GPO(29) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[29]INT_NET\, 
        GPO(28) => 
        \StreamingReceiver_RF_MSS_0/MSS_GPIO_0_GPIO_28_OUT_D\, 
        GPO(27) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[27]INT_NET\, 
        GPO(26) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[26]INT_NET\, 
        GPO(25) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[25]INT_NET\, 
        GPO(24) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[24]INT_NET\, 
        GPO(23) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[23]INT_NET\, 
        GPO(22) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[22]INT_NET\, 
        GPO(21) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[21]INT_NET\, 
        GPO(20) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[20]INT_NET\, 
        GPO(19) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[19]INT_NET\, 
        GPO(18) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[18]INT_NET\, 
        GPO(17) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[17]INT_NET\, 
        GPO(16) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[16]INT_NET\, 
        GPO(15) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[15]INT_NET\, 
        GPO(14) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[14]INT_NET\, 
        GPO(13) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[13]INT_NET\, 
        GPO(12) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[12]INT_NET\, 
        GPO(11) => nc82, GPO(10) => nc81, GPO(9) => nc79, GPO(8)
         => nc43, GPO(7) => nc69, GPO(6) => nc56, GPO(5) => nc20, 
        GPO(4) => nc10, GPO(3) => nc57, GPO(2) => nc95, GPO(1)
         => nc24, GPO(0) => nc14, MACM2FTXD(1) => nc46, 
        MACM2FTXD(0) => nc30, MACF2MRXD(1) => GLMUXINT_GND, 
        MACF2MRXD(0) => GLMUXINT_GND, ACEFLAGS(31) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[31]INT_NET\, 
        ACEFLAGS(30) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[30]INT_NET\, 
        ACEFLAGS(29) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[29]INT_NET\, 
        ACEFLAGS(28) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[28]INT_NET\, 
        ACEFLAGS(27) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[27]INT_NET\, 
        ACEFLAGS(26) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[26]INT_NET\, 
        ACEFLAGS(25) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[25]INT_NET\, 
        ACEFLAGS(24) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[24]INT_NET\, 
        ACEFLAGS(23) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[23]INT_NET\, 
        ACEFLAGS(22) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[22]INT_NET\, 
        ACEFLAGS(21) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[21]INT_NET\, 
        ACEFLAGS(20) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[20]INT_NET\, 
        ACEFLAGS(19) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[19]INT_NET\, 
        ACEFLAGS(18) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[18]INT_NET\, 
        ACEFLAGS(17) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[17]INT_NET\, 
        ACEFLAGS(16) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[16]INT_NET\, 
        ACEFLAGS(15) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[15]INT_NET\, 
        ACEFLAGS(14) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[14]INT_NET\, 
        ACEFLAGS(13) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[13]INT_NET\, 
        ACEFLAGS(12) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[12]INT_NET\, 
        ACEFLAGS(11) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[11]INT_NET\, 
        ACEFLAGS(10) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[10]INT_NET\, 
        ACEFLAGS(9) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[9]INT_NET\, 
        ACEFLAGS(8) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[8]INT_NET\, 
        ACEFLAGS(7) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[7]INT_NET\, 
        ACEFLAGS(6) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[6]INT_NET\, 
        ACEFLAGS(5) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[5]INT_NET\, 
        ACEFLAGS(4) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[4]INT_NET\, 
        ACEFLAGS(3) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[3]INT_NET\, 
        ACEFLAGS(2) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[2]INT_NET\, 
        ACEFLAGS(1) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[1]INT_NET\, 
        ACEFLAGS(0) => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[0]INT_NET\, 
        UART0CTSn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0CTSnINT_NET\, 
        UART0DSRn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0DSRnINT_NET\, 
        UART0RTSn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0RTSnINT_NET\, 
        UART0DTRn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0DTRnINT_NET\, 
        UART0RIn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0RInINT_NET\, 
        UART0DCDn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0DCDnINT_NET\, 
        UART1CTSn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1CTSnINT_NET\, 
        UART1DSRn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1DSRnINT_NET\, 
        UART1RIn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1RInINT_NET\, 
        UART1DCDn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1DCDnINT_NET\, 
        I2C0SMBALERTNO => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBALERTNOINT_NET\, 
        I2C0BCLK => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0BCLKINT_NET\, 
        I2C0SMBALERTNI => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBALERTNIINT_NET\, 
        I2C0SMBUSNI => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBUSNIINT_NET\, 
        I2C1SMBALERTNO => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBALERTNOINT_NET\, 
        I2C1BCLK => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1BCLKINT_NET\, 
        I2C1SMBALERTNI => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBALERTNIINT_NET\, 
        I2C1SMBUSNI => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBUSNIINT_NET\, 
        UART1RTSn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1RTSnINT_NET\, 
        UART1DTRn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1DTRnINT_NET\, 
        TXEV => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/TXEVINT_NET\, 
        RXEV => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/RXEVINT_NET\, 
        VRON => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/VRONINT_NET\, 
        MACM2FTXEN => OPEN, MACF2MCRSDV => GLMUXINT_GND, 
        MACM2FMDEN => OPEN, MACF2MRXER => GLMUXINT_GND, MACM2FMDO
         => OPEN, MACF2MMDI => GLMUXINT_GND, MACM2FMDC => OPEN, 
        I2C0SMBUSNO => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBUSNOINT_NET\, 
        I2C1SMBUSNO => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBUSNOINT_NET\, 
        CALIBOUT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CALIBOUTINT_NET\, 
        CALIBIN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CALIBININT_NET\, 
        LVTTL0 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL0INT_NET\, 
        LVTTL1 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL1INT_NET\, 
        LVTTL2 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL2INT_NET\, 
        LVTTL0EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL0ENINT_NET\, 
        LVTTL1EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL1ENINT_NET\, 
        LVTTL2EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL2ENINT_NET\, 
        LVTTL3 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL3INT_NET\, 
        LVTTL4 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL4INT_NET\, 
        LVTTL5 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL5INT_NET\, 
        LVTTL3EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL3ENINT_NET\, 
        LVTTL4EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL4ENINT_NET\, 
        LVTTL5EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL5ENINT_NET\, 
        LVTTL6 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL6INT_NET\, 
        LVTTL7 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL7INT_NET\, 
        LVTTL8 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL8INT_NET\, 
        LVTTL6EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL6ENINT_NET\, 
        LVTTL7EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL7ENINT_NET\, 
        LVTTL8EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL8ENINT_NET\, 
        LVTTL9 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL9INT_NET\, 
        LVTTL10 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL10INT_NET\, 
        LVTTL11 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL11INT_NET\, 
        LVTTL9EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL9ENINT_NET\, 
        LVTTL10EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL10ENINT_NET\, 
        LVTTL11EN => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL11ENINT_NET\, 
        CMP0 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP0INT_NET\, 
        CMP1 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP1INT_NET\, 
        CMP2 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP2INT_NET\, 
        CMP3 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP3INT_NET\, 
        CMP4 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP4INT_NET\, 
        CMP5 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP5INT_NET\, 
        FABSDD0D => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD0DINT_NET\, 
        FABSDD1D => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD1DINT_NET\, 
        FABSDD2D => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD2DINT_NET\, 
        CMP6 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP6INT_NET\, 
        CMP7 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP7INT_NET\, 
        CMP8 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP8INT_NET\, 
        FABACETRIG => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABACETRIGINT_NET\, 
        CMP9 => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP9INT_NET\, 
        FABSDD0CLK => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD0CLKINT_NET\, 
        FABSDD1CLK => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD1CLKINT_NET\, 
        FABSDD2CLK => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD2CLKINT_NET\, 
        VCC15GOOD => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/VCC15GOODINT_NET\, 
        VCC33GOOD => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/VCC33GOODINT_NET\, 
        PUFABn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/PUFABnINT_NET\, 
        MSSPREADY => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPREADYINT_NET\, 
        MSSPSLVERR => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPSLVERRINT_NET\, 
        MSSPSEL => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPSELINT_NET\, 
        MSSPENABLE => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPENABLEINT_NET\, 
        MSSPWRITE => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWRITEINT_NET\, 
        FABPSEL => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPSELINT_NET\, 
        FABPENABLE => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPENABLEINT_NET\, 
        FABPWRITE => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWRITEINT_NET\, 
        FABPREADY => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPREADYINT_NET\, 
        FABPSLVERR => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPSLVERRINT_NET\, 
        DEEPSLEEP => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/DEEPSLEEPINT_NET\, 
        SLEEP => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SLEEPINT_NET\, 
        M2FRESETn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/M2FRESETnINT_NET\, 
        WDINT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/WDINTINT_NET\, 
        FABINT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABINTINT_NET\, 
        F2MRESETn => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/F2MRESETnINT_NET\, 
        SYNCCLKFDBK => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SYNCCLKFDBKINT_NET\, 
        CMP10 => OPEN, CMP11 => OPEN);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[31]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[31]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[31]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[22]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n22\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[22]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[22]/Y\);
    
    \USB_RXF_n_pin_pad/U0/U1\ : IOIN_IB
      port map(YIN => \USB_RXF_n_pin_pad/U0/NET1\, Y => 
        USB_RXF_n_pin_c);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNIFH6E_0[0]\ : 
        OA1
      port map(A => \USB_FIFO_IF_0/USB_IF_0/un5_s_temp_reg_state\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state\, C => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_0_sqmuxa\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_7\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0CTSnINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[31]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0DSRnINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[31]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI0SSO[1]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI0SSO[2]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNIR94K[6]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c4\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[6]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c6\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[10]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[10]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[10]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_86\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[17]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[16]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[18]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[16]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[17]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[18]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[13]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[13]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[13]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[3]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[3]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[3]\);
    
    \USB_WR_n_pin_pad/U0/U0\ : IOPAD_TRI
      port map(D => \USB_WR_n_pin_pad/U0/NET1\, E => 
        \USB_WR_n_pin_pad/U0/NET2\, PAD => USB_WR_n_pin);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[5]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[5]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[5]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[27]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[27]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[27]/Y\);
    
    \CoreAPB3_0/CAPB3O1II/PRDATA_5_i\ : NOR3C
      port map(A => \CoreAPB3_0.CAPB3iool_1[0]\, B => 
        \CoreAPB3_0.CAPB3iool_2[0]\, C => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[5]\\\, Y => N_27);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[25]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[25]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[25]/Y\);
    
    \SAMPLE_APB_0/p_REG_READ.un8_pwrite_4\ : NOR3A
      port map(A => \SAMPLE_APB_0/un8_pwrite_1\, B => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[1]\\\, C => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[0]\\\, Y => 
        \SAMPLE_APB_0/un8_pwrite_4\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[24]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[24]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[24]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[24]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_32\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[6]\\\, PIN2 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[7]\\\, PIN3 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[8]\\\, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[7]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[6]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[8]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[6]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[7]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[8]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[5]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c4\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n5\);
    
    \SAMPLE_APB_0/p_REG_READ.un8_pwrite\ : OR2B
      port map(A => \SAMPLE_APB_0/un8_pwrite_5\, B => 
        \SAMPLE_APB_0/un8_pwrite_4\, Y => 
        \SAMPLE_APB_0/un8_pwrite_i_0\);
    
    \StreamingReceiver_RF_MSS_0/MSS_SPI_1_DO\ : IOPAD_TRI
      port map(D => \StreamingReceiver_RF_MSS_0/MSS_SPI_1_DO_D\, 
        E => \StreamingReceiver_RF_MSS_0/MSS_SPI_1_DO_E\, PAD => 
        SPI_1_DO);
    
    \SAMPLE_APB_0/s_READ_SUCCESSFUL/U0\ : MX2
      port map(A => USB_FIFO_IF_0_FROM_USB_RDY, B => 
        SAMPLE_APB_0_READ_SUCCESSFUL, S => 
        \SAMPLE_APB_0/s_REG_FULL\, Y => 
        \SAMPLE_APB_0/s_READ_SUCCESSFUL/Y\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_35\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[16]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[15]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[17]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[15]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[16]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[17]INT_NET\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_49\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[5]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[4]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[6]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[4]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[5]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[6]INT_NET\);
    
    \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/U_TILE2\ : 
        MSS_CCC_GL_IF
      port map(PIN2 => GLMUXINT_GND, PIN3 => GLMUXINT_GND, PIN4
         => GLMUXINT_GND, PIN1 => OPEN, PIN5 => AFE2_CLK_pin_c, 
        PIN2INT => OPEN, PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/CLKB_INT\, 
        PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/MODE_INT\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/YB_INT\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/GLB_INT\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNI6OCK_0[0]\ : 
        NOR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_0_sqmuxa\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[31]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[31]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[31]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[31]/Y\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_59\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => GLMUXINT_GND, PIN2INT => GLMUXINT_GND, PIN3INT
         => GLMUXINT_GND);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[10]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n10\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[10]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[10]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_0\ : NOR2
      port map(A => USB_WR_n_pin_c, B => USB_TXE_n_pin_c, Y => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\);
    
    \AFE_IF_0/g_DDR_INTERFACE_9_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_ID_OD_EB
      port map(DR => \AFE_IF_0/s_tx_q[9]\, DF => 
        \AFE_IF_0/s_tx_q[9]\, CLR => INV_2_Y, E => GLMUXINT_GND, 
        ICLK => AFE2_CLK_pin_c, OCLK => AFE2_CLK_pin_c, YIN => 
        \AFE_IF_0/g_DDR_INTERFACE.9.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.9.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.9.u_BIBUF_LVCMOS33/U0/NET2\, YR
         => INV_1_Y, YF => INV_0_Y);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[12]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[12]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[12]\);
    
    \SAMPLE_APB_0/PRDATA_1_RNO[6]\ : OA1
      port map(A => \SAMPLE_APB_0/REG[6]_net_1\, B => 
        \SAMPLE_APB_0/un8_pwrite_i_0\, C => N_42, Y => 
        \SAMPLE_APB_0/N_41\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[4]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[4]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[4]_net_1\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_99\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => 
        \StreamingReceiver_RF_MSS_0/MSSINT_GPO_15_A\, PIN2 => 
        OPEN, PIN3 => OPEN, PIN4INT => OPEN, PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[15]INT_NET\, 
        PIN6INT => OPEN, PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[15]INT_NET\, 
        PIN2INT => GLMUXINT_GND, PIN3INT => GLMUXINT_GND);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[27]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[27]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[19]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[27]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[7]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[7]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[7]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_41\ : MSS_IF
      port map(PIN4 => PRDATA_10_i, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[14]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[13]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[15]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[13]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[14]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[15]INT_NET\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_67\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => GLMUXINT_GND, PIN2INT => GLMUXINT_GND, PIN3INT
         => GLMUXINT_GND);
    
    \SAMPLE_APB_0/PRDATA_1_RNO[5]\ : NOR3B
      port map(A => N_42, B => \SAMPLE_APB_0/REG[5]_net_1\, C => 
        \SAMPLE_APB_0/un8_pwrite_i_0\, Y => \SAMPLE_APB_0/N_13\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNITJO[0]\ : 
        OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[0]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[1]_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state_0\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[22]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[22]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[22]\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[22]\);
    
    \USB_OE_n_pin_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => USB_OE_n_pin_c, E => PLLEN_VCC, DOUT => 
        \USB_OE_n_pin_pad/U0/NET1\, EOUT => 
        \USB_OE_n_pin_pad/U0/NET2\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_51\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[11]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[10]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[12]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[10]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[11]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[12]INT_NET\);
    
    \AFE2_CLK_pin_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => AFE2_CLK_pin_c, E => PLLEN_VCC, DOUT => 
        \AFE2_CLK_pin_pad/U0/NET1\, EOUT => 
        \AFE2_CLK_pin_pad/U0/NET2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[15]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[15]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[15]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[30]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[30]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[30]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[30]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[25]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[25]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[25]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[10]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[10]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[10]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[16]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[16]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[16]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[16]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[12]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[12]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[12]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[25]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[25]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[25]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[25]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[20]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[20]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[20]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[20]/Y\);
    
    \CoreAPB3_0/CAPB3O1II/PRDATA_10_i\ : NOR3C
      port map(A => \CoreAPB3_0.CAPB3iool_1[0]\, B => 
        \CoreAPB3_0.CAPB3iool_2[0]\, C => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[8]\\\, Y => PRDATA_10_i);
    
    \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_I_29\ : 
        AX1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_2[0]\, B
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[4]_net_1\, 
        C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[5]_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/I_29\);
    
    \USB_FIFO_IF_0/sample_FIFO_0/_FIFOBLOCK[0]_\ : FIFO4K18
      port map(AEVAL11 => GLMUXINT_GND, AEVAL10 => GLMUXINT_GND, 
        AEVAL9 => GLMUXINT_GND, AEVAL8 => PLLEN_VCC, AEVAL7 => 
        GLMUXINT_GND, AEVAL6 => GLMUXINT_GND, AEVAL5 => 
        GLMUXINT_GND, AEVAL4 => GLMUXINT_GND, AEVAL3 => 
        GLMUXINT_GND, AEVAL2 => GLMUXINT_GND, AEVAL1 => 
        GLMUXINT_GND, AEVAL0 => GLMUXINT_GND, AFVAL11 => 
        GLMUXINT_GND, AFVAL10 => PLLEN_VCC, AFVAL9 => PLLEN_VCC, 
        AFVAL8 => PLLEN_VCC, AFVAL7 => PLLEN_VCC, AFVAL6 => 
        PLLEN_VCC, AFVAL5 => PLLEN_VCC, AFVAL4 => GLMUXINT_GND, 
        AFVAL3 => GLMUXINT_GND, AFVAL2 => GLMUXINT_GND, AFVAL1
         => GLMUXINT_GND, AFVAL0 => GLMUXINT_GND, WD17 => 
        GLMUXINT_GND, WD16 => GLMUXINT_GND, WD15 => 
        AFE_IF_0_RX_I9to9, WD14 => \\\AFE_IF_0_RX_I8to0_[8]\\\, 
        WD13 => \\\AFE_IF_0_RX_I8to0_[7]\\\, WD12 => 
        \\\AFE_IF_0_RX_I8to0_[6]\\\, WD11 => 
        \\\AFE_IF_0_RX_I8to0_[5]\\\, WD10 => 
        \\\AFE_IF_0_RX_I8to0_[4]\\\, WD9 => 
        \\\AFE_IF_0_RX_I8to0_[3]\\\, WD8 => 
        \\\AFE_IF_0_RX_I8to0_[2]\\\, WD7 => 
        \\\AFE_IF_0_RX_I8to0_[1]\\\, WD6 => 
        \\\AFE_IF_0_RX_I8to0_[0]\\\, WD5 => GLMUXINT_GND, WD4 => 
        GLMUXINT_GND, WD3 => GLMUXINT_GND, WD2 => GLMUXINT_GND, 
        WD1 => GLMUXINT_GND, WD0 => GLMUXINT_GND, WW0 => 
        GLMUXINT_GND, WW1 => GLMUXINT_GND, WW2 => PLLEN_VCC, RW0
         => GLMUXINT_GND, RW1 => GLMUXINT_GND, RW2 => PLLEN_VCC, 
        RPIPE => GLMUXINT_GND, WEN => 
        \USB_FIFO_IF_0/sample_FIFO_0/WRITE_ENABLE_I\, REN => 
        \USB_FIFO_IF_0/sample_FIFO_0/READ_ENABLE_I\, WBLK => 
        GLMUXINT_GND, RBLK => GLMUXINT_GND, WCLK => 
        AFE2_CLK_pin_c, RCLK => 
        \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, RESET => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, ESTOP => 
        PLLEN_VCC, FSTOP => PLLEN_VCC, RD17 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[17]\\\\\, RD16 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[16]\\\\\, RD15 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[15]\\\\\, RD14 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[14]\\\\\, RD13 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[13]\\\\\, RD12 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[12]\\\\\, RD11 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[11]\\\\\, RD10 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[10]\\\\\, RD9 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[9]\\\\\, RD8 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[8]\\\\\, RD7 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[7]\\\\\, RD6 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[6]\\\\\, RD5 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[5]\\\\\, RD4 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[4]\\\\\, RD3 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[3]\\\\\, RD2 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[2]\\\\\, RD1 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[1]\\\\\, RD0 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[0]\\\\\, FULL => 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\FULLX_I[0]\\\\\, AFULL
         => OPEN, EMPTY => 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\EMPTYX_I[0]\\\\\, 
        AEMPTY => 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\AEMPTYX_I[0]\\\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[11]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c10\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n11\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_91\ : MSS_IF
      port map(PIN4 => FAB_CLK, PIN5 => GLMUXINT_GND, PIN6 => 
        GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => OPEN, 
        PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SYNCCLKFDBKINT_NET\, 
        PIN5INT => OPEN, PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[31]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[31]INT_NET\, 
        PIN2INT => GLMUXINT_GND, PIN3INT => GLMUXINT_GND);
    
    \USB_FIFO_IF_0/USB_IF_0/u_USB_CLKBUF/U0/U0\ : IOPAD_IN
      port map(PAD => USB_CLK_pin, Y => 
        \USB_FIFO_IF_0/USB_IF_0/u_USB_CLKBUF/U0/NET1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_RD_n_pin_RNIP2NH\ : NOR3A
      port map(A => StreamingReceiver_RF_MSS_0_M2F_RESET_N, B => 
        USB_RD_n_pin_c, C => USB_RXF_n_pin_c, Y => 
        \USB_FIFO_IF_0/USB_IF_0/READ_FROM_USB_REG_0_sqmuxa\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_63\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/VCC15GOODINT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/VCC33GOODINT_NET\, 
        PIN3INT => GLMUXINT_GND);
    
    \USB_FIFO_IF_0/USB_IF_0/un2_s_from_adc_smpl_cntr_I_6\ : NOR2B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[1]_net_1\, B
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[0]_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/N_6\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[27]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[27]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[27]\);
    
    \SAMPLE_APB_0/PRDATA_1[4]\ : DFN1C0
      port map(D => \SAMPLE_APB_0/N_39\, CLK => FAB_CLK, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[4]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[27]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[27]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[27]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[27]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNI9K61[6]\ : 
        OR3
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[4]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[6]_net_1\, 
        C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[5]_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state_5\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNI7CO2_0[0]\ : 
        NOR3
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state_2\, B => 
        \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state_0\, C => 
        \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state_5\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[24]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[24]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[16]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[24]\);
    
    \AFE_IF_0/g_DDR_INTERFACE.8.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \AFE_IF_0/g_DDR_INTERFACE.8.u_BIBUF_LVCMOS33/U0/NET1\, E
         => \AFE_IF_0/g_DDR_INTERFACE.8.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \AFE_IF_0/g_DDR_INTERFACE.8.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => DATA_pin(8));
    
    \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_XTLOSC\ : MSS_XTLOSC
      port map(XTL => MAINXIN, CLKOUT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/N_CLKA_XTLOSC\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[30]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[30]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[30]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[4]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[4]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[4]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[5]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[5]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[5]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNIBQ152[22]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c20\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[22]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c22\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[31]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[30]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c29\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[31]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n31\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[15]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[15]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[7]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[15]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_44\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[22]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[21]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[23]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SLEEPINT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[0]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[1]INT_NET\);
    
    \USB_FIFO_IF_0/sample_FIFO_0/OR2_EMPTY\ : OR2
      port map(A => 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\EMPTYX_I[0]\\\\\, B => 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\EMPTYX_I[1]\\\\\, Y => 
        \USB_FIFO_IF_0/sample_FIFO_0_EMPTY\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA_5_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_IRE_OB_EB
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[29]_net_1\, 
        E => USB_OE_n_pin_c, ICE => 
        \USB_FIFO_IF_0/USB_IF_0/READ_FROM_USB_REG_0_sqmuxa\, ICLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, YIN => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.5.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.5.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.5.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[5]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[20]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[20]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[12]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[20]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[29]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[29]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[29]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[29]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_54\ : MSS_IF
      port map(PIN4 => PRDATA_10_i, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[20]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[19]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[21]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[19]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[20]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[21]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[31]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[31]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[31]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[12]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c10\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[12]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n12\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[2]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[2]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[2]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_79\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[11]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[12]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[13]INT_NET\);
    
    \SAMPLE_APB_0/REG[5]\ : DFN1E1
      port map(D => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[5]\\\, 
        CLK => FAB_CLK, E => \SAMPLE_APB_0/REG_0_sqmuxa\, Q => 
        \SAMPLE_APB_0/REG[5]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[28]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[28]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[28]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[22]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[22]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[22]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[22]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNI1CJ8[2]\ : NOR3C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[0]_net_1\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[2]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c2\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_94\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBALERTNIINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0BCLKINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBUSNIINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[4]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[5]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBALERTNOINT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[1]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[1]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[1]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[21]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c20\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n21\);
    
    \SAMPLE_APB_0/REG[2]\ : DFN1E1
      port map(D => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[2]\\\, 
        CLK => FAB_CLK, E => \SAMPLE_APB_0/REG_0_sqmuxa\, Q => 
        \SAMPLE_APB_0/REG[2]_net_1\);
    
    \AFE_IF_0/g_DDR_INTERFACE.1.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \AFE_IF_0/g_DDR_INTERFACE.1.u_BIBUF_LVCMOS33/U0/NET1\, E
         => \AFE_IF_0/g_DDR_INTERFACE.1.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \AFE_IF_0/g_DDR_INTERFACE.1.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => DATA_pin(1));
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[9]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[9]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[9]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNO[5]\ : XA1
      port map(A => \USB_FIFO_IF_0/USB_IF_0/N_3\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[5]_net_1\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[5]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[4]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c2\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[4]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n4\);
    
    \AFE_IF_0/g_DDR_INTERFACE.2.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \AFE_IF_0/g_DDR_INTERFACE.2.u_BIBUF_LVCMOS33/U0/NET1\, E
         => \AFE_IF_0/g_DDR_INTERFACE.2.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \AFE_IF_0/g_DDR_INTERFACE.2.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => DATA_pin(2));
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[18]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[18]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[10]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[18]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_71\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP0INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP1INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP2INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[3]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[3]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[3]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNI85EB_0[0]\ : 
        OR2B
      port map(A => \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[1]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[1]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[1]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[17]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[17]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[17]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNISIBE[4]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c2\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[4]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c4\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNIOHRU1[20]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c18\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[20]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c20\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[15]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[15]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[15]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[22]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c20\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[22]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n22\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_48\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[2]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[1]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[3]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[1]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[2]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[3]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C\ : NOR2
      port map(A => USB_WR_n_pin_c, B => USB_TXE_n_pin_c, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_8\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0DCDnINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0RInINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1CTSnINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI0SSO[3]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0RTSnINT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART0DTRnINT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[28]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[28]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[28]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[28]/Y\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_58\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[31]INT_NET\, 
        PIN6INT => OPEN, PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[31]INT_NET\, 
        PIN2INT => GLMUXINT_GND, PIN3INT => GLMUXINT_GND);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[1]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[1]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[1]\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.1.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.1.u_BIBUF_LVCMOS33/U0/NET1\, 
        E => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.1.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.1.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => USB_DATA_pin(1));
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[22]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[22]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[14]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[22]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[24]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[24]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[24]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_98\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => 
        \StreamingReceiver_RF_MSS_0/MSSINT_GPO_14_A\, PIN2 => 
        OPEN, PIN3 => OPEN, PIN4INT => OPEN, PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[14]INT_NET\, 
        PIN6INT => OPEN, PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[14]INT_NET\, 
        PIN2INT => GLMUXINT_GND, PIN3INT => GLMUXINT_GND);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_2\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[17]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[16]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[18]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[16]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[17]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[18]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[20]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n20\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[20]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[20]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[27]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[27]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[27]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[24]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[24]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[24]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[24]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[30]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n30\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[30]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[30]/Y\);
    
    \AFE2_SHDN_n_pin_pad/U0/U0\ : IOPAD_TRI
      port map(D => \AFE2_SHDN_n_pin_pad/U0/NET1\, E => 
        \AFE2_SHDN_n_pin_pad/U0/NET2\, PAD => AFE2_SHDN_n_pin);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_30\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[0]\\\, PIN2 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[1]\\\, PIN3 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[2]\\\, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[1]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[0]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[2]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[0]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[1]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[2]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[8]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[8]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[0]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[8]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[6]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c4\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[6]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n6\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[22]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[22]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[22]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[20]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[20]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[20]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[20]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_STORE_SAMPLES/U1\ : DFN1P0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_STORE_SAMPLES/Y\, 
        CLK => AFE2_CLK_pin_c, PRE => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/s_STORE_SAMPLES\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_74\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD1CLKINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD0CLKINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD2CLKINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP9INT_NET\, 
        PIN2INT => GLMUXINT_GND, PIN3INT => GLMUXINT_GND);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[1]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[1]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[1]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[14]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[14]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[14]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[14]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/U_TILE3\ : 
        MSS_CCC_GL_IF
      port map(PIN2 => GLMUXINT_GND, PIN3 => GLMUXINT_GND, PIN4
         => GLMUXINT_GND, PIN1 => OPEN, PIN5 => OPEN, PIN2INT => 
        OPEN, PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/CLKC_INT\, 
        PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SUPDATE_INT\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/YC_INT\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/GLC_INT\);
    
    \SAMPLE_APB_0/PRDATA_1_RNO[1]\ : NOR3B
      port map(A => N_42, B => \SAMPLE_APB_0/REG[1]_net_1\, C => 
        \SAMPLE_APB_0/un8_pwrite_i_0\, Y => \SAMPLE_APB_0/N_9\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[16]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n16\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[16]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[16]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_I_17\ : 
        XOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[0]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_partial_sum[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL/Y\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL\);
    
    INV_2_0 : INV
      port map(A => StreamingReceiver_RF_MSS_0_M2F_RESET_N, Y => 
        INV_2_Y_0);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[9]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[9]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[9]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[29]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[29]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[29]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[29]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n1\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_oe\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_oe_3\, CLK => 
        \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        USB_OE_n_pin_c);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[13]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[13]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[13]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[17]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c16\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n17\);
    
    \AFE_IF_0/g_DDR_INTERFACE_8_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_ID_OD_EB
      port map(DR => \AFE_IF_0/s_tx_q[8]\, DF => 
        \AFE_IF_0/s_tx_q[8]\, CLR => INV_2_Y, E => GLMUXINT_GND, 
        ICLK => AFE2_CLK_pin_c, OCLK => AFE2_CLK_pin_c, YIN => 
        \AFE_IF_0/g_DDR_INTERFACE.8.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.8.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.8.u_BIBUF_LVCMOS33/U0/NET2\, YR
         => \\\AFE_IF_0_RX_Q8to0_[8]\\\, YF => 
        \\\AFE_IF_0_RX_I8to0_[8]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNO[1]\ : MX2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/I_27\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[1]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[10]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[10]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[10]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[10]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[8]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[8]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[8]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[21]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[21]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[21]/Y\);
    
    \CoreAPB3_0/CAPB3O1II/PRDATA_1_i\ : NOR3C
      port map(A => \CoreAPB3_0.CAPB3iool_1[0]\, B => 
        \CoreAPB3_0.CAPB3iool_2[0]\, C => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[1]\\\, Y => N_19);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_10\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/VRONINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/RXEVINT_NET\, 
        PIN6INT => OPEN, PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1RTSnINT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/UART1DTRnINT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/TXEVINT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[0]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[0]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[0]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNIU6SQ1[1]\ : 
        NOR2A
      port map(A => \USB_FIFO_IF_0/sample_FIFO_0_AEMPTY\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_36\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => PLLEN_VCC, PIN6 => 
        N_17, PIN1 => OPEN, PIN2 => OPEN, PIN3 => OPEN, PIN4INT
         => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPSLVERRINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPREADYINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[0]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[18]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[19]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[0]INT_NET\);
    
    \AFE2_CLK_pin_pad/U0/U0\ : IOPAD_TRI
      port map(D => \AFE2_CLK_pin_pad/U0/NET1\, E => 
        \AFE2_CLK_pin_pad/U0/NET2\, PAD => AFE2_CLK_pin);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[14]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[14]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[14]\);
    
    \SAMPLE_APB_0/s_REG_FULL/U1\ : DFN1C0
      port map(D => \SAMPLE_APB_0/s_REG_FULL/Y\, CLK => FAB_CLK, 
        CLR => StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \SAMPLE_APB_0/s_REG_FULL\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[8]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[8]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[8]\);
    
    \AFE_IF_0/g_DDR_INTERFACE.4.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \AFE_IF_0/g_DDR_INTERFACE.4.u_BIBUF_LVCMOS33/U0/NET1\, E
         => \AFE_IF_0/g_DDR_INTERFACE.4.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \AFE_IF_0/g_DDR_INTERFACE.4.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => DATA_pin(4));
    
    \LD_pad/U0/U0\ : IOPAD_IN
      port map(PAD => LD, Y => \LD_pad/U0/NET1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[31]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[31]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[31]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[31]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_78\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[8]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[9]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[10]INT_NET\);
    
    \SAMPLE_APB_0/PRDATA_1_RNO[4]\ : OA1
      port map(A => \SAMPLE_APB_0/REG[4]_net_1\, B => 
        \SAMPLE_APB_0/un8_pwrite_i_0\, C => N_42, Y => 
        \SAMPLE_APB_0/N_39\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[12]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[12]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[12]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[12]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_RD_n_pin\ : DFN1P0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/un5_s_read_from_usb_reg_full\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, PRE => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        USB_RD_n_pin_c);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[16]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[16]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[16]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNO_0[0]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[3]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/un27_s_temp_reg_state\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_0_sqmuxa_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[1]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[1]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[1]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[1]\);
    
    \SAMPLE_APB_0/PRDATA_1_RNO[7]\ : NOR3B
      port map(A => N_42, B => \SAMPLE_APB_0/REG[7]_net_1\, C => 
        \SAMPLE_APB_0/un8_pwrite_i_0\, Y => \SAMPLE_APB_0/N_15\);
    
    INV_1 : INV
      port map(A => INV_1_Y, Y => AFE_IF_0_RX_Q9to9);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[19]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[19]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[19]/Y\);
    
    \ANTSEL_pad/U0/U0\ : IOPAD_TRI
      port map(D => \ANTSEL_pad/U0/NET1\, E => 
        \ANTSEL_pad/U0/NET2\, PAD => ANTSEL);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI87KQ\ : NOR2B
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_oe_3_2\, B => 
        \USB_FIFO_IF_0/USB_IF_0/un5_s_read_from_usb_reg_full\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_oe_3_4\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_62\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL1ENINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL0ENINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL2ENINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL0INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL1INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL2INT_NET\);
    
    \CoreAPB3_0/CAPB3O1II/PRDATA_3_i\ : NOR3C
      port map(A => \CoreAPB3_0.CAPB3iool_1[0]\, B => 
        \CoreAPB3_0.CAPB3iool_2[0]\, C => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[3]\\\, Y => N_23);
    
    \AFE2_SHDN_n_pin_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => PLLEN_VCC, E => PLLEN_VCC, DOUT => 
        \AFE2_SHDN_n_pin_pad/U0/NET1\, EOUT => 
        \AFE2_SHDN_n_pin_pad/U0/NET2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[11]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[11]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[11]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[5]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[5]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[5]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[5]\);
    
    \AFE_IF_0/g_DDR_INTERFACE_1_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_ID_OD_EB
      port map(DR => \AFE_IF_0/s_tx_q[1]\, DF => 
        \AFE_IF_0/s_tx_q[1]\, CLR => INV_2_Y_0, E => GLMUXINT_GND, 
        ICLK => AFE2_CLK_pin_c, OCLK => AFE2_CLK_pin_c, YIN => 
        \AFE_IF_0/g_DDR_INTERFACE.1.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.1.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.1.u_BIBUF_LVCMOS33/U0/NET2\, YR
         => \\\AFE_IF_0_RX_Q8to0_[1]\\\, YF => 
        \\\AFE_IF_0_RX_I8to0_[1]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa\ : 
        OR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[16]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c14\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[16]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n16\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_65\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/PUFABnINT_NET\, 
        PIN2INT => GLMUXINT_GND, PIN3INT => GLMUXINT_GND);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[12]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[12]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[12]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[12]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNITJO_0[0]\ : 
        OR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[0]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[1]_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/un5_s_temp_reg_state_0\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[27]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c26\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n27\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[6]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[6]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[6]_net_1\);
    
    \AFE_IF_0/s_tx_i[0]\ : DFN1C1
      port map(D => \AFE_IF_0/s_tx_q[0]\, CLK => AFE2_CLK_pin_c, 
        CLR => INV_2_Y, Q => \AFE_IF_0/s_tx_q[0]\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.6.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.6.u_BIBUF_LVCMOS33/U0/NET1\, 
        E => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.6.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.6.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => USB_DATA_pin(6));
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[11]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[11]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[11]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[11]\);
    
    \AFE_IF_0/g_DDR_INTERFACE_2_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_ID_OD_EB
      port map(DR => \AFE_IF_0/s_tx_q[2]\, DF => 
        \AFE_IF_0/s_tx_q[2]\, CLR => INV_2_Y_0, E => GLMUXINT_GND, 
        ICLK => AFE2_CLK_pin_c, OCLK => AFE2_CLK_pin_c, YIN => 
        \AFE_IF_0/g_DDR_INTERFACE.2.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.2.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.2.u_BIBUF_LVCMOS33/U0/NET2\, YR
         => \\\AFE_IF_0_RX_Q8to0_[2]\\\, YF => 
        \\\AFE_IF_0_RX_I8to0_[2]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[28]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[28]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[28]\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[28]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[16]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[16]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[16]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNI2DLO1[18]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c16\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[18]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c18\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[15]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c14\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n15\);
    
    \SAMPLE_APB_0/PRDATA_1[2]\ : DFN1C0
      port map(D => \SAMPLE_APB_0/N_37\, CLK => FAB_CLK, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[2]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNO[5]\ : 
        NOR2B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_net_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/I_29\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[5]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n13\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[23]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[23]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[23]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[23]\);
    
    \nSHDN_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \StreamingReceiver_RF_MSS_0/MSSINT_GPO_13_A\, 
        E => PLLEN_VCC, DOUT => \nSHDN_pad/U0/NET1\, EOUT => 
        \nSHDN_pad/U0/NET2\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_89\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[26]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[25]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[27]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[25]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[26]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[27]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[10]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[10]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[10]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[6]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[6]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[6]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[6]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[30]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[30]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[30]_net_1\);
    
    \nSHDN_pad/U0/U0\ : IOPAD_TRI
      port map(D => \nSHDN_pad/U0/NET1\, E => \nSHDN_pad/U0/NET2\, 
        PAD => nSHDN);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[21]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[21]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[21]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_47\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[31]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[30]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[0]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[0]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[7]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/WDINTINT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[4]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[4]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[4]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[21]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[21]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[21]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_I_35\ : 
        NOR3C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[4]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[5]_net_1\, 
        C => \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_2[0]\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_11[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[2]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[2]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[2]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[2]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[17]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[17]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[9]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[17]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[26]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c24\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[26]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n26\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_57\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => PRDATA_10_i, PIN6
         => PRDATA_10_i, PIN1 => OPEN, PIN2 => OPEN, PIN3 => OPEN, 
        PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[29]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[28]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[30]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[28]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[29]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[30]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[18]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[18]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[18]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[18]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[9]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c8\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n9\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[0]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[0]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[0]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]/Y\, CLK => 
        \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNI9P23[0]\ : NOR2A
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_oe_3_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[6]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[6]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[6]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_97\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => 
        \StreamingReceiver_RF_MSS_0/MSSINT_GPO_13_A\, PIN2 => 
        OPEN, PIN3 => OPEN, PIN4INT => OPEN, PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[13]INT_NET\, 
        PIN6INT => OPEN, PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[13]INT_NET\, 
        PIN2INT => GLMUXINT_GND, PIN3INT => GLMUXINT_GND);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_43\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[19]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[18]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[20]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPREADYINT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPSLVERRINT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/DEEPSLEEPINT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNO[3]\ : INV
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[3]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8_i[3]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[14]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[14]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[14]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_81\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[17]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[18]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[19]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[5]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[5]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[5]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[25]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c24\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n25\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[17]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[17]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[17]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[14]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[14]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[14]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[14]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_53\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => PRDATA_10_i, PIN6
         => PRDATA_10_i, PIN1 => OPEN, PIN2 => OPEN, PIN3 => OPEN, 
        PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[17]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[16]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[18]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[16]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[17]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[18]INT_NET\);
    
    \StreamingReceiver_RF_MSS_0/MSS_GPIO_0_GPIO_28_OUT\ : 
        IOPAD_TRI
      port map(D => 
        \StreamingReceiver_RF_MSS_0/MSS_GPIO_0_GPIO_28_OUT_D\, E
         => PLLEN_VCC, PAD => RXTX);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.2.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.2.u_BIBUF_LVCMOS33/U0/NET1\, 
        E => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.2.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.2.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => USB_DATA_pin(2));
    
    \AFE_IF_0/g_DDR_INTERFACE.0.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \AFE_IF_0/g_DDR_INTERFACE.0.u_BIBUF_LVCMOS33/U0/NET1\, E
         => \AFE_IF_0/g_DDR_INTERFACE.0.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \AFE_IF_0/g_DDR_INTERFACE.0.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => DATA_pin(0));
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNIC533[4]\ : NOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[4]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/un27_s_temp_reg_state\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[6]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[6]\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[6]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL/U0\ : MX2
      port map(A => SAMPLE_APB_0_READ_SUCCESSFUL_i, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL_1_sqmuxa\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[26]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n26\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[26]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[26]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[0]\ : DFN1P0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_e0\, CLK
         => AFE2_CLK_pin_c, PRE => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[0]_net_1\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_93\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CALIBININT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C0SMBUSNOINT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBUSNOINT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CALIBOUTINT_NET\);
    
    \AFE_IF_0/g_DDR_INTERFACE.6.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \AFE_IF_0/g_DDR_INTERFACE.6.u_BIBUF_LVCMOS33/U0/NET1\, E
         => \AFE_IF_0/g_DDR_INTERFACE.6.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \AFE_IF_0/g_DDR_INTERFACE.6.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => DATA_pin(6));
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[5]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[5]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[5]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[14]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[14]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[6]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[14]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[5]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[5]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[5]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[3]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c2\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n3\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[3]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[3]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[3]_net_1\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.4.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.4.u_BIBUF_LVCMOS33/U0/NET1\, 
        E => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.4.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.4.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => USB_DATA_pin(4));
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[2]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[2]\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[2]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[10]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[10]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[2]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[10]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[25]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[25]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[25]_net_1\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_84\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[26]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[27]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[28]INT_NET\);
    
    \AFE_IF_0/g_DDR_INTERFACE_4_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_ID_OD_EB
      port map(DR => \AFE_IF_0/s_tx_q[4]\, DF => 
        \AFE_IF_0/s_tx_q[4]\, CLR => INV_2_Y_0, E => GLMUXINT_GND, 
        ICLK => AFE2_CLK_pin_c, OCLK => AFE2_CLK_pin_c, YIN => 
        \AFE_IF_0/g_DDR_INTERFACE.4.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.4.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.4.u_BIBUF_LVCMOS33/U0/NET2\, YR
         => \\\AFE_IF_0_RX_Q8to0_[4]\\\, YF => 
        \\\AFE_IF_0_RX_I8to0_[4]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[10]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[10]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[10]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[10]\);
    
    \SAMPLE_APB_0/REG[7]\ : DFN1E1
      port map(D => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[7]\\\, 
        CLK => FAB_CLK, E => \SAMPLE_APB_0/REG_0_sqmuxa\, Q => 
        \SAMPLE_APB_0/REG[7]_net_1\);
    
    \SAMPLE_APB_0/PRDATA_1[3]\ : DFN1C0
      port map(D => \SAMPLE_APB_0/N_11\, CLK => FAB_CLK, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[3]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[11]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[11]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[11]/Y\);
    
    \CoreAPB3_0/CAPB3iool_2[0]\ : NOR3A
      port map(A => 
        StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PSELx, B => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[8]\\\, C => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[11]\\\, Y => 
        \CoreAPB3_0.CAPB3iool_2[0]\);
    
    \USB_TXE_n_pin_pad/U0/U0\ : IOPAD_IN
      port map(PAD => USB_TXE_n_pin, Y => 
        \USB_TXE_n_pin_pad/U0/NET1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[24]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[24]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[24]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[9]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[9]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[9]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[9]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[25]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[25]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[25]\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[25]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[17]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[17]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[17]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNIVSP8[3]\ : NOR3A
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_oe_3_1\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[3]\, C => 
        USB_TXE_n_pin_c, Y => \USB_FIFO_IF_0/USB_IF_0/s_oe_3_3\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.3.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.3.u_BIBUF_LVCMOS33/U0/NET1\, 
        E => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.3.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.3.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => USB_DATA_pin(3));
    
    \USB_FIFO_IF_0/USB_IF_0/un2_s_from_adc_smpl_cntr_I_16\ : AND3
      port map(A => \USB_FIFO_IF_0/USB_IF_0/DWACT_FINC_E[0]\, B
         => \USB_FIFO_IF_0/USB_IF_0/DWACT_FINC_E[1]\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[5]_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/N_2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[8]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[8]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[8]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[8]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[26]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[26]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[26]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_77\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[5]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[6]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[7]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[27]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[27]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[27]\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[27]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_RESET_0_MSS_RESET_N\ : 
        IOPAD_IN
      port map(PAD => MSS_RESET_N, Y => 
        \StreamingReceiver_RF_MSS_0/MSS_RESET_0_MSS_RESET_N_Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[14]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c12\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[14]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n14\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA_7_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_IRE_OB_EB
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[31]_net_1\, 
        E => USB_OE_n_pin_c, ICE => 
        \USB_FIFO_IF_0/USB_IF_0/READ_FROM_USB_REG_0_sqmuxa\, ICLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, YIN => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.7.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.7.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.7.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[7]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[19]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[19]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[19]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[19]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[13]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c12\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n13\);
    
    \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/U_TILE0\ : 
        MSS_CCC_IF
      port map(PIN2 => GLMUXINT_GND, PIN3 => GLMUXINT_GND, PIN4
         => GLMUXINT_GND, PIN1 => OPEN, PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SDIN_INT\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SCLK_INT\, 
        PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SSHIFT_INT\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SDOUT_INT\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_3\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[20]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[19]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[21]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[19]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[20]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[21]INT_NET\);
    
    \AFE_IF_0/s_tx_i[8]\ : DFN1C1
      port map(D => \AFE_IF_0/s_tx_q[8]\, CLK => AFE2_CLK_pin_c, 
        CLR => INV_2_Y, Q => \AFE_IF_0/s_tx_q[8]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[3]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[3]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[3]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/U_MSSCCC\ : 
        MSS_CCC_IP
      generic map(VCOFREQUENCY => 24.0)

      port map(CLKA => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/N_CLKA_XTLOSC\, 
        EXTFB => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/EXTFB_INT\, 
        GLA => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/GLA_INT\, 
        GLAMSS => \StreamingReceiver_RF_MSS_0/GLA0\, LOCK => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/LOCK_INT\, 
        LOCKMSS => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST_PLLLOCK\, CLKB
         => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/CLKB_INT\, 
        GLB => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/GLB_INT\, 
        YB => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/YB_INT\, 
        CLKC => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/CLKC_INT\, 
        GLC => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/GLC_INT\, 
        YC => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/YC_INT\, 
        MACCLK => OPEN, SDIN => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SDIN_INT\, 
        SCLK => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SCLK_INT\, 
        SSHIFT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SSHIFT_INT\, 
        SUPDATE => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SUPDATE_INT\, 
        MODE => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/MODE_INT\, 
        SDOUT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/SDOUT_INT\, 
        PLLEN => PLLEN_VCC, OADIV(4) => GLMUXINT_GND, OADIV(3)
         => GLMUXINT_GND, OADIV(2) => GLMUXINT_GND, OADIV(1) => 
        PLLEN_VCC, OADIV(0) => GLMUXINT_GND, OADIVHALF => 
        GLMUXINT_GND, OADIVRST => GLMUXINT_GND, OAMUX(2) => 
        PLLEN_VCC, OAMUX(1) => GLMUXINT_GND, OAMUX(0) => 
        GLMUXINT_GND, BYPASSA => GLMUXINT_GND, DLYGLA(4) => 
        GLMUXINT_GND, DLYGLA(3) => GLMUXINT_GND, DLYGLA(2) => 
        GLMUXINT_GND, DLYGLA(1) => GLMUXINT_GND, DLYGLA(0) => 
        GLMUXINT_GND, DLYGLAMSS(4) => GLMUXINT_GND, DLYGLAMSS(3)
         => PLLEN_VCC, DLYGLAMSS(2) => GLMUXINT_GND, DLYGLAMSS(1)
         => GLMUXINT_GND, DLYGLAMSS(0) => GLMUXINT_GND, 
        DLYGLAFAB(4) => GLMUXINT_GND, DLYGLAFAB(3) => PLLEN_VCC, 
        DLYGLAFAB(2) => PLLEN_VCC, DLYGLAFAB(1) => PLLEN_VCC, 
        DLYGLAFAB(0) => PLLEN_VCC, OBDIV(4) => PLLEN_VCC, 
        OBDIV(3) => PLLEN_VCC, OBDIV(2) => PLLEN_VCC, OBDIV(1)
         => PLLEN_VCC, OBDIV(0) => PLLEN_VCC, OBDIVHALF => 
        GLMUXINT_GND, OBDIVRST => GLMUXINT_GND, OBMUX(2) => 
        PLLEN_VCC, OBMUX(1) => GLMUXINT_GND, OBMUX(0) => 
        GLMUXINT_GND, BYPASSB => GLMUXINT_GND, DLYGLB(4) => 
        GLMUXINT_GND, DLYGLB(3) => GLMUXINT_GND, DLYGLB(2) => 
        GLMUXINT_GND, DLYGLB(1) => GLMUXINT_GND, DLYGLB(0) => 
        GLMUXINT_GND, OCDIV(4) => GLMUXINT_GND, OCDIV(3) => 
        GLMUXINT_GND, OCDIV(2) => GLMUXINT_GND, OCDIV(1) => 
        GLMUXINT_GND, OCDIV(0) => GLMUXINT_GND, OCDIVHALF => 
        GLMUXINT_GND, OCDIVRST => GLMUXINT_GND, OCMUX(2) => 
        GLMUXINT_GND, OCMUX(1) => GLMUXINT_GND, OCMUX(0) => 
        GLMUXINT_GND, BYPASSC => PLLEN_VCC, DLYGLC(4) => 
        GLMUXINT_GND, DLYGLC(3) => GLMUXINT_GND, DLYGLC(2) => 
        GLMUXINT_GND, DLYGLC(1) => GLMUXINT_GND, DLYGLC(0) => 
        GLMUXINT_GND, FINDIV(6) => GLMUXINT_GND, FINDIV(5) => 
        GLMUXINT_GND, FINDIV(4) => GLMUXINT_GND, FINDIV(3) => 
        GLMUXINT_GND, FINDIV(2) => PLLEN_VCC, FINDIV(1) => 
        GLMUXINT_GND, FINDIV(0) => GLMUXINT_GND, FBDIV(6) => 
        GLMUXINT_GND, FBDIV(5) => GLMUXINT_GND, FBDIV(4) => 
        GLMUXINT_GND, FBDIV(3) => GLMUXINT_GND, FBDIV(2) => 
        PLLEN_VCC, FBDIV(1) => GLMUXINT_GND, FBDIV(0) => 
        PLLEN_VCC, FBDLY(4) => GLMUXINT_GND, FBDLY(3) => 
        GLMUXINT_GND, FBDLY(2) => GLMUXINT_GND, FBDLY(1) => 
        GLMUXINT_GND, FBDLY(0) => PLLEN_VCC, FBSEL(1) => 
        GLMUXINT_GND, FBSEL(0) => PLLEN_VCC, XDLYSEL => 
        GLMUXINT_GND, VCOSEL(2) => GLMUXINT_GND, VCOSEL(1) => 
        GLMUXINT_GND, VCOSEL(0) => GLMUXINT_GND, GLMUXINT => 
        GLMUXINT_GND, GLMUXSEL(1) => GLMUXINT_GND, GLMUXSEL(0)
         => GLMUXINT_GND, GLMUXCFG(1) => GLMUXINT_GND, 
        GLMUXCFG(0) => GLMUXINT_GND);
    
    \SAMPLE_APB_0/REG[4]\ : DFN1E1
      port map(D => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[4]\\\, 
        CLK => FAB_CLK, E => \SAMPLE_APB_0/REG_0_sqmuxa\, Q => 
        \SAMPLE_APB_0/REG[4]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[26]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[26]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[18]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[26]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[8]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[8]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[8]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[3]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[3]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[3]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[21]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[21]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[21]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_73\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABACETRIGINT_NET\, 
        PIN6INT => OPEN, PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP6INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP7INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP8INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[21]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[21]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[21]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[21]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[16]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[16]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[16]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n19\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNIN666[0]\ : OR3B
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_oe_3_2\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n7\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNI4GI1[3]\ : 
        NOR3C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[4]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[3]_net_1\, 
        C => \USB_FIFO_IF_0/USB_IF_0/un45_s_temp_reg_state_2\, Y
         => \USB_FIFO_IF_0/USB_IF_0/un45_s_temp_reg_state_4\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_88\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[23]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[22]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[24]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[22]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[23]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[24]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[2]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[2]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[2]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_2_sqmuxa\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[2]/Y\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST_RNI483L1\ : NOR3B
      port map(A => \CoreAPB3_0.CAPB3iool_1[0]\, B => 
        \CoreAPB3_0.CAPB3iool_2[0]\, C => 
        \StreamingReceiver_RF_MSS_0/CoreAPB3_0_APBmslave0_PWRITE\, 
        Y => N_42);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_60\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABINTINT_NET\, 
        PIN6INT => OPEN, PIN1INT => GLMUXINT_GND, PIN2INT => 
        GLMUXINT_GND, PIN3INT => GLMUXINT_GND);
    
    \AFE_IF_0/g_DDR_INTERFACE.5.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \AFE_IF_0/g_DDR_INTERFACE.5.u_BIBUF_LVCMOS33/U0/NET1\, E
         => \AFE_IF_0/g_DDR_INTERFACE.5.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \AFE_IF_0/g_DDR_INTERFACE.5.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => DATA_pin(5));
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n23\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/un2_s_from_adc_smpl_cntr_I_8\ : AND3
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[0]_net_1\, B
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[1]_net_1\, C
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[2]_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/N_5\);
    
    \USB_FIFO_IF_0/USB_IF_0/un2_s_from_adc_smpl_cntr_I_10\ : AND3
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[0]_net_1\, B
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[1]_net_1\, C
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[2]_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/DWACT_FINC_E[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[16]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[16]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[16]\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[16]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[8]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c6\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[8]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n8\);
    
    \USB_FIFO_IF_0/USB_IF_0/FIFO_RE\ : DFI1P0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[3]\, CLK => 
        \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, PRE => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, QN => 
        \USB_FIFO_IF_0/WEAP\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[29]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[29]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[29]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNIFH6E[0]\ : 
        OR3A
      port map(A => \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un5_s_temp_reg_state\, C => 
        \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[3]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[12]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[12]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[4]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[12]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[0]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[0]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[0]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[20]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[20]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[20]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[30]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[30]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[30]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[24]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c22\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[24]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n24\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[6]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[6]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[6]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[6]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNO[0]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_0_sqmuxa_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[23]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c22\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n23\);
    
    INV_2 : INV
      port map(A => StreamingReceiver_RF_MSS_0_M2F_RESET_N, Y => 
        INV_2_Y);
    
    \USB_FIFO_IF_0/USB_IF_0/u_USB_CLKBUF/U0/U1\ : CLKSRC
      port map(A => \USB_FIFO_IF_0/USB_IF_0/u_USB_CLKBUF/U0/NET1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[3]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[3]\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[3]_net_1\);
    
    \SAMPLE_APB_0/PRDATA_1[6]\ : DFN1C0
      port map(D => \SAMPLE_APB_0/N_41\, CLK => FAB_CLK, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[6]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[11]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[11]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[11]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNIMATV[10]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c8\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[10]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c10\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNI3B361[12]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c10\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[12]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c12\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[23]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[23]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[23]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[1]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_2_sqmuxa\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[18]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[18]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[18]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[18]\);
    
    \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_I_27\ : 
        XOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[1]_net_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_TMP[0]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/I_27\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[21]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[21]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[13]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[21]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[4]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n4\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[4]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[4]/Y\);
    
    \AFE_IF_0/g_DDR_INTERFACE_0_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_ID_OD_EB
      port map(DR => \AFE_IF_0/s_tx_q[0]\, DF => 
        \AFE_IF_0/s_tx_q[0]\, CLR => INV_2_Y_0, E => GLMUXINT_GND, 
        ICLK => AFE2_CLK_pin_c, OCLK => AFE2_CLK_pin_c, YIN => 
        \AFE_IF_0/g_DDR_INTERFACE.0.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.0.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.0.u_BIBUF_LVCMOS33/U0/NET2\, YR
         => \\\AFE_IF_0_RX_Q8to0_[0]\\\, YF => 
        \\\AFE_IF_0_RX_I8to0_[0]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[4]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[4]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[4]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[4]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[30]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[30]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[22]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[30]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNIU6SQ1_0[1]\ : 
        NOR2A
      port map(A => \USB_FIFO_IF_0/sample_FIFO_0_AEMPTY\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\);
    
    \SAMPLE_APB_0/PRDATA_1[0]\ : DFN1C0
      port map(D => \SAMPLE_APB_0/N_35\, CLK => FAB_CLK, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[0]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[0]\ : XNOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[0]_net_1\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_e0\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[13]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[13]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[13]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[13]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_66\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL7ENINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL6ENINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL8ENINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL6INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL7INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL8INT_NET\);
    
    \AFE_IF_0/s_tx_i[3]\ : DFN1C1
      port map(D => \AFE_IF_0/s_tx_q[3]\, CLK => AFE2_CLK_pin_c, 
        CLR => INV_2_Y, Q => \AFE_IF_0/s_tx_q[3]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNO[4]\ : XA1
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[4]_net_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_2[0]\, 
        C => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[4]\);
    
    \AFE_IF_0/g_DDR_INTERFACE_6_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_ID_OD_EB
      port map(DR => \AFE_IF_0/s_tx_q[6]\, DF => 
        \AFE_IF_0/s_tx_q[6]\, CLR => INV_2_Y_0, E => GLMUXINT_GND, 
        ICLK => AFE2_CLK_pin_c, OCLK => AFE2_CLK_pin_c, YIN => 
        \AFE_IF_0/g_DDR_INTERFACE.6.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.6.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.6.u_BIBUF_LVCMOS33/U0/NET2\, YR
         => \\\AFE_IF_0_RX_Q8to0_[6]\\\, YF => 
        \\\AFE_IF_0_RX_I8to0_[6]\\\);
    
    \USB_RD_n_pin_pad/U0/U0\ : IOPAD_TRI
      port map(D => \USB_RD_n_pin_pad/U0/NET1\, E => 
        \USB_RD_n_pin_pad/U0/NET2\, PAD => USB_RD_n_pin);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNIDPNQ2[29]\ : NOR2B
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c28\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[29]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c29\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[3]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8_i[3]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[3]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_2_sqmuxa\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[3]/Y\);
    
    \CoreAPB3_0/CAPB3O1II/PRDATA_7_i\ : NOR3C
      port map(A => \CoreAPB3_0.CAPB3iool_1[0]\, B => 
        \CoreAPB3_0.CAPB3iool_2[0]\, C => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[7]\\\, Y => PRDATA_7_i);
    
    \SAMPLE_APB_0/PRDATA_1[1]\ : DFN1C0
      port map(D => \SAMPLE_APB_0/N_9\, CLK => FAB_CLK, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[1]\\\);
    
    \USB_FIFO_IF_0/sample_FIFO_0/OR2_AEMPTY\ : OR2
      port map(A => 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\AEMPTYX_I[0]\\\\\, B
         => \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\AEMPTYX_I[1]\\\\\, 
        Y => \USB_FIFO_IF_0/sample_FIFO_0_AEMPTY\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNI3S51[6]\ : 
        NOR3C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[2]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[6]_net_1\, 
        C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[1]_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/un45_s_temp_reg_state_3\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[2]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[2]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[2]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[29]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[29]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[21]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[29]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL_RNO\ : OA1B
      port map(A => USB_RD_n_pin_c, B => USB_RXF_n_pin_c, C => 
        SAMPLE_APB_0_READ_SUCCESSFUL, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL_1_sqmuxa\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNO[2]\ : XA1
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[2]_net_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_1[0]\, 
        C => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[2]\);
    
    \SAMPLE_APB_0/PRDATA_1[7]\ : DFN1C0
      port map(D => \SAMPLE_APB_0/N_15\, CLK => FAB_CLK, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[7]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR_3_I_8\ : XOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR[0]_net_1\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_partial_sum_0[0]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_42\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => 
        StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PSELx, PIN2 => 
        OPEN, PIN3 => 
        \StreamingReceiver_RF_MSS_0/CoreAPB3_0_APBmslave0_PWRITE\, 
        PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPENABLEINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPSELINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWRITEINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPSELINT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPENABLEINT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWRITEINT_NET\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_52\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[14]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[13]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[15]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[13]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[14]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[15]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/un2_s_from_adc_smpl_cntr_I_15\ : AND2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[3]_net_1\, B
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[4]_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/DWACT_FINC_E[1]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_45\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[25]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[24]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[26]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[2]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[3]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[4]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNIKB9C1[14]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c12\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[14]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c14\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n3\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[3]/Y\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_55\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => PRDATA_10_i, PIN6
         => PRDATA_10_i, PIN1 => OPEN, PIN2 => OPEN, PIN3 => OPEN, 
        PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[23]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[22]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[24]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[22]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[23]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[24]INT_NET\);
    
    \USB_SIWU_N_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => PLLEN_VCC, E => PLLEN_VCC, DOUT => 
        \USB_SIWU_N_pad/U0/NET1\, EOUT => 
        \USB_SIWU_N_pad/U0/NET2\);
    
    \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_I_32\ : 
        NOR2B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_1[0]\, B
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[2]_net_1\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_12[0]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_92\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => GLMUXINT_GND, PIN2INT => GLMUXINT_GND, PIN3INT
         => GLMUXINT_GND);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNIGMGE1_0[1]\ : 
        OR3C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_2\, B => 
        \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_3\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\);
    
    \AFE_IF_0/s_tx_i[1]\ : DFN1C1
      port map(D => \AFE_IF_0/s_tx_q[1]\, CLK => AFE2_CLK_pin_c, 
        CLR => INV_2_Y, Q => \AFE_IF_0/s_tx_q[1]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[3]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[3]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[3]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[3]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_95\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBALERTNIINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1BCLKINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBUSNIINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[6]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/SPI1SSO[7]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/I2C1SMBALERTNOINT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNI7D792[3]\ : NOR3B
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_oe_3_4\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_oe_3_3\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_0_sqmuxa\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_oe_3\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[24]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[24]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[24]_net_1\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_39\ : MSS_IF
      port map(PIN4 => PRDATA_10_i, PIN5 => PRDATA_7_i, PIN6 => 
        GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => OPEN, 
        PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[8]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[7]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[9]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[7]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[8]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[9]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[14]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[14]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[14]\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.0.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.0.u_BIBUF_LVCMOS33/U0/NET1\, 
        E => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.0.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.0.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => USB_DATA_pin(0));
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[8]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[8]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[8]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[2]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[2]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[2]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[26]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[26]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[26]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[8]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[8]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[8]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[8]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[14]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[14]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[14]\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[14]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[18]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[18]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[18]_net_1\);
    
    \AFE_IF_0/g_DDR_INTERFACE_5_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_ID_OD_EB
      port map(DR => \AFE_IF_0/s_tx_q[5]\, DF => 
        \AFE_IF_0/s_tx_q[5]\, CLR => INV_2_Y_0, E => GLMUXINT_GND, 
        ICLK => AFE2_CLK_pin_c, OCLK => AFE2_CLK_pin_c, YIN => 
        \AFE_IF_0/g_DDR_INTERFACE.5.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.5.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.5.u_BIBUF_LVCMOS33/U0/NET2\, YR
         => \\\AFE_IF_0_RX_Q8to0_[5]\\\, YF => 
        \\\AFE_IF_0_RX_I8to0_[5]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[29]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n29\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[29]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[29]/Y\);
    
    \USB_FIFO_IF_0/sample_FIFO_0/WRITE_AND\ : OR3A
      port map(A => \USB_FIFO_IF_0/s_STORE_SAMPLES\, B => 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\FULLX_I[1]\\\\\, C => 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\FULLX_I[0]\\\\\, Y => 
        \USB_FIFO_IF_0/sample_FIFO_0/WRITE_ENABLE_I\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_31\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[3]\\\, PIN2 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[4]\\\, PIN3 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[5]\\\, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[4]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[3]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[5]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[3]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[4]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[5]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[4]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[4]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[4]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[9]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[9]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[9]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[9]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/U_TILE1\ : 
        MSS_CCC_GL_IF
      port map(PIN2 => GLMUXINT_GND, PIN3 => GLMUXINT_GND, PIN4
         => GLMUXINT_GND, PIN1 => OPEN, PIN5 => FAB_CLK, PIN2INT
         => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/EXTFB_INT\, 
        PIN3INT => OPEN, PIN4INT => OPEN, PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/LOCK_INT\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_CCC_0/I_MSSCCC/GLA_INT\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[15]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[15]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[15]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[15]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[26]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[26]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[26]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[26]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[26]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[26]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[26]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNO[4]\ : XA1
      port map(A => \USB_FIFO_IF_0/USB_IF_0/N_4\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[4]_net_1\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[4]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_87\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[20]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[19]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[21]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[19]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[20]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[21]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[17]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[17]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[17]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[17]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[3]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[3]/Y\, CLK => 
        \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[3]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[26]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[26]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[26]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[26]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[9]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[9]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[9]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_72\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD1DINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD0DINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABSDD2DINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP3INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP4INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/CMP5INT_NET\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_83\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[23]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[24]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[25]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[12]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[12]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[12]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR_RNID7IH1[1]\ : 
        NOR3
      port map(A => \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un27_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_2_sqmuxa\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[22]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[22]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[22]\);
    
    \SAMPLE_APB_0/p_REG_READ.un8_pwrite_5\ : NOR3A
      port map(A => \SAMPLE_APB_0/un8_pwrite_3\, B => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[5]\\\, C => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[4]\\\, Y => 
        \SAMPLE_APB_0/un8_pwrite_5\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR_3_I_7\ : XOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR[1]_net_1\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_partial_sum[1]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[5]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[5]\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[5]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_75\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => GLMUXINT_GND, PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[0]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[1]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNO[3]\ : XA1
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[3]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_12[0]\, C
         => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[3]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNI1PL8[0]\ : NOR3B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state_2\, B => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state_1\, C => 
        \USB_FIFO_IF_0/sample_FIFO_0_EMPTY\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[31]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[31]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[31]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[31]\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA_1_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_IRE_OB_EB
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[25]_net_1\, 
        E => USB_OE_n_pin_c, ICE => 
        \USB_FIFO_IF_0/USB_IF_0/READ_FROM_USB_REG_0_sqmuxa\, ICLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, YIN => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.1.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.1.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.1.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[1]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[13]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[13]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[13]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[13]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNIED33[2]\ : NOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[2]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[4]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_oe_3_2\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_34\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[13]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[12]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[14]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[12]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[13]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[14]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[12]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[12]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[12]\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[12]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_STORE_SAMPLES/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/sample_FIFO_0_AEMPTY\, B => 
        \USB_FIFO_IF_0/s_STORE_SAMPLES\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_STORE_SAMPLES/Y\);
    
    \SAMPLE_APB_0/s_REG_FULL_RNI76EK\ : NOR3A
      port map(A => USB_FIFO_IF_0_FROM_USB_RDY, B => 
        \SAMPLE_APB_0/s_REG_FULL\, C => 
        SAMPLE_APB_0_READ_SUCCESSFUL, Y => 
        \SAMPLE_APB_0/s_REG_FULL_0_sqmuxa\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNI54L4[2]\ : NOR3A
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[4]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[3]\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[2]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state_2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNIU29D[1]\ : 
        NOR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[3]_net_1\, B
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[1]_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNO[2]\ : OA1
      port map(A => \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un27_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[3]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[2]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[23]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[23]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[15]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[23]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[7]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c6\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n7\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]\);
    
    \AFE_IF_0/g_DDR_INTERFACE.7.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \AFE_IF_0/g_DDR_INTERFACE.7.u_BIBUF_LVCMOS33/U0/NET1\, E
         => \AFE_IF_0/g_DDR_INTERFACE.7.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \AFE_IF_0/g_DDR_INTERFACE.7.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => DATA_pin(7));
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[20]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[20]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[20]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[22]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[22]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[22]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[31]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[31]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[31]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n17\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]/Y\);
    
    \StreamingReceiver_RF_MSS_0/MSS_SPI_1_CLK\ : IOPAD_BI
      port map(D => \StreamingReceiver_RF_MSS_0/MSS_SPI_1_CLK_D\, 
        E => \StreamingReceiver_RF_MSS_0/MSS_SPI_1_SS_E\, Y => 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_CLK_Y\, PAD => 
        SPI_1_CLK);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[7]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[7]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[7]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[7]\);
    
    \SAMPLE_APB_0/PRDATA_1_RNO[3]\ : NOR3B
      port map(A => N_42, B => \SAMPLE_APB_0/REG[3]_net_1\, C => 
        \SAMPLE_APB_0/un8_pwrite_i_0\, Y => \SAMPLE_APB_0/N_11\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[8]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n8\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[8]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[8]/Y\);
    
    \StreamingReceiver_RF_MSS_0/MSS_SPI_1_DI\ : IOPAD_IN
      port map(PAD => SPI_1_DI, Y => 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_DI_Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n15\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[15]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]/Y\, CLK => 
        \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[30]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[30]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[30]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[10]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c8\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[10]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n10\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_6\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[29]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[28]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[30]INT_NET\, 
        PIN1INT => OPEN, PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[29]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[30]INT_NET\);
    
    \USB_FIFO_IF_0/sample_FIFO_0/_FIFOBLOCK[1]_\ : FIFO4K18
      port map(AEVAL11 => GLMUXINT_GND, AEVAL10 => GLMUXINT_GND, 
        AEVAL9 => GLMUXINT_GND, AEVAL8 => PLLEN_VCC, AEVAL7 => 
        GLMUXINT_GND, AEVAL6 => GLMUXINT_GND, AEVAL5 => 
        GLMUXINT_GND, AEVAL4 => GLMUXINT_GND, AEVAL3 => 
        GLMUXINT_GND, AEVAL2 => GLMUXINT_GND, AEVAL1 => 
        GLMUXINT_GND, AEVAL0 => GLMUXINT_GND, AFVAL11 => 
        GLMUXINT_GND, AFVAL10 => PLLEN_VCC, AFVAL9 => PLLEN_VCC, 
        AFVAL8 => PLLEN_VCC, AFVAL7 => PLLEN_VCC, AFVAL6 => 
        PLLEN_VCC, AFVAL5 => PLLEN_VCC, AFVAL4 => GLMUXINT_GND, 
        AFVAL3 => GLMUXINT_GND, AFVAL2 => GLMUXINT_GND, AFVAL1
         => GLMUXINT_GND, AFVAL0 => GLMUXINT_GND, WD17 => 
        GLMUXINT_GND, WD16 => GLMUXINT_GND, WD15 => GLMUXINT_GND, 
        WD14 => GLMUXINT_GND, WD13 => AFE_IF_0_RX_Q9to9, WD12 => 
        \\\AFE_IF_0_RX_Q8to0_[8]\\\, WD11 => 
        \\\AFE_IF_0_RX_Q8to0_[7]\\\, WD10 => 
        \\\AFE_IF_0_RX_Q8to0_[6]\\\, WD9 => 
        \\\AFE_IF_0_RX_Q8to0_[5]\\\, WD8 => 
        \\\AFE_IF_0_RX_Q8to0_[4]\\\, WD7 => 
        \\\AFE_IF_0_RX_Q8to0_[3]\\\, WD6 => 
        \\\AFE_IF_0_RX_Q8to0_[2]\\\, WD5 => 
        \\\AFE_IF_0_RX_Q8to0_[1]\\\, WD4 => 
        \\\AFE_IF_0_RX_Q8to0_[0]\\\, WD3 => GLMUXINT_GND, WD2 => 
        GLMUXINT_GND, WD1 => GLMUXINT_GND, WD0 => GLMUXINT_GND, 
        WW0 => GLMUXINT_GND, WW1 => GLMUXINT_GND, WW2 => 
        PLLEN_VCC, RW0 => GLMUXINT_GND, RW1 => GLMUXINT_GND, RW2
         => PLLEN_VCC, RPIPE => GLMUXINT_GND, WEN => 
        \USB_FIFO_IF_0/sample_FIFO_0/WRITE_ENABLE_I\, REN => 
        \USB_FIFO_IF_0/sample_FIFO_0/READ_ENABLE_I\, WBLK => 
        GLMUXINT_GND, RBLK => GLMUXINT_GND, WCLK => 
        AFE2_CLK_pin_c, RCLK => 
        \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, RESET => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, ESTOP => 
        PLLEN_VCC, FSTOP => PLLEN_VCC, RD17 => OPEN, RD16 => OPEN, 
        RD15 => OPEN, RD14 => OPEN, RD13 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[31]\\\\\, RD12 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[30]\\\\\, RD11 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[29]\\\\\, RD10 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[28]\\\\\, RD9 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[27]\\\\\, RD8 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[26]\\\\\, RD7 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[25]\\\\\, RD6 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[24]\\\\\, RD5 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[23]\\\\\, RD4 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[22]\\\\\, RD3 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[21]\\\\\, RD2 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[20]\\\\\, RD1 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[19]\\\\\, RD0 => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[18]\\\\\, FULL => 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\FULLX_I[1]\\\\\, AFULL
         => OPEN, EMPTY => 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\EMPTYX_I[1]\\\\\, 
        AEMPTY => 
        \USB_FIFO_IF_0/sample_FIFO_0/Z\\\\AEMPTYX_I[1]\\\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[4]/U1\ : DFN1P0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[4]/Y\, CLK => 
        \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, PRE => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[4]\);
    
    \AFE_IF_0/s_tx_i[2]\ : DFN1C1
      port map(D => \AFE_IF_0/s_tx_q[2]\, CLK => AFE2_CLK_pin_c, 
        CLR => INV_2_Y, Q => \AFE_IF_0/s_tx_q[2]\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.5.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.5.u_BIBUF_LVCMOS33/U0/NET1\, 
        E => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.5.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.5.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => USB_DATA_pin(5));
    
    \SAMPLE_APB_0/PRDATA_1[8]\ : DFN1C0
      port map(D => \SAMPLE_APB_0/s_REG_FULL_1_sqmuxa\, CLK => 
        FAB_CLK, CLR => StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q
         => \\\CoreAPB3_0_APBmslave0_PRDATA_[8]\\\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_38\ : MSS_IF
      port map(PIN4 => N_27, PIN5 => N_25, PIN6 => PRDATA_6_i, 
        PIN1 => OPEN, PIN2 => OPEN, PIN3 => OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[5]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[4]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[6]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[4]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[5]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[6]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[28]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[28]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[28]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[30]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c29\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[30]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n30\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[16]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[16]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[8]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[16]\);
    
    \SAMPLE_APB_0/PRDATA_1_RNO[0]\ : OA1
      port map(A => \SAMPLE_APB_0/REG[0]_net_1\, B => 
        \SAMPLE_APB_0/un8_pwrite_i_0\, C => N_42, Y => 
        \SAMPLE_APB_0/N_35\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_40\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => PRDATA_10_i, PIN6
         => PRDATA_10_i, PIN1 => OPEN, PIN2 => OPEN, PIN3 => OPEN, 
        PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[11]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[10]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[12]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[10]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[11]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[12]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR[1]\ : DFN1P0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR_3[1]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, PRE => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR[1]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[0]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[0]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNII8UJ[6]\ : 
        NOR3C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[5]_net_1\, B
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[6]_net_1\, C
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[0]_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_3\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_50\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[8]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[7]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[9]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[7]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[8]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[9]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNI7CO2[0]\ : 
        NOR3
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state_2\, B => 
        \USB_FIFO_IF_0/USB_IF_0/un5_s_temp_reg_state_0\, C => 
        \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state_5\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/un5_s_temp_reg_state\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[9]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[9]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[9]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[4]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[4]\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[4]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[21]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[2]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[2]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[2]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[31]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[31]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[31]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[6]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[6]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[6]\);
    
    \SAMPLE_APB_0/SMPL_RDY\ : DFN1C0
      port map(D => \SAMPLE_APB_0/s_REG_FULL_0_sqmuxa\, CLK => 
        FAB_CLK, CLR => StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q
         => SAMPLE_APB_0_SMPL_RDY);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[18]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n18\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[18]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[18]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNI9P23_0[0]\ : NOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_temp_reg_state_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[24]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[24]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[24]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[20]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c18\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[20]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n20\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_90\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[29]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[28]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPWDATA[30]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[28]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[29]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPRDATA[30]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[24]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[24]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[24]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[24]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[16]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[16]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[16]\);
    
    \USB_SIWU_N_pad/U0/U0\ : IOPAD_TRI
      port map(D => \USB_SIWU_N_pad/U0/NET1\, E => 
        \USB_SIWU_N_pad/U0/NET2\, PAD => USB_SIWU_N);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[2]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[2]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[2]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[30]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[30]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[30]\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[30]\);
    
    \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_I_38\ : 
        NOR3C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[2]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[3]_net_1\, 
        C => \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_1[0]\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_2[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[5]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[5]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[5]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[5]\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA_6_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_IRE_OB_EB
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[30]_net_1\, 
        E => USB_OE_n_pin_c, ICE => 
        \USB_FIFO_IF_0/USB_IF_0/READ_FROM_USB_REG_0_sqmuxa\, ICLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, YIN => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.6.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.6.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.6.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[6]\\\);
    
    \SAMPLE_APB_0/s_READ_SUCCESSFUL/U1\ : DFN1C0
      port map(D => \SAMPLE_APB_0/s_READ_SUCCESSFUL/Y\, CLK => 
        FAB_CLK, CLR => StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q
         => SAMPLE_APB_0_READ_SUCCESSFUL);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[0]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[0]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[0]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[6]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[6]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[6]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[6]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[10]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[10]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[10]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[1]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[1]\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[1]_net_1\);
    
    \SAMPLE_APB_0/REG[1]\ : DFN1E1
      port map(D => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[1]\\\, 
        CLK => FAB_CLK, E => \SAMPLE_APB_0/REG_0_sqmuxa\, Q => 
        \SAMPLE_APB_0/REG[1]_net_1\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_46\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, PIN3 => OPEN, 
        PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[28]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[27]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[29]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[5]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/M2FRESETnINT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSINT[6]INT_NET\);
    
    \AFE2_T_R_n_pin_pad/U0/U1\ : IOTRI_ORP_EB
      port map(D => GLMUXINT_GND, PRE => INV_2_Y, E => PLLEN_VCC, 
        OCLK => AFE2_CLK_pin_c, DOUT => 
        \AFE2_T_R_n_pin_pad/U0/NET1\, EOUT => 
        \AFE2_T_R_n_pin_pad/U0/NET2\);
    
    \USB_RD_n_pin_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => USB_RD_n_pin_c, E => PLLEN_VCC, DOUT => 
        \USB_RD_n_pin_pad/U0/NET1\, EOUT => 
        \USB_RD_n_pin_pad/U0/NET2\);
    
    \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_I_31\ : 
        NOR2B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_TMP[0]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[1]_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_1[0]\);
    
    \SAMPLE_APB_0/s_REG_FULL_RNO\ : AO1A
      port map(A => \SAMPLE_APB_0/un8_pwrite_i_0\, B => N_42, C
         => \SAMPLE_APB_0/s_REG_FULL_0_sqmuxa\, Y => 
        \SAMPLE_APB_0/N_7\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[21]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[21]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[21]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[21]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[8]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[8]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[8]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[8]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[11]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[11]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[3]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[11]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_56\ : MSS_IF
      port map(PIN4 => PRDATA_10_i, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[26]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[25]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[27]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[25]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[26]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[27]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNI238B2[24]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[23]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c22\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[24]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c24\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[3]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[3]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[3]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[3]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[16]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[16]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[16]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[16]/Y\);
    
    \AFE_IF_0/s_tx_i[7]\ : DFN1C1
      port map(D => \AFE_IF_0/s_tx_q[7]\, CLK => AFE2_CLK_pin_c, 
        CLR => INV_2_Y, Q => \AFE_IF_0/s_tx_q[7]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[10]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[10]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[10]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[10]\);
    
    \CoreAPB3_0/CAPB3O1II/PRDATA_0_i\ : NOR3C
      port map(A => \CoreAPB3_0.CAPB3iool_1[0]\, B => 
        \CoreAPB3_0.CAPB3iool_2[0]\, C => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[0]\\\, Y => N_17);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNI0B9D[2]\ : 
        NOR2B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[2]_net_1\, B
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[4]_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_1\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_96\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => LD_c, PIN6 => 
        GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => OPEN, 
        PIN4INT => OPEN, PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[12]INT_NET\, 
        PIN6INT => OPEN, PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[12]INT_NET\, 
        PIN2INT => GLMUXINT_GND, PIN3INT => GLMUXINT_GND);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[12]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[12]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[12]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[6]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n6\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[6]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[6]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[19]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[19]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[19]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[22]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[22]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[22]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[22]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[22]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[22]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[22]\);
    
    \AFE_IF_0/g_DDR_INTERFACE.3.u_BIBUF_LVCMOS33/U0/U0\ : 
        IOPAD_BI
      port map(D => 
        \AFE_IF_0/g_DDR_INTERFACE.3.u_BIBUF_LVCMOS33/U0/NET1\, E
         => \AFE_IF_0/g_DDR_INTERFACE.3.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => 
        \AFE_IF_0/g_DDR_INTERFACE.3.u_BIBUF_LVCMOS33/U0/NET3\, 
        PAD => DATA_pin(3));
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[19]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[19]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[11]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[19]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[11]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[11]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[11]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNIN666_0[0]\ : OR3B
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[1]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_oe_3_2\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[0]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[4]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[4]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[4]\);
    
    \AFE_IF_0/s_tx_i[4]\ : DFN1C1
      port map(D => \AFE_IF_0/s_tx_q[4]\, CLK => AFE2_CLK_pin_c, 
        CLR => INV_2_Y, Q => \AFE_IF_0/s_tx_q[4]\);
    
    \AFE_IF_0/g_DDR_INTERFACE_7_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_ID_OD_EB
      port map(DR => \AFE_IF_0/s_tx_q[7]\, DF => 
        \AFE_IF_0/s_tx_q[7]\, CLR => INV_2_Y_0, E => GLMUXINT_GND, 
        ICLK => AFE2_CLK_pin_c, OCLK => AFE2_CLK_pin_c, YIN => 
        \AFE_IF_0/g_DDR_INTERFACE.7.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.7.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.7.u_BIBUF_LVCMOS33/U0/NET2\, YR
         => \\\AFE_IF_0_RX_Q8to0_[7]\\\, YF => 
        \\\AFE_IF_0_RX_I8to0_[7]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[2]\ : AX1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[0]_net_1\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[1]\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[2]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[19]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[19]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[19]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[19]\);
    
    \RXHP_pad/U0/U0\ : IOPAD_TRI
      port map(D => \RXHP_pad/U0/NET1\, E => \RXHP_pad/U0/NET2\, 
        PAD => RXHP);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNO_0[0]\ : 
        NOR2A
      port map(A => \USB_FIFO_IF_0/USB_IF_0/un5_s_temp_reg_state\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un27_s_temp_reg_state\, Y
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_0_sqmuxa_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[29]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[29]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[29]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[7]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[7]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[7]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[29]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[29]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[29]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[14]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n14\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[14]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[14]/Y\);
    
    \USB_OE_n_pin_pad/U0/U0\ : IOPAD_TRI
      port map(D => \USB_OE_n_pin_pad/U0/NET1\, E => 
        \USB_OE_n_pin_pad/U0/NET2\, PAD => USB_OE_n_pin);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n9\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]/Y\);
    
    \CoreAPB3_0/CAPB3O1II/PRDATA_6_i\ : NOR3C
      port map(A => \CoreAPB3_0.CAPB3iool_1[0]\, B => 
        \CoreAPB3_0.CAPB3iool_2[0]\, C => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[6]\\\, Y => PRDATA_6_i);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA_2_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_IRE_OB_EB
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[26]_net_1\, 
        E => USB_OE_n_pin_c, ICE => 
        \USB_FIFO_IF_0/USB_IF_0/READ_FROM_USB_REG_0_sqmuxa\, ICLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, YIN => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.2.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.2.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.2.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[2]\\\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_82\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[20]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[21]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[22]INT_NET\);
    
    \AFE2_T_R_n_pin_pad/U0/U0\ : IOPAD_TRI
      port map(D => \AFE2_T_R_n_pin_pad/U0/NET1\, E => 
        \AFE2_T_R_n_pin_pad/U0/NET2\, PAD => AFE2_T_R_n_pin);
    
    \USB_RXF_n_pin_pad/U0/U0\ : IOPAD_IN
      port map(PAD => USB_RXF_n_pin, Y => 
        \USB_RXF_n_pin_pad/U0/NET1\);
    
    \USB_FIFO_IF_0/USB_IF_0/un2_s_from_adc_smpl_cntr_I_4\ : INV
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[0]_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/I_4\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[23]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[23]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[23]_net_1\);
    
    \AFE_IF_0/s_tx_i[9]\ : DFN1P1
      port map(D => \AFE_IF_0/s_tx_q[9]\, CLK => AFE2_CLK_pin_c, 
        PRE => INV_2_Y, Q => \AFE_IF_0/s_tx_q[9]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n27\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[27]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL_RNIO4MF\ : 
        OR3
      port map(A => SAMPLE_APB_0_READ_SUCCESSFUL, B => 
        USB_RXF_n_pin_c, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/un5_s_read_from_usb_reg_full_1\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_85\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[29]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[30]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[31]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[18]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[18]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[18]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin\ : DFN1P0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_oe_3_i\, CLK => 
        \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, PRE => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        USB_WR_n_pin_c);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n25\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[7]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[7]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[7]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n11\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[11]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNIGMGE1[1]\ : 
        OR3C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_2\, B => 
        \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/un6_from_adc_smpl_rdy_3\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\);
    
    \SAMPLE_APB_0/PRDATA_1_RNO[2]\ : OA1
      port map(A => \SAMPLE_APB_0/REG[2]_net_1\, B => 
        \SAMPLE_APB_0/un8_pwrite_i_0\, C => N_42, Y => 
        \SAMPLE_APB_0/N_37\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR[0]\ : DFN1P0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_partial_sum_0[0]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, PRE => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR[0]_net_1\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA_4_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_IRE_OB_EB
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[28]_net_1\, 
        E => USB_OE_n_pin_c, ICE => 
        \USB_FIFO_IF_0/USB_IF_0/READ_FROM_USB_REG_0_sqmuxa\, ICLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, YIN => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.4.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.4.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.4.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[4]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[0]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[0]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[0]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa_0\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[0]/Y\);
    
    \SAMPLE_APB_0/PRDATA_1[5]\ : DFN1C0
      port map(D => \SAMPLE_APB_0/N_13\, CLK => FAB_CLK, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[5]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNI14P[3]\ : 
        OR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[3]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[2]_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/un8_s_temp_reg_state_2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNO[6]\ : XA1
      port map(A => \USB_FIFO_IF_0/USB_IF_0/N_2\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[6]_net_1\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[6]\);
    
    \SAMPLE_APB_0/REG[0]\ : DFN1E1
      port map(D => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[0]\\\, 
        CLK => FAB_CLK, E => \SAMPLE_APB_0/REG_0_sqmuxa\, Q => 
        \SAMPLE_APB_0/REG[0]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[1]\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[1]\, CLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[1]_net_1\);
    
    \RXHP_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \StreamingReceiver_RF_MSS_0/MSSINT_GPO_14_A\, 
        E => PLLEN_VCC, DOUT => \RXHP_pad/U0/NET1\, EOUT => 
        \RXHP_pad/U0/NET2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[6]\ : OR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[6]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[6]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[18]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[18]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[18]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_76\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => OPEN, PIN5INT => OPEN, PIN6INT => OPEN, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[2]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[3]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/ACEFLAGS[4]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[15]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[15]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[15]_net_1\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_61\ : MSS_IF
      port map(PIN4 => SAMPLE_APB_0_SMPL_RDY, PIN5 => PLLEN_VCC, 
        PIN6 => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3
         => OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/DMAREADY[0]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/F2MRESETnINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/DMAREADY[1]INT_NET\, 
        PIN1INT => GLMUXINT_GND, PIN2INT => GLMUXINT_GND, PIN3INT
         => GLMUXINT_GND);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[7]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[7]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[7]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_37\ : MSS_IF
      port map(PIN4 => N_21, PIN5 => N_19, PIN6 => N_23, PIN1 => 
        OPEN, PIN2 => OPEN, PIN3 => OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[2]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[1]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPRDATA[3]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[1]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[2]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPWDATA[3]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[18]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[18]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[18]\);
    
    \USB_FIFO_IF_0/USB_IF_0/FROM_USB_RDY_RNO\ : NOR2A
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_READ_FROM_USB_REG_FULL\, B => 
        SAMPLE_APB_0_READ_SUCCESSFUL, Y => 
        \USB_FIFO_IF_0/USB_IF_0/FROM_USB_RDY_2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNI14P[5]\ : 
        NOR2B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[5]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[0]_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/un45_s_temp_reg_state_2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_RNO[1]\ : NOR2B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un27_s_temp_reg_state\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE[2]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_STATE_8[1]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[13]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[13]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[13]\);
    
    \USB_TXE_n_pin_pad/U0/U1\ : IOIN_IB
      port map(YIN => \USB_TXE_n_pin_pad/U0/NET1\, Y => 
        USB_TXE_n_pin_c);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[18]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[18]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[18]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[18]\);
    
    
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA_3_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_IRE_OB_EB
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[27]_net_1\, 
        E => USB_OE_n_pin_c, ICE => 
        \USB_FIFO_IF_0/USB_IF_0/READ_FROM_USB_REG_0_sqmuxa\, ICLK
         => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, YIN => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.3.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.3.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \USB_FIFO_IF_0/USB_IF_0/g_USB_SYNC_FIFO_DATA.3.u_BIBUF_LVCMOS33/U0/NET2\, 
        Y => \\\USB_FIFO_IF_0_READ_FROM_USB_REG_[3]\\\);
    
    \ANTSEL_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \StreamingReceiver_RF_MSS_0/MSSINT_GPO_15_A\, 
        E => PLLEN_VCC, DOUT => \ANTSEL_pad/U0/NET1\, EOUT => 
        \ANTSEL_pad/U0/NET2\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[2]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[2]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[2]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[2]\);
    
    \AFE_IF_0/s_tx_i[6]\ : DFN1C1
      port map(D => \AFE_IF_0/s_tx_q[6]\, CLK => AFE2_CLK_pin_c, 
        CLR => INV_2_Y, Q => \AFE_IF_0/s_tx_q[6]\);
    
    \CoreAPB3_0/CAPB3iool_1[0]\ : NOR2
      port map(A => \\\CoreAPB3_0_APBmslave0_PADDR_[9]\\\, B => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[10]\\\, Y => 
        \CoreAPB3_0.CAPB3iool_1[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[31]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[31]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[23]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[31]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[26]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[26]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[26]_net_1\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_33\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[9]\\\, PIN2 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[10]\\\, PIN3 => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[11]\\\, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[10]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[9]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/FABPADDR[11]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[9]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[10]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/MSSPADDR[11]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNITBEH2[26]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[25]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c24\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[26]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c26\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[0]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[0]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[0]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[28]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n28\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[28]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[28]/Y\);
    
    \LD_pad/U0/U1\ : IOIN_IB
      port map(YIN => \LD_pad/U0/NET1\, Y => LD_c);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNO[1]\ : XA1
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[0]_net_1\, B
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[1]_net_1\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[1]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[13]\ : AO1D
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state_0\, B => 
        \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[13]\\\\\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[13]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[13]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[12]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n12\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[12]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[12]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[25]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[25]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[17]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[25]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[20]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[20]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[20]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[23]/U1\ : DFN1C0
      port map(D => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[23]/Y\, CLK
         => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[23]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[19]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c18\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[19]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n19\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_RNO[6]\ : XA1
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR[6]_net_1\, 
        B => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_g_array_11[0]\, C
         => 
        \USB_FIFO_IF_0/USB_IF_0/un1_s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_net_1\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_8[6]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_64\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL4ENINT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL3ENINT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL5ENINT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL3INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL4INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/LVTTL5INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNIQPGN\ : OR2A
      port map(A => USB_WR_n_pin_c, B => 
        \USB_FIFO_IF_0/USB_IF_0/un5_s_read_from_usb_reg_full_1\, 
        Y => 
        \USB_FIFO_IF_0/USB_IF_0/un5_s_read_from_usb_reg_full\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[9]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[9]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[1]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[9]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[1]\ : AO1B
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[1]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[1]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[1]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[2]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n2\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[2]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[2]/Y\);
    
    \SAMPLE_APB_0/s_REG_FULL/U0\ : MX2
      port map(A => \SAMPLE_APB_0/s_REG_FULL\, B => 
        \SAMPLE_APB_0/s_REG_FULL_0_sqmuxa\, S => 
        \SAMPLE_APB_0/N_7\, Y => \SAMPLE_APB_0/s_REG_FULL/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNIUGTP[8]\ : NOR3C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[7]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c6\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[8]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c8\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_RNO[2]\ : XA1
      port map(A => \USB_FIFO_IF_0/USB_IF_0/N_6\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[2]_net_1\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR_3[2]\);
    
    \CoreAPB3_0/CAPB3O1II/PRDATA_4_i\ : NOR3C
      port map(A => \CoreAPB3_0.CAPB3iool_1[0]\, B => 
        \CoreAPB3_0.CAPB3iool_2[0]\, C => 
        \\\CoreAPB3_0_APBmslave0_PRDATA_[4]\\\, Y => N_25);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[4]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[4]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[4]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[4]\);
    
    \StreamingReceiver_RF_MSS_0/MSS_SPI_1_SS\ : IOPAD_BI
      port map(D => \StreamingReceiver_RF_MSS_0/MSS_SPI_1_SS_D\, 
        E => \StreamingReceiver_RF_MSS_0/MSS_SPI_1_SS_E\, Y => 
        \StreamingReceiver_RF_MSS_0/MSS_SPI_1_SS_Y\, PAD => 
        SPI_1_SS);
    
    INV_0 : INV
      port map(A => INV_0_Y, Y => AFE_IF_0_RX_I9to9);
    
    \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR_3_I_10\ : AX1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR[0]_net_1\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_USB_WR_n_pin_RNI120C_net_1\, 
        C => 
        \USB_FIFO_IF_0/USB_IF_0/DWACT_ADD_CI_0_partial_sum[1]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_USB_SMPL_BYTE_CNTR_3[1]\);
    
    \AFE_IF_0/s_tx_i[5]\ : DFN1C1
      port map(D => \AFE_IF_0/s_tx_q[5]\, CLK => AFE2_CLK_pin_c, 
        CLR => INV_2_Y, Q => \AFE_IF_0/s_tx_q[5]\);
    
    \USB_FIFO_IF_0/USB_IF_0/un2_s_from_adc_smpl_cntr_I_13\ : AND3
      port map(A => \USB_FIFO_IF_0/USB_IF_0/DWACT_FINC_E[0]\, B
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[3]_net_1\, C
         => 
        \USB_FIFO_IF_0/USB_IF_0/s_FROM_ADC_SMPL_CNTR[4]_net_1\, Y
         => \USB_FIFO_IF_0/USB_IF_0/N_3\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[20]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[20]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[20]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]/U0\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n5\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTRe\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[5]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_0[20]\ : OA1C
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_2_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[20]_net_1\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[20]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[20]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[30]/U0\ : MX2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[30]\, B => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[30]\, S => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_0_sqmuxa\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[30]/Y\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[13]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv[13]\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[5]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[13]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[19]\ : DFN1E1
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[19]\, 
        CLK => \USB_FIFO_IF_0/USB_IF_0_USB_CLK_OUT\, E => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[19]_net_1\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO[28]\ : MX2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6[28]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG[20]_net_1\, S => 
        \USB_FIFO_IF_0/USB_IF_0/un1_usb_txe_n_pin_0\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_9[28]\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]/U1\ : DFN1C0
      port map(D => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]/Y\, 
        CLK => AFE2_CLK_pin_c, CLR => 
        StreamingReceiver_RF_MSS_0_M2F_RESET_N, Q => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[9]\);
    
    \AFE_IF_0/g_DDR_INTERFACE_3_u_BIBUF_LVCMOS33/U0/U1\ : 
        IOBI_ID_OD_EB
      port map(DR => \AFE_IF_0/s_tx_q[3]\, DF => 
        \AFE_IF_0/s_tx_q[3]\, CLR => INV_2_Y_0, E => GLMUXINT_GND, 
        ICLK => AFE2_CLK_pin_c, OCLK => AFE2_CLK_pin_c, YIN => 
        \AFE_IF_0/g_DDR_INTERFACE.3.u_BIBUF_LVCMOS33/U0/NET3\, 
        DOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.3.u_BIBUF_LVCMOS33/U0/NET1\, 
        EOUT => 
        \AFE_IF_0/g_DDR_INTERFACE.3.u_BIBUF_LVCMOS33/U0/NET2\, YR
         => \\\AFE_IF_0_RX_Q8to0_[3]\\\, YF => 
        \\\AFE_IF_0_RX_I8to0_[3]\\\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[18]\ : AX1C
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[17]\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c16\, C => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[18]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n18\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_1[26]\ : OA1A
      port map(A => \USB_FIFO_IF_0/Z\\\\sample_FIFO_0_Q_[26]\\\\\, 
        B => \USB_FIFO_IF_0/USB_IF_0/un40_s_temp_reg_state\, C
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_m[26]\, 
        Y => \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_6_iv_0[26]\);
    
    \SAMPLE_APB_0/s_READ_SUCCESSFUL_RNIMFI3\ : INV
      port map(A => SAMPLE_APB_0_READ_SUCCESSFUL, Y => 
        SAMPLE_APB_0_READ_SUCCESSFUL_i);
    
    \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_RNO[29]\ : XOR2
      port map(A => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_c28\, B
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR[29]\, Y => 
        \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CNTR_n29\);
    
    \SAMPLE_APB_0/p_REG_READ.un8_pwrite_1\ : NOR2
      port map(A => \\\CoreAPB3_0_APBmslave0_PADDR_[2]\\\, B => 
        \\\CoreAPB3_0_APBmslave0_PADDR_[3]\\\, Y => 
        \SAMPLE_APB_0/un8_pwrite_1\);
    
    \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/U_4\ : MSS_IF
      port map(PIN4 => GLMUXINT_GND, PIN5 => GLMUXINT_GND, PIN6
         => GLMUXINT_GND, PIN1 => OPEN, PIN2 => OPEN, PIN3 => 
        OPEN, PIN4INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[23]INT_NET\, 
        PIN5INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[22]INT_NET\, 
        PIN6INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPI[24]INT_NET\, 
        PIN1INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[22]INT_NET\, 
        PIN2INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[23]INT_NET\, 
        PIN3INT => 
        \StreamingReceiver_RF_MSS_0/MSS_ADLIB_INST/GPO[24]INT_NET\);
    
    \USB_FIFO_IF_0/USB_IF_0/s_TEMP_REG_RNO_2[29]\ : NOR2
      port map(A => 
        \USB_FIFO_IF_0/USB_IF_0/s_TO_TEMPREG_SMPL_CNTR_1_sqmuxa_1_0\, 
        B => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR[29]\, Y
         => \USB_FIFO_IF_0/USB_IF_0/s_FRAME_CURRENT_CNTR_i_m[29]\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
