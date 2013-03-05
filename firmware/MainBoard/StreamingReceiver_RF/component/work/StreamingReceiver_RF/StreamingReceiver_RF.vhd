----------------------------------------------------------------------
-- Created by SmartDesign Tue Mar 05 08:19:24 2013
-- Version: 10.1 SP3 10.1.3.1
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion;
use smartfusion.all;
library COREAPB3_LIB;
use COREAPB3_LIB.all;
----------------------------------------------------------------------
-- StreamingReceiver_RF entity declaration
----------------------------------------------------------------------
entity StreamingReceiver_RF is
    -- Port list
    port(
        -- Inputs
        LD              : in    std_logic;
        MAINXIN         : in    std_logic;
        MSS_RESET_N     : in    std_logic;
        SPI_1_DI        : in    std_logic;
        USB_CLK_pin     : in    std_logic;
        USB_RXF_n_pin   : in    std_logic;
        USB_TXE_n_pin   : in    std_logic;
        -- Outputs
        AFE1_CLK_pin    : out   std_logic;
        AFE1_SHDN_n_pin : out   std_logic;
        AFE1_T_R_n_pin  : out   std_logic;
        AFE2_CLK_pin    : out   std_logic;
        AFE2_SHDN_n_pin : out   std_logic;
        AFE2_T_R_n_pin  : out   std_logic;
        ANTSEL          : out   std_logic;
        LED1            : out   std_logic;
        RXHP            : out   std_logic;
        RXTX            : out   std_logic;
        SPI_1_DO        : out   std_logic;
        USB_OE_n_pin    : out   std_logic;
        USB_RD_n_pin    : out   std_logic;
        USB_SIWU_N      : out   std_logic;
        USB_WR_n_pin    : out   std_logic;
        nSHDN           : out   std_logic;
        -- Inouts
        AFE1_DATA_pin   : inout std_logic_vector(9 downto 0);
        AFE2_DATA_pin   : inout std_logic_vector(9 downto 0);
        SPI_1_CLK       : inout std_logic;
        SPI_1_SS        : inout std_logic;
        USB_DATA_pin    : inout std_logic_vector(7 downto 0)
        );
end StreamingReceiver_RF;
----------------------------------------------------------------------
-- StreamingReceiver_RF architecture body
----------------------------------------------------------------------
architecture RTL of StreamingReceiver_RF is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- AFE_IF
component AFE_IF
    -- Port list
    port(
        -- Inputs
        CLK        : in    std_logic;
        CLK_SH90   : in    std_logic;
        RST        : in    std_logic;
        SHDN       : in    std_logic;
        TX_I       : in    std_logic_vector(9 downto 0);
        TX_Q       : in    std_logic_vector(9 downto 0);
        TX_RX_n    : in    std_logic;
        TX_STROBE  : in    std_logic;
        -- Outputs
        CLK_pin    : out   std_logic;
        RX_I       : out   std_logic_vector(9 downto 0);
        RX_Q       : out   std_logic_vector(9 downto 0);
        RX_STROBE  : out   std_logic;
        SHDN_n_pin : out   std_logic;
        T_R_n_pin  : out   std_logic;
        -- Inouts
        DATA_pin   : inout std_logic_vector(9 downto 0)
        );
end component;
-- AFE_mux
component AFE_mux
    -- Port list
    port(
        -- Inputs
        Data0_port : in  std_logic_vector(19 downto 0);
        Data1_port : in  std_logic_vector(19 downto 0);
        Sel0       : in  std_logic;
        -- Outputs
        Result     : out std_logic_vector(19 downto 0)
        );
