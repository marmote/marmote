----------------------------------------------------------------------
-- Created by SmartDesign Mon Mar 04 18:43:44 2013
-- Version: 10.1 SP3 10.1.3.1
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion;
use smartfusion.all;
----------------------------------------------------------------------
-- StreamingReceiver_RF_MSS entity declaration
----------------------------------------------------------------------
entity StreamingReceiver_RF_MSS is
    -- Port list
    port(
        -- Inputs
        F2M_GPI_12  : in    std_logic;
        FABINT      : in    std_logic;
        MAINXIN     : in    std_logic;
        MSSPRDATA   : in    std_logic_vector(31 downto 0);
        MSSPREADY   : in    std_logic;
        MSSPSLVERR  : in    std_logic;
        MSS_RESET_N : in    std_logic;
        SPI_1_DI    : in    std_logic;
        -- Outputs
        FAB_CLK     : out   std_logic;
        GLB         : out   std_logic;
        GLC         : out   std_logic;
        GPIO_28_OUT : out   std_logic;
        M2F_GPO_13  : out   std_logic;
        M2F_GPO_14  : out   std_logic;
        M2F_GPO_15  : out   std_logic;
        M2F_RESET_N : out   std_logic;
        MSSPADDR    : out   std_logic_vector(19 downto 0);
        MSSPENABLE  : out   std_logic;
        MSSPSEL     : out   std_logic;
        MSSPWDATA   : out   std_logic_vector(31 downto 0);
        MSSPWRITE   : out   std_logic;
        SPI_1_DO    : out   std_logic;
        -- Inouts
        SPI_1_CLK   : inout std_logic;
        SPI_1_SS    : inout std_logic
        );
