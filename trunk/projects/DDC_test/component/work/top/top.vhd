-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;
library COREAPB3_LIB;
use COREAPB3_LIB.all;
library COREGPIO_LIB;
use COREGPIO_LIB.all;

entity top is

    port( MSS_RESET_N  : in    std_logic;
          MAINXIN      : in    std_logic;
          IO_8_PADOUT  : out   std_logic;
          IO_7_PADIN   : in    std_logic;
          IO_6_PADIN   : in    std_logic;
          IO_5_PADOUT  : out   std_logic;
          MAC_0_MDIO   : inout std_logic := 'Z';
          MAC_0_CRSDV  : in    std_logic;
          MAC_0_RXER   : in    std_logic;
          MAC_0_TXEN   : out   std_logic;
          MAC_0_MDC    : out   std_logic;
          GLC          : out   std_logic;
          SMPL_RDY     : out   std_logic;
          IO_13_PADOUT : out   std_logic;
          IO_4_PADOUT  : out   std_logic;
          IO_3_PADIN   : in    std_logic;
          IO_2_PADOUT  : out   std_logic;
          IO_1_PADOUT  : out   std_logic;
          IO_0_PADOUT  : out   std_logic;
          IO_15_PADOUT : out   std_logic;
          IO_14_PADOUT : out   std_logic;
          IO_12_PADOUT : out   std_logic;
          GPIO_IN      : in    std_logic;
          MAC_0_RXD    : in    std_logic_vector(1 downto 0);
          MAC_0_TXD    : out   std_logic_vector(1 downto 0);
          GPIO_OUT_1   : out   std_logic_vector(12 downto 8);
          GPIO_OUT_2   : out   std_logic_vector(16 downto 14)
        );

end top;