end component;
-- CoreAPB3   -   Actel:DirectCore:CoreAPB3:3.0.103
component CoreAPB3
    generic( 
        APB_DWIDTH      : integer := 32 ;
        APBSLOT0ENABLE  : integer := 1 ;
        APBSLOT1ENABLE  : integer := 0 ;
        APBSLOT2ENABLE  : integer := 0 ;
        APBSLOT3ENABLE  : integer := 0 ;
        APBSLOT4ENABLE  : integer := 0 ;
        APBSLOT5ENABLE  : integer := 0 ;
        APBSLOT6ENABLE  : integer := 0 ;
        APBSLOT7ENABLE  : integer := 0 ;
        APBSLOT8ENABLE  : integer := 0 ;
        APBSLOT9ENABLE  : integer := 0 ;
        APBSLOT10ENABLE : integer := 0 ;
        APBSLOT11ENABLE : integer := 0 ;
        APBSLOT12ENABLE : integer := 0 ;
        APBSLOT13ENABLE : integer := 0 ;
        APBSLOT14ENABLE : integer := 0 ;
        APBSLOT15ENABLE : integer := 0 ;
        IADDR_ENABLE    : integer := 0 ;
        RANGESIZE       : integer := 256 
        );
    -- Port list
    port(
        -- Inputs
        PADDR      : in  std_logic_vector(23 downto 0);
        PCLK       : in  std_logic;
        PENABLE    : in  std_logic;
        PRDATAS0   : in  std_logic_vector(31 downto 0);
        PRDATAS1   : in  std_logic_vector(31 downto 0);
        PRDATAS10  : in  std_logic_vector(31 downto 0);
        PRDATAS11  : in  std_logic_vector(31 downto 0);
        PRDATAS12  : in  std_logic_vector(31 downto 0);
        PRDATAS13  : in  std_logic_vector(31 downto 0);
        PRDATAS14  : in  std_logic_vector(31 downto 0);
        PRDATAS15  : in  std_logic_vector(31 downto 0);
        PRDATAS2   : in  std_logic_vector(31 downto 0);
        PRDATAS3   : in  std_logic_vector(31 downto 0);
        PRDATAS4   : in  std_logic_vector(31 downto 0);
        PRDATAS5   : in  std_logic_vector(31 downto 0);
        PRDATAS6   : in  std_logic_vector(31 downto 0);
        PRDATAS7   : in  std_logic_vector(31 downto 0);
        PRDATAS8   : in  std_logic_vector(31 downto 0);
        PRDATAS9   : in  std_logic_vector(31 downto 0);
        PREADYS0   : in  std_logic;
        PREADYS1   : in  std_logic;
        PREADYS10  : in  std_logic;
        PREADYS11  : in  std_logic;
        PREADYS12  : in  std_logic;
        PREADYS13  : in  std_logic;
        PREADYS14  : in  std_logic;
        PREADYS15  : in  std_logic;
        PREADYS2   : in  std_logic;
        PREADYS3   : in  std_logic;
        PREADYS4   : in  std_logic;
        PREADYS5   : in  std_logic;
        PREADYS6   : in  std_logic;
        PREADYS7   : in  std_logic;
        PREADYS8   : in  std_logic;
        PREADYS9   : in  std_logic;
        PRESETN    : in  std_logic;
        PSEL       : in  std_logic;
        PSLVERRS0  : in  std_logic;
        PSLVERRS1  : in  std_logic;
        PSLVERRS10 : in  std_logic;
        PSLVERRS11 : in  std_logic;
        PSLVERRS12 : in  std_logic;
        PSLVERRS13 : in  std_logic;
        PSLVERRS14 : in  std_logic;
        PSLVERRS15 : in  std_logic;
        PSLVERRS2  : in  std_logic;
        PSLVERRS3  : in  std_logic;
        PSLVERRS4  : in  std_logic;
        PSLVERRS5  : in  std_logic;
        PSLVERRS6  : in  std_logic;
        PSLVERRS7  : in  std_logic;
        PSLVERRS8  : in  std_logic;
        PSLVERRS9  : in  std_logic;
        PWDATA     : in  std_logic_vector(31 downto 0);
        PWRITE     : in  std_logic;
        -- Outputs
        PADDRS     : out std_logic_vector(23 downto 0);
        PADDRS0    : out std_logic_vector(23 downto 0);
        PENABLES   : out std_logic;
        PRDATA     : out std_logic_vector(31 downto 0);
        PREADY     : out std_logic;
        PSELS0     : out std_logic;
        PSELS1     : out std_logic;
        PSELS10    : out std_logic;
        PSELS11    : out std_logic;
        PSELS12    : out std_logic;
        PSELS13    : out std_logic;
        PSELS14    : out std_logic;
        PSELS15    : out std_logic;
        PSELS2     : out std_logic;
        PSELS3     : out std_logic;
        PSELS4     : out std_logic;
        PSELS5     : out std_logic;
        PSELS6     : out std_logic;
        PSELS7     : out std_logic;
        PSELS8     : out std_logic;
        PSELS9     : out std_logic;
        PSLVERR    : out std_logic;
        PWDATAS    : out std_logic_vector(31 downto 0);
        PWRITES    : out std_logic
        );