end StreamingReceiver_RF_MSS;
----------------------------------------------------------------------
-- StreamingReceiver_RF_MSS architecture body
----------------------------------------------------------------------
architecture RTL of StreamingReceiver_RF_MSS is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- MSS_APB
component MSS_APB
    generic( 
        ACT_CONFIG : integer := 0 ;
        ACT_FCLK   : integer := 0 ;
        ACT_DIE    : string  := "" ;
        ACT_PKG    : string  := "" 
        );
    -- Port list
    port(
        -- Inputs
        ABPS0          : in  std_logic;
        ABPS1          : in  std_logic;
        ABPS10         : in  std_logic;
        ABPS11         : in  std_logic;
        ABPS2          : in  std_logic;
        ABPS3          : in  std_logic;
        ABPS4          : in  std_logic;
        ABPS5          : in  std_logic;
        ABPS6          : in  std_logic;
        ABPS7          : in  std_logic;
        ABPS8          : in  std_logic;
        ABPS9          : in  std_logic;
        ADC0           : in  std_logic;
        ADC1           : in  std_logic;
        ADC10          : in  std_logic;
        ADC11          : in  std_logic;
        ADC2           : in  std_logic;
        ADC3           : in  std_logic;
        ADC4           : in  std_logic;
        ADC5           : in  std_logic;
        ADC6           : in  std_logic;
        ADC7           : in  std_logic;
        ADC8           : in  std_logic;
        ADC9           : in  std_logic;
        CALIBIN        : in  std_logic;
        CM0            : in  std_logic;
        CM1            : in  std_logic;
        CM2            : in  std_logic;
        CM3            : in  std_logic;
        CM4            : in  std_logic;
        CM5            : in  std_logic;
        DMAREADY       : in  std_logic_vector(1 downto 0);
        EMCCLKRTN      : in  std_logic;
        EMCRDB         : in  std_logic_vector(15 downto 0);
        F2MRESETn      : in  std_logic;
        FABACETRIG     : in  std_logic;
        FABINT         : in  std_logic;
        FABPADDR       : in  std_logic_vector(31 downto 0);
        FABPENABLE     : in  std_logic;
        FABPSEL        : in  std_logic;
        FABPWDATA      : in  std_logic_vector(31 downto 0);
        FABPWRITE      : in  std_logic;
        FABSDD0CLK     : in  std_logic;
        FABSDD0D       : in  std_logic;
        FABSDD1CLK     : in  std_logic;
        FABSDD1D       : in  std_logic;
        FABSDD2CLK     : in  std_logic;
        FABSDD2D       : in  std_logic;
        FCLK           : in  std_logic;
        GNDTM0         : in  std_logic;
        GNDTM1         : in  std_logic;
        GNDTM2         : in  std_logic;
        GNDVAREF       : in  std_logic;
        GPI            : in  std_logic_vector(31 downto 0);
        I2C0BCLK       : in  std_logic;
        I2C0SCLI       : in  std_logic;
        I2C0SDAI       : in  std_logic;
        I2C0SMBALERTNI : in  std_logic;
        I2C0SMBUSNI    : in  std_logic;
        I2C1BCLK       : in  std_logic;
        I2C1SCLI       : in  std_logic;
        I2C1SDAI       : in  std_logic;
        I2C1SMBALERTNI : in  std_logic;
        I2C1SMBUSNI    : in  std_logic;
        LVTTL0EN       : in  std_logic;
        LVTTL10EN      : in  std_logic;
        LVTTL11EN      : in  std_logic;
        LVTTL1EN       : in  std_logic;
        LVTTL2EN       : in  std_logic;
        LVTTL3EN       : in  std_logic;
        LVTTL4EN       : in  std_logic;
        LVTTL5EN       : in  std_logic;
        LVTTL6EN       : in  std_logic;
        LVTTL7EN       : in  std_logic;
        LVTTL8EN       : in  std_logic;
        LVTTL9EN       : in  std_logic;
        MACCLK         : in  std_logic;
        MACCLKCCC      : in  std_logic;
        MACCRSDV       : in  std_logic;
        MACF2MCRSDV    : in  std_logic;
        MACF2MMDI      : in  std_logic;
        MACF2MRXD      : in  std_logic_vector(1 downto 0);
        MACF2MRXER     : in  std_logic;
        MACMDI         : in  std_logic;
        MACRXD         : in  std_logic_vector(1 downto 0);
        MACRXER        : in  std_logic;
        MSSPRDATA      : in  std_logic_vector(31 downto 0);
        MSSPREADY      : in  std_logic;
        MSSPSLVERR     : in  std_logic;
        MSSRESETn      : in  std_logic;
        PLLLOCK        : in  std_logic;
        PUn            : in  std_logic;
        RCOSC          : in  std_logic;
        RXEV           : in  std_logic;
        SPI0CLKI       : in  std_logic;
        SPI0DI         : in  std_logic;
        SPI0SSI        : in  std_logic;
        SPI1CLKI       : in  std_logic;
        SPI1DI         : in  std_logic;
        SPI1SSI        : in  std_logic;
        SYNCCLKFDBK    : in  std_logic;
        TM0            : in  std_logic;
        TM1            : in  std_logic;
        TM2            : in  std_logic;
        TM3            : in  std_logic;
        TM4            : in  std_logic;
        TM5            : in  std_logic;
        UART0CTSn      : in  std_logic;
        UART0DCDn      : in  std_logic;
        UART0DSRn      : in  std_logic;
        UART0RIn       : in  std_logic;
        UART0RXD       : in  std_logic;
        UART1CTSn      : in  std_logic;
        UART1DCDn      : in  std_logic;
        UART1DSRn      : in  std_logic;
        UART1RIn       : in  std_logic;
        UART1RXD       : in  std_logic;
        VAREF0         : in  std_logic;
        VAREF1         : in  std_logic;
        VAREF2         : in  std_logic;
        VRON           : in  std_logic;
        -- Outputs
        ACEFLAGS       : out std_logic_vector(31 downto 0);
        CALIBOUT       : out std_logic;
        CMP0           : out std_logic;
        CMP1           : out std_logic;
        CMP10          : out std_logic;
        CMP11          : out std_logic;
        CMP2           : out std_logic;
        CMP3           : out std_logic;
        CMP4           : out std_logic;
        CMP5           : out std_logic;
        CMP6           : out std_logic;
        CMP7           : out std_logic;
        CMP8           : out std_logic;
        CMP9           : out std_logic;
        DEEPSLEEP      : out std_logic;
        EMCAB          : out std_logic_vector(25 downto 0);
        EMCBYTEN       : out std_logic_vector(1 downto 0);
        EMCCLK         : out std_logic;
        EMCCS0n        : out std_logic;
        EMCCS1n        : out std_logic;
        EMCDBOE        : out std_logic;
        EMCOEN0n       : out std_logic;
        EMCOEN1n       : out std_logic;
        EMCRWn         : out std_logic;
        EMCWDB         : out std_logic_vector(15 downto 0);
        FABPRDATA      : out std_logic_vector(31 downto 0);
        FABPREADY      : out std_logic;
        FABPSLVERR     : out std_logic;
        GPO            : out std_logic_vector(31 downto 0);
        GPOE           : out std_logic_vector(31 downto 0);
        I2C0SCLO       : out std_logic;
        I2C0SDAO       : out std_logic;
        I2C0SMBALERTNO : out std_logic;
        I2C0SMBUSNO    : out std_logic;
        I2C1SCLO       : out std_logic;
        I2C1SDAO       : out std_logic;
        I2C1SMBALERTNO : out std_logic;
        I2C1SMBUSNO    : out std_logic;
        LVTTL0         : out std_logic;
        LVTTL1         : out std_logic;
        LVTTL10        : out std_logic;
        LVTTL11        : out std_logic;
        LVTTL2         : out std_logic;
        LVTTL3         : out std_logic;
        LVTTL4         : out std_logic;
        LVTTL5         : out std_logic;
        LVTTL6         : out std_logic;
        LVTTL7         : out std_logic;
        LVTTL8         : out std_logic;
        LVTTL9         : out std_logic;
        M2FRESETn      : out std_logic;
        MACM2FMDC      : out std_logic;
        MACM2FMDEN     : out std_logic;
        MACM2FMDO      : out std_logic;
        MACM2FTXD      : out std_logic_vector(1 downto 0);
        MACM2FTXEN     : out std_logic;
        MACMDC         : out std_logic;
        MACMDEN        : out std_logic;
        MACMDO         : out std_logic;
        MACTXD         : out std_logic_vector(1 downto 0);
        MACTXEN        : out std_logic;
        MSSINT         : out std_logic_vector(7 downto 0);
        MSSPADDR       : out std_logic_vector(19 downto 0);
        MSSPENABLE     : out std_logic;
        MSSPSEL        : out std_logic;
        MSSPWDATA      : out std_logic_vector(31 downto 0);
        MSSPWRITE      : out std_logic;
        PUFABn         : out std_logic;
        SDD0           : out std_logic;
        SDD1           : out std_logic;
        SDD2           : out std_logic;
        SLEEP          : out std_logic;
        SPI0CLKO       : out std_logic;
        SPI0DO         : out std_logic;
        SPI0DOE        : out std_logic;
        SPI0MODE       : out std_logic;
        SPI0SSO        : out std_logic_vector(7 downto 0);
        SPI1CLKO       : out std_logic;
        SPI1DO         : out std_logic;
        SPI1DOE        : out std_logic;
        SPI1MODE       : out std_logic;
        SPI1SSO        : out std_logic_vector(7 downto 0);
        TXEV           : out std_logic;
        UART0DTRn      : out std_logic;
        UART0RTSn      : out std_logic;
        UART0TXD       : out std_logic;
        UART1DTRn      : out std_logic;
        UART1RTSn      : out std_logic;
        UART1TXD       : out std_logic;
        VAREFOUT       : out std_logic;
        VCC15GOOD      : out std_logic;
        VCC33GOOD      : out std_logic;
        WDINT          : out std_logic
        );