architecture DEF_ARCH of top is 

  component DDC
    port( RST           : in    std_logic := 'U';
          CLK           : in    std_logic := 'U';
          sample_rdy_in : in    std_logic := 'U';
          I_SMPL_RDY    : out   std_logic;
          Q_SMPL_RDY    : out   std_logic;
          I_in          : in    std_logic_vector(13 downto 0) := (others => 'U');
          Q_in          : in    std_logic_vector(13 downto 0) := (others => 'U');
          DPHASE        : in    std_logic_vector(15 downto 0) := (others => 'U');
          I_out         : out   std_logic_vector(26 downto 0);
          Q_out         : out   std_logic_vector(26 downto 0);
          DC_OFFSETI    : in    std_logic_vector(13 downto 0) := (others => 'U');
          DC_OFFSETQ    : in    std_logic_vector(13 downto 0) := (others => 'U')
        );
  end component;

  component CoreAPB3
    generic (APBSLOT0ENABLE:integer := 0; 
        APBSLOT10ENABLE:integer := 0; 
        APBSLOT11ENABLE:integer := 0; 
        APBSLOT12ENABLE:integer := 0; 
        APBSLOT13ENABLE:integer := 0; 
        APBSLOT14ENABLE:integer := 0; 
        APBSLOT15ENABLE:integer := 0; APBSLOT1ENABLE:integer := 0; 
        APBSLOT2ENABLE:integer := 0; APBSLOT3ENABLE:integer := 0; 
        APBSLOT4ENABLE:integer := 0; APBSLOT5ENABLE:integer := 0; 
        APBSLOT6ENABLE:integer := 0; APBSLOT7ENABLE:integer := 0; 
        APBSLOT8ENABLE:integer := 0; APBSLOT9ENABLE:integer := 0; 
        APB_DWIDTH:integer := 0; IADDR_ENABLE:integer := 0; 
        RANGESIZE:integer := 0);

    port( PRESETN    : in    std_logic := 'U';
          PCLK       : in    std_logic := 'U';
          PWRITE     : in    std_logic := 'U';
          PENABLE    : in    std_logic := 'U';
          PSEL       : in    std_logic := 'U';
          PREADY     : out   std_logic;
          PSLVERR    : out   std_logic;
          PWRITES    : out   std_logic;
          PENABLES   : out   std_logic;
          PSELS0     : out   std_logic;
          PREADYS0   : in    std_logic := 'U';
          PSLVERRS0  : in    std_logic := 'U';
          PSELS1     : out   std_logic;
          PREADYS1   : in    std_logic := 'U';
          PSLVERRS1  : in    std_logic := 'U';
          PSELS2     : out   std_logic;
          PREADYS2   : in    std_logic := 'U';
          PSLVERRS2  : in    std_logic := 'U';
          PSELS3     : out   std_logic;
          PREADYS3   : in    std_logic := 'U';
          PSLVERRS3  : in    std_logic := 'U';
          PSELS4     : out   std_logic;
          PREADYS4   : in    std_logic := 'U';
          PSLVERRS4  : in    std_logic := 'U';
          PSELS5     : out   std_logic;
          PREADYS5   : in    std_logic := 'U';
          PSLVERRS5  : in    std_logic := 'U';
          PSELS6     : out   std_logic;
          PREADYS6   : in    std_logic := 'U';
          PSLVERRS6  : in    std_logic := 'U';
          PSELS7     : out   std_logic;
          PREADYS7   : in    std_logic := 'U';
          PSLVERRS7  : in    std_logic := 'U';
          PSELS8     : out   std_logic;
          PREADYS8   : in    std_logic := 'U';
          PSLVERRS8  : in    std_logic := 'U';
          PSELS9     : out   std_logic;
          PREADYS9   : in    std_logic := 'U';
          PSLVERRS9  : in    std_logic := 'U';
          PSELS10    : out   std_logic;
          PREADYS10  : in    std_logic := 'U';
          PSLVERRS10 : in    std_logic := 'U';
          PSELS11    : out   std_logic;
          PREADYS11  : in    std_logic := 'U';
          PSLVERRS11 : in    std_logic := 'U';
          PSELS12    : out   std_logic;
          PREADYS12  : in    std_logic := 'U';
          PSLVERRS12 : in    std_logic := 'U';
          PSELS13    : out   std_logic;
          PREADYS13  : in    std_logic := 'U';
          PSLVERRS13 : in    std_logic := 'U';
          PSELS14    : out   std_logic;
          PREADYS14  : in    std_logic := 'U';
          PSLVERRS14 : in    std_logic := 'U';
          PSELS15    : out   std_logic;
          PREADYS15  : in    std_logic := 'U';
          PSLVERRS15 : in    std_logic := 'U';
          PADDR      : in    std_logic_vector(23 downto 0) := (others => 'U');
          PWDATA     : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATA     : out   std_logic_vector(31 downto 0);
          PADDRS     : out   std_logic_vector(23 downto 0);
          PADDRS0    : out   std_logic_vector(23 downto 0);
          PWDATAS    : out   std_logic_vector(31 downto 0);
          PRDATAS0   : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS1   : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS2   : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS3   : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS4   : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS5   : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS6   : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS7   : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS8   : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS9   : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS10  : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS11  : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS12  : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS13  : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS14  : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATAS15  : in    std_logic_vector(31 downto 0) := (others => 'U')
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component uC
    port( MSS_RESET_N  : in    std_logic := 'U';
          FAB_CLK      : out   std_logic;
          MAINXIN      : in    std_logic := 'U';
          M2F_RESET_N  : out   std_logic;
          IO_8_PADOUT  : out   std_logic;
          IO_8_D       : in    std_logic := 'U';
          IO_7_PADIN   : in    std_logic := 'U';
          IO_7_Y       : out   std_logic;
          IO_6_PADIN   : in    std_logic := 'U';
          IO_6_Y       : out   std_logic;
          IO_5_PADOUT  : out   std_logic;
          IO_5_D       : in    std_logic := 'U';
          MSSPSEL      : out   std_logic;
          MSSPENABLE   : out   std_logic;
          MSSPWRITE    : out   std_logic;
          MSSPREADY    : in    std_logic := 'U';
          MSSPSLVERR   : in    std_logic := 'U';
          GLC          : out   std_logic;
          MAC_0_MDIO   : inout   std_logic;
          MAC_0_CRSDV  : in    std_logic := 'U';
          MAC_0_RXER   : in    std_logic := 'U';
          MAC_0_TXEN   : out   std_logic;
          MAC_0_MDC    : out   std_logic;
          IO_13_PADOUT : out   std_logic;
          IO_13_D      : in    std_logic := 'U';
          IO_4_PADOUT  : out   std_logic;
          IO_4_D       : in    std_logic := 'U';
          IO_3_PADIN   : in    std_logic := 'U';
          IO_3_Y       : out   std_logic;
          IO_2_PADOUT  : out   std_logic;
          IO_2_D       : in    std_logic := 'U';
          IO_1_PADOUT  : out   std_logic;
          IO_1_D       : in    std_logic := 'U';
          IO_0_PADOUT  : out   std_logic;
          IO_0_D       : in    std_logic := 'U';
          IO_15_PADOUT : out   std_logic;
          IO_15_D      : in    std_logic := 'U';
          IO_14_PADOUT : out   std_logic;
          IO_14_D      : in    std_logic := 'U';
          IO_12_PADOUT : out   std_logic;
          IO_12_D      : in    std_logic := 'U';
          MSSPADDR     : out   std_logic_vector(19 downto 0);
          MSSPRDATA    : in    std_logic_vector(31 downto 0) := (others => 'U');
          MSSPWDATA    : out   std_logic_vector(31 downto 0);
          MAC_0_RXD    : in    std_logic_vector(1 downto 0) := (others => 'U');
          MAC_0_TXD    : out   std_logic_vector(1 downto 0);
          DMAREADY     : in    std_logic_vector(1 downto 0) := (others => 'U')
        );
  end component;

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CoreGPIO
    generic (APB_WIDTH:integer := 0; FAMILY:integer := 0; 
        FIXED_CONFIG_0:integer := 0; FIXED_CONFIG_1:integer := 0; 
        FIXED_CONFIG_10:integer := 0; 
        FIXED_CONFIG_11:integer := 0; 
        FIXED_CONFIG_12:integer := 0; 
        FIXED_CONFIG_13:integer := 0; 
        FIXED_CONFIG_14:integer := 0; 
        FIXED_CONFIG_15:integer := 0; 
        FIXED_CONFIG_16:integer := 0; 
        FIXED_CONFIG_17:integer := 0; 
        FIXED_CONFIG_18:integer := 0; 
        FIXED_CONFIG_19:integer := 0; FIXED_CONFIG_2:integer := 0; 
        FIXED_CONFIG_20:integer := 0; 
        FIXED_CONFIG_21:integer := 0; 
        FIXED_CONFIG_22:integer := 0; 
        FIXED_CONFIG_23:integer := 0; 
        FIXED_CONFIG_24:integer := 0; 
        FIXED_CONFIG_25:integer := 0; 
        FIXED_CONFIG_26:integer := 0; 
        FIXED_CONFIG_27:integer := 0; 
        FIXED_CONFIG_28:integer := 0; 
        FIXED_CONFIG_29:integer := 0; FIXED_CONFIG_3:integer := 0; 
        FIXED_CONFIG_30:integer := 0; 
        FIXED_CONFIG_31:integer := 0; FIXED_CONFIG_4:integer := 0; 
        FIXED_CONFIG_5:integer := 0; FIXED_CONFIG_6:integer := 0; 
        FIXED_CONFIG_7:integer := 0; FIXED_CONFIG_8:integer := 0; 
        FIXED_CONFIG_9:integer := 0; INT_BUS:integer := 0; 
        IO_INT_TYPE_0:integer := 0; IO_INT_TYPE_1:integer := 0; 
        IO_INT_TYPE_10:integer := 0; IO_INT_TYPE_11:integer := 0; 
        IO_INT_TYPE_12:integer := 0; IO_INT_TYPE_13:integer := 0; 
        IO_INT_TYPE_14:integer := 0; IO_INT_TYPE_15:integer := 0; 
        IO_INT_TYPE_16:integer := 0; IO_INT_TYPE_17:integer := 0; 
        IO_INT_TYPE_18:integer := 0; IO_INT_TYPE_19:integer := 0; 
        IO_INT_TYPE_2:integer := 0; IO_INT_TYPE_20:integer := 0; 
        IO_INT_TYPE_21:integer := 0; IO_INT_TYPE_22:integer := 0; 
        IO_INT_TYPE_23:integer := 0; IO_INT_TYPE_24:integer := 0; 
        IO_INT_TYPE_25:integer := 0; IO_INT_TYPE_26:integer := 0; 
        IO_INT_TYPE_27:integer := 0; IO_INT_TYPE_28:integer := 0; 
        IO_INT_TYPE_29:integer := 0; IO_INT_TYPE_3:integer := 0; 
        IO_INT_TYPE_30:integer := 0; IO_INT_TYPE_31:integer := 0; 
        IO_INT_TYPE_4:integer := 0; IO_INT_TYPE_5:integer := 0; 
        IO_INT_TYPE_6:integer := 0; IO_INT_TYPE_7:integer := 0; 
        IO_INT_TYPE_8:integer := 0; IO_INT_TYPE_9:integer := 0; 
        IO_NUM:integer := 0; IO_TYPE_0:integer := 0; 
        IO_TYPE_1:integer := 0; IO_TYPE_10:integer := 0; 
        IO_TYPE_11:integer := 0; IO_TYPE_12:integer := 0; 
        IO_TYPE_13:integer := 0; IO_TYPE_14:integer := 0; 
        IO_TYPE_15:integer := 0; IO_TYPE_16:integer := 0; 
        IO_TYPE_17:integer := 0; IO_TYPE_18:integer := 0; 
        IO_TYPE_19:integer := 0; IO_TYPE_2:integer := 0; 
        IO_TYPE_20:integer := 0; IO_TYPE_21:integer := 0; 
        IO_TYPE_22:integer := 0; IO_TYPE_23:integer := 0; 
        IO_TYPE_24:integer := 0; IO_TYPE_25:integer := 0; 
        IO_TYPE_26:integer := 0; IO_TYPE_27:integer := 0; 
        IO_TYPE_28:integer := 0; IO_TYPE_29:integer := 0; 
        IO_TYPE_3:integer := 0; IO_TYPE_30:integer := 0; 
        IO_TYPE_31:integer := 0; IO_TYPE_4:integer := 0; 
        IO_TYPE_5:integer := 0; IO_TYPE_6:integer := 0; 
        IO_TYPE_7:integer := 0; IO_TYPE_8:integer := 0; 
        IO_TYPE_9:integer := 0; IO_VAL_0:integer := 0; 
        IO_VAL_1:integer := 0; IO_VAL_10:integer := 0; 
        IO_VAL_11:integer := 0; IO_VAL_12:integer := 0; 
        IO_VAL_13:integer := 0; IO_VAL_14:integer := 0; 
        IO_VAL_15:integer := 0; IO_VAL_16:integer := 0; 
        IO_VAL_17:integer := 0; IO_VAL_18:integer := 0; 
        IO_VAL_19:integer := 0; IO_VAL_2:integer := 0; 
        IO_VAL_20:integer := 0; IO_VAL_21:integer := 0; 
        IO_VAL_22:integer := 0; IO_VAL_23:integer := 0; 
        IO_VAL_24:integer := 0; IO_VAL_25:integer := 0; 
        IO_VAL_26:integer := 0; IO_VAL_27:integer := 0; 
        IO_VAL_28:integer := 0; IO_VAL_29:integer := 0; 
        IO_VAL_3:integer := 0; IO_VAL_30:integer := 0; 
        IO_VAL_31:integer := 0; IO_VAL_4:integer := 0; 
        IO_VAL_5:integer := 0; IO_VAL_6:integer := 0; 
        IO_VAL_7:integer := 0; IO_VAL_8:integer := 0; 
        IO_VAL_9:integer := 0; OE_TYPE:integer := 0);

    port( PRESETN  : in    std_logic := 'U';
          PCLK     : in    std_logic := 'U';
          PSEL     : in    std_logic := 'U';
          PENABLE  : in    std_logic := 'U';
          PWRITE   : in    std_logic := 'U';
          PSLVERR  : out   std_logic;
          PREADY   : out   std_logic;
          INT_OR   : out   std_logic;
          PADDR    : in    std_logic_vector(7 downto 0) := (others => 'U');
          PWDATA   : in    std_logic_vector(31 downto 0) := (others => 'U');
          PRDATA   : out   std_logic_vector(31 downto 0);
          INT      : out   std_logic_vector(16 downto 0);
          GPIO_IN  : in    std_logic_vector(16 downto 0) := (others => 'U');
          GPIO_OUT : out   std_logic_vector(16 downto 0);
          GPIO_OE  : out   std_logic_vector(16 downto 0)
        );
  end component;

    signal \ADC_SPI_0_CH1_[13]\, \ADC_SPI_0_CH1_[12]\, 
        \ADC_SPI_0_CH1_[11]\, \ADC_SPI_0_CH1_[10]\, 
        \ADC_SPI_0_CH1_[9]\, \ADC_SPI_0_CH1_[8]\, 
        \ADC_SPI_0_CH1_[7]\, \ADC_SPI_0_CH1_[6]\, 
        \ADC_SPI_0_CH1_[5]\, \ADC_SPI_0_CH1_[4]\, 
        \ADC_SPI_0_CH1_[3]\, \ADC_SPI_0_CH1_[2]\, 
        \ADC_SPI_0_CH1_[1]\, \ADC_SPI_0_CH1_[0]\, 
        \ADC_SPI_0_CH2_[13]\, \ADC_SPI_0_CH2_[12]\, 
        \ADC_SPI_0_CH2_[11]\, \ADC_SPI_0_CH2_[10]\, 
        \ADC_SPI_0_CH2_[9]\, \ADC_SPI_0_CH2_[8]\, 
        \ADC_SPI_0_CH2_[7]\, \ADC_SPI_0_CH2_[6]\, 
        \ADC_SPI_0_CH2_[5]\, \ADC_SPI_0_CH2_[4]\, 
        \ADC_SPI_0_CH2_[3]\, \ADC_SPI_0_CH2_[2]\, 
        \ADC_SPI_0_CH2_[1]\, \ADC_SPI_0_CH2_[0]\, ADC_SPI_0_CSn, 
        ADC_SPI_0_sample_rdy, ADC_SPI_0_SCLK, 
        \CoreAPB3_0_APBmslave0_PADDR_[0]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[1]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[2]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[3]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[4]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[5]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[6]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[7]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[8]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[9]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[10]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[11]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[12]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[13]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[14]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[15]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[16]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[17]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[18]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[19]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[20]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[21]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[22]\, 
        \CoreAPB3_0_APBmslave0_PADDR_[23]\, 
        CoreAPB3_0_APBmslave0_PENABLE, 
        \CoreAPB3_0_APBmslave0_PRDATA_[0]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[1]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[2]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[3]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[4]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[5]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[6]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[7]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[8]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[9]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[10]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[11]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[12]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[13]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[14]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[15]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[16]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[17]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[18]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[19]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[20]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[21]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[22]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[23]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[24]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[25]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[26]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[27]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[28]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[29]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[30]\, 
        \CoreAPB3_0_APBmslave0_PRDATA_[31]\, 
        CoreAPB3_0_APBmslave0_PREADY, CoreAPB3_0_APBmslave0_PSELx, 
        CoreAPB3_0_APBmslave0_PSLVERR, 
        \CoreAPB3_0_APBmslave0_PWDATA_[0]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[1]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[2]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[3]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[4]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[5]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[6]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[7]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[8]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[9]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[10]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[11]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[12]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[13]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[14]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[15]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[16]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[17]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[18]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[19]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[20]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[21]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[22]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[23]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[24]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[25]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[26]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[27]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[28]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[29]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[30]\, 
        \CoreAPB3_0_APBmslave0_PWDATA_[31]\, 
        CoreAPB3_0_APBmslave0_PWRITE, 
        \CoreAPB3_0_APBmslave1_PADDR_[0]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[1]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[2]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[3]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[4]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[5]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[6]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[7]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[8]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[9]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[10]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[11]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[12]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[13]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[14]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[15]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[16]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[17]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[18]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[19]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[20]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[21]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[22]\, 
        \CoreAPB3_0_APBmslave1_PADDR_[23]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[0]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[1]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[2]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[3]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[4]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[5]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[6]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[7]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[8]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[9]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[10]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[11]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[12]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[13]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[14]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[15]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[16]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[17]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[18]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[19]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[20]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[21]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[22]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[23]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[24]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[25]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[26]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[27]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[28]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[29]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[30]\, 
        \CoreAPB3_0_APBmslave1_PRDATA_[31]\, 
        CoreAPB3_0_APBmslave1_PREADY, CoreAPB3_0_APBmslave1_PSELx, 
        CoreAPB3_0_APBmslave1_PSLVERR, CoreGPIO_0_GPIO_OUT0to0, 
        CoreGPIO_0_GPIO_OUT1to1, CoreGPIO_0_GPIO_OUT2to2, 
        CoreGPIO_0_GPIO_OUT4to4, CoreGPIO_0_GPIO_OUT5to5, 
        CoreGPIO_0_GPIO_OUT6to6_0, CoreGPIO_0_GPIO_OUT7to7, 
        \DDC_0_I_out_1_[26]\, \DDC_0_I_out_1_[25]\, 
        \DDC_0_I_out_1_[24]\, \DDC_0_I_out_1_[23]\, 
        \DDC_0_I_out_1_[22]\, \DDC_0_I_out_1_[21]\, 
        \DDC_0_I_out_1_[20]\, \DDC_0_I_out_1_[19]\, 
        \DDC_0_I_out_1_[18]\, \DDC_0_I_out_1_[17]\, 
        \DDC_0_I_out_1_[16]\, \DDC_0_I_out_1_[15]\, 
        \DDC_0_I_out_1_[14]\, \DDC_0_I_out_1_[13]\, 
        \DDC_0_I_out_1_[12]\, \DDC_0_I_out_1_[11]\, 
        \DDC_0_I_out_1_[10]\, \DDC_0_I_out_1_[9]\, 
        \DDC_0_I_out_1_[8]\, \DDC_0_I_out_1_[7]\, 
        \DDC_0_I_out_1_[6]\, \DDC_0_I_out_1_[5]\, 
        \DDC_0_I_out_1_[4]\, \DDC_0_I_out_1_[3]\, 
        \DDC_0_I_out_1_[2]\, \DDC_0_I_out_1_[1]\, 
        \DDC_0_I_out_1_[0]\, DDC_0_I_SMPL_RDY, 
        \DDC_0_Q_out_0_[26]\, \DDC_0_Q_out_0_[25]\, 
        \DDC_0_Q_out_0_[24]\, \DDC_0_Q_out_0_[23]\, 
        \DDC_0_Q_out_0_[22]\, \DDC_0_Q_out_0_[21]\, 
        \DDC_0_Q_out_0_[20]\, \DDC_0_Q_out_0_[19]\, 
        \DDC_0_Q_out_0_[18]\, \DDC_0_Q_out_0_[17]\, 
        \DDC_0_Q_out_0_[16]\, \DDC_0_Q_out_0_[15]\, 
        \DDC_0_Q_out_0_[14]\, \DDC_0_Q_out_0_[13]\, 
        \DDC_0_Q_out_0_[12]\, \DDC_0_Q_out_0_[11]\, 
        \DDC_0_Q_out_0_[10]\, \DDC_0_Q_out_0_[9]\, 
        \DDC_0_Q_out_0_[8]\, \DDC_0_Q_out_0_[7]\, 
        \DDC_0_Q_out_0_[6]\, \DDC_0_Q_out_0_[5]\, 
        \DDC_0_Q_out_0_[4]\, \DDC_0_Q_out_0_[3]\, 
        \DDC_0_Q_out_0_[2]\, \DDC_0_Q_out_0_[1]\, 
        \DDC_0_Q_out_0_[0]\, \SAMPLE_APB3_0_DC_OFFSETI_[13]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[12]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[11]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[10]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[9]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[8]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[7]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[6]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[5]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[4]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[3]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[2]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[1]\, 
        \SAMPLE_APB3_0_DC_OFFSETI_[0]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[13]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[12]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[11]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[10]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[9]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[8]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[7]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[6]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[5]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[4]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[3]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[2]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[1]\, 
        \SAMPLE_APB3_0_DC_OFFSETQ_[0]\, 
        \SAMPLE_APB3_0_DPHASE_[15]\, \SAMPLE_APB3_0_DPHASE_[14]\, 
        \SAMPLE_APB3_0_DPHASE_[13]\, \SAMPLE_APB3_0_DPHASE_[12]\, 
        \SAMPLE_APB3_0_DPHASE_[11]\, \SAMPLE_APB3_0_DPHASE_[10]\, 
        \SAMPLE_APB3_0_DPHASE_[9]\, \SAMPLE_APB3_0_DPHASE_[8]\, 
        \SAMPLE_APB3_0_DPHASE_[7]\, \SAMPLE_APB3_0_DPHASE_[6]\, 
        \SAMPLE_APB3_0_DPHASE_[5]\, \SAMPLE_APB3_0_DPHASE_[4]\, 
        \SAMPLE_APB3_0_DPHASE_[3]\, \SAMPLE_APB3_0_DPHASE_[2]\, 
        \SAMPLE_APB3_0_DPHASE_[1]\, \SAMPLE_APB3_0_DPHASE_[0]\, 
        \SMPL_RDY\, uC_0_FAB_CLK, uC_0_IO_3_Y, uC_0_IO_6_Y, 
        uC_0_IO_7_Y, uC_0_M2F_RESET_N, INV_0_Y, 
        \uC_0_MSS_MASTER_APB_PADDR_[0]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[1]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[2]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[3]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[4]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[5]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[6]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[7]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[8]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[9]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[10]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[11]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[12]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[13]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[14]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[15]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[16]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[17]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[18]\, 
        \uC_0_MSS_MASTER_APB_PADDR_[19]\, 
        uC_0_MSS_MASTER_APB_PENABLE, 
        \uC_0_MSS_MASTER_APB_PRDATA_[0]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[1]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[2]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[3]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[4]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[5]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[6]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[7]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[8]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[9]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[10]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[11]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[12]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[13]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[14]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[15]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[16]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[17]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[18]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[19]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[20]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[21]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[22]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[23]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[24]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[25]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[26]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[27]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[28]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[29]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[30]\, 
        \uC_0_MSS_MASTER_APB_PRDATA_[31]\, 
        uC_0_MSS_MASTER_APB_PREADY, uC_0_MSS_MASTER_APB_PSELx, 
        uC_0_MSS_MASTER_APB_PSLVERR, 
        \uC_0_MSS_MASTER_APB_PWDATA_[0]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[1]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[2]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[3]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[4]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[5]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[6]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[7]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[8]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[9]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[10]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[11]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[12]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[13]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[14]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[15]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[16]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[17]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[18]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[19]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[20]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[21]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[22]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[23]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[24]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[25]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[26]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[27]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[28]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[29]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[30]\, 
        \uC_0_MSS_MASTER_APB_PWDATA_[31]\, 
        uC_0_MSS_MASTER_APB_PWRITE, GND_net, VCC_net : std_logic;
    signal nc34, nc9, nc13, nc23, nc33, nc16, nc26, nc27, nc17, 
        nc36, nc5, nc4, nc25, nc15, nc35, nc28, nc18, nc1, nc2, 
        nc22, nc12, nc21, nc11, nc3, nc32, nc31, nc7, nc6, nc19, 
        nc29, nc8, nc20, nc10, nc24, nc14, nc30 : std_logic;

begin 

    SMPL_RDY <= \SMPL_RDY\;

    DDC_0 : DDC
      port map(RST => INV_0_Y, CLK => uC_0_FAB_CLK, sample_rdy_in
         => ADC_SPI_0_sample_rdy, I_SMPL_RDY => DDC_0_I_SMPL_RDY, 
        Q_SMPL_RDY => OPEN, I_in(13) => \ADC_SPI_0_CH2_[13]\, 
        I_in(12) => \ADC_SPI_0_CH2_[12]\, I_in(11) => 
        \ADC_SPI_0_CH2_[11]\, I_in(10) => \ADC_SPI_0_CH2_[10]\, 
        I_in(9) => \ADC_SPI_0_CH2_[9]\, I_in(8) => 
        \ADC_SPI_0_CH2_[8]\, I_in(7) => \ADC_SPI_0_CH2_[7]\, 
        I_in(6) => \ADC_SPI_0_CH2_[6]\, I_in(5) => 
        \ADC_SPI_0_CH2_[5]\, I_in(4) => \ADC_SPI_0_CH2_[4]\, 
        I_in(3) => \ADC_SPI_0_CH2_[3]\, I_in(2) => 
        \ADC_SPI_0_CH2_[2]\, I_in(1) => \ADC_SPI_0_CH2_[1]\, 
        I_in(0) => \ADC_SPI_0_CH2_[0]\, Q_in(13) => 
        \ADC_SPI_0_CH1_[13]\, Q_in(12) => \ADC_SPI_0_CH1_[12]\, 
        Q_in(11) => \ADC_SPI_0_CH1_[11]\, Q_in(10) => 
        \ADC_SPI_0_CH1_[10]\, Q_in(9) => \ADC_SPI_0_CH1_[9]\, 
        Q_in(8) => \ADC_SPI_0_CH1_[8]\, Q_in(7) => 
        \ADC_SPI_0_CH1_[7]\, Q_in(6) => \ADC_SPI_0_CH1_[6]\, 
        Q_in(5) => \ADC_SPI_0_CH1_[5]\, Q_in(4) => 
        \ADC_SPI_0_CH1_[4]\, Q_in(3) => \ADC_SPI_0_CH1_[3]\, 
        Q_in(2) => \ADC_SPI_0_CH1_[2]\, Q_in(1) => 
        \ADC_SPI_0_CH1_[1]\, Q_in(0) => \ADC_SPI_0_CH1_[0]\, 
        DPHASE(15) => \SAMPLE_APB3_0_DPHASE_[15]\, DPHASE(14) => 
        \SAMPLE_APB3_0_DPHASE_[14]\, DPHASE(13) => 
        \SAMPLE_APB3_0_DPHASE_[13]\, DPHASE(12) => 
        \SAMPLE_APB3_0_DPHASE_[12]\, DPHASE(11) => 
        \SAMPLE_APB3_0_DPHASE_[11]\, DPHASE(10) => 
        \SAMPLE_APB3_0_DPHASE_[10]\, DPHASE(9) => 
        \SAMPLE_APB3_0_DPHASE_[9]\, DPHASE(8) => 
        \SAMPLE_APB3_0_DPHASE_[8]\, DPHASE(7) => 
        \SAMPLE_APB3_0_DPHASE_[7]\, DPHASE(6) => 
        \SAMPLE_APB3_0_DPHASE_[6]\, DPHASE(5) => 
        \SAMPLE_APB3_0_DPHASE_[5]\, DPHASE(4) => 
        \SAMPLE_APB3_0_DPHASE_[4]\, DPHASE(3) => 
        \SAMPLE_APB3_0_DPHASE_[3]\, DPHASE(2) => 
        \SAMPLE_APB3_0_DPHASE_[2]\, DPHASE(1) => 
        \SAMPLE_APB3_0_DPHASE_[1]\, DPHASE(0) => 
        \SAMPLE_APB3_0_DPHASE_[0]\, I_out(26) => 
        \DDC_0_I_out_1_[26]\, I_out(25) => \DDC_0_I_out_1_[25]\, 
        I_out(24) => \DDC_0_I_out_1_[24]\, I_out(23) => 
        \DDC_0_I_out_1_[23]\, I_out(22) => \DDC_0_I_out_1_[22]\, 
        I_out(21) => \DDC_0_I_out_1_[21]\, I_out(20) => 
        \DDC_0_I_out_1_[20]\, I_out(19) => \DDC_0_I_out_1_[19]\, 
        I_out(18) => \DDC_0_I_out_1_[18]\, I_out(17) => 
        \DDC_0_I_out_1_[17]\, I_out(16) => \DDC_0_I_out_1_[16]\, 
        I_out(15) => \DDC_0_I_out_1_[15]\, I_out(14) => 
        \DDC_0_I_out_1_[14]\, I_out(13) => \DDC_0_I_out_1_[13]\, 
        I_out(12) => \DDC_0_I_out_1_[12]\, I_out(11) => 
        \DDC_0_I_out_1_[11]\, I_out(10) => \DDC_0_I_out_1_[10]\, 
        I_out(9) => \DDC_0_I_out_1_[9]\, I_out(8) => 
        \DDC_0_I_out_1_[8]\, I_out(7) => \DDC_0_I_out_1_[7]\, 
        I_out(6) => \DDC_0_I_out_1_[6]\, I_out(5) => 
        \DDC_0_I_out_1_[5]\, I_out(4) => \DDC_0_I_out_1_[4]\, 
        I_out(3) => \DDC_0_I_out_1_[3]\, I_out(2) => 
        \DDC_0_I_out_1_[2]\, I_out(1) => \DDC_0_I_out_1_[1]\, 
        I_out(0) => \DDC_0_I_out_1_[0]\, Q_out(26) => 
        \DDC_0_Q_out_0_[26]\, Q_out(25) => \DDC_0_Q_out_0_[25]\, 
        Q_out(24) => \DDC_0_Q_out_0_[24]\, Q_out(23) => 
        \DDC_0_Q_out_0_[23]\, Q_out(22) => \DDC_0_Q_out_0_[22]\, 
        Q_out(21) => \DDC_0_Q_out_0_[21]\, Q_out(20) => 
        \DDC_0_Q_out_0_[20]\, Q_out(19) => \DDC_0_Q_out_0_[19]\, 
        Q_out(18) => \DDC_0_Q_out_0_[18]\, Q_out(17) => 
        \DDC_0_Q_out_0_[17]\, Q_out(16) => \DDC_0_Q_out_0_[16]\, 
        Q_out(15) => \DDC_0_Q_out_0_[15]\, Q_out(14) => 
        \DDC_0_Q_out_0_[14]\, Q_out(13) => \DDC_0_Q_out_0_[13]\, 
        Q_out(12) => \DDC_0_Q_out_0_[12]\, Q_out(11) => 
        \DDC_0_Q_out_0_[11]\, Q_out(10) => \DDC_0_Q_out_0_[10]\, 
        Q_out(9) => \DDC_0_Q_out_0_[9]\, Q_out(8) => 
        \DDC_0_Q_out_0_[8]\, Q_out(7) => \DDC_0_Q_out_0_[7]\, 
        Q_out(6) => \DDC_0_Q_out_0_[6]\, Q_out(5) => 
        \DDC_0_Q_out_0_[5]\, Q_out(4) => \DDC_0_Q_out_0_[4]\, 
        Q_out(3) => \DDC_0_Q_out_0_[3]\, Q_out(2) => 
        \DDC_0_Q_out_0_[2]\, Q_out(1) => \DDC_0_Q_out_0_[1]\, 
        Q_out(0) => \DDC_0_Q_out_0_[0]\, DC_OFFSETI(13) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[13]\, DC_OFFSETI(12) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[12]\, DC_OFFSETI(11) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[11]\, DC_OFFSETI(10) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[10]\, DC_OFFSETI(9) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[9]\, DC_OFFSETI(8) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[8]\, DC_OFFSETI(7) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[7]\, DC_OFFSETI(6) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[6]\, DC_OFFSETI(5) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[5]\, DC_OFFSETI(4) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[4]\, DC_OFFSETI(3) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[3]\, DC_OFFSETI(2) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[2]\, DC_OFFSETI(1) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[1]\, DC_OFFSETI(0) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[0]\, DC_OFFSETQ(13) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[13]\, DC_OFFSETQ(12) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[12]\, DC_OFFSETQ(11) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[11]\, DC_OFFSETQ(10) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[10]\, DC_OFFSETQ(9) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[9]\, DC_OFFSETQ(8) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[8]\, DC_OFFSETQ(7) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[7]\, DC_OFFSETQ(6) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[6]\, DC_OFFSETQ(5) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[5]\, DC_OFFSETQ(4) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[4]\, DC_OFFSETQ(3) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[3]\, DC_OFFSETQ(2) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[2]\, DC_OFFSETQ(1) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[1]\, DC_OFFSETQ(0) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[0]\);
    
    CoreAPB3_0 : CoreAPB3
      generic map(APBSLOT0ENABLE => 1, APBSLOT10ENABLE => 0,
         APBSLOT11ENABLE => 0, APBSLOT12ENABLE => 0,
         APBSLOT13ENABLE => 0, APBSLOT14ENABLE => 0,
         APBSLOT15ENABLE => 0, APBSLOT1ENABLE => 1,
         APBSLOT2ENABLE => 0, APBSLOT3ENABLE => 0,
         APBSLOT4ENABLE => 0, APBSLOT5ENABLE => 0,
         APBSLOT6ENABLE => 0, APBSLOT7ENABLE => 0,
         APBSLOT8ENABLE => 0, APBSLOT9ENABLE => 0,
         APB_DWIDTH => 32, IADDR_ENABLE => 0, RANGESIZE => 256)

      port map(PRESETN => GND_net, PCLK => GND_net, PWRITE => 
        uC_0_MSS_MASTER_APB_PWRITE, PENABLE => 
        uC_0_MSS_MASTER_APB_PENABLE, PSEL => 
        uC_0_MSS_MASTER_APB_PSELx, PREADY => 
        uC_0_MSS_MASTER_APB_PREADY, PSLVERR => 
        uC_0_MSS_MASTER_APB_PSLVERR, PWRITES => 
        CoreAPB3_0_APBmslave0_PWRITE, PENABLES => 
        CoreAPB3_0_APBmslave0_PENABLE, PSELS0 => 
        CoreAPB3_0_APBmslave0_PSELx, PREADYS0 => 
        CoreAPB3_0_APBmslave0_PREADY, PSLVERRS0 => 
        CoreAPB3_0_APBmslave0_PSLVERR, PSELS1 => 
        CoreAPB3_0_APBmslave1_PSELx, PREADYS1 => 
        CoreAPB3_0_APBmslave1_PREADY, PSLVERRS1 => 
        CoreAPB3_0_APBmslave1_PSLVERR, PSELS2 => OPEN, PREADYS2
         => VCC_net, PSLVERRS2 => GND_net, PSELS3 => OPEN, 
        PREADYS3 => VCC_net, PSLVERRS3 => GND_net, PSELS4 => OPEN, 
        PREADYS4 => VCC_net, PSLVERRS4 => GND_net, PSELS5 => OPEN, 
        PREADYS5 => VCC_net, PSLVERRS5 => GND_net, PSELS6 => OPEN, 
        PREADYS6 => VCC_net, PSLVERRS6 => GND_net, PSELS7 => OPEN, 
        PREADYS7 => VCC_net, PSLVERRS7 => GND_net, PSELS8 => OPEN, 
        PREADYS8 => VCC_net, PSLVERRS8 => GND_net, PSELS9 => OPEN, 
        PREADYS9 => VCC_net, PSLVERRS9 => GND_net, PSELS10 => 
        OPEN, PREADYS10 => VCC_net, PSLVERRS10 => GND_net, 
        PSELS11 => OPEN, PREADYS11 => VCC_net, PSLVERRS11 => 
        GND_net, PSELS12 => OPEN, PREADYS12 => VCC_net, 
        PSLVERRS12 => GND_net, PSELS13 => OPEN, PREADYS13 => 
        VCC_net, PSLVERRS13 => GND_net, PSELS14 => OPEN, 
        PREADYS14 => VCC_net, PSLVERRS14 => GND_net, PSELS15 => 
        OPEN, PREADYS15 => VCC_net, PSLVERRS15 => GND_net, 
        PADDR(23) => GND_net, PADDR(22) => GND_net, PADDR(21) => 
        GND_net, PADDR(20) => GND_net, PADDR(19) => 
        \uC_0_MSS_MASTER_APB_PADDR_[19]\, PADDR(18) => 
        \uC_0_MSS_MASTER_APB_PADDR_[18]\, PADDR(17) => 
        \uC_0_MSS_MASTER_APB_PADDR_[17]\, PADDR(16) => 
        \uC_0_MSS_MASTER_APB_PADDR_[16]\, PADDR(15) => 
        \uC_0_MSS_MASTER_APB_PADDR_[15]\, PADDR(14) => 
        \uC_0_MSS_MASTER_APB_PADDR_[14]\, PADDR(13) => 
        \uC_0_MSS_MASTER_APB_PADDR_[13]\, PADDR(12) => 
        \uC_0_MSS_MASTER_APB_PADDR_[12]\, PADDR(11) => 
        \uC_0_MSS_MASTER_APB_PADDR_[11]\, PADDR(10) => 
        \uC_0_MSS_MASTER_APB_PADDR_[10]\, PADDR(9) => 
        \uC_0_MSS_MASTER_APB_PADDR_[9]\, PADDR(8) => 
        \uC_0_MSS_MASTER_APB_PADDR_[8]\, PADDR(7) => 
        \uC_0_MSS_MASTER_APB_PADDR_[7]\, PADDR(6) => 
        \uC_0_MSS_MASTER_APB_PADDR_[6]\, PADDR(5) => 
        \uC_0_MSS_MASTER_APB_PADDR_[5]\, PADDR(4) => 
        \uC_0_MSS_MASTER_APB_PADDR_[4]\, PADDR(3) => 
        \uC_0_MSS_MASTER_APB_PADDR_[3]\, PADDR(2) => 
        \uC_0_MSS_MASTER_APB_PADDR_[2]\, PADDR(1) => 
        \uC_0_MSS_MASTER_APB_PADDR_[1]\, PADDR(0) => 
        \uC_0_MSS_MASTER_APB_PADDR_[0]\, PWDATA(31) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[31]\, PWDATA(30) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[30]\, PWDATA(29) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[29]\, PWDATA(28) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[28]\, PWDATA(27) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[27]\, PWDATA(26) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[26]\, PWDATA(25) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[25]\, PWDATA(24) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[24]\, PWDATA(23) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[23]\, PWDATA(22) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[22]\, PWDATA(21) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[21]\, PWDATA(20) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[20]\, PWDATA(19) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[19]\, PWDATA(18) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[18]\, PWDATA(17) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[17]\, PWDATA(16) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[16]\, PWDATA(15) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[15]\, PWDATA(14) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[14]\, PWDATA(13) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[13]\, PWDATA(12) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[12]\, PWDATA(11) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[11]\, PWDATA(10) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[10]\, PWDATA(9) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[9]\, PWDATA(8) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[8]\, PWDATA(7) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[7]\, PWDATA(6) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[6]\, PWDATA(5) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[5]\, PWDATA(4) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[4]\, PWDATA(3) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[3]\, PWDATA(2) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[2]\, PWDATA(1) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[1]\, PWDATA(0) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[0]\, PRDATA(31) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[31]\, PRDATA(30) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[30]\, PRDATA(29) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[29]\, PRDATA(28) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[28]\, PRDATA(27) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[27]\, PRDATA(26) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[26]\, PRDATA(25) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[25]\, PRDATA(24) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[24]\, PRDATA(23) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[23]\, PRDATA(22) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[22]\, PRDATA(21) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[21]\, PRDATA(20) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[20]\, PRDATA(19) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[19]\, PRDATA(18) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[18]\, PRDATA(17) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[17]\, PRDATA(16) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[16]\, PRDATA(15) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[15]\, PRDATA(14) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[14]\, PRDATA(13) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[13]\, PRDATA(12) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[12]\, PRDATA(11) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[11]\, PRDATA(10) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[10]\, PRDATA(9) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[9]\, PRDATA(8) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[8]\, PRDATA(7) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[7]\, PRDATA(6) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[6]\, PRDATA(5) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[5]\, PRDATA(4) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[4]\, PRDATA(3) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[3]\, PRDATA(2) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[2]\, PRDATA(1) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[1]\, PRDATA(0) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[0]\, PADDRS(23) => 
        \CoreAPB3_0_APBmslave1_PADDR_[23]\, PADDRS(22) => 
        \CoreAPB3_0_APBmslave1_PADDR_[22]\, PADDRS(21) => 
        \CoreAPB3_0_APBmslave1_PADDR_[21]\, PADDRS(20) => 
        \CoreAPB3_0_APBmslave1_PADDR_[20]\, PADDRS(19) => 
        \CoreAPB3_0_APBmslave1_PADDR_[19]\, PADDRS(18) => 
        \CoreAPB3_0_APBmslave1_PADDR_[18]\, PADDRS(17) => 
        \CoreAPB3_0_APBmslave1_PADDR_[17]\, PADDRS(16) => 
        \CoreAPB3_0_APBmslave1_PADDR_[16]\, PADDRS(15) => 
        \CoreAPB3_0_APBmslave1_PADDR_[15]\, PADDRS(14) => 
        \CoreAPB3_0_APBmslave1_PADDR_[14]\, PADDRS(13) => 
        \CoreAPB3_0_APBmslave1_PADDR_[13]\, PADDRS(12) => 
        \CoreAPB3_0_APBmslave1_PADDR_[12]\, PADDRS(11) => 
        \CoreAPB3_0_APBmslave1_PADDR_[11]\, PADDRS(10) => 
        \CoreAPB3_0_APBmslave1_PADDR_[10]\, PADDRS(9) => 
        \CoreAPB3_0_APBmslave1_PADDR_[9]\, PADDRS(8) => 
        \CoreAPB3_0_APBmslave1_PADDR_[8]\, PADDRS(7) => 
        \CoreAPB3_0_APBmslave1_PADDR_[7]\, PADDRS(6) => 
        \CoreAPB3_0_APBmslave1_PADDR_[6]\, PADDRS(5) => 
        \CoreAPB3_0_APBmslave1_PADDR_[5]\, PADDRS(4) => 
        \CoreAPB3_0_APBmslave1_PADDR_[4]\, PADDRS(3) => 
        \CoreAPB3_0_APBmslave1_PADDR_[3]\, PADDRS(2) => 
        \CoreAPB3_0_APBmslave1_PADDR_[2]\, PADDRS(1) => 
        \CoreAPB3_0_APBmslave1_PADDR_[1]\, PADDRS(0) => 
        \CoreAPB3_0_APBmslave1_PADDR_[0]\, PADDRS0(23) => 
        \CoreAPB3_0_APBmslave0_PADDR_[23]\, PADDRS0(22) => 
        \CoreAPB3_0_APBmslave0_PADDR_[22]\, PADDRS0(21) => 
        \CoreAPB3_0_APBmslave0_PADDR_[21]\, PADDRS0(20) => 
        \CoreAPB3_0_APBmslave0_PADDR_[20]\, PADDRS0(19) => 
        \CoreAPB3_0_APBmslave0_PADDR_[19]\, PADDRS0(18) => 
        \CoreAPB3_0_APBmslave0_PADDR_[18]\, PADDRS0(17) => 
        \CoreAPB3_0_APBmslave0_PADDR_[17]\, PADDRS0(16) => 
        \CoreAPB3_0_APBmslave0_PADDR_[16]\, PADDRS0(15) => 
        \CoreAPB3_0_APBmslave0_PADDR_[15]\, PADDRS0(14) => 
        \CoreAPB3_0_APBmslave0_PADDR_[14]\, PADDRS0(13) => 
        \CoreAPB3_0_APBmslave0_PADDR_[13]\, PADDRS0(12) => 
        \CoreAPB3_0_APBmslave0_PADDR_[12]\, PADDRS0(11) => 
        \CoreAPB3_0_APBmslave0_PADDR_[11]\, PADDRS0(10) => 
        \CoreAPB3_0_APBmslave0_PADDR_[10]\, PADDRS0(9) => 
        \CoreAPB3_0_APBmslave0_PADDR_[9]\, PADDRS0(8) => 
        \CoreAPB3_0_APBmslave0_PADDR_[8]\, PADDRS0(7) => 
        \CoreAPB3_0_APBmslave0_PADDR_[7]\, PADDRS0(6) => 
        \CoreAPB3_0_APBmslave0_PADDR_[6]\, PADDRS0(5) => 
        \CoreAPB3_0_APBmslave0_PADDR_[5]\, PADDRS0(4) => 
        \CoreAPB3_0_APBmslave0_PADDR_[4]\, PADDRS0(3) => 
        \CoreAPB3_0_APBmslave0_PADDR_[3]\, PADDRS0(2) => 
        \CoreAPB3_0_APBmslave0_PADDR_[2]\, PADDRS0(1) => 
        \CoreAPB3_0_APBmslave0_PADDR_[1]\, PADDRS0(0) => 
        \CoreAPB3_0_APBmslave0_PADDR_[0]\, PWDATAS(31) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[31]\, PWDATAS(30) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[30]\, PWDATAS(29) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[29]\, PWDATAS(28) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[28]\, PWDATAS(27) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[27]\, PWDATAS(26) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[26]\, PWDATAS(25) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[25]\, PWDATAS(24) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[24]\, PWDATAS(23) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[23]\, PWDATAS(22) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[22]\, PWDATAS(21) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[21]\, PWDATAS(20) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[20]\, PWDATAS(19) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[19]\, PWDATAS(18) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[18]\, PWDATAS(17) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[17]\, PWDATAS(16) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[16]\, PWDATAS(15) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[15]\, PWDATAS(14) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[14]\, PWDATAS(13) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[13]\, PWDATAS(12) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[12]\, PWDATAS(11) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[11]\, PWDATAS(10) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[10]\, PWDATAS(9) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[9]\, PWDATAS(8) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[8]\, PWDATAS(7) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[7]\, PWDATAS(6) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[6]\, PWDATAS(5) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[5]\, PWDATAS(4) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[4]\, PWDATAS(3) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[3]\, PWDATAS(2) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[2]\, PWDATAS(1) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[1]\, PWDATAS(0) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[0]\, PRDATAS0(31) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[31]\, PRDATAS0(30) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[30]\, PRDATAS0(29) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[29]\, PRDATAS0(28) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[28]\, PRDATAS0(27) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[27]\, PRDATAS0(26) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[26]\, PRDATAS0(25) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[25]\, PRDATAS0(24) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[24]\, PRDATAS0(23) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[23]\, PRDATAS0(22) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[22]\, PRDATAS0(21) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[21]\, PRDATAS0(20) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[20]\, PRDATAS0(19) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[19]\, PRDATAS0(18) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[18]\, PRDATAS0(17) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[17]\, PRDATAS0(16) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[16]\, PRDATAS0(15) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[15]\, PRDATAS0(14) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[14]\, PRDATAS0(13) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[13]\, PRDATAS0(12) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[12]\, PRDATAS0(11) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[11]\, PRDATAS0(10) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[10]\, PRDATAS0(9) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[9]\, PRDATAS0(8) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[8]\, PRDATAS0(7) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[7]\, PRDATAS0(6) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[6]\, PRDATAS0(5) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[5]\, PRDATAS0(4) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[4]\, PRDATAS0(3) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[3]\, PRDATAS0(2) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[2]\, PRDATAS0(1) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[1]\, PRDATAS0(0) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[0]\, PRDATAS1(31) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[31]\, PRDATAS1(30) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[30]\, PRDATAS1(29) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[29]\, PRDATAS1(28) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[28]\, PRDATAS1(27) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[27]\, PRDATAS1(26) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[26]\, PRDATAS1(25) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[25]\, PRDATAS1(24) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[24]\, PRDATAS1(23) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[23]\, PRDATAS1(22) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[22]\, PRDATAS1(21) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[21]\, PRDATAS1(20) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[20]\, PRDATAS1(19) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[19]\, PRDATAS1(18) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[18]\, PRDATAS1(17) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[17]\, PRDATAS1(16) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[16]\, PRDATAS1(15) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[15]\, PRDATAS1(14) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[14]\, PRDATAS1(13) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[13]\, PRDATAS1(12) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[12]\, PRDATAS1(11) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[11]\, PRDATAS1(10) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[10]\, PRDATAS1(9) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[9]\, PRDATAS1(8) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[8]\, PRDATAS1(7) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[7]\, PRDATAS1(6) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[6]\, PRDATAS1(5) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[5]\, PRDATAS1(4) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[4]\, PRDATAS1(3) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[3]\, PRDATAS1(2) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[2]\, PRDATAS1(1) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[1]\, PRDATAS1(0) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[0]\, PRDATAS2(31) => 
        GND_net, PRDATAS2(30) => GND_net, PRDATAS2(29) => GND_net, 
        PRDATAS2(28) => GND_net, PRDATAS2(27) => GND_net, 
        PRDATAS2(26) => GND_net, PRDATAS2(25) => GND_net, 
        PRDATAS2(24) => GND_net, PRDATAS2(23) => GND_net, 
        PRDATAS2(22) => GND_net, PRDATAS2(21) => GND_net, 
        PRDATAS2(20) => GND_net, PRDATAS2(19) => GND_net, 
        PRDATAS2(18) => GND_net, PRDATAS2(17) => GND_net, 
        PRDATAS2(16) => GND_net, PRDATAS2(15) => GND_net, 
        PRDATAS2(14) => GND_net, PRDATAS2(13) => GND_net, 
        PRDATAS2(12) => GND_net, PRDATAS2(11) => GND_net, 
        PRDATAS2(10) => GND_net, PRDATAS2(9) => GND_net, 
        PRDATAS2(8) => GND_net, PRDATAS2(7) => GND_net, 
        PRDATAS2(6) => GND_net, PRDATAS2(5) => GND_net, 
        PRDATAS2(4) => GND_net, PRDATAS2(3) => GND_net, 
        PRDATAS2(2) => GND_net, PRDATAS2(1) => GND_net, 
        PRDATAS2(0) => GND_net, PRDATAS3(31) => GND_net, 
        PRDATAS3(30) => GND_net, PRDATAS3(29) => GND_net, 
        PRDATAS3(28) => GND_net, PRDATAS3(27) => GND_net, 
        PRDATAS3(26) => GND_net, PRDATAS3(25) => GND_net, 
        PRDATAS3(24) => GND_net, PRDATAS3(23) => GND_net, 
        PRDATAS3(22) => GND_net, PRDATAS3(21) => GND_net, 
        PRDATAS3(20) => GND_net, PRDATAS3(19) => GND_net, 
        PRDATAS3(18) => GND_net, PRDATAS3(17) => GND_net, 
        PRDATAS3(16) => GND_net, PRDATAS3(15) => GND_net, 
        PRDATAS3(14) => GND_net, PRDATAS3(13) => GND_net, 
        PRDATAS3(12) => GND_net, PRDATAS3(11) => GND_net, 
        PRDATAS3(10) => GND_net, PRDATAS3(9) => GND_net, 
        PRDATAS3(8) => GND_net, PRDATAS3(7) => GND_net, 
        PRDATAS3(6) => GND_net, PRDATAS3(5) => GND_net, 
        PRDATAS3(4) => GND_net, PRDATAS3(3) => GND_net, 
        PRDATAS3(2) => GND_net, PRDATAS3(1) => GND_net, 
        PRDATAS3(0) => GND_net, PRDATAS4(31) => GND_net, 
        PRDATAS4(30) => GND_net, PRDATAS4(29) => GND_net, 
        PRDATAS4(28) => GND_net, PRDATAS4(27) => GND_net, 
        PRDATAS4(26) => GND_net, PRDATAS4(25) => GND_net, 
        PRDATAS4(24) => GND_net, PRDATAS4(23) => GND_net, 
        PRDATAS4(22) => GND_net, PRDATAS4(21) => GND_net, 
        PRDATAS4(20) => GND_net, PRDATAS4(19) => GND_net, 
        PRDATAS4(18) => GND_net, PRDATAS4(17) => GND_net, 
        PRDATAS4(16) => GND_net, PRDATAS4(15) => GND_net, 
        PRDATAS4(14) => GND_net, PRDATAS4(13) => GND_net, 
        PRDATAS4(12) => GND_net, PRDATAS4(11) => GND_net, 
        PRDATAS4(10) => GND_net, PRDATAS4(9) => GND_net, 
        PRDATAS4(8) => GND_net, PRDATAS4(7) => GND_net, 
        PRDATAS4(6) => GND_net, PRDATAS4(5) => GND_net, 
        PRDATAS4(4) => GND_net, PRDATAS4(3) => GND_net, 
        PRDATAS4(2) => GND_net, PRDATAS4(1) => GND_net, 
        PRDATAS4(0) => GND_net, PRDATAS5(31) => GND_net, 
        PRDATAS5(30) => GND_net, PRDATAS5(29) => GND_net, 
        PRDATAS5(28) => GND_net, PRDATAS5(27) => GND_net, 
        PRDATAS5(26) => GND_net, PRDATAS5(25) => GND_net, 
        PRDATAS5(24) => GND_net, PRDATAS5(23) => GND_net, 
        PRDATAS5(22) => GND_net, PRDATAS5(21) => GND_net, 
        PRDATAS5(20) => GND_net, PRDATAS5(19) => GND_net, 
        PRDATAS5(18) => GND_net, PRDATAS5(17) => GND_net, 
        PRDATAS5(16) => GND_net, PRDATAS5(15) => GND_net, 
        PRDATAS5(14) => GND_net, PRDATAS5(13) => GND_net, 
        PRDATAS5(12) => GND_net, PRDATAS5(11) => GND_net, 
        PRDATAS5(10) => GND_net, PRDATAS5(9) => GND_net, 
        PRDATAS5(8) => GND_net, PRDATAS5(7) => GND_net, 
        PRDATAS5(6) => GND_net, PRDATAS5(5) => GND_net, 
        PRDATAS5(4) => GND_net, PRDATAS5(3) => GND_net, 
        PRDATAS5(2) => GND_net, PRDATAS5(1) => GND_net, 
        PRDATAS5(0) => GND_net, PRDATAS6(31) => GND_net, 
        PRDATAS6(30) => GND_net, PRDATAS6(29) => GND_net, 
        PRDATAS6(28) => GND_net, PRDATAS6(27) => GND_net, 
        PRDATAS6(26) => GND_net, PRDATAS6(25) => GND_net, 
        PRDATAS6(24) => GND_net, PRDATAS6(23) => GND_net, 
        PRDATAS6(22) => GND_net, PRDATAS6(21) => GND_net, 
        PRDATAS6(20) => GND_net, PRDATAS6(19) => GND_net, 
        PRDATAS6(18) => GND_net, PRDATAS6(17) => GND_net, 
        PRDATAS6(16) => GND_net, PRDATAS6(15) => GND_net, 
        PRDATAS6(14) => GND_net, PRDATAS6(13) => GND_net, 
        PRDATAS6(12) => GND_net, PRDATAS6(11) => GND_net, 
        PRDATAS6(10) => GND_net, PRDATAS6(9) => GND_net, 
        PRDATAS6(8) => GND_net, PRDATAS6(7) => GND_net, 
        PRDATAS6(6) => GND_net, PRDATAS6(5) => GND_net, 
        PRDATAS6(4) => GND_net, PRDATAS6(3) => GND_net, 
        PRDATAS6(2) => GND_net, PRDATAS6(1) => GND_net, 
        PRDATAS6(0) => GND_net, PRDATAS7(31) => GND_net, 
        PRDATAS7(30) => GND_net, PRDATAS7(29) => GND_net, 
        PRDATAS7(28) => GND_net, PRDATAS7(27) => GND_net, 
        PRDATAS7(26) => GND_net, PRDATAS7(25) => GND_net, 
        PRDATAS7(24) => GND_net, PRDATAS7(23) => GND_net, 
        PRDATAS7(22) => GND_net, PRDATAS7(21) => GND_net, 
        PRDATAS7(20) => GND_net, PRDATAS7(19) => GND_net, 
        PRDATAS7(18) => GND_net, PRDATAS7(17) => GND_net, 
        PRDATAS7(16) => GND_net, PRDATAS7(15) => GND_net, 
        PRDATAS7(14) => GND_net, PRDATAS7(13) => GND_net, 
        PRDATAS7(12) => GND_net, PRDATAS7(11) => GND_net, 
        PRDATAS7(10) => GND_net, PRDATAS7(9) => GND_net, 
        PRDATAS7(8) => GND_net, PRDATAS7(7) => GND_net, 
        PRDATAS7(6) => GND_net, PRDATAS7(5) => GND_net, 
        PRDATAS7(4) => GND_net, PRDATAS7(3) => GND_net, 
        PRDATAS7(2) => GND_net, PRDATAS7(1) => GND_net, 
        PRDATAS7(0) => GND_net, PRDATAS8(31) => GND_net, 
        PRDATAS8(30) => GND_net, PRDATAS8(29) => GND_net, 
        PRDATAS8(28) => GND_net, PRDATAS8(27) => GND_net, 
        PRDATAS8(26) => GND_net, PRDATAS8(25) => GND_net, 
        PRDATAS8(24) => GND_net, PRDATAS8(23) => GND_net, 
        PRDATAS8(22) => GND_net, PRDATAS8(21) => GND_net, 
        PRDATAS8(20) => GND_net, PRDATAS8(19) => GND_net, 
        PRDATAS8(18) => GND_net, PRDATAS8(17) => GND_net, 
        PRDATAS8(16) => GND_net, PRDATAS8(15) => GND_net, 
        PRDATAS8(14) => GND_net, PRDATAS8(13) => GND_net, 
        PRDATAS8(12) => GND_net, PRDATAS8(11) => GND_net, 
        PRDATAS8(10) => GND_net, PRDATAS8(9) => GND_net, 
        PRDATAS8(8) => GND_net, PRDATAS8(7) => GND_net, 
        PRDATAS8(6) => GND_net, PRDATAS8(5) => GND_net, 
        PRDATAS8(4) => GND_net, PRDATAS8(3) => GND_net, 
        PRDATAS8(2) => GND_net, PRDATAS8(1) => GND_net, 
        PRDATAS8(0) => GND_net, PRDATAS9(31) => GND_net, 
        PRDATAS9(30) => GND_net, PRDATAS9(29) => GND_net, 
        PRDATAS9(28) => GND_net, PRDATAS9(27) => GND_net, 
        PRDATAS9(26) => GND_net, PRDATAS9(25) => GND_net, 
        PRDATAS9(24) => GND_net, PRDATAS9(23) => GND_net, 
        PRDATAS9(22) => GND_net, PRDATAS9(21) => GND_net, 
        PRDATAS9(20) => GND_net, PRDATAS9(19) => GND_net, 
        PRDATAS9(18) => GND_net, PRDATAS9(17) => GND_net, 
        PRDATAS9(16) => GND_net, PRDATAS9(15) => GND_net, 
        PRDATAS9(14) => GND_net, PRDATAS9(13) => GND_net, 
        PRDATAS9(12) => GND_net, PRDATAS9(11) => GND_net, 
        PRDATAS9(10) => GND_net, PRDATAS9(9) => GND_net, 
        PRDATAS9(8) => GND_net, PRDATAS9(7) => GND_net, 
        PRDATAS9(6) => GND_net, PRDATAS9(5) => GND_net, 
        PRDATAS9(4) => GND_net, PRDATAS9(3) => GND_net, 
        PRDATAS9(2) => GND_net, PRDATAS9(1) => GND_net, 
        PRDATAS9(0) => GND_net, PRDATAS10(31) => GND_net, 
        PRDATAS10(30) => GND_net, PRDATAS10(29) => GND_net, 
        PRDATAS10(28) => GND_net, PRDATAS10(27) => GND_net, 
        PRDATAS10(26) => GND_net, PRDATAS10(25) => GND_net, 
        PRDATAS10(24) => GND_net, PRDATAS10(23) => GND_net, 
        PRDATAS10(22) => GND_net, PRDATAS10(21) => GND_net, 
        PRDATAS10(20) => GND_net, PRDATAS10(19) => GND_net, 
        PRDATAS10(18) => GND_net, PRDATAS10(17) => GND_net, 
        PRDATAS10(16) => GND_net, PRDATAS10(15) => GND_net, 
        PRDATAS10(14) => GND_net, PRDATAS10(13) => GND_net, 
        PRDATAS10(12) => GND_net, PRDATAS10(11) => GND_net, 
        PRDATAS10(10) => GND_net, PRDATAS10(9) => GND_net, 
        PRDATAS10(8) => GND_net, PRDATAS10(7) => GND_net, 
        PRDATAS10(6) => GND_net, PRDATAS10(5) => GND_net, 
        PRDATAS10(4) => GND_net, PRDATAS10(3) => GND_net, 
        PRDATAS10(2) => GND_net, PRDATAS10(1) => GND_net, 
        PRDATAS10(0) => GND_net, PRDATAS11(31) => GND_net, 
        PRDATAS11(30) => GND_net, PRDATAS11(29) => GND_net, 
        PRDATAS11(28) => GND_net, PRDATAS11(27) => GND_net, 
        PRDATAS11(26) => GND_net, PRDATAS11(25) => GND_net, 
        PRDATAS11(24) => GND_net, PRDATAS11(23) => GND_net, 
        PRDATAS11(22) => GND_net, PRDATAS11(21) => GND_net, 
        PRDATAS11(20) => GND_net, PRDATAS11(19) => GND_net, 
        PRDATAS11(18) => GND_net, PRDATAS11(17) => GND_net, 
        PRDATAS11(16) => GND_net, PRDATAS11(15) => GND_net, 
        PRDATAS11(14) => GND_net, PRDATAS11(13) => GND_net, 
        PRDATAS11(12) => GND_net, PRDATAS11(11) => GND_net, 
        PRDATAS11(10) => GND_net, PRDATAS11(9) => GND_net, 
        PRDATAS11(8) => GND_net, PRDATAS11(7) => GND_net, 
        PRDATAS11(6) => GND_net, PRDATAS11(5) => GND_net, 
        PRDATAS11(4) => GND_net, PRDATAS11(3) => GND_net, 
        PRDATAS11(2) => GND_net, PRDATAS11(1) => GND_net, 
        PRDATAS11(0) => GND_net, PRDATAS12(31) => GND_net, 
        PRDATAS12(30) => GND_net, PRDATAS12(29) => GND_net, 
        PRDATAS12(28) => GND_net, PRDATAS12(27) => GND_net, 
        PRDATAS12(26) => GND_net, PRDATAS12(25) => GND_net, 
        PRDATAS12(24) => GND_net, PRDATAS12(23) => GND_net, 
        PRDATAS12(22) => GND_net, PRDATAS12(21) => GND_net, 
        PRDATAS12(20) => GND_net, PRDATAS12(19) => GND_net, 
        PRDATAS12(18) => GND_net, PRDATAS12(17) => GND_net, 
        PRDATAS12(16) => GND_net, PRDATAS12(15) => GND_net, 
        PRDATAS12(14) => GND_net, PRDATAS12(13) => GND_net, 
        PRDATAS12(12) => GND_net, PRDATAS12(11) => GND_net, 
        PRDATAS12(10) => GND_net, PRDATAS12(9) => GND_net, 
        PRDATAS12(8) => GND_net, PRDATAS12(7) => GND_net, 
        PRDATAS12(6) => GND_net, PRDATAS12(5) => GND_net, 
        PRDATAS12(4) => GND_net, PRDATAS12(3) => GND_net, 
        PRDATAS12(2) => GND_net, PRDATAS12(1) => GND_net, 
        PRDATAS12(0) => GND_net, PRDATAS13(31) => GND_net, 
        PRDATAS13(30) => GND_net, PRDATAS13(29) => GND_net, 
        PRDATAS13(28) => GND_net, PRDATAS13(27) => GND_net, 
        PRDATAS13(26) => GND_net, PRDATAS13(25) => GND_net, 
        PRDATAS13(24) => GND_net, PRDATAS13(23) => GND_net, 
        PRDATAS13(22) => GND_net, PRDATAS13(21) => GND_net, 
        PRDATAS13(20) => GND_net, PRDATAS13(19) => GND_net, 
        PRDATAS13(18) => GND_net, PRDATAS13(17) => GND_net, 
        PRDATAS13(16) => GND_net, PRDATAS13(15) => GND_net, 
        PRDATAS13(14) => GND_net, PRDATAS13(13) => GND_net, 
        PRDATAS13(12) => GND_net, PRDATAS13(11) => GND_net, 
        PRDATAS13(10) => GND_net, PRDATAS13(9) => GND_net, 
        PRDATAS13(8) => GND_net, PRDATAS13(7) => GND_net, 
        PRDATAS13(6) => GND_net, PRDATAS13(5) => GND_net, 
        PRDATAS13(4) => GND_net, PRDATAS13(3) => GND_net, 
        PRDATAS13(2) => GND_net, PRDATAS13(1) => GND_net, 
        PRDATAS13(0) => GND_net, PRDATAS14(31) => GND_net, 
        PRDATAS14(30) => GND_net, PRDATAS14(29) => GND_net, 
        PRDATAS14(28) => GND_net, PRDATAS14(27) => GND_net, 
        PRDATAS14(26) => GND_net, PRDATAS14(25) => GND_net, 
        PRDATAS14(24) => GND_net, PRDATAS14(23) => GND_net, 
        PRDATAS14(22) => GND_net, PRDATAS14(21) => GND_net, 
        PRDATAS14(20) => GND_net, PRDATAS14(19) => GND_net, 
        PRDATAS14(18) => GND_net, PRDATAS14(17) => GND_net, 
        PRDATAS14(16) => GND_net, PRDATAS14(15) => GND_net, 
        PRDATAS14(14) => GND_net, PRDATAS14(13) => GND_net, 
        PRDATAS14(12) => GND_net, PRDATAS14(11) => GND_net, 
        PRDATAS14(10) => GND_net, PRDATAS14(9) => GND_net, 
        PRDATAS14(8) => GND_net, PRDATAS14(7) => GND_net, 
        PRDATAS14(6) => GND_net, PRDATAS14(5) => GND_net, 
        PRDATAS14(4) => GND_net, PRDATAS14(3) => GND_net, 
        PRDATAS14(2) => GND_net, PRDATAS14(1) => GND_net, 
        PRDATAS14(0) => GND_net, PRDATAS15(31) => GND_net, 
        PRDATAS15(30) => GND_net, PRDATAS15(29) => GND_net, 
        PRDATAS15(28) => GND_net, PRDATAS15(27) => GND_net, 
        PRDATAS15(26) => GND_net, PRDATAS15(25) => GND_net, 
        PRDATAS15(24) => GND_net, PRDATAS15(23) => GND_net, 
        PRDATAS15(22) => GND_net, PRDATAS15(21) => GND_net, 
        PRDATAS15(20) => GND_net, PRDATAS15(19) => GND_net, 
        PRDATAS15(18) => GND_net, PRDATAS15(17) => GND_net, 
        PRDATAS15(16) => GND_net, PRDATAS15(15) => GND_net, 
        PRDATAS15(14) => GND_net, PRDATAS15(13) => GND_net, 
        PRDATAS15(12) => GND_net, PRDATAS15(11) => GND_net, 
        PRDATAS15(10) => GND_net, PRDATAS15(9) => GND_net, 
        PRDATAS15(8) => GND_net, PRDATAS15(7) => GND_net, 
        PRDATAS15(6) => GND_net, PRDATAS15(5) => GND_net, 
        PRDATAS15(4) => GND_net, PRDATAS15(3) => GND_net, 
        PRDATAS15(2) => GND_net, PRDATAS15(1) => GND_net, 
        PRDATAS15(0) => GND_net);
    
    \VCC\ : VCC
      port map(Y => VCC_net);
    
    uC_0 : uC
      port map(MSS_RESET_N => MSS_RESET_N, FAB_CLK => 
        uC_0_FAB_CLK, MAINXIN => MAINXIN, M2F_RESET_N => 
        uC_0_M2F_RESET_N, IO_8_PADOUT => IO_8_PADOUT, IO_8_D => 
        ADC_SPI_0_CSn, IO_7_PADIN => IO_7_PADIN, IO_7_Y => 
        uC_0_IO_7_Y, IO_6_PADIN => IO_6_PADIN, IO_6_Y => 
        uC_0_IO_6_Y, IO_5_PADOUT => IO_5_PADOUT, IO_5_D => 
        ADC_SPI_0_SCLK, MSSPSEL => uC_0_MSS_MASTER_APB_PSELx, 
        MSSPENABLE => uC_0_MSS_MASTER_APB_PENABLE, MSSPWRITE => 
        uC_0_MSS_MASTER_APB_PWRITE, MSSPREADY => 
        uC_0_MSS_MASTER_APB_PREADY, MSSPSLVERR => 
        uC_0_MSS_MASTER_APB_PSLVERR, GLC => GLC, MAC_0_MDIO => 
        MAC_0_MDIO, MAC_0_CRSDV => MAC_0_CRSDV, MAC_0_RXER => 
        MAC_0_RXER, MAC_0_TXEN => MAC_0_TXEN, MAC_0_MDC => 
        MAC_0_MDC, IO_13_PADOUT => IO_13_PADOUT, IO_13_D => 
        uC_0_FAB_CLK, IO_4_PADOUT => IO_4_PADOUT, IO_4_D => 
        CoreGPIO_0_GPIO_OUT4to4, IO_3_PADIN => IO_3_PADIN, IO_3_Y
         => uC_0_IO_3_Y, IO_2_PADOUT => IO_2_PADOUT, IO_2_D => 
        CoreGPIO_0_GPIO_OUT2to2, IO_1_PADOUT => IO_1_PADOUT, 
        IO_1_D => CoreGPIO_0_GPIO_OUT1to1, IO_0_PADOUT => 
        IO_0_PADOUT, IO_0_D => CoreGPIO_0_GPIO_OUT0to0, 
        IO_15_PADOUT => IO_15_PADOUT, IO_15_D => 
        CoreGPIO_0_GPIO_OUT7to7, IO_14_PADOUT => IO_14_PADOUT, 
        IO_14_D => CoreGPIO_0_GPIO_OUT6to6_0, IO_12_PADOUT => 
        IO_12_PADOUT, IO_12_D => CoreGPIO_0_GPIO_OUT5to5, 
        MSSPADDR(19) => \uC_0_MSS_MASTER_APB_PADDR_[19]\, 
        MSSPADDR(18) => \uC_0_MSS_MASTER_APB_PADDR_[18]\, 
        MSSPADDR(17) => \uC_0_MSS_MASTER_APB_PADDR_[17]\, 
        MSSPADDR(16) => \uC_0_MSS_MASTER_APB_PADDR_[16]\, 
        MSSPADDR(15) => \uC_0_MSS_MASTER_APB_PADDR_[15]\, 
        MSSPADDR(14) => \uC_0_MSS_MASTER_APB_PADDR_[14]\, 
        MSSPADDR(13) => \uC_0_MSS_MASTER_APB_PADDR_[13]\, 
        MSSPADDR(12) => \uC_0_MSS_MASTER_APB_PADDR_[12]\, 
        MSSPADDR(11) => \uC_0_MSS_MASTER_APB_PADDR_[11]\, 
        MSSPADDR(10) => \uC_0_MSS_MASTER_APB_PADDR_[10]\, 
        MSSPADDR(9) => \uC_0_MSS_MASTER_APB_PADDR_[9]\, 
        MSSPADDR(8) => \uC_0_MSS_MASTER_APB_PADDR_[8]\, 
        MSSPADDR(7) => \uC_0_MSS_MASTER_APB_PADDR_[7]\, 
        MSSPADDR(6) => \uC_0_MSS_MASTER_APB_PADDR_[6]\, 
        MSSPADDR(5) => \uC_0_MSS_MASTER_APB_PADDR_[5]\, 
        MSSPADDR(4) => \uC_0_MSS_MASTER_APB_PADDR_[4]\, 
        MSSPADDR(3) => \uC_0_MSS_MASTER_APB_PADDR_[3]\, 
        MSSPADDR(2) => \uC_0_MSS_MASTER_APB_PADDR_[2]\, 
        MSSPADDR(1) => \uC_0_MSS_MASTER_APB_PADDR_[1]\, 
        MSSPADDR(0) => \uC_0_MSS_MASTER_APB_PADDR_[0]\, 
        MSSPRDATA(31) => \uC_0_MSS_MASTER_APB_PRDATA_[31]\, 
        MSSPRDATA(30) => \uC_0_MSS_MASTER_APB_PRDATA_[30]\, 
        MSSPRDATA(29) => \uC_0_MSS_MASTER_APB_PRDATA_[29]\, 
        MSSPRDATA(28) => \uC_0_MSS_MASTER_APB_PRDATA_[28]\, 
        MSSPRDATA(27) => \uC_0_MSS_MASTER_APB_PRDATA_[27]\, 
        MSSPRDATA(26) => \uC_0_MSS_MASTER_APB_PRDATA_[26]\, 
        MSSPRDATA(25) => \uC_0_MSS_MASTER_APB_PRDATA_[25]\, 
        MSSPRDATA(24) => \uC_0_MSS_MASTER_APB_PRDATA_[24]\, 
        MSSPRDATA(23) => \uC_0_MSS_MASTER_APB_PRDATA_[23]\, 
        MSSPRDATA(22) => \uC_0_MSS_MASTER_APB_PRDATA_[22]\, 
        MSSPRDATA(21) => \uC_0_MSS_MASTER_APB_PRDATA_[21]\, 
        MSSPRDATA(20) => \uC_0_MSS_MASTER_APB_PRDATA_[20]\, 
        MSSPRDATA(19) => \uC_0_MSS_MASTER_APB_PRDATA_[19]\, 
        MSSPRDATA(18) => \uC_0_MSS_MASTER_APB_PRDATA_[18]\, 
        MSSPRDATA(17) => \uC_0_MSS_MASTER_APB_PRDATA_[17]\, 
        MSSPRDATA(16) => \uC_0_MSS_MASTER_APB_PRDATA_[16]\, 
        MSSPRDATA(15) => \uC_0_MSS_MASTER_APB_PRDATA_[15]\, 
        MSSPRDATA(14) => \uC_0_MSS_MASTER_APB_PRDATA_[14]\, 
        MSSPRDATA(13) => \uC_0_MSS_MASTER_APB_PRDATA_[13]\, 
        MSSPRDATA(12) => \uC_0_MSS_MASTER_APB_PRDATA_[12]\, 
        MSSPRDATA(11) => \uC_0_MSS_MASTER_APB_PRDATA_[11]\, 
        MSSPRDATA(10) => \uC_0_MSS_MASTER_APB_PRDATA_[10]\, 
        MSSPRDATA(9) => \uC_0_MSS_MASTER_APB_PRDATA_[9]\, 
        MSSPRDATA(8) => \uC_0_MSS_MASTER_APB_PRDATA_[8]\, 
        MSSPRDATA(7) => \uC_0_MSS_MASTER_APB_PRDATA_[7]\, 
        MSSPRDATA(6) => \uC_0_MSS_MASTER_APB_PRDATA_[6]\, 
        MSSPRDATA(5) => \uC_0_MSS_MASTER_APB_PRDATA_[5]\, 
        MSSPRDATA(4) => \uC_0_MSS_MASTER_APB_PRDATA_[4]\, 
        MSSPRDATA(3) => \uC_0_MSS_MASTER_APB_PRDATA_[3]\, 
        MSSPRDATA(2) => \uC_0_MSS_MASTER_APB_PRDATA_[2]\, 
        MSSPRDATA(1) => \uC_0_MSS_MASTER_APB_PRDATA_[1]\, 
        MSSPRDATA(0) => \uC_0_MSS_MASTER_APB_PRDATA_[0]\, 
        MSSPWDATA(31) => \uC_0_MSS_MASTER_APB_PWDATA_[31]\, 
        MSSPWDATA(30) => \uC_0_MSS_MASTER_APB_PWDATA_[30]\, 
        MSSPWDATA(29) => \uC_0_MSS_MASTER_APB_PWDATA_[29]\, 
        MSSPWDATA(28) => \uC_0_MSS_MASTER_APB_PWDATA_[28]\, 
        MSSPWDATA(27) => \uC_0_MSS_MASTER_APB_PWDATA_[27]\, 
        MSSPWDATA(26) => \uC_0_MSS_MASTER_APB_PWDATA_[26]\, 
        MSSPWDATA(25) => \uC_0_MSS_MASTER_APB_PWDATA_[25]\, 
        MSSPWDATA(24) => \uC_0_MSS_MASTER_APB_PWDATA_[24]\, 
        MSSPWDATA(23) => \uC_0_MSS_MASTER_APB_PWDATA_[23]\, 
        MSSPWDATA(22) => \uC_0_MSS_MASTER_APB_PWDATA_[22]\, 
        MSSPWDATA(21) => \uC_0_MSS_MASTER_APB_PWDATA_[21]\, 
        MSSPWDATA(20) => \uC_0_MSS_MASTER_APB_PWDATA_[20]\, 
        MSSPWDATA(19) => \uC_0_MSS_MASTER_APB_PWDATA_[19]\, 
        MSSPWDATA(18) => \uC_0_MSS_MASTER_APB_PWDATA_[18]\, 
        MSSPWDATA(17) => \uC_0_MSS_MASTER_APB_PWDATA_[17]\, 
        MSSPWDATA(16) => \uC_0_MSS_MASTER_APB_PWDATA_[16]\, 
        MSSPWDATA(15) => \uC_0_MSS_MASTER_APB_PWDATA_[15]\, 
        MSSPWDATA(14) => \uC_0_MSS_MASTER_APB_PWDATA_[14]\, 
        MSSPWDATA(13) => \uC_0_MSS_MASTER_APB_PWDATA_[13]\, 
        MSSPWDATA(12) => \uC_0_MSS_MASTER_APB_PWDATA_[12]\, 
        MSSPWDATA(11) => \uC_0_MSS_MASTER_APB_PWDATA_[11]\, 
        MSSPWDATA(10) => \uC_0_MSS_MASTER_APB_PWDATA_[10]\, 
        MSSPWDATA(9) => \uC_0_MSS_MASTER_APB_PWDATA_[9]\, 
        MSSPWDATA(8) => \uC_0_MSS_MASTER_APB_PWDATA_[8]\, 
        MSSPWDATA(7) => \uC_0_MSS_MASTER_APB_PWDATA_[7]\, 
        MSSPWDATA(6) => \uC_0_MSS_MASTER_APB_PWDATA_[6]\, 
        MSSPWDATA(5) => \uC_0_MSS_MASTER_APB_PWDATA_[5]\, 
        MSSPWDATA(4) => \uC_0_MSS_MASTER_APB_PWDATA_[4]\, 
        MSSPWDATA(3) => \uC_0_MSS_MASTER_APB_PWDATA_[3]\, 
        MSSPWDATA(2) => \uC_0_MSS_MASTER_APB_PWDATA_[2]\, 
        MSSPWDATA(1) => \uC_0_MSS_MASTER_APB_PWDATA_[1]\, 
        MSSPWDATA(0) => \uC_0_MSS_MASTER_APB_PWDATA_[0]\, 
        MAC_0_RXD(1) => MAC_0_RXD(1), MAC_0_RXD(0) => 
        MAC_0_RXD(0), MAC_0_TXD(1) => MAC_0_TXD(1), MAC_0_TXD(0)
         => MAC_0_TXD(0), DMAREADY(1) => GND_net, DMAREADY(0) => 
        \SMPL_RDY\);
    
    SAMPLE_APB3_0 : entity work.SAMPLE_APB3
      port map(PCLK => uC_0_FAB_CLK, PRESETn => uC_0_M2F_RESET_N, 
        PADDR(31) => GND_net, PADDR(30) => GND_net, PADDR(29) => 
        GND_net, PADDR(28) => GND_net, PADDR(27) => GND_net, 
        PADDR(26) => GND_net, PADDR(25) => GND_net, PADDR(24) => 
        GND_net, PADDR(23) => \CoreAPB3_0_APBmslave0_PADDR_[23]\, 
        PADDR(22) => \CoreAPB3_0_APBmslave0_PADDR_[22]\, 
        PADDR(21) => \CoreAPB3_0_APBmslave0_PADDR_[21]\, 
        PADDR(20) => \CoreAPB3_0_APBmslave0_PADDR_[20]\, 
        PADDR(19) => \CoreAPB3_0_APBmslave0_PADDR_[19]\, 
        PADDR(18) => \CoreAPB3_0_APBmslave0_PADDR_[18]\, 
        PADDR(17) => \CoreAPB3_0_APBmslave0_PADDR_[17]\, 
        PADDR(16) => \CoreAPB3_0_APBmslave0_PADDR_[16]\, 
        PADDR(15) => \CoreAPB3_0_APBmslave0_PADDR_[15]\, 
        PADDR(14) => \CoreAPB3_0_APBmslave0_PADDR_[14]\, 
        PADDR(13) => \CoreAPB3_0_APBmslave0_PADDR_[13]\, 
        PADDR(12) => \CoreAPB3_0_APBmslave0_PADDR_[12]\, 
        PADDR(11) => \CoreAPB3_0_APBmslave0_PADDR_[11]\, 
        PADDR(10) => \CoreAPB3_0_APBmslave0_PADDR_[10]\, PADDR(9)
         => \CoreAPB3_0_APBmslave0_PADDR_[9]\, PADDR(8) => 
        \CoreAPB3_0_APBmslave0_PADDR_[8]\, PADDR(7) => 
        \CoreAPB3_0_APBmslave0_PADDR_[7]\, PADDR(6) => 
        \CoreAPB3_0_APBmslave0_PADDR_[6]\, PADDR(5) => 
        \CoreAPB3_0_APBmslave0_PADDR_[5]\, PADDR(4) => 
        \CoreAPB3_0_APBmslave0_PADDR_[4]\, PADDR(3) => 
        \CoreAPB3_0_APBmslave0_PADDR_[3]\, PADDR(2) => 
        \CoreAPB3_0_APBmslave0_PADDR_[2]\, PADDR(1) => 
        \CoreAPB3_0_APBmslave0_PADDR_[1]\, PADDR(0) => 
        \CoreAPB3_0_APBmslave0_PADDR_[0]\, PSEL => 
        CoreAPB3_0_APBmslave0_PSELx, PENABLE => 
        CoreAPB3_0_APBmslave0_PENABLE, PWRITE => 
        CoreAPB3_0_APBmslave0_PWRITE, PWDATA(31) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[31]\, PWDATA(30) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[30]\, PWDATA(29) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[29]\, PWDATA(28) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[28]\, PWDATA(27) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[27]\, PWDATA(26) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[26]\, PWDATA(25) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[25]\, PWDATA(24) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[24]\, PWDATA(23) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[23]\, PWDATA(22) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[22]\, PWDATA(21) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[21]\, PWDATA(20) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[20]\, PWDATA(19) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[19]\, PWDATA(18) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[18]\, PWDATA(17) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[17]\, PWDATA(16) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[16]\, PWDATA(15) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[15]\, PWDATA(14) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[14]\, PWDATA(13) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[13]\, PWDATA(12) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[12]\, PWDATA(11) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[11]\, PWDATA(10) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[10]\, PWDATA(9) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[9]\, PWDATA(8) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[8]\, PWDATA(7) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[7]\, PWDATA(6) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[6]\, PWDATA(5) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[5]\, PWDATA(4) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[4]\, PWDATA(3) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[3]\, PWDATA(2) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[2]\, PWDATA(1) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[1]\, PWDATA(0) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[0]\, PREADY => 
        CoreAPB3_0_APBmslave0_PREADY, PRDATA(31) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[31]\, PRDATA(30) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[30]\, PRDATA(29) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[29]\, PRDATA(28) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[28]\, PRDATA(27) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[27]\, PRDATA(26) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[26]\, PRDATA(25) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[25]\, PRDATA(24) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[24]\, PRDATA(23) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[23]\, PRDATA(22) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[22]\, PRDATA(21) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[21]\, PRDATA(20) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[20]\, PRDATA(19) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[19]\, PRDATA(18) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[18]\, PRDATA(17) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[17]\, PRDATA(16) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[16]\, PRDATA(15) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[15]\, PRDATA(14) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[14]\, PRDATA(13) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[13]\, PRDATA(12) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[12]\, PRDATA(11) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[11]\, PRDATA(10) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[10]\, PRDATA(9) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[9]\, PRDATA(8) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[8]\, PRDATA(7) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[7]\, PRDATA(6) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[6]\, PRDATA(5) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[5]\, PRDATA(4) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[4]\, PRDATA(3) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[3]\, PRDATA(2) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[2]\, PRDATA(1) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[1]\, PRDATA(0) => 
        \CoreAPB3_0_APBmslave0_PRDATA_[0]\, PSLVERR => 
        CoreAPB3_0_APBmslave0_PSLVERR, INPUT(53) => 
        \DDC_0_Q_out_0_[26]\, INPUT(52) => \DDC_0_Q_out_0_[25]\, 
        INPUT(51) => \DDC_0_Q_out_0_[24]\, INPUT(50) => 
        \DDC_0_Q_out_0_[23]\, INPUT(49) => \DDC_0_Q_out_0_[22]\, 
        INPUT(48) => \DDC_0_Q_out_0_[21]\, INPUT(47) => 
        \DDC_0_Q_out_0_[20]\, INPUT(46) => \DDC_0_Q_out_0_[19]\, 
        INPUT(45) => \DDC_0_Q_out_0_[18]\, INPUT(44) => 
        \DDC_0_Q_out_0_[17]\, INPUT(43) => \DDC_0_Q_out_0_[16]\, 
        INPUT(42) => \DDC_0_Q_out_0_[15]\, INPUT(41) => 
        \DDC_0_Q_out_0_[14]\, INPUT(40) => \DDC_0_Q_out_0_[13]\, 
        INPUT(39) => \DDC_0_Q_out_0_[12]\, INPUT(38) => 
        \DDC_0_Q_out_0_[11]\, INPUT(37) => \DDC_0_Q_out_0_[10]\, 
        INPUT(36) => \DDC_0_Q_out_0_[9]\, INPUT(35) => 
        \DDC_0_Q_out_0_[8]\, INPUT(34) => \DDC_0_Q_out_0_[7]\, 
        INPUT(33) => \DDC_0_Q_out_0_[6]\, INPUT(32) => 
        \DDC_0_Q_out_0_[5]\, INPUT(31) => \DDC_0_Q_out_0_[4]\, 
        INPUT(30) => \DDC_0_Q_out_0_[3]\, INPUT(29) => 
        \DDC_0_Q_out_0_[2]\, INPUT(28) => \DDC_0_Q_out_0_[1]\, 
        INPUT(27) => \DDC_0_Q_out_0_[0]\, INPUT(26) => 
        \DDC_0_I_out_1_[26]\, INPUT(25) => \DDC_0_I_out_1_[25]\, 
        INPUT(24) => \DDC_0_I_out_1_[24]\, INPUT(23) => 
        \DDC_0_I_out_1_[23]\, INPUT(22) => \DDC_0_I_out_1_[22]\, 
        INPUT(21) => \DDC_0_I_out_1_[21]\, INPUT(20) => 
        \DDC_0_I_out_1_[20]\, INPUT(19) => \DDC_0_I_out_1_[19]\, 
        INPUT(18) => \DDC_0_I_out_1_[18]\, INPUT(17) => 
        \DDC_0_I_out_1_[17]\, INPUT(16) => \DDC_0_I_out_1_[16]\, 
        INPUT(15) => \DDC_0_I_out_1_[15]\, INPUT(14) => 
        \DDC_0_I_out_1_[14]\, INPUT(13) => \DDC_0_I_out_1_[13]\, 
        INPUT(12) => \DDC_0_I_out_1_[12]\, INPUT(11) => 
        \DDC_0_I_out_1_[11]\, INPUT(10) => \DDC_0_I_out_1_[10]\, 
        INPUT(9) => \DDC_0_I_out_1_[9]\, INPUT(8) => 
        \DDC_0_I_out_1_[8]\, INPUT(7) => \DDC_0_I_out_1_[7]\, 
        INPUT(6) => \DDC_0_I_out_1_[6]\, INPUT(5) => 
        \DDC_0_I_out_1_[5]\, INPUT(4) => \DDC_0_I_out_1_[4]\, 
        INPUT(3) => \DDC_0_I_out_1_[3]\, INPUT(2) => 
        \DDC_0_I_out_1_[2]\, INPUT(1) => \DDC_0_I_out_1_[1]\, 
        INPUT(0) => \DDC_0_I_out_1_[0]\, DPHASE(15) => 
        \SAMPLE_APB3_0_DPHASE_[15]\, DPHASE(14) => 
        \SAMPLE_APB3_0_DPHASE_[14]\, DPHASE(13) => 
        \SAMPLE_APB3_0_DPHASE_[13]\, DPHASE(12) => 
        \SAMPLE_APB3_0_DPHASE_[12]\, DPHASE(11) => 
        \SAMPLE_APB3_0_DPHASE_[11]\, DPHASE(10) => 
        \SAMPLE_APB3_0_DPHASE_[10]\, DPHASE(9) => 
        \SAMPLE_APB3_0_DPHASE_[9]\, DPHASE(8) => 
        \SAMPLE_APB3_0_DPHASE_[8]\, DPHASE(7) => 
        \SAMPLE_APB3_0_DPHASE_[7]\, DPHASE(6) => 
        \SAMPLE_APB3_0_DPHASE_[6]\, DPHASE(5) => 
        \SAMPLE_APB3_0_DPHASE_[5]\, DPHASE(4) => 
        \SAMPLE_APB3_0_DPHASE_[4]\, DPHASE(3) => 
        \SAMPLE_APB3_0_DPHASE_[3]\, DPHASE(2) => 
        \SAMPLE_APB3_0_DPHASE_[2]\, DPHASE(1) => 
        \SAMPLE_APB3_0_DPHASE_[1]\, DPHASE(0) => 
        \SAMPLE_APB3_0_DPHASE_[0]\, DC_OFFSETI(13) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[13]\, DC_OFFSETI(12) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[12]\, DC_OFFSETI(11) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[11]\, DC_OFFSETI(10) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[10]\, DC_OFFSETI(9) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[9]\, DC_OFFSETI(8) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[8]\, DC_OFFSETI(7) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[7]\, DC_OFFSETI(6) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[6]\, DC_OFFSETI(5) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[5]\, DC_OFFSETI(4) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[4]\, DC_OFFSETI(3) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[3]\, DC_OFFSETI(2) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[2]\, DC_OFFSETI(1) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[1]\, DC_OFFSETI(0) => 
        \SAMPLE_APB3_0_DC_OFFSETI_[0]\, DC_OFFSETQ(13) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[13]\, DC_OFFSETQ(12) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[12]\, DC_OFFSETQ(11) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[11]\, DC_OFFSETQ(10) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[10]\, DC_OFFSETQ(9) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[9]\, DC_OFFSETQ(8) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[8]\, DC_OFFSETQ(7) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[7]\, DC_OFFSETQ(6) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[6]\, DC_OFFSETQ(5) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[5]\, DC_OFFSETQ(4) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[4]\, DC_OFFSETQ(3) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[3]\, DC_OFFSETQ(2) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[2]\, DC_OFFSETQ(1) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[1]\, DC_OFFSETQ(0) => 
        \SAMPLE_APB3_0_DC_OFFSETQ_[0]\, SMPL_RDY_IN => 
        DDC_0_I_SMPL_RDY, SMPL_RDY => \SMPL_RDY\);
    
    INV_0 : INV
      port map(A => uC_0_M2F_RESET_N, Y => INV_0_Y);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    CoreGPIO_0 : CoreGPIO
      generic map(APB_WIDTH => 32, FAMILY => 15,
         FIXED_CONFIG_0 => 1, FIXED_CONFIG_1 => 1,
         FIXED_CONFIG_10 => 1, FIXED_CONFIG_11 => 1,
         FIXED_CONFIG_12 => 1, FIXED_CONFIG_13 => 1,
         FIXED_CONFIG_14 => 1, FIXED_CONFIG_15 => 1,
         FIXED_CONFIG_16 => 1, FIXED_CONFIG_17 => 1,
         FIXED_CONFIG_18 => 1, FIXED_CONFIG_19 => 1,
         FIXED_CONFIG_2 => 1, FIXED_CONFIG_20 => 1,
         FIXED_CONFIG_21 => 0, FIXED_CONFIG_22 => 0,
         FIXED_CONFIG_23 => 0, FIXED_CONFIG_24 => 0,
         FIXED_CONFIG_25 => 0, FIXED_CONFIG_26 => 0,
         FIXED_CONFIG_27 => 0, FIXED_CONFIG_28 => 0,
         FIXED_CONFIG_29 => 0, FIXED_CONFIG_3 => 1,
         FIXED_CONFIG_30 => 0, FIXED_CONFIG_31 => 0,
         FIXED_CONFIG_4 => 1, FIXED_CONFIG_5 => 1,
         FIXED_CONFIG_6 => 1, FIXED_CONFIG_7 => 1,
         FIXED_CONFIG_8 => 1, FIXED_CONFIG_9 => 1, INT_BUS => 0,
         IO_INT_TYPE_0 => 7, IO_INT_TYPE_1 => 7,
         IO_INT_TYPE_10 => 7, IO_INT_TYPE_11 => 7,
         IO_INT_TYPE_12 => 7, IO_INT_TYPE_13 => 7,
         IO_INT_TYPE_14 => 7, IO_INT_TYPE_15 => 7,
         IO_INT_TYPE_16 => 7, IO_INT_TYPE_17 => 7,
         IO_INT_TYPE_18 => 7, IO_INT_TYPE_19 => 7,
         IO_INT_TYPE_2 => 7, IO_INT_TYPE_20 => 7,
         IO_INT_TYPE_21 => 7, IO_INT_TYPE_22 => 7,
         IO_INT_TYPE_23 => 7, IO_INT_TYPE_24 => 7,
         IO_INT_TYPE_25 => 7, IO_INT_TYPE_26 => 7,
         IO_INT_TYPE_27 => 7, IO_INT_TYPE_28 => 7,
         IO_INT_TYPE_29 => 7, IO_INT_TYPE_3 => 7,
         IO_INT_TYPE_30 => 7, IO_INT_TYPE_31 => 7,
         IO_INT_TYPE_4 => 7, IO_INT_TYPE_5 => 7,
         IO_INT_TYPE_6 => 7, IO_INT_TYPE_7 => 7,
         IO_INT_TYPE_8 => 7, IO_INT_TYPE_9 => 7, IO_NUM => 17,
         IO_TYPE_0 => 1, IO_TYPE_1 => 1, IO_TYPE_10 => 1,
         IO_TYPE_11 => 1, IO_TYPE_12 => 1, IO_TYPE_13 => 0,
         IO_TYPE_14 => 1, IO_TYPE_15 => 1, IO_TYPE_16 => 1,
         IO_TYPE_17 => 1, IO_TYPE_18 => 0, IO_TYPE_19 => 0,
         IO_TYPE_2 => 1, IO_TYPE_20 => 0, IO_TYPE_21 => 0,
         IO_TYPE_22 => 0, IO_TYPE_23 => 0, IO_TYPE_24 => 0,
         IO_TYPE_25 => 0, IO_TYPE_26 => 0, IO_TYPE_27 => 0,
         IO_TYPE_28 => 0, IO_TYPE_29 => 0, IO_TYPE_3 => 0,
         IO_TYPE_30 => 0, IO_TYPE_31 => 0, IO_TYPE_4 => 1,
         IO_TYPE_5 => 1, IO_TYPE_6 => 1, IO_TYPE_7 => 1,
         IO_TYPE_8 => 1, IO_TYPE_9 => 1, IO_VAL_0 => 0,
         IO_VAL_1 => 0, IO_VAL_10 => 0, IO_VAL_11 => 0,
         IO_VAL_12 => 0, IO_VAL_13 => 0, IO_VAL_14 => 0,
         IO_VAL_15 => 0, IO_VAL_16 => 0, IO_VAL_17 => 0,
         IO_VAL_18 => 0, IO_VAL_19 => 0, IO_VAL_2 => 0,
         IO_VAL_20 => 0, IO_VAL_21 => 0, IO_VAL_22 => 0,
         IO_VAL_23 => 0, IO_VAL_24 => 0, IO_VAL_25 => 0,
         IO_VAL_26 => 0, IO_VAL_27 => 0, IO_VAL_28 => 0,
         IO_VAL_29 => 0, IO_VAL_3 => 0, IO_VAL_30 => 0,
         IO_VAL_31 => 0, IO_VAL_4 => 0, IO_VAL_5 => 0,
         IO_VAL_6 => 0, IO_VAL_7 => 0, IO_VAL_8 => 0,
         IO_VAL_9 => 0, OE_TYPE => 1)

      port map(PRESETN => uC_0_M2F_RESET_N, PCLK => uC_0_FAB_CLK, 
        PSEL => CoreAPB3_0_APBmslave1_PSELx, PENABLE => 
        CoreAPB3_0_APBmslave0_PENABLE, PWRITE => 
        CoreAPB3_0_APBmslave0_PWRITE, PSLVERR => 
        CoreAPB3_0_APBmslave1_PSLVERR, PREADY => 
        CoreAPB3_0_APBmslave1_PREADY, INT_OR => OPEN, PADDR(7)
         => \CoreAPB3_0_APBmslave1_PADDR_[7]\, PADDR(6) => 
        \CoreAPB3_0_APBmslave1_PADDR_[6]\, PADDR(5) => 
        \CoreAPB3_0_APBmslave1_PADDR_[5]\, PADDR(4) => 
        \CoreAPB3_0_APBmslave1_PADDR_[4]\, PADDR(3) => 
        \CoreAPB3_0_APBmslave1_PADDR_[3]\, PADDR(2) => 
        \CoreAPB3_0_APBmslave1_PADDR_[2]\, PADDR(1) => 
        \CoreAPB3_0_APBmslave1_PADDR_[1]\, PADDR(0) => 
        \CoreAPB3_0_APBmslave1_PADDR_[0]\, PWDATA(31) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[31]\, PWDATA(30) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[30]\, PWDATA(29) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[29]\, PWDATA(28) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[28]\, PWDATA(27) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[27]\, PWDATA(26) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[26]\, PWDATA(25) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[25]\, PWDATA(24) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[24]\, PWDATA(23) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[23]\, PWDATA(22) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[22]\, PWDATA(21) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[21]\, PWDATA(20) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[20]\, PWDATA(19) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[19]\, PWDATA(18) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[18]\, PWDATA(17) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[17]\, PWDATA(16) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[16]\, PWDATA(15) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[15]\, PWDATA(14) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[14]\, PWDATA(13) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[13]\, PWDATA(12) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[12]\, PWDATA(11) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[11]\, PWDATA(10) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[10]\, PWDATA(9) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[9]\, PWDATA(8) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[8]\, PWDATA(7) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[7]\, PWDATA(6) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[6]\, PWDATA(5) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[5]\, PWDATA(4) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[4]\, PWDATA(3) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[3]\, PWDATA(2) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[2]\, PWDATA(1) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[1]\, PWDATA(0) => 
        \CoreAPB3_0_APBmslave0_PWDATA_[0]\, PRDATA(31) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[31]\, PRDATA(30) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[30]\, PRDATA(29) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[29]\, PRDATA(28) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[28]\, PRDATA(27) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[27]\, PRDATA(26) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[26]\, PRDATA(25) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[25]\, PRDATA(24) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[24]\, PRDATA(23) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[23]\, PRDATA(22) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[22]\, PRDATA(21) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[21]\, PRDATA(20) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[20]\, PRDATA(19) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[19]\, PRDATA(18) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[18]\, PRDATA(17) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[17]\, PRDATA(16) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[16]\, PRDATA(15) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[15]\, PRDATA(14) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[14]\, PRDATA(13) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[13]\, PRDATA(12) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[12]\, PRDATA(11) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[11]\, PRDATA(10) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[10]\, PRDATA(9) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[9]\, PRDATA(8) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[8]\, PRDATA(7) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[7]\, PRDATA(6) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[6]\, PRDATA(5) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[5]\, PRDATA(4) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[4]\, PRDATA(3) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[3]\, PRDATA(2) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[2]\, PRDATA(1) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[1]\, PRDATA(0) => 
        \CoreAPB3_0_APBmslave1_PRDATA_[0]\, INT(16) => nc34, 
        INT(15) => nc9, INT(14) => nc13, INT(13) => nc23, INT(12)
         => nc33, INT(11) => nc16, INT(10) => nc26, INT(9) => 
        nc27, INT(8) => nc17, INT(7) => nc36, INT(6) => nc5, 
        INT(5) => nc4, INT(4) => nc25, INT(3) => nc15, INT(2) => 
        nc35, INT(1) => nc28, INT(0) => nc18, GPIO_IN(16) => 
        GND_net, GPIO_IN(15) => GND_net, GPIO_IN(14) => GND_net, 
        GPIO_IN(13) => GPIO_IN, GPIO_IN(12) => GND_net, 
        GPIO_IN(11) => GND_net, GPIO_IN(10) => GND_net, 
        GPIO_IN(9) => GND_net, GPIO_IN(8) => GND_net, GPIO_IN(7)
         => GND_net, GPIO_IN(6) => GND_net, GPIO_IN(5) => GND_net, 
        GPIO_IN(4) => GND_net, GPIO_IN(3) => uC_0_IO_3_Y, 
        GPIO_IN(2) => GND_net, GPIO_IN(1) => GND_net, GPIO_IN(0)
         => GND_net, GPIO_OUT(16) => GPIO_OUT_2(16), GPIO_OUT(15)
         => GPIO_OUT_2(15), GPIO_OUT(14) => GPIO_OUT_2(14), 
        GPIO_OUT(13) => nc1, GPIO_OUT(12) => GPIO_OUT_1(12), 
        GPIO_OUT(11) => GPIO_OUT_1(11), GPIO_OUT(10) => 
        GPIO_OUT_1(10), GPIO_OUT(9) => GPIO_OUT_1(9), GPIO_OUT(8)
         => GPIO_OUT_1(8), GPIO_OUT(7) => CoreGPIO_0_GPIO_OUT7to7, 
        GPIO_OUT(6) => CoreGPIO_0_GPIO_OUT6to6_0, GPIO_OUT(5) => 
        CoreGPIO_0_GPIO_OUT5to5, GPIO_OUT(4) => 
        CoreGPIO_0_GPIO_OUT4to4, GPIO_OUT(3) => nc2, GPIO_OUT(2)
         => CoreGPIO_0_GPIO_OUT2to2, GPIO_OUT(1) => 
        CoreGPIO_0_GPIO_OUT1to1, GPIO_OUT(0) => 
        CoreGPIO_0_GPIO_OUT0to0, GPIO_OE(16) => nc22, GPIO_OE(15)
         => nc12, GPIO_OE(14) => nc21, GPIO_OE(13) => nc11, 
        GPIO_OE(12) => nc3, GPIO_OE(11) => nc32, GPIO_OE(10) => 
        nc31, GPIO_OE(9) => nc7, GPIO_OE(8) => nc6, GPIO_OE(7)
         => nc19, GPIO_OE(6) => nc29, GPIO_OE(5) => nc8, 
        GPIO_OE(4) => nc20, GPIO_OE(3) => nc10, GPIO_OE(2) => 
        nc24, GPIO_OE(1) => nc14, GPIO_OE(0) => nc30);
    
    ADC_SPI_0 : entity work.ADC_SPI
      port map(PCLK => uC_0_FAB_CLK, PRESETn => uC_0_M2F_RESET_N, 
        SCLK => ADC_SPI_0_SCLK, CSn => ADC_SPI_0_CSn, sample_rdy
         => ADC_SPI_0_sample_rdy, CH1(13) => \ADC_SPI_0_CH1_[13]\, 
        CH1(12) => \ADC_SPI_0_CH1_[12]\, CH1(11) => 
        \ADC_SPI_0_CH1_[11]\, CH1(10) => \ADC_SPI_0_CH1_[10]\, 
        CH1(9) => \ADC_SPI_0_CH1_[9]\, CH1(8) => 
        \ADC_SPI_0_CH1_[8]\, CH1(7) => \ADC_SPI_0_CH1_[7]\, 
        CH1(6) => \ADC_SPI_0_CH1_[6]\, CH1(5) => 
        \ADC_SPI_0_CH1_[5]\, CH1(4) => \ADC_SPI_0_CH1_[4]\, 
        CH1(3) => \ADC_SPI_0_CH1_[3]\, CH1(2) => 
        \ADC_SPI_0_CH1_[2]\, CH1(1) => \ADC_SPI_0_CH1_[1]\, 
        CH1(0) => \ADC_SPI_0_CH1_[0]\, CH2(13) => 
        \ADC_SPI_0_CH2_[13]\, CH2(12) => \ADC_SPI_0_CH2_[12]\, 
        CH2(11) => \ADC_SPI_0_CH2_[11]\, CH2(10) => 
        \ADC_SPI_0_CH2_[10]\, CH2(9) => \ADC_SPI_0_CH2_[9]\, 
        CH2(8) => \ADC_SPI_0_CH2_[8]\, CH2(7) => 
        \ADC_SPI_0_CH2_[7]\, CH2(6) => \ADC_SPI_0_CH2_[6]\, 
        CH2(5) => \ADC_SPI_0_CH2_[5]\, CH2(4) => 
        \ADC_SPI_0_CH2_[4]\, CH2(3) => \ADC_SPI_0_CH2_[3]\, 
        CH2(2) => \ADC_SPI_0_CH2_[2]\, CH2(1) => 
        \ADC_SPI_0_CH2_[1]\, CH2(0) => \ADC_SPI_0_CH2_[0]\, 
        SDATA(1) => uC_0_IO_7_Y, SDATA(2) => uC_0_IO_6_Y);
    

end DEF_ARCH; 