end component;
-- SAMPLE_APB
component SAMPLE_APB
    -- Port list
    port(
        -- Inputs
        FROM_USB_RDY    : in  std_logic;
        INPUT           : in  std_logic_vector(7 downto 0);
        PADDR           : in  std_logic_vector(31 downto 0);
        PCLK            : in  std_logic;
        PENABLE         : in  std_logic;
        PRESETn         : in  std_logic;
        PSELx           : in  std_logic;
        PWDATA          : in  std_logic_vector(31 downto 0);
        PWRITE          : in  std_logic;
        -- Outputs
        PRDATA          : out std_logic_vector(31 downto 0);
        PREADY          : out std_logic;
        PSLVERR         : out std_logic;
        READ_SUCCESSFUL : out std_logic;
        REG_FULL        : out std_logic;
        SMPL_RDY        : out std_logic
        );
end component;
-- StreamingReceiver_RF_MSS
component StreamingReceiver_RF_MSS
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
end component;
-- USB_FIFO_IF
component USB_FIFO_IF
    -- Port list
    port(
        -- Inputs
        ADC_I             : in    std_logic_vector(15 downto 0);
        ADC_Q             : in    std_logic_vector(31 downto 16);
        CLK               : in    std_logic;
        FROM_ADC_SMPL_RDY : in    std_logic;
        READ_SUCCESSFUL   : in    std_logic;
        RST_n             : in    std_logic;
        USB_CLK_pin       : in    std_logic;
        USB_RXF_n_pin     : in    std_logic;
        USB_TXE_n_pin     : in    std_logic;
        -- Outputs
        FROM_USB_RDY      : out   std_logic;
        READ_FROM_USB_REG : out   std_logic_vector(7 downto 0);
        USB_OE_n_pin      : out   std_logic;
        USB_RD_n_pin      : out   std_logic;
        USB_SIWU_N        : out   std_logic;
        USB_WR_n_pin      : out   std_logic;
        -- Inouts
        USB_DATA_pin      : inout std_logic_vector(7 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AFE1_CLK_pin_net_0                                : std_logic;
signal AFE1_SHDN_n_pin_net_0                             : std_logic;
signal AFE1_T_R_n_pin_net_0                              : std_logic;
signal AFE2_CLK_pin_net_0                                : std_logic;
signal AFE2_SHDN_n_pin_net_0                             : std_logic;
signal AFE2_T_R_n_pin_net_0                              : std_logic;
signal AFE_IF_0_RX_I                                     : std_logic_vector(9 downto 0);
signal AFE_IF_0_RX_Q                                     : std_logic_vector(9 downto 0);
signal AFE_IF_1_RX_I                                     : std_logic_vector(9 downto 0);
signal AFE_IF_1_RX_Q                                     : std_logic_vector(9 downto 0);
signal AFE_mux_0_Result9to0                              : std_logic_vector(9 downto 0);
signal AFE_mux_0_Result19to10                            : std_logic_vector(19 downto 10);
signal ANTSEL_net_0                                      : std_logic;
signal ANTSEL_0                                          : std_logic;
signal CoreAPB3_0_APBmslave0_PENABLE                     : std_logic;
signal CoreAPB3_0_APBmslave0_PRDATA                      : std_logic_vector(31 downto 0);
signal CoreAPB3_0_APBmslave0_PREADY                      : std_logic;
signal CoreAPB3_0_APBmslave0_PSELx                       : std_logic;
signal CoreAPB3_0_APBmslave0_PSLVERR                     : std_logic;
signal CoreAPB3_0_APBmslave0_PWDATA                      : std_logic_vector(31 downto 0);
signal CoreAPB3_0_APBmslave0_PWRITE                      : std_logic;
signal LED1_net_0                                        : std_logic;
signal nSHDN_net_0                                       : std_logic;
signal nSHDN_0                                           : std_logic;
signal RXHP_net_0                                        : std_logic;
signal RXHP_0                                            : std_logic;
signal RXHP_1                                            : std_logic;
signal RXTX_net_0                                        : std_logic;
signal SPI_1_DO_net_0                                    : std_logic;
signal StreamingReceiver_RF_MSS_0_FAB_CLK                : std_logic;
signal StreamingReceiver_RF_MSS_0_GLB                    : std_logic;
signal StreamingReceiver_RF_MSS_0_GLC                    : std_logic;
signal StreamingReceiver_RF_MSS_0_M2F_RESET_N            : std_logic;
signal StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PENABLE : std_logic;
signal StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PRDATA  : std_logic_vector(31 downto 0);
signal StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PREADY  : std_logic;
signal StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PSELx   : std_logic;
signal StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PSLVERR : std_logic;
signal StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PWDATA  : std_logic_vector(31 downto 0);
signal StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PWRITE  : std_logic;
signal USB_FIFO_IF_0_READ_FROM_USB_REG                   : std_logic_vector(7 downto 0);
signal USB_OE_n_pin_net_0                                : std_logic;
signal USB_RD_n_pin_net_0                                : std_logic;
signal USB_SIWU_N_net_0                                  : std_logic;
signal SPI_1_DO_net_1                                    : std_logic;
signal RXTX_net_1                                        : std_logic;
signal ANTSEL_0_net_0                                    : std_logic;
signal RXHP_1_net_0                                      : std_logic;
signal nSHDN_0_net_0                                     : std_logic;
signal AFE2_CLK_pin_net_1                                : std_logic;
signal AFE2_SHDN_n_pin_net_1                             : std_logic;
signal AFE2_T_R_n_pin_net_1                              : std_logic;
signal RXHP_0_net_0                                      : std_logic;
signal USB_OE_n_pin_net_1                                : std_logic;
signal USB_RD_n_pin_net_1                                : std_logic;
signal USB_SIWU_N_net_1                                  : std_logic;
signal LED1_net_1                                        : std_logic;
signal AFE1_CLK_pin_net_1                                : std_logic;
signal AFE1_SHDN_n_pin_net_1                             : std_logic;
signal AFE1_T_R_n_pin_net_1                              : std_logic;
signal Data0_port_net_0                                  : std_logic_vector(19 downto 0);
signal Data1_port_net_0                                  : std_logic_vector(19 downto 0);
signal Result_net_0                                      : std_logic_vector(19 downto 0);
signal ADC_Q_net_0                                       : std_logic_vector(31 downto 16);
signal ADC_I_net_0                                       : std_logic_vector(15 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                                           : std_logic;
signal TX_I_const_net_0                                  : std_logic_vector(9 downto 0);
signal TX_Q_const_net_0                                  : std_logic_vector(9 downto 0);
signal TX_I_const_net_1                                  : std_logic_vector(9 downto 0);
signal TX_Q_const_net_1                                  : std_logic_vector(9 downto 0);
signal VCC_net                                           : std_logic;
signal ADC_Q_const_net_0                                 : std_logic_vector(21 downto 16);
signal ADC_I_const_net_0                                 : std_logic_vector(5 downto 0);
signal PRDATAS1_const_net_0                              : std_logic_vector(31 downto 0);
signal PRDATAS2_const_net_0                              : std_logic_vector(31 downto 0);
signal PRDATAS3_const_net_0                              : std_logic_vector(31 downto 0);
signal PRDATAS4_const_net_0                              : std_logic_vector(31 downto 0);
signal PRDATAS5_const_net_0                              : std_logic_vector(31 downto 0);
signal PRDATAS6_const_net_0                              : std_logic_vector(31 downto 0);
signal PRDATAS7_const_net_0                              : std_logic_vector(31 downto 0);
signal PRDATAS8_const_net_0                              : std_logic_vector(31 downto 0);
signal PRDATAS9_const_net_0                              : std_logic_vector(31 downto 0);
signal PRDATAS10_const_net_0                             : std_logic_vector(31 downto 0);
signal PRDATAS11_const_net_0                             : std_logic_vector(31 downto 0);
signal PRDATAS12_const_net_0                             : std_logic_vector(31 downto 0);
signal PRDATAS13_const_net_0                             : std_logic_vector(31 downto 0);
signal PRDATAS14_const_net_0                             : std_logic_vector(31 downto 0);
signal PRDATAS15_const_net_0                             : std_logic_vector(31 downto 0);
----------------------------------------------------------------------
-- Inverted Signals
----------------------------------------------------------------------
signal RST_IN_POST_INV0_0                                : std_logic;
signal RST_IN_POST_INV1_0                                : std_logic;
----------------------------------------------------------------------
-- Bus Interface Nets Declarations - Unequal Pin Widths
----------------------------------------------------------------------
signal CoreAPB3_0_APBmslave0_PADDR                       : std_logic_vector(23 downto 0);
signal CoreAPB3_0_APBmslave0_PADDR_0_31to24              : std_logic_vector(31 downto 24);
signal CoreAPB3_0_APBmslave0_PADDR_0_23to0               : std_logic_vector(23 downto 0);
signal CoreAPB3_0_APBmslave0_PADDR_0                     : std_logic_vector(31 downto 0);

signal StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR_0_23to20: std_logic_vector(23 downto 20);
signal StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR_0_19to0: std_logic_vector(19 downto 0);
signal StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR_0 : std_logic_vector(23 downto 0);
signal StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR   : std_logic_vector(19 downto 0);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net               <= '0';
 TX_I_const_net_0      <= B"0000000000";
 TX_Q_const_net_0      <= B"0000000000";
 TX_I_const_net_1      <= B"0000000000";
 TX_Q_const_net_1      <= B"0000000000";
 VCC_net               <= '1';
 ADC_Q_const_net_0     <= B"000000";
 ADC_I_const_net_0     <= B"000000";
 PRDATAS1_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS2_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS3_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS4_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS5_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS6_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS7_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS8_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS9_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS10_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS11_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS12_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS13_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS14_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS15_const_net_0 <= B"00000000000000000000000000000000";
----------------------------------------------------------------------
-- Inversions
----------------------------------------------------------------------
 RST_IN_POST_INV0_0 <= NOT StreamingReceiver_RF_MSS_0_M2F_RESET_N;
 RST_IN_POST_INV1_0 <= NOT StreamingReceiver_RF_MSS_0_M2F_RESET_N;
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SPI_1_DO_net_1        <= SPI_1_DO_net_0;
 SPI_1_DO              <= SPI_1_DO_net_1;
 RXTX_net_1            <= RXTX_net_0;
 RXTX                  <= RXTX_net_1;
 ANTSEL_0_net_0        <= ANTSEL_0;
 ANTSEL                <= ANTSEL_0_net_0;
 RXHP_1_net_0          <= RXHP_1;
 RXHP                  <= RXHP_1_net_0;
 nSHDN_0_net_0         <= nSHDN_0;
 nSHDN                 <= nSHDN_0_net_0;
 AFE2_CLK_pin_net_1    <= AFE2_CLK_pin_net_0;
 AFE2_CLK_pin          <= AFE2_CLK_pin_net_1;
 AFE2_SHDN_n_pin_net_1 <= AFE2_SHDN_n_pin_net_0;
 AFE2_SHDN_n_pin       <= AFE2_SHDN_n_pin_net_1;
 AFE2_T_R_n_pin_net_1  <= AFE2_T_R_n_pin_net_0;
 AFE2_T_R_n_pin        <= AFE2_T_R_n_pin_net_1;
 RXHP_0_net_0          <= RXHP_0;
 USB_WR_n_pin          <= RXHP_0_net_0;
 USB_OE_n_pin_net_1    <= USB_OE_n_pin_net_0;
 USB_OE_n_pin          <= USB_OE_n_pin_net_1;
 USB_RD_n_pin_net_1    <= USB_RD_n_pin_net_0;
 USB_RD_n_pin          <= USB_RD_n_pin_net_1;
 USB_SIWU_N_net_1      <= USB_SIWU_N_net_0;
 USB_SIWU_N            <= USB_SIWU_N_net_1;
 LED1_net_1            <= LED1_net_0;
 LED1                  <= LED1_net_1;
 AFE1_CLK_pin_net_1    <= AFE1_CLK_pin_net_0;
 AFE1_CLK_pin          <= AFE1_CLK_pin_net_1;
 AFE1_SHDN_n_pin_net_1 <= AFE1_SHDN_n_pin_net_0;
 AFE1_SHDN_n_pin       <= AFE1_SHDN_n_pin_net_1;
 AFE1_T_R_n_pin_net_1  <= AFE1_T_R_n_pin_net_0;
 AFE1_T_R_n_pin        <= AFE1_T_R_n_pin_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 AFE_mux_0_Result9to0   <= Result_net_0(9 downto 0);
 AFE_mux_0_Result19to10 <= Result_net_0(19 downto 10);
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 Data0_port_net_0 <= ( AFE_IF_0_RX_I & AFE_IF_0_RX_Q );
 Data1_port_net_0 <= ( AFE_IF_1_RX_I & AFE_IF_1_RX_Q );
 ADC_Q_net_0      <= ( AFE_mux_0_Result9to0 & B"000000" );
 ADC_I_net_0      <= ( AFE_mux_0_Result19to10 & B"000000" );
----------------------------------------------------------------------
-- Bus Interface Nets Assignments - Unequal Pin Widths
----------------------------------------------------------------------
 CoreAPB3_0_APBmslave0_PADDR_0_31to24(31 downto 24) <= B"00000000";
 CoreAPB3_0_APBmslave0_PADDR_0_23to0(23 downto 0) <= CoreAPB3_0_APBmslave0_PADDR(23 downto 0);
 CoreAPB3_0_APBmslave0_PADDR_0 <= ( CoreAPB3_0_APBmslave0_PADDR_0_31to24(31 downto 24) & CoreAPB3_0_APBmslave0_PADDR_0_23to0(23 downto 0) );

 StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR_0_23to20(23 downto 20) <= B"0000";
 StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR_0_19to0(19 downto 0) <= StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR(19 downto 0);
 StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR_0 <= ( StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR_0_23to20(23 downto 20) & StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR_0_19to0(19 downto 0) );

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AFE_IF_0
AFE_IF_0 : AFE_IF
    port map( 
        -- Inputs
        CLK        => StreamingReceiver_RF_MSS_0_GLB,
        CLK_SH90   => StreamingReceiver_RF_MSS_0_GLC,
        RST        => RST_IN_POST_INV0_0,
        SHDN       => GND_net,
        TX_RX_n    => GND_net,
        TX_STROBE  => GND_net,
        TX_I       => TX_I_const_net_0,
        TX_Q       => TX_Q_const_net_0,
        -- Outputs
        RX_STROBE  => OPEN,
        CLK_pin    => AFE2_CLK_pin_net_0,
        SHDN_n_pin => AFE2_SHDN_n_pin_net_0,
        T_R_n_pin  => AFE2_T_R_n_pin_net_0,
        RX_I       => AFE_IF_0_RX_I,
        RX_Q       => AFE_IF_0_RX_Q,
        -- Inouts
        DATA_pin   => AFE2_DATA_pin 
        );
-- AFE_IF_1
AFE_IF_1 : AFE_IF
    port map( 
        -- Inputs
        CLK        => StreamingReceiver_RF_MSS_0_GLB,
        CLK_SH90   => StreamingReceiver_RF_MSS_0_GLC,
        RST        => RST_IN_POST_INV1_0,
        SHDN       => GND_net,
        TX_RX_n    => GND_net,
        TX_STROBE  => GND_net,
        TX_I       => TX_I_const_net_1,
        TX_Q       => TX_Q_const_net_1,
        -- Outputs
        RX_STROBE  => OPEN,
        CLK_pin    => AFE1_CLK_pin_net_0,
        SHDN_n_pin => AFE1_SHDN_n_pin_net_0,
        T_R_n_pin  => AFE1_T_R_n_pin_net_0,
        RX_I       => AFE_IF_1_RX_I,
        RX_Q       => AFE_IF_1_RX_Q,
        -- Inouts
        DATA_pin   => AFE1_DATA_pin 
        );
-- AFE_mux_0
AFE_mux_0 : AFE_mux
    port map( 
        -- Inputs
        Sel0       => GND_net,
        Data0_port => Data0_port_net_0,
        Data1_port => Data1_port_net_0,
        -- Outputs
        Result     => Result_net_0 
        );
-- CoreAPB3_0   -   Actel:DirectCore:CoreAPB3:3.0.103
CoreAPB3_0 : CoreAPB3
    generic map( 
        APB_DWIDTH      => ( 32 ),
        APBSLOT0ENABLE  => ( 1 ),
        APBSLOT1ENABLE  => ( 0 ),
        APBSLOT2ENABLE  => ( 0 ),
        APBSLOT3ENABLE  => ( 0 ),
        APBSLOT4ENABLE  => ( 0 ),
        APBSLOT5ENABLE  => ( 0 ),
        APBSLOT6ENABLE  => ( 0 ),
        APBSLOT7ENABLE  => ( 0 ),
        APBSLOT8ENABLE  => ( 0 ),
        APBSLOT9ENABLE  => ( 0 ),
        APBSLOT10ENABLE => ( 0 ),
        APBSLOT11ENABLE => ( 0 ),
        APBSLOT12ENABLE => ( 0 ),
        APBSLOT13ENABLE => ( 0 ),
        APBSLOT14ENABLE => ( 0 ),
        APBSLOT15ENABLE => ( 0 ),
        IADDR_ENABLE    => ( 0 ),
        RANGESIZE       => ( 256 )
        )
    port map( 
        -- Inputs
        PRESETN    => GND_net, -- tied to '0' from definition
        PCLK       => GND_net, -- tied to '0' from definition
        PWRITE     => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PWRITE,
        PENABLE    => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PENABLE,
        PSEL       => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PSELx,
        PREADYS0   => CoreAPB3_0_APBmslave0_PREADY,
        PSLVERRS0  => CoreAPB3_0_APBmslave0_PSLVERR,
        PREADYS1   => VCC_net, -- tied to '1' from definition
        PSLVERRS1  => GND_net, -- tied to '0' from definition
        PREADYS2   => VCC_net, -- tied to '1' from definition
        PSLVERRS2  => GND_net, -- tied to '0' from definition
        PREADYS3   => VCC_net, -- tied to '1' from definition
        PSLVERRS3  => GND_net, -- tied to '0' from definition
        PREADYS4   => VCC_net, -- tied to '1' from definition
        PSLVERRS4  => GND_net, -- tied to '0' from definition
        PREADYS5   => VCC_net, -- tied to '1' from definition
        PSLVERRS5  => GND_net, -- tied to '0' from definition
        PREADYS6   => VCC_net, -- tied to '1' from definition
        PSLVERRS6  => GND_net, -- tied to '0' from definition
        PREADYS7   => VCC_net, -- tied to '1' from definition
        PSLVERRS7  => GND_net, -- tied to '0' from definition
        PREADYS8   => VCC_net, -- tied to '1' from definition
        PSLVERRS8  => GND_net, -- tied to '0' from definition
        PREADYS9   => VCC_net, -- tied to '1' from definition
        PSLVERRS9  => GND_net, -- tied to '0' from definition
        PREADYS10  => VCC_net, -- tied to '1' from definition
        PSLVERRS10 => GND_net, -- tied to '0' from definition
        PREADYS11  => VCC_net, -- tied to '1' from definition
        PSLVERRS11 => GND_net, -- tied to '0' from definition
        PREADYS12  => VCC_net, -- tied to '1' from definition
        PSLVERRS12 => GND_net, -- tied to '0' from definition
        PREADYS13  => VCC_net, -- tied to '1' from definition
        PSLVERRS13 => GND_net, -- tied to '0' from definition
        PREADYS14  => VCC_net, -- tied to '1' from definition
        PSLVERRS14 => GND_net, -- tied to '0' from definition
        PREADYS15  => VCC_net, -- tied to '1' from definition
        PSLVERRS15 => GND_net, -- tied to '0' from definition
        PADDR      => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR_0,
        PWDATA     => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PWDATA,
        PRDATAS0   => CoreAPB3_0_APBmslave0_PRDATA,
        PRDATAS1   => PRDATAS1_const_net_0, -- tied to X"0" from definition
        PRDATAS2   => PRDATAS2_const_net_0, -- tied to X"0" from definition
        PRDATAS3   => PRDATAS3_const_net_0, -- tied to X"0" from definition
        PRDATAS4   => PRDATAS4_const_net_0, -- tied to X"0" from definition
        PRDATAS5   => PRDATAS5_const_net_0, -- tied to X"0" from definition
        PRDATAS6   => PRDATAS6_const_net_0, -- tied to X"0" from definition
        PRDATAS7   => PRDATAS7_const_net_0, -- tied to X"0" from definition
        PRDATAS8   => PRDATAS8_const_net_0, -- tied to X"0" from definition
        PRDATAS9   => PRDATAS9_const_net_0, -- tied to X"0" from definition
        PRDATAS10  => PRDATAS10_const_net_0, -- tied to X"0" from definition
        PRDATAS11  => PRDATAS11_const_net_0, -- tied to X"0" from definition
        PRDATAS12  => PRDATAS12_const_net_0, -- tied to X"0" from definition
        PRDATAS13  => PRDATAS13_const_net_0, -- tied to X"0" from definition
        PRDATAS14  => PRDATAS14_const_net_0, -- tied to X"0" from definition
        PRDATAS15  => PRDATAS15_const_net_0, -- tied to X"0" from definition
        -- Outputs
        PREADY     => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PREADY,
        PSLVERR    => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PSLVERR,
        PWRITES    => CoreAPB3_0_APBmslave0_PWRITE,
        PENABLES   => CoreAPB3_0_APBmslave0_PENABLE,
        PSELS0     => CoreAPB3_0_APBmslave0_PSELx,
        PSELS1     => OPEN,
        PSELS2     => OPEN,
        PSELS3     => OPEN,
        PSELS4     => OPEN,
        PSELS5     => OPEN,
        PSELS6     => OPEN,
        PSELS7     => OPEN,
        PSELS8     => OPEN,
        PSELS9     => OPEN,
        PSELS10    => OPEN,
        PSELS11    => OPEN,
        PSELS12    => OPEN,
        PSELS13    => OPEN,
        PSELS14    => OPEN,
        PSELS15    => OPEN,
        PRDATA     => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PRDATA,
        PADDRS     => OPEN,
        PADDRS0    => CoreAPB3_0_APBmslave0_PADDR,
        PWDATAS    => CoreAPB3_0_APBmslave0_PWDATA 
        );
-- SAMPLE_APB_0
SAMPLE_APB_0 : SAMPLE_APB
    port map( 
        -- Inputs
        PCLK            => StreamingReceiver_RF_MSS_0_FAB_CLK,
        PRESETn         => StreamingReceiver_RF_MSS_0_M2F_RESET_N,
        PSELx           => CoreAPB3_0_APBmslave0_PSELx,
        PENABLE         => CoreAPB3_0_APBmslave0_PENABLE,
        PWRITE          => CoreAPB3_0_APBmslave0_PWRITE,
        FROM_USB_RDY    => nSHDN_net_0,
        PADDR           => CoreAPB3_0_APBmslave0_PADDR_0,
        PWDATA          => CoreAPB3_0_APBmslave0_PWDATA,
        INPUT           => USB_FIFO_IF_0_READ_FROM_USB_REG,
        -- Outputs
        PREADY          => CoreAPB3_0_APBmslave0_PREADY,
        PSLVERR         => CoreAPB3_0_APBmslave0_PSLVERR,
        READ_SUCCESSFUL => ANTSEL_net_0,
        SMPL_RDY        => RXHP_net_0,
        REG_FULL        => LED1_net_0,
        PRDATA          => CoreAPB3_0_APBmslave0_PRDATA 
        );
-- StreamingReceiver_RF_MSS_0
StreamingReceiver_RF_MSS_0 : StreamingReceiver_RF_MSS
    port map( 
        -- Inputs
        MSS_RESET_N => MSS_RESET_N,
        SPI_1_DI    => SPI_1_DI,
        MSSPREADY   => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PREADY,
        MSSPSLVERR  => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PSLVERR,
        F2M_GPI_12  => LD,
        MAINXIN     => MAINXIN,
        FABINT      => RXHP_net_0,
        MSSPRDATA   => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PRDATA,
        -- Outputs
        SPI_1_DO    => SPI_1_DO_net_0,
        MSSPSEL     => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PSELx,
        MSSPENABLE  => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PENABLE,
        MSSPWRITE   => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PWRITE,
        GPIO_28_OUT => RXTX_net_0,
        M2F_GPO_15  => ANTSEL_0,
        M2F_GPO_14  => RXHP_1,
        M2F_GPO_13  => nSHDN_0,
        M2F_RESET_N => StreamingReceiver_RF_MSS_0_M2F_RESET_N,
        GLB         => StreamingReceiver_RF_MSS_0_GLB,
        FAB_CLK     => StreamingReceiver_RF_MSS_0_FAB_CLK,
        GLC         => StreamingReceiver_RF_MSS_0_GLC,
        MSSPADDR    => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PADDR,
        MSSPWDATA   => StreamingReceiver_RF_MSS_0_MSS_MASTER_APB_PWDATA,
        -- Inouts
        SPI_1_CLK   => SPI_1_CLK,
        SPI_1_SS    => SPI_1_SS 
        );
-- USB_FIFO_IF_0
USB_FIFO_IF_0 : USB_FIFO_IF
    port map( 
        -- Inputs
        USB_CLK_pin       => USB_CLK_pin,
        USB_TXE_n_pin     => USB_TXE_n_pin,
        CLK               => StreamingReceiver_RF_MSS_0_GLB,
        RST_n             => StreamingReceiver_RF_MSS_0_M2F_RESET_N,
        FROM_ADC_SMPL_RDY => VCC_net,
        USB_RXF_n_pin     => USB_RXF_n_pin,
        READ_SUCCESSFUL   => ANTSEL_net_0,
        ADC_Q             => ADC_Q_net_0,
        ADC_I             => ADC_I_net_0,
        -- Outputs
        USB_WR_n_pin      => RXHP_0,
        USB_SIWU_N        => USB_SIWU_N_net_0,
        USB_RD_n_pin      => USB_RD_n_pin_net_0,
        USB_OE_n_pin      => USB_OE_n_pin_net_0,
        FROM_USB_RDY      => nSHDN_net_0,
        READ_FROM_USB_REG => USB_FIFO_IF_0_READ_FROM_USB_REG,
        -- Inouts
        USB_DATA_pin      => USB_DATA_pin 
        );

end RTL;