end component;
-- StreamingReceiver_RF_MSS_tmp_MSS_CCC_0_MSS_CCC   -   Actel:SmartFusionMSS:MSS_CCC:2.0.106
component StreamingReceiver_RF_MSS_tmp_MSS_CCC_0_MSS_CCC
    -- Port list
    port(
        -- Inputs
        CLKA           : in  std_logic;
        CLKA_PAD       : in  std_logic;
        CLKA_PADN      : in  std_logic;
        CLKA_PADP      : in  std_logic;
        CLKB           : in  std_logic;
        CLKB_PAD       : in  std_logic;
        CLKB_PADN      : in  std_logic;
        CLKB_PADP      : in  std_logic;
        CLKC           : in  std_logic;
        CLKC_PAD       : in  std_logic;
        CLKC_PADN      : in  std_logic;
        CLKC_PADP      : in  std_logic;
        LPXIN          : in  std_logic;
        MAC_CLK        : in  std_logic;
        MAINXIN        : in  std_logic;
        -- Outputs
        FAB_CLK        : out std_logic;
        FAB_LOCK       : out std_logic;
        GLA            : out std_logic;
        GLA0           : out std_logic;
        GLB            : out std_logic;
        GLC            : out std_logic;
        LPXIN_CLKOUT   : out std_logic;
        MAC_CLK_CCC    : out std_logic;
        MAC_CLK_IO     : out std_logic;
        MAINXIN_CLKOUT : out std_logic;
        MSS_LOCK       : out std_logic;
        RCOSC_CLKOUT   : out std_logic;
        YB             : out std_logic;
        YC             : out std_logic
        );
end component;
-- OUTBUF_MSS
component OUTBUF_MSS
    generic( 
        ACT_CONFIG : integer := 0 ;
        ACT_PIN    : string  := "NA" 
        );
    -- Port list
    port(
        -- Inputs
        D   : in  std_logic;
        -- Outputs
        PAD : out std_logic
        );
end component;
-- INBUF_MSS
component INBUF_MSS
    generic( 
        ACT_CONFIG : integer := 0 ;
        ACT_PIN    : string  := "NA" 
        );
    -- Port list
    port(
        -- Inputs
        PAD : in  std_logic;
        -- Outputs
        Y   : out std_logic
        );
end component;
-- BIBUF_MSS
component BIBUF_MSS
    generic( 
        ACT_CONFIG : integer := 0 ;
        ACT_PIN    : string  := "NA" 
        );
    -- Port list
    port(
        -- Inputs
        D   : in    std_logic;
        E   : in    std_logic;
        -- Outputs
        Y   : out   std_logic;
        -- Inouts
        PAD : inout std_logic
        );
end component;
-- TRIBUFF_MSS
component TRIBUFF_MSS
    generic( 
        ACT_CONFIG : integer := 0 ;
        ACT_PIN    : string  := "NA" 
        );
    -- Port list
    port(
        -- Inputs
        D   : in  std_logic;
        E   : in  std_logic;
        -- Outputs
        PAD : out std_logic
        );
end component;
-- MSSINT
component MSSINT
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal GLB_net_0                        : std_logic;
signal GLC_net_0                        : std_logic;
signal GPIO_28_OUT_net_0                : std_logic;
signal MSS_ADLIB_INST_EMCCLK            : std_logic;
signal MSS_ADLIB_INST_FCLK              : std_logic;
signal MSS_ADLIB_INST_MACCLK            : std_logic;
signal MSS_ADLIB_INST_MACCLKCCC         : std_logic;
signal MSS_ADLIB_INST_PLLLOCK           : std_logic;
signal MSS_ADLIB_INST_SYNCCLKFDBK       : std_logic;
signal MSS_GPIO_0_GPIO_28_OUT_D         : std_logic_vector(28 to 28);
signal MSS_RESET_0_MSS_RESET_N_Y        : std_logic;
signal MSS_SPI_1_CLK_D                  : std_logic;
signal MSS_SPI_1_CLK_Y                  : std_logic;
signal MSS_SPI_1_DI_Y                   : std_logic;
signal MSS_SPI_1_DO_D                   : std_logic;
signal MSS_SPI_1_DO_E                   : std_logic;
signal MSS_SPI_1_SS_D                   : std_logic_vector(0 to 0);
signal MSS_SPI_1_SS_E                   : std_logic;
signal MSS_SPI_1_SS_Y                   : std_logic;
signal MSSINT_GPI_12_Y                  : std_logic;
signal MSSINT_GPO_13_A                  : std_logic_vector(13 to 13);
signal MSSINT_GPO_14_A                  : std_logic_vector(14 to 14);
signal MSSINT_GPO_15_A                  : std_logic_vector(15 to 15);
signal net_71                           : std_logic;
signal net_72                           : std_logic;
signal net_73                           : std_logic;
signal net_74                           : std_logic;
signal net_75_PADDR                     : std_logic_vector(19 downto 0);
signal net_75_PENABLE                   : std_logic;
signal net_75_PSELx                     : std_logic;
signal net_75_PWDATA                    : std_logic_vector(31 downto 0);
signal net_75_PWRITE                    : std_logic;
signal SPI_1_DO_net_0                   : std_logic;
signal net_75_PSELx_net_0               : std_logic;
signal net_75_PENABLE_net_0             : std_logic;
signal net_75_PWRITE_net_0              : std_logic;
signal net_73_net_0                     : std_logic;
signal net_72_net_0                     : std_logic;
signal net_71_net_0                     : std_logic;
signal net_74_net_0                     : std_logic;
signal GLB_net_1                        : std_logic;
signal MSS_ADLIB_INST_SYNCCLKFDBK_net_0 : std_logic;
signal GLC_net_1                        : std_logic;
signal net_75_PADDR_net_0               : std_logic_vector(19 downto 0);
signal net_75_PWDATA_net_0              : std_logic_vector(31 downto 0);
signal SPI_1_DO_net_1                   : std_logic;
signal GPIO_28_OUT_net_1                : std_logic;
signal GPI_net_0                        : std_logic_vector(31 downto 0);
signal GPO_net_0                        : std_logic_vector(31 downto 0);
signal SPI1SSO_net_0                    : std_logic_vector(7 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                          : std_logic;
signal VCC_net                          : std_logic;
signal DMAREADY_const_net_0             : std_logic_vector(1 downto 0);
signal MACF2MRXD_const_net_0            : std_logic_vector(1 downto 0);
signal MACRXD_const_net_0               : std_logic_vector(1 downto 0);
signal EMCRDB_const_net_0               : std_logic_vector(15 downto 0);
signal FABPADDR_const_net_0             : std_logic_vector(31 downto 0);
signal FABPWDATA_const_net_0            : std_logic_vector(31 downto 0);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net               <= '0';
 VCC_net               <= '1';
 DMAREADY_const_net_0  <= B"00";
 MACF2MRXD_const_net_0 <= B"00";
 MACRXD_const_net_0    <= B"00";
 EMCRDB_const_net_0    <= B"0000000000000000";
 FABPADDR_const_net_0  <= B"00000000000000000000000000000000";
 FABPWDATA_const_net_0 <= B"00000000000000000000000000000000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 net_75_PSELx_net_0               <= net_75_PSELx;
 MSSPSEL                          <= net_75_PSELx_net_0;
 net_75_PENABLE_net_0             <= net_75_PENABLE;
 MSSPENABLE                       <= net_75_PENABLE_net_0;
 net_75_PWRITE_net_0              <= net_75_PWRITE;
 MSSPWRITE                        <= net_75_PWRITE_net_0;
 net_73_net_0                     <= net_73;
 M2F_GPO_15                       <= net_73_net_0;
 net_72_net_0                     <= net_72;
 M2F_GPO_14                       <= net_72_net_0;
 net_71_net_0                     <= net_71;
 M2F_GPO_13                       <= net_71_net_0;
 net_74_net_0                     <= net_74;
 M2F_RESET_N                      <= net_74_net_0;
 GLB_net_1                        <= GLB_net_0;
 GLB                              <= GLB_net_1;
 MSS_ADLIB_INST_SYNCCLKFDBK_net_0 <= MSS_ADLIB_INST_SYNCCLKFDBK;
 FAB_CLK                          <= MSS_ADLIB_INST_SYNCCLKFDBK_net_0;
 GLC_net_1                        <= GLC_net_0;
 GLC                              <= GLC_net_1;
 net_75_PADDR_net_0               <= net_75_PADDR;
 MSSPADDR(19 downto 0)            <= net_75_PADDR_net_0;
 net_75_PWDATA_net_0              <= net_75_PWDATA;
 MSSPWDATA(31 downto 0)           <= net_75_PWDATA_net_0;
 SPI_1_DO_net_1                   <= SPI_1_DO_net_0;
 SPI_1_DO                         <= SPI_1_DO_net_1;
 GPIO_28_OUT_net_1                <= GPIO_28_OUT_net_0;
 GPIO_28_OUT                      <= GPIO_28_OUT_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 MSS_GPIO_0_GPIO_28_OUT_D(28) <= GPO_net_0(28);
 MSS_SPI_1_SS_D(0)            <= SPI1SSO_net_0(0);
 MSSINT_GPO_13_A(13)          <= GPO_net_0(13);
 MSSINT_GPO_14_A(14)          <= GPO_net_0(14);
 MSSINT_GPO_15_A(15)          <= GPO_net_0(15);
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 GPI_net_0 <= ( B"0000000000000000000" & MSSINT_GPI_12_Y & B"000000000000" );
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- MSS_ADLIB_INST
MSS_ADLIB_INST : MSS_APB
    generic map( 
        ACT_CONFIG => ( 0 ),
        ACT_DIE    => ( "IP6X5M2" ),
        ACT_FCLK   => ( 8000000 ),
        ACT_PKG    => ( "fg256" )
        )
    port map( 
        -- Inputs
        MSSPRDATA      => MSSPRDATA,
        MSSPREADY      => MSSPREADY,
        MSSPSLVERR     => MSSPSLVERR,
        FABPADDR       => FABPADDR_const_net_0, -- tied to X"0" from definition
        FABPWDATA      => FABPWDATA_const_net_0, -- tied to X"0" from definition
        FABPWRITE      => GND_net, -- tied to '0' from definition
        FABPSEL        => GND_net, -- tied to '0' from definition
        FABPENABLE     => GND_net, -- tied to '0' from definition
        SYNCCLKFDBK    => MSS_ADLIB_INST_SYNCCLKFDBK,
        CALIBIN        => GND_net, -- tied to '0' from definition
        FABINT         => FABINT,
        F2MRESETn      => VCC_net, -- tied to '1' from definition
        DMAREADY       => DMAREADY_const_net_0, -- tied to X"0" from definition
        RXEV           => GND_net, -- tied to '0' from definition
        VRON           => GND_net, -- tied to '0' from definition
        GPI            => GPI_net_0,
        UART0CTSn      => GND_net, -- tied to '0' from definition
        UART0DSRn      => GND_net, -- tied to '0' from definition
        UART0RIn       => GND_net, -- tied to '0' from definition
        UART0DCDn      => GND_net, -- tied to '0' from definition
        UART1CTSn      => GND_net, -- tied to '0' from definition
        UART1DSRn      => GND_net, -- tied to '0' from definition
        UART1RIn       => GND_net, -- tied to '0' from definition
        UART1DCDn      => GND_net, -- tied to '0' from definition
        I2C0SMBUSNI    => GND_net, -- tied to '0' from definition
        I2C0SMBALERTNI => GND_net, -- tied to '0' from definition
        I2C0BCLK       => GND_net, -- tied to '0' from definition
        I2C1SMBUSNI    => GND_net, -- tied to '0' from definition
        I2C1SMBALERTNI => GND_net, -- tied to '0' from definition
        I2C1BCLK       => GND_net, -- tied to '0' from definition
        MACF2MRXD      => MACF2MRXD_const_net_0, -- tied to X"0" from definition
        MACF2MCRSDV    => GND_net, -- tied to '0' from definition
        MACF2MRXER     => GND_net, -- tied to '0' from definition
        MACF2MMDI      => GND_net, -- tied to '0' from definition
        FABSDD0D       => GND_net, -- tied to '0' from definition
        FABSDD1D       => GND_net, -- tied to '0' from definition
        FABSDD2D       => GND_net, -- tied to '0' from definition
        FABSDD0CLK     => GND_net, -- tied to '0' from definition
        FABSDD1CLK     => GND_net, -- tied to '0' from definition
        FABSDD2CLK     => GND_net, -- tied to '0' from definition
        FABACETRIG     => GND_net, -- tied to '0' from definition
        LVTTL0EN       => GND_net, -- tied to '0' from definition
        LVTTL1EN       => GND_net, -- tied to '0' from definition
        LVTTL2EN       => GND_net, -- tied to '0' from definition
        LVTTL3EN       => GND_net, -- tied to '0' from definition
        LVTTL4EN       => GND_net, -- tied to '0' from definition
        LVTTL5EN       => GND_net, -- tied to '0' from definition
        LVTTL6EN       => GND_net, -- tied to '0' from definition
        LVTTL7EN       => GND_net, -- tied to '0' from definition
        LVTTL8EN       => GND_net, -- tied to '0' from definition
        LVTTL9EN       => GND_net, -- tied to '0' from definition
        LVTTL10EN      => GND_net, -- tied to '0' from definition
        LVTTL11EN      => GND_net, -- tied to '0' from definition
        FCLK           => MSS_ADLIB_INST_FCLK,
        MACCLKCCC      => MSS_ADLIB_INST_MACCLKCCC,
        RCOSC          => GND_net, -- tied to '0' from definition
        MACCLK         => MSS_ADLIB_INST_MACCLK,
        PLLLOCK        => MSS_ADLIB_INST_PLLLOCK,
        MSSRESETn      => MSS_RESET_0_MSS_RESET_N_Y,
        SPI0DI         => GND_net, -- tied to '0' from definition
        SPI0CLKI       => GND_net, -- tied to '0' from definition
        SPI0SSI        => GND_net, -- tied to '0' from definition
        UART0RXD       => GND_net, -- tied to '0' from definition
        I2C0SDAI       => GND_net, -- tied to '0' from definition
        I2C0SCLI       => GND_net, -- tied to '0' from definition
        SPI1DI         => MSS_SPI_1_DI_Y,
        SPI1CLKI       => MSS_SPI_1_CLK_Y,
        SPI1SSI        => MSS_SPI_1_SS_Y,
        UART1RXD       => GND_net, -- tied to '0' from definition
        I2C1SDAI       => GND_net, -- tied to '0' from definition
        I2C1SCLI       => GND_net, -- tied to '0' from definition
        MACRXD         => MACRXD_const_net_0, -- tied to X"0" from definition
        MACCRSDV       => GND_net, -- tied to '0' from definition
        MACRXER        => GND_net, -- tied to '0' from definition
        MACMDI         => GND_net, -- tied to '0' from definition
        EMCCLKRTN      => MSS_ADLIB_INST_EMCCLK,
        EMCRDB         => EMCRDB_const_net_0, -- tied to X"0" from definition
        ADC0           => GND_net, -- tied to '0' from definition
        ADC1           => GND_net, -- tied to '0' from definition
        ADC2           => GND_net, -- tied to '0' from definition
        ADC3           => GND_net, -- tied to '0' from definition
        ADC4           => GND_net, -- tied to '0' from definition
        ADC5           => GND_net, -- tied to '0' from definition
        ADC6           => GND_net, -- tied to '0' from definition
        ADC7           => GND_net, -- tied to '0' from definition
        ADC8           => GND_net, -- tied to '0' from definition
        ADC9           => GND_net, -- tied to '0' from definition
        ADC10          => GND_net, -- tied to '0' from definition
        ADC11          => GND_net, -- tied to '0' from definition
        ABPS0          => GND_net, -- tied to '0' from definition
        ABPS1          => GND_net, -- tied to '0' from definition
        ABPS2          => GND_net, -- tied to '0' from definition
        ABPS3          => GND_net, -- tied to '0' from definition
        ABPS4          => GND_net, -- tied to '0' from definition
        ABPS5          => GND_net, -- tied to '0' from definition
        ABPS6          => GND_net, -- tied to '0' from definition
        ABPS7          => GND_net, -- tied to '0' from definition
        ABPS8          => GND_net, -- tied to '0' from definition
        ABPS9          => GND_net, -- tied to '0' from definition
        ABPS10         => GND_net, -- tied to '0' from definition
        ABPS11         => GND_net, -- tied to '0' from definition
        TM0            => GND_net, -- tied to '0' from definition
        TM1            => GND_net, -- tied to '0' from definition
        TM2            => GND_net, -- tied to '0' from definition
        TM3            => GND_net, -- tied to '0' from definition
        TM4            => GND_net, -- tied to '0' from definition
        TM5            => GND_net, -- tied to '0' from definition
        CM0            => GND_net, -- tied to '0' from definition
        CM1            => GND_net, -- tied to '0' from definition
        CM2            => GND_net, -- tied to '0' from definition
        CM3            => GND_net, -- tied to '0' from definition
        CM4            => GND_net, -- tied to '0' from definition
        CM5            => GND_net, -- tied to '0' from definition
        GNDTM0         => GND_net, -- tied to '0' from definition
        GNDTM1         => GND_net, -- tied to '0' from definition
        GNDTM2         => GND_net, -- tied to '0' from definition
        VAREF0         => GND_net, -- tied to '0' from definition
        VAREF1         => GND_net, -- tied to '0' from definition
        VAREF2         => GND_net, -- tied to '0' from definition
        GNDVAREF       => GND_net, -- tied to '0' from definition
        PUn            => GND_net, -- tied to '0' from definition
        -- Outputs
        MSSPADDR       => net_75_PADDR,
        MSSPWDATA      => net_75_PWDATA,
        MSSPWRITE      => net_75_PWRITE,
        MSSPSEL        => net_75_PSELx,
        MSSPENABLE     => net_75_PENABLE,
        FABPRDATA      => OPEN,
        FABPREADY      => OPEN,
        FABPSLVERR     => OPEN,
        CALIBOUT       => OPEN,
        MSSINT         => OPEN,
        WDINT          => OPEN,
        M2FRESETn      => net_74,
        DEEPSLEEP      => OPEN,
        SLEEP          => OPEN,
        TXEV           => OPEN,
        GPO            => GPO_net_0,
        UART0RTSn      => OPEN,
        UART0DTRn      => OPEN,
        UART1RTSn      => OPEN,
        UART1DTRn      => OPEN,
        I2C0SMBUSNO    => OPEN,
        I2C0SMBALERTNO => OPEN,
        I2C1SMBUSNO    => OPEN,
        I2C1SMBALERTNO => OPEN,
        MACM2FTXD      => OPEN,
        MACM2FTXEN     => OPEN,
        MACM2FMDO      => OPEN,
        MACM2FMDEN     => OPEN,
        MACM2FMDC      => OPEN,
        ACEFLAGS       => OPEN,
        CMP0           => OPEN,
        CMP1           => OPEN,
        CMP2           => OPEN,
        CMP3           => OPEN,
        CMP4           => OPEN,
        CMP5           => OPEN,
        CMP6           => OPEN,
        CMP7           => OPEN,
        CMP8           => OPEN,
        CMP9           => OPEN,
        CMP10          => OPEN,
        CMP11          => OPEN,
        LVTTL0         => OPEN,
        LVTTL1         => OPEN,
        LVTTL2         => OPEN,
        LVTTL3         => OPEN,
        LVTTL4         => OPEN,
        LVTTL5         => OPEN,
        LVTTL6         => OPEN,
        LVTTL7         => OPEN,
        LVTTL8         => OPEN,
        LVTTL9         => OPEN,
        LVTTL10        => OPEN,
        LVTTL11        => OPEN,
        PUFABn         => OPEN,
        VCC15GOOD      => OPEN,
        VCC33GOOD      => OPEN,
        GPOE           => OPEN,
        SPI0DO         => OPEN,
        SPI0DOE        => OPEN,
        SPI0CLKO       => OPEN,
        SPI0MODE       => OPEN,
        SPI0SSO        => OPEN,
        UART0TXD       => OPEN,
        I2C0SDAO       => OPEN,
        I2C0SCLO       => OPEN,
        SPI1DO         => MSS_SPI_1_DO_D,
        SPI1DOE        => MSS_SPI_1_DO_E,
        SPI1CLKO       => MSS_SPI_1_CLK_D,
        SPI1MODE       => MSS_SPI_1_SS_E,
        SPI1SSO        => SPI1SSO_net_0,
        UART1TXD       => OPEN,
        I2C1SDAO       => OPEN,
        I2C1SCLO       => OPEN,
        MACTXD         => OPEN,
        MACTXEN        => OPEN,
        MACMDO         => OPEN,
        MACMDEN        => OPEN,
        MACMDC         => OPEN,
        EMCCLK         => MSS_ADLIB_INST_EMCCLK,
        EMCAB          => OPEN,
        EMCWDB         => OPEN,
        EMCRWn         => OPEN,
        EMCCS0n        => OPEN,
        EMCCS1n        => OPEN,
        EMCOEN0n       => OPEN,
        EMCOEN1n       => OPEN,
        EMCBYTEN       => OPEN,
        EMCDBOE        => OPEN,
        SDD0           => OPEN,
        SDD1           => OPEN,
        SDD2           => OPEN,
        VAREFOUT       => OPEN 
        );
-- MSS_CCC_0   -   Actel:SmartFusionMSS:MSS_CCC:2.0.106
MSS_CCC_0 : StreamingReceiver_RF_MSS_tmp_MSS_CCC_0_MSS_CCC
    port map( 
        -- Inputs
        CLKA           => GND_net, -- tied to '0' from definition
        CLKA_PAD       => GND_net, -- tied to '0' from definition
        CLKA_PADP      => GND_net, -- tied to '0' from definition
        CLKA_PADN      => GND_net, -- tied to '0' from definition
        CLKB           => GND_net, -- tied to '0' from definition
        CLKB_PAD       => GND_net, -- tied to '0' from definition
        CLKB_PADP      => GND_net, -- tied to '0' from definition
        CLKB_PADN      => GND_net, -- tied to '0' from definition
        CLKC           => GND_net, -- tied to '0' from definition
        CLKC_PAD       => GND_net, -- tied to '0' from definition
        CLKC_PADP      => GND_net, -- tied to '0' from definition
        CLKC_PADN      => GND_net, -- tied to '0' from definition
        MAINXIN        => MAINXIN,
        LPXIN          => GND_net, -- tied to '0' from definition
        MAC_CLK        => GND_net, -- tied to '0' from definition
        -- Outputs
        GLA            => OPEN,
        GLB            => GLB_net_0,
        GLC            => GLC_net_0,
        FAB_CLK        => MSS_ADLIB_INST_SYNCCLKFDBK,
        YB             => OPEN,
        YC             => OPEN,
        FAB_LOCK       => OPEN,
        RCOSC_CLKOUT   => OPEN,
        MAINXIN_CLKOUT => OPEN,
        LPXIN_CLKOUT   => OPEN,
        GLA0           => MSS_ADLIB_INST_FCLK,
        MSS_LOCK       => MSS_ADLIB_INST_PLLLOCK,
        MAC_CLK_CCC    => MSS_ADLIB_INST_MACCLKCCC,
        MAC_CLK_IO     => MSS_ADLIB_INST_MACCLK 
        );
-- MSS_GPIO_0_GPIO_28_OUT
MSS_GPIO_0_GPIO_28_OUT : OUTBUF_MSS
    generic map( 
        ACT_CONFIG => ( 0 ),
        ACT_PIN    => ( "K14" )
        )
    port map( 
        -- Inputs
        D   => MSS_GPIO_0_GPIO_28_OUT_D(28),
        -- Outputs
        PAD => GPIO_28_OUT_net_0 
        );
-- MSS_RESET_0_MSS_RESET_N
MSS_RESET_0_MSS_RESET_N : INBUF_MSS
    generic map( 
        ACT_CONFIG => ( 0 ),
        ACT_PIN    => ( "K4" )
        )
    port map( 
        -- Inputs
        PAD => MSS_RESET_N,
        -- Outputs
        Y   => MSS_RESET_0_MSS_RESET_N_Y 
        );
-- MSS_SPI_1_CLK
MSS_SPI_1_CLK : BIBUF_MSS
    generic map( 
        ACT_CONFIG => ( 0 ),
        ACT_PIN    => ( "L14" )
        )
    port map( 
        -- Inputs
        D   => MSS_SPI_1_CLK_D,
        E   => MSS_SPI_1_SS_E,
        -- Outputs
        Y   => MSS_SPI_1_CLK_Y,
        -- Inouts
        PAD => SPI_1_CLK 
        );
-- MSS_SPI_1_DI
MSS_SPI_1_DI : INBUF_MSS
    generic map( 
        ACT_CONFIG => ( 0 ),
        ACT_PIN    => ( "L15" )
        )
    port map( 
        -- Inputs
        PAD => SPI_1_DI,
        -- Outputs
        Y   => MSS_SPI_1_DI_Y 
        );
-- MSS_SPI_1_DO
MSS_SPI_1_DO : TRIBUFF_MSS
    generic map( 
        ACT_CONFIG => ( 0 ),
        ACT_PIN    => ( "L12" )
        )
    port map( 
        -- Inputs
        D   => MSS_SPI_1_DO_D,
        E   => MSS_SPI_1_DO_E,
        -- Outputs
        PAD => SPI_1_DO_net_0 
        );
-- MSS_SPI_1_SS
MSS_SPI_1_SS : BIBUF_MSS
    generic map( 
        ACT_CONFIG => ( 0 ),
        ACT_PIN    => ( "L13" )
        )
    port map( 
        -- Inputs
        D   => MSS_SPI_1_SS_D(0),
        E   => MSS_SPI_1_SS_E,
        -- Outputs
        Y   => MSS_SPI_1_SS_Y,
        -- Inouts
        PAD => SPI_1_SS 
        );
-- MSSINT_GPI_12
MSSINT_GPI_12 : MSSINT
    port map( 
        -- Inputs
        A => F2M_GPI_12,
        -- Outputs
        Y => MSSINT_GPI_12_Y 
        );
-- MSSINT_GPO_13
MSSINT_GPO_13 : MSSINT
    port map( 
        -- Inputs
        A => MSSINT_GPO_13_A(13),
        -- Outputs
        Y => net_71 
        );
-- MSSINT_GPO_14
MSSINT_GPO_14 : MSSINT
    port map( 
        -- Inputs
        A => MSSINT_GPO_14_A(14),
        -- Outputs
        Y => net_72 
        );
-- MSSINT_GPO_15
MSSINT_GPO_15 : MSSINT
    port map( 
        -- Inputs
        A => MSSINT_GPO_15_A(15),
        -- Outputs
        Y => net_73 
        );

end RTL;
