-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;
library COREAPB3_LIB;
use COREAPB3_LIB.all;

entity top is

    port( MSS_RESET_N : in    std_logic;
          MAINXIN     : in    std_logic;
          IO_8_PADOUT : out   std_logic;
          IO_7_PADIN  : in    std_logic;
          IO_6_PADIN  : in    std_logic;
          IO_5_PADOUT : out   std_logic;
          MAC_0_MDIO  : inout std_logic := 'Z';
          MAC_0_CRSDV : in    std_logic;
          MAC_0_RXER  : in    std_logic;
          MAC_0_TXEN  : out   std_logic;
          MAC_0_MDC   : out   std_logic;
          GLC         : out   std_logic;
          MAC_0_RXD   : in    std_logic_vector(1 downto 0);
          MAC_0_TXD   : out   std_logic_vector(1 downto 0)
        );

end top;

architecture DEF_ARCH of top is 

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
    port( MSS_RESET_N : in    std_logic := 'U';
          FAB_CLK     : out   std_logic;
          MAINXIN     : in    std_logic := 'U';
          M2F_RESET_N : out   std_logic;
          FABINT      : in    std_logic := 'U';
          IO_8_PADOUT : out   std_logic;
          IO_8_D      : in    std_logic := 'U';
          IO_7_PADIN  : in    std_logic := 'U';
          IO_7_Y      : out   std_logic;
          IO_6_PADIN  : in    std_logic := 'U';
          IO_6_Y      : out   std_logic;
          IO_5_PADOUT : out   std_logic;
          IO_5_D      : in    std_logic := 'U';
          MSSPSEL     : out   std_logic;
          MSSPENABLE  : out   std_logic;
          MSSPWRITE   : out   std_logic;
          MSSPREADY   : in    std_logic := 'U';
          MSSPSLVERR  : in    std_logic := 'U';
          GLC         : out   std_logic;
          MAC_0_MDIO  : inout   std_logic;
          MAC_0_CRSDV : in    std_logic := 'U';
          MAC_0_RXER  : in    std_logic := 'U';
          MAC_0_TXEN  : out   std_logic;
          MAC_0_MDC   : out   std_logic;
          MSSPADDR    : out   std_logic_vector(19 downto 0);
          MSSPRDATA   : in    std_logic_vector(31 downto 0) := (others => 'U');
          MSSPWDATA   : out   std_logic_vector(31 downto 0);
          DMAREADY    : in    std_logic_vector(1 downto 0) := (others => 'U');
          MAC_0_RXD   : in    std_logic_vector(1 downto 0) := (others => 'U');
          MAC_0_TXD   : out   std_logic_vector(1 downto 0)
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \CoreAPB3_0_APBmslave0_PADDR_[0]\, 
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
        CoreAPB3_0_APBmslave0_PWRITE, net_2, SPI_APB_ADC_0_CSn, 
        SPI_APB_ADC_0_SCLK, uC_0_FAB_CLK, uC_0_IO_6_Y, 
        uC_0_IO_7_Y, uC_0_M2F_RESET_N, 
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
    signal nc24, nc1, nc8, nc13, nc16, nc19, nc20, nc9, nc22, 
        nc14, nc5, nc21, nc15, nc3, nc10, nc7, nc17, nc4, nc12, 
        nc2, nc23, nc18, nc6, nc11 : std_logic;

begin 


    CoreAPB3_0 : CoreAPB3
      generic map(APBSLOT0ENABLE => 1, APBSLOT10ENABLE => 0,
         APBSLOT11ENABLE => 0, APBSLOT12ENABLE => 0,
         APBSLOT13ENABLE => 0, APBSLOT14ENABLE => 0,
         APBSLOT15ENABLE => 0, APBSLOT1ENABLE => 0,
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
        CoreAPB3_0_APBmslave0_PSLVERR, PSELS1 => OPEN, PREADYS1
         => VCC_net, PSLVERRS1 => GND_net, PSELS2 => OPEN, 
        PREADYS2 => VCC_net, PSLVERRS2 => GND_net, PSELS3 => OPEN, 
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
        \uC_0_MSS_MASTER_APB_PRDATA_[0]\, PADDRS(23) => nc24, 
        PADDRS(22) => nc1, PADDRS(21) => nc8, PADDRS(20) => nc13, 
        PADDRS(19) => nc16, PADDRS(18) => nc19, PADDRS(17) => 
        nc20, PADDRS(16) => nc9, PADDRS(15) => nc22, PADDRS(14)
         => nc14, PADDRS(13) => nc5, PADDRS(12) => nc21, 
        PADDRS(11) => nc15, PADDRS(10) => nc3, PADDRS(9) => nc10, 
        PADDRS(8) => nc7, PADDRS(7) => nc17, PADDRS(6) => nc4, 
        PADDRS(5) => nc12, PADDRS(4) => nc2, PADDRS(3) => nc23, 
        PADDRS(2) => nc18, PADDRS(1) => nc6, PADDRS(0) => nc11, 
        PADDRS0(23) => \CoreAPB3_0_APBmslave0_PADDR_[23]\, 
        PADDRS0(22) => \CoreAPB3_0_APBmslave0_PADDR_[22]\, 
        PADDRS0(21) => \CoreAPB3_0_APBmslave0_PADDR_[21]\, 
        PADDRS0(20) => \CoreAPB3_0_APBmslave0_PADDR_[20]\, 
        PADDRS0(19) => \CoreAPB3_0_APBmslave0_PADDR_[19]\, 
        PADDRS0(18) => \CoreAPB3_0_APBmslave0_PADDR_[18]\, 
        PADDRS0(17) => \CoreAPB3_0_APBmslave0_PADDR_[17]\, 
        PADDRS0(16) => \CoreAPB3_0_APBmslave0_PADDR_[16]\, 
        PADDRS0(15) => \CoreAPB3_0_APBmslave0_PADDR_[15]\, 
        PADDRS0(14) => \CoreAPB3_0_APBmslave0_PADDR_[14]\, 
        PADDRS0(13) => \CoreAPB3_0_APBmslave0_PADDR_[13]\, 
        PADDRS0(12) => \CoreAPB3_0_APBmslave0_PADDR_[12]\, 
        PADDRS0(11) => \CoreAPB3_0_APBmslave0_PADDR_[11]\, 
        PADDRS0(10) => \CoreAPB3_0_APBmslave0_PADDR_[10]\, 
        PADDRS0(9) => \CoreAPB3_0_APBmslave0_PADDR_[9]\, 
        PADDRS0(8) => \CoreAPB3_0_APBmslave0_PADDR_[8]\, 
        PADDRS0(7) => \CoreAPB3_0_APBmslave0_PADDR_[7]\, 
        PADDRS0(6) => \CoreAPB3_0_APBmslave0_PADDR_[6]\, 
        PADDRS0(5) => \CoreAPB3_0_APBmslave0_PADDR_[5]\, 
        PADDRS0(4) => \CoreAPB3_0_APBmslave0_PADDR_[4]\, 
        PADDRS0(3) => \CoreAPB3_0_APBmslave0_PADDR_[3]\, 
        PADDRS0(2) => \CoreAPB3_0_APBmslave0_PADDR_[2]\, 
        PADDRS0(1) => \CoreAPB3_0_APBmslave0_PADDR_[1]\, 
        PADDRS0(0) => \CoreAPB3_0_APBmslave0_PADDR_[0]\, 
        PWDATAS(31) => \CoreAPB3_0_APBmslave0_PWDATA_[31]\, 
        PWDATAS(30) => \CoreAPB3_0_APBmslave0_PWDATA_[30]\, 
        PWDATAS(29) => \CoreAPB3_0_APBmslave0_PWDATA_[29]\, 
        PWDATAS(28) => \CoreAPB3_0_APBmslave0_PWDATA_[28]\, 
        PWDATAS(27) => \CoreAPB3_0_APBmslave0_PWDATA_[27]\, 
        PWDATAS(26) => \CoreAPB3_0_APBmslave0_PWDATA_[26]\, 
        PWDATAS(25) => \CoreAPB3_0_APBmslave0_PWDATA_[25]\, 
        PWDATAS(24) => \CoreAPB3_0_APBmslave0_PWDATA_[24]\, 
        PWDATAS(23) => \CoreAPB3_0_APBmslave0_PWDATA_[23]\, 
        PWDATAS(22) => \CoreAPB3_0_APBmslave0_PWDATA_[22]\, 
        PWDATAS(21) => \CoreAPB3_0_APBmslave0_PWDATA_[21]\, 
        PWDATAS(20) => \CoreAPB3_0_APBmslave0_PWDATA_[20]\, 
        PWDATAS(19) => \CoreAPB3_0_APBmslave0_PWDATA_[19]\, 
        PWDATAS(18) => \CoreAPB3_0_APBmslave0_PWDATA_[18]\, 
        PWDATAS(17) => \CoreAPB3_0_APBmslave0_PWDATA_[17]\, 
        PWDATAS(16) => \CoreAPB3_0_APBmslave0_PWDATA_[16]\, 
        PWDATAS(15) => \CoreAPB3_0_APBmslave0_PWDATA_[15]\, 
        PWDATAS(14) => \CoreAPB3_0_APBmslave0_PWDATA_[14]\, 
        PWDATAS(13) => \CoreAPB3_0_APBmslave0_PWDATA_[13]\, 
        PWDATAS(12) => \CoreAPB3_0_APBmslave0_PWDATA_[12]\, 
        PWDATAS(11) => \CoreAPB3_0_APBmslave0_PWDATA_[11]\, 
        PWDATAS(10) => \CoreAPB3_0_APBmslave0_PWDATA_[10]\, 
        PWDATAS(9) => \CoreAPB3_0_APBmslave0_PWDATA_[9]\, 
        PWDATAS(8) => \CoreAPB3_0_APBmslave0_PWDATA_[8]\, 
        PWDATAS(7) => \CoreAPB3_0_APBmslave0_PWDATA_[7]\, 
        PWDATAS(6) => \CoreAPB3_0_APBmslave0_PWDATA_[6]\, 
        PWDATAS(5) => \CoreAPB3_0_APBmslave0_PWDATA_[5]\, 
        PWDATAS(4) => \CoreAPB3_0_APBmslave0_PWDATA_[4]\, 
        PWDATAS(3) => \CoreAPB3_0_APBmslave0_PWDATA_[3]\, 
        PWDATAS(2) => \CoreAPB3_0_APBmslave0_PWDATA_[2]\, 
        PWDATAS(1) => \CoreAPB3_0_APBmslave0_PWDATA_[1]\, 
        PWDATAS(0) => \CoreAPB3_0_APBmslave0_PWDATA_[0]\, 
        PRDATAS0(31) => \CoreAPB3_0_APBmslave0_PRDATA_[31]\, 
        PRDATAS0(30) => \CoreAPB3_0_APBmslave0_PRDATA_[30]\, 
        PRDATAS0(29) => \CoreAPB3_0_APBmslave0_PRDATA_[29]\, 
        PRDATAS0(28) => \CoreAPB3_0_APBmslave0_PRDATA_[28]\, 
        PRDATAS0(27) => \CoreAPB3_0_APBmslave0_PRDATA_[27]\, 
        PRDATAS0(26) => \CoreAPB3_0_APBmslave0_PRDATA_[26]\, 
        PRDATAS0(25) => \CoreAPB3_0_APBmslave0_PRDATA_[25]\, 
        PRDATAS0(24) => \CoreAPB3_0_APBmslave0_PRDATA_[24]\, 
        PRDATAS0(23) => \CoreAPB3_0_APBmslave0_PRDATA_[23]\, 
        PRDATAS0(22) => \CoreAPB3_0_APBmslave0_PRDATA_[22]\, 
        PRDATAS0(21) => \CoreAPB3_0_APBmslave0_PRDATA_[21]\, 
        PRDATAS0(20) => \CoreAPB3_0_APBmslave0_PRDATA_[20]\, 
        PRDATAS0(19) => \CoreAPB3_0_APBmslave0_PRDATA_[19]\, 
        PRDATAS0(18) => \CoreAPB3_0_APBmslave0_PRDATA_[18]\, 
        PRDATAS0(17) => \CoreAPB3_0_APBmslave0_PRDATA_[17]\, 
        PRDATAS0(16) => \CoreAPB3_0_APBmslave0_PRDATA_[16]\, 
        PRDATAS0(15) => \CoreAPB3_0_APBmslave0_PRDATA_[15]\, 
        PRDATAS0(14) => \CoreAPB3_0_APBmslave0_PRDATA_[14]\, 
        PRDATAS0(13) => \CoreAPB3_0_APBmslave0_PRDATA_[13]\, 
        PRDATAS0(12) => \CoreAPB3_0_APBmslave0_PRDATA_[12]\, 
        PRDATAS0(11) => \CoreAPB3_0_APBmslave0_PRDATA_[11]\, 
        PRDATAS0(10) => \CoreAPB3_0_APBmslave0_PRDATA_[10]\, 
        PRDATAS0(9) => \CoreAPB3_0_APBmslave0_PRDATA_[9]\, 
        PRDATAS0(8) => \CoreAPB3_0_APBmslave0_PRDATA_[8]\, 
        PRDATAS0(7) => \CoreAPB3_0_APBmslave0_PRDATA_[7]\, 
        PRDATAS0(6) => \CoreAPB3_0_APBmslave0_PRDATA_[6]\, 
        PRDATAS0(5) => \CoreAPB3_0_APBmslave0_PRDATA_[5]\, 
        PRDATAS0(4) => \CoreAPB3_0_APBmslave0_PRDATA_[4]\, 
        PRDATAS0(3) => \CoreAPB3_0_APBmslave0_PRDATA_[3]\, 
        PRDATAS0(2) => \CoreAPB3_0_APBmslave0_PRDATA_[2]\, 
        PRDATAS0(1) => \CoreAPB3_0_APBmslave0_PRDATA_[1]\, 
        PRDATAS0(0) => \CoreAPB3_0_APBmslave0_PRDATA_[0]\, 
        PRDATAS1(31) => GND_net, PRDATAS1(30) => GND_net, 
        PRDATAS1(29) => GND_net, PRDATAS1(28) => GND_net, 
        PRDATAS1(27) => GND_net, PRDATAS1(26) => GND_net, 
        PRDATAS1(25) => GND_net, PRDATAS1(24) => GND_net, 
        PRDATAS1(23) => GND_net, PRDATAS1(22) => GND_net, 
        PRDATAS1(21) => GND_net, PRDATAS1(20) => GND_net, 
        PRDATAS1(19) => GND_net, PRDATAS1(18) => GND_net, 
        PRDATAS1(17) => GND_net, PRDATAS1(16) => GND_net, 
        PRDATAS1(15) => GND_net, PRDATAS1(14) => GND_net, 
        PRDATAS1(13) => GND_net, PRDATAS1(12) => GND_net, 
        PRDATAS1(11) => GND_net, PRDATAS1(10) => GND_net, 
        PRDATAS1(9) => GND_net, PRDATAS1(8) => GND_net, 
        PRDATAS1(7) => GND_net, PRDATAS1(6) => GND_net, 
        PRDATAS1(5) => GND_net, PRDATAS1(4) => GND_net, 
        PRDATAS1(3) => GND_net, PRDATAS1(2) => GND_net, 
        PRDATAS1(1) => GND_net, PRDATAS1(0) => GND_net, 
        PRDATAS2(31) => GND_net, PRDATAS2(30) => GND_net, 
        PRDATAS2(29) => GND_net, PRDATAS2(28) => GND_net, 
        PRDATAS2(27) => GND_net, PRDATAS2(26) => GND_net, 
        PRDATAS2(25) => GND_net, PRDATAS2(24) => GND_net, 
        PRDATAS2(23) => GND_net, PRDATAS2(22) => GND_net, 
        PRDATAS2(21) => GND_net, PRDATAS2(20) => GND_net, 
        PRDATAS2(19) => GND_net, PRDATAS2(18) => GND_net, 
        PRDATAS2(17) => GND_net, PRDATAS2(16) => GND_net, 
        PRDATAS2(15) => GND_net, PRDATAS2(14) => GND_net, 
        PRDATAS2(13) => GND_net, PRDATAS2(12) => GND_net, 
        PRDATAS2(11) => GND_net, PRDATAS2(10) => GND_net, 
        PRDATAS2(9) => GND_net, PRDATAS2(8) => GND_net, 
        PRDATAS2(7) => GND_net, PRDATAS2(6) => GND_net, 
        PRDATAS2(5) => GND_net, PRDATAS2(4) => GND_net, 
        PRDATAS2(3) => GND_net, PRDATAS2(2) => GND_net, 
        PRDATAS2(1) => GND_net, PRDATAS2(0) => GND_net, 
        PRDATAS3(31) => GND_net, PRDATAS3(30) => GND_net, 
        PRDATAS3(29) => GND_net, PRDATAS3(28) => GND_net, 
        PRDATAS3(27) => GND_net, PRDATAS3(26) => GND_net, 
        PRDATAS3(25) => GND_net, PRDATAS3(24) => GND_net, 
        PRDATAS3(23) => GND_net, PRDATAS3(22) => GND_net, 
        PRDATAS3(21) => GND_net, PRDATAS3(20) => GND_net, 
        PRDATAS3(19) => GND_net, PRDATAS3(18) => GND_net, 
        PRDATAS3(17) => GND_net, PRDATAS3(16) => GND_net, 
        PRDATAS3(15) => GND_net, PRDATAS3(14) => GND_net, 
        PRDATAS3(13) => GND_net, PRDATAS3(12) => GND_net, 
        PRDATAS3(11) => GND_net, PRDATAS3(10) => GND_net, 
        PRDATAS3(9) => GND_net, PRDATAS3(8) => GND_net, 
        PRDATAS3(7) => GND_net, PRDATAS3(6) => GND_net, 
        PRDATAS3(5) => GND_net, PRDATAS3(4) => GND_net, 
        PRDATAS3(3) => GND_net, PRDATAS3(2) => GND_net, 
        PRDATAS3(1) => GND_net, PRDATAS3(0) => GND_net, 
        PRDATAS4(31) => GND_net, PRDATAS4(30) => GND_net, 
        PRDATAS4(29) => GND_net, PRDATAS4(28) => GND_net, 
        PRDATAS4(27) => GND_net, PRDATAS4(26) => GND_net, 
        PRDATAS4(25) => GND_net, PRDATAS4(24) => GND_net, 
        PRDATAS4(23) => GND_net, PRDATAS4(22) => GND_net, 
        PRDATAS4(21) => GND_net, PRDATAS4(20) => GND_net, 
        PRDATAS4(19) => GND_net, PRDATAS4(18) => GND_net, 
        PRDATAS4(17) => GND_net, PRDATAS4(16) => GND_net, 
        PRDATAS4(15) => GND_net, PRDATAS4(14) => GND_net, 
        PRDATAS4(13) => GND_net, PRDATAS4(12) => GND_net, 
        PRDATAS4(11) => GND_net, PRDATAS4(10) => GND_net, 
        PRDATAS4(9) => GND_net, PRDATAS4(8) => GND_net, 
        PRDATAS4(7) => GND_net, PRDATAS4(6) => GND_net, 
        PRDATAS4(5) => GND_net, PRDATAS4(4) => GND_net, 
        PRDATAS4(3) => GND_net, PRDATAS4(2) => GND_net, 
        PRDATAS4(1) => GND_net, PRDATAS4(0) => GND_net, 
        PRDATAS5(31) => GND_net, PRDATAS5(30) => GND_net, 
        PRDATAS5(29) => GND_net, PRDATAS5(28) => GND_net, 
        PRDATAS5(27) => GND_net, PRDATAS5(26) => GND_net, 
        PRDATAS5(25) => GND_net, PRDATAS5(24) => GND_net, 
        PRDATAS5(23) => GND_net, PRDATAS5(22) => GND_net, 
        PRDATAS5(21) => GND_net, PRDATAS5(20) => GND_net, 
        PRDATAS5(19) => GND_net, PRDATAS5(18) => GND_net, 
        PRDATAS5(17) => GND_net, PRDATAS5(16) => GND_net, 
        PRDATAS5(15) => GND_net, PRDATAS5(14) => GND_net, 
        PRDATAS5(13) => GND_net, PRDATAS5(12) => GND_net, 
        PRDATAS5(11) => GND_net, PRDATAS5(10) => GND_net, 
        PRDATAS5(9) => GND_net, PRDATAS5(8) => GND_net, 
        PRDATAS5(7) => GND_net, PRDATAS5(6) => GND_net, 
        PRDATAS5(5) => GND_net, PRDATAS5(4) => GND_net, 
        PRDATAS5(3) => GND_net, PRDATAS5(2) => GND_net, 
        PRDATAS5(1) => GND_net, PRDATAS5(0) => GND_net, 
        PRDATAS6(31) => GND_net, PRDATAS6(30) => GND_net, 
        PRDATAS6(29) => GND_net, PRDATAS6(28) => GND_net, 
        PRDATAS6(27) => GND_net, PRDATAS6(26) => GND_net, 
        PRDATAS6(25) => GND_net, PRDATAS6(24) => GND_net, 
        PRDATAS6(23) => GND_net, PRDATAS6(22) => GND_net, 
        PRDATAS6(21) => GND_net, PRDATAS6(20) => GND_net, 
        PRDATAS6(19) => GND_net, PRDATAS6(18) => GND_net, 
        PRDATAS6(17) => GND_net, PRDATAS6(16) => GND_net, 
        PRDATAS6(15) => GND_net, PRDATAS6(14) => GND_net, 
        PRDATAS6(13) => GND_net, PRDATAS6(12) => GND_net, 
        PRDATAS6(11) => GND_net, PRDATAS6(10) => GND_net, 
        PRDATAS6(9) => GND_net, PRDATAS6(8) => GND_net, 
        PRDATAS6(7) => GND_net, PRDATAS6(6) => GND_net, 
        PRDATAS6(5) => GND_net, PRDATAS6(4) => GND_net, 
        PRDATAS6(3) => GND_net, PRDATAS6(2) => GND_net, 
        PRDATAS6(1) => GND_net, PRDATAS6(0) => GND_net, 
        PRDATAS7(31) => GND_net, PRDATAS7(30) => GND_net, 
        PRDATAS7(29) => GND_net, PRDATAS7(28) => GND_net, 
        PRDATAS7(27) => GND_net, PRDATAS7(26) => GND_net, 
        PRDATAS7(25) => GND_net, PRDATAS7(24) => GND_net, 
        PRDATAS7(23) => GND_net, PRDATAS7(22) => GND_net, 
        PRDATAS7(21) => GND_net, PRDATAS7(20) => GND_net, 
        PRDATAS7(19) => GND_net, PRDATAS7(18) => GND_net, 
        PRDATAS7(17) => GND_net, PRDATAS7(16) => GND_net, 
        PRDATAS7(15) => GND_net, PRDATAS7(14) => GND_net, 
        PRDATAS7(13) => GND_net, PRDATAS7(12) => GND_net, 
        PRDATAS7(11) => GND_net, PRDATAS7(10) => GND_net, 
        PRDATAS7(9) => GND_net, PRDATAS7(8) => GND_net, 
        PRDATAS7(7) => GND_net, PRDATAS7(6) => GND_net, 
        PRDATAS7(5) => GND_net, PRDATAS7(4) => GND_net, 
        PRDATAS7(3) => GND_net, PRDATAS7(2) => GND_net, 
        PRDATAS7(1) => GND_net, PRDATAS7(0) => GND_net, 
        PRDATAS8(31) => GND_net, PRDATAS8(30) => GND_net, 
        PRDATAS8(29) => GND_net, PRDATAS8(28) => GND_net, 
        PRDATAS8(27) => GND_net, PRDATAS8(26) => GND_net, 
        PRDATAS8(25) => GND_net, PRDATAS8(24) => GND_net, 
        PRDATAS8(23) => GND_net, PRDATAS8(22) => GND_net, 
        PRDATAS8(21) => GND_net, PRDATAS8(20) => GND_net, 
        PRDATAS8(19) => GND_net, PRDATAS8(18) => GND_net, 
        PRDATAS8(17) => GND_net, PRDATAS8(16) => GND_net, 
        PRDATAS8(15) => GND_net, PRDATAS8(14) => GND_net, 
        PRDATAS8(13) => GND_net, PRDATAS8(12) => GND_net, 
        PRDATAS8(11) => GND_net, PRDATAS8(10) => GND_net, 
        PRDATAS8(9) => GND_net, PRDATAS8(8) => GND_net, 
        PRDATAS8(7) => GND_net, PRDATAS8(6) => GND_net, 
        PRDATAS8(5) => GND_net, PRDATAS8(4) => GND_net, 
        PRDATAS8(3) => GND_net, PRDATAS8(2) => GND_net, 
        PRDATAS8(1) => GND_net, PRDATAS8(0) => GND_net, 
        PRDATAS9(31) => GND_net, PRDATAS9(30) => GND_net, 
        PRDATAS9(29) => GND_net, PRDATAS9(28) => GND_net, 
        PRDATAS9(27) => GND_net, PRDATAS9(26) => GND_net, 
        PRDATAS9(25) => GND_net, PRDATAS9(24) => GND_net, 
        PRDATAS9(23) => GND_net, PRDATAS9(22) => GND_net, 
        PRDATAS9(21) => GND_net, PRDATAS9(20) => GND_net, 
        PRDATAS9(19) => GND_net, PRDATAS9(18) => GND_net, 
        PRDATAS9(17) => GND_net, PRDATAS9(16) => GND_net, 
        PRDATAS9(15) => GND_net, PRDATAS9(14) => GND_net, 
        PRDATAS9(13) => GND_net, PRDATAS9(12) => GND_net, 
        PRDATAS9(11) => GND_net, PRDATAS9(10) => GND_net, 
        PRDATAS9(9) => GND_net, PRDATAS9(8) => GND_net, 
        PRDATAS9(7) => GND_net, PRDATAS9(6) => GND_net, 
        PRDATAS9(5) => GND_net, PRDATAS9(4) => GND_net, 
        PRDATAS9(3) => GND_net, PRDATAS9(2) => GND_net, 
        PRDATAS9(1) => GND_net, PRDATAS9(0) => GND_net, 
        PRDATAS10(31) => GND_net, PRDATAS10(30) => GND_net, 
        PRDATAS10(29) => GND_net, PRDATAS10(28) => GND_net, 
        PRDATAS10(27) => GND_net, PRDATAS10(26) => GND_net, 
        PRDATAS10(25) => GND_net, PRDATAS10(24) => GND_net, 
        PRDATAS10(23) => GND_net, PRDATAS10(22) => GND_net, 
        PRDATAS10(21) => GND_net, PRDATAS10(20) => GND_net, 
        PRDATAS10(19) => GND_net, PRDATAS10(18) => GND_net, 
        PRDATAS10(17) => GND_net, PRDATAS10(16) => GND_net, 
        PRDATAS10(15) => GND_net, PRDATAS10(14) => GND_net, 
        PRDATAS10(13) => GND_net, PRDATAS10(12) => GND_net, 
        PRDATAS10(11) => GND_net, PRDATAS10(10) => GND_net, 
        PRDATAS10(9) => GND_net, PRDATAS10(8) => GND_net, 
        PRDATAS10(7) => GND_net, PRDATAS10(6) => GND_net, 
        PRDATAS10(5) => GND_net, PRDATAS10(4) => GND_net, 
        PRDATAS10(3) => GND_net, PRDATAS10(2) => GND_net, 
        PRDATAS10(1) => GND_net, PRDATAS10(0) => GND_net, 
        PRDATAS11(31) => GND_net, PRDATAS11(30) => GND_net, 
        PRDATAS11(29) => GND_net, PRDATAS11(28) => GND_net, 
        PRDATAS11(27) => GND_net, PRDATAS11(26) => GND_net, 
        PRDATAS11(25) => GND_net, PRDATAS11(24) => GND_net, 
        PRDATAS11(23) => GND_net, PRDATAS11(22) => GND_net, 
        PRDATAS11(21) => GND_net, PRDATAS11(20) => GND_net, 
        PRDATAS11(19) => GND_net, PRDATAS11(18) => GND_net, 
        PRDATAS11(17) => GND_net, PRDATAS11(16) => GND_net, 
        PRDATAS11(15) => GND_net, PRDATAS11(14) => GND_net, 
        PRDATAS11(13) => GND_net, PRDATAS11(12) => GND_net, 
        PRDATAS11(11) => GND_net, PRDATAS11(10) => GND_net, 
        PRDATAS11(9) => GND_net, PRDATAS11(8) => GND_net, 
        PRDATAS11(7) => GND_net, PRDATAS11(6) => GND_net, 
        PRDATAS11(5) => GND_net, PRDATAS11(4) => GND_net, 
        PRDATAS11(3) => GND_net, PRDATAS11(2) => GND_net, 
        PRDATAS11(1) => GND_net, PRDATAS11(0) => GND_net, 
        PRDATAS12(31) => GND_net, PRDATAS12(30) => GND_net, 
        PRDATAS12(29) => GND_net, PRDATAS12(28) => GND_net, 
        PRDATAS12(27) => GND_net, PRDATAS12(26) => GND_net, 
        PRDATAS12(25) => GND_net, PRDATAS12(24) => GND_net, 
        PRDATAS12(23) => GND_net, PRDATAS12(22) => GND_net, 
        PRDATAS12(21) => GND_net, PRDATAS12(20) => GND_net, 
        PRDATAS12(19) => GND_net, PRDATAS12(18) => GND_net, 
        PRDATAS12(17) => GND_net, PRDATAS12(16) => GND_net, 
        PRDATAS12(15) => GND_net, PRDATAS12(14) => GND_net, 
        PRDATAS12(13) => GND_net, PRDATAS12(12) => GND_net, 
        PRDATAS12(11) => GND_net, PRDATAS12(10) => GND_net, 
        PRDATAS12(9) => GND_net, PRDATAS12(8) => GND_net, 
        PRDATAS12(7) => GND_net, PRDATAS12(6) => GND_net, 
        PRDATAS12(5) => GND_net, PRDATAS12(4) => GND_net, 
        PRDATAS12(3) => GND_net, PRDATAS12(2) => GND_net, 
        PRDATAS12(1) => GND_net, PRDATAS12(0) => GND_net, 
        PRDATAS13(31) => GND_net, PRDATAS13(30) => GND_net, 
        PRDATAS13(29) => GND_net, PRDATAS13(28) => GND_net, 
        PRDATAS13(27) => GND_net, PRDATAS13(26) => GND_net, 
        PRDATAS13(25) => GND_net, PRDATAS13(24) => GND_net, 
        PRDATAS13(23) => GND_net, PRDATAS13(22) => GND_net, 
        PRDATAS13(21) => GND_net, PRDATAS13(20) => GND_net, 
        PRDATAS13(19) => GND_net, PRDATAS13(18) => GND_net, 
        PRDATAS13(17) => GND_net, PRDATAS13(16) => GND_net, 
        PRDATAS13(15) => GND_net, PRDATAS13(14) => GND_net, 
        PRDATAS13(13) => GND_net, PRDATAS13(12) => GND_net, 
        PRDATAS13(11) => GND_net, PRDATAS13(10) => GND_net, 
        PRDATAS13(9) => GND_net, PRDATAS13(8) => GND_net, 
        PRDATAS13(7) => GND_net, PRDATAS13(6) => GND_net, 
        PRDATAS13(5) => GND_net, PRDATAS13(4) => GND_net, 
        PRDATAS13(3) => GND_net, PRDATAS13(2) => GND_net, 
        PRDATAS13(1) => GND_net, PRDATAS13(0) => GND_net, 
        PRDATAS14(31) => GND_net, PRDATAS14(30) => GND_net, 
        PRDATAS14(29) => GND_net, PRDATAS14(28) => GND_net, 
        PRDATAS14(27) => GND_net, PRDATAS14(26) => GND_net, 
        PRDATAS14(25) => GND_net, PRDATAS14(24) => GND_net, 
        PRDATAS14(23) => GND_net, PRDATAS14(22) => GND_net, 
        PRDATAS14(21) => GND_net, PRDATAS14(20) => GND_net, 
        PRDATAS14(19) => GND_net, PRDATAS14(18) => GND_net, 
        PRDATAS14(17) => GND_net, PRDATAS14(16) => GND_net, 
        PRDATAS14(15) => GND_net, PRDATAS14(14) => GND_net, 
        PRDATAS14(13) => GND_net, PRDATAS14(12) => GND_net, 
        PRDATAS14(11) => GND_net, PRDATAS14(10) => GND_net, 
        PRDATAS14(9) => GND_net, PRDATAS14(8) => GND_net, 
        PRDATAS14(7) => GND_net, PRDATAS14(6) => GND_net, 
        PRDATAS14(5) => GND_net, PRDATAS14(4) => GND_net, 
        PRDATAS14(3) => GND_net, PRDATAS14(2) => GND_net, 
        PRDATAS14(1) => GND_net, PRDATAS14(0) => GND_net, 
        PRDATAS15(31) => GND_net, PRDATAS15(30) => GND_net, 
        PRDATAS15(29) => GND_net, PRDATAS15(28) => GND_net, 
        PRDATAS15(27) => GND_net, PRDATAS15(26) => GND_net, 
        PRDATAS15(25) => GND_net, PRDATAS15(24) => GND_net, 
        PRDATAS15(23) => GND_net, PRDATAS15(22) => GND_net, 
        PRDATAS15(21) => GND_net, PRDATAS15(20) => GND_net, 
        PRDATAS15(19) => GND_net, PRDATAS15(18) => GND_net, 
        PRDATAS15(17) => GND_net, PRDATAS15(16) => GND_net, 
        PRDATAS15(15) => GND_net, PRDATAS15(14) => GND_net, 
        PRDATAS15(13) => GND_net, PRDATAS15(12) => GND_net, 
        PRDATAS15(11) => GND_net, PRDATAS15(10) => GND_net, 
        PRDATAS15(9) => GND_net, PRDATAS15(8) => GND_net, 
        PRDATAS15(7) => GND_net, PRDATAS15(6) => GND_net, 
        PRDATAS15(5) => GND_net, PRDATAS15(4) => GND_net, 
        PRDATAS15(3) => GND_net, PRDATAS15(2) => GND_net, 
        PRDATAS15(1) => GND_net, PRDATAS15(0) => GND_net);
    
    \VCC\ : VCC
      port map(Y => VCC_net);
    
    uC_0 : uC
      port map(MSS_RESET_N => MSS_RESET_N, FAB_CLK => 
        uC_0_FAB_CLK, MAINXIN => MAINXIN, M2F_RESET_N => 
        uC_0_M2F_RESET_N, FABINT => net_2, IO_8_PADOUT => 
        IO_8_PADOUT, IO_8_D => SPI_APB_ADC_0_CSn, IO_7_PADIN => 
        IO_7_PADIN, IO_7_Y => uC_0_IO_7_Y, IO_6_PADIN => 
        IO_6_PADIN, IO_6_Y => uC_0_IO_6_Y, IO_5_PADOUT => 
        IO_5_PADOUT, IO_5_D => SPI_APB_ADC_0_SCLK, MSSPSEL => 
        uC_0_MSS_MASTER_APB_PSELx, MSSPENABLE => 
        uC_0_MSS_MASTER_APB_PENABLE, MSSPWRITE => 
        uC_0_MSS_MASTER_APB_PWRITE, MSSPREADY => 
        uC_0_MSS_MASTER_APB_PREADY, MSSPSLVERR => 
        uC_0_MSS_MASTER_APB_PSLVERR, GLC => GLC, MAC_0_MDIO => 
        MAC_0_MDIO, MAC_0_CRSDV => MAC_0_CRSDV, MAC_0_RXER => 
        MAC_0_RXER, MAC_0_TXEN => MAC_0_TXEN, MAC_0_MDC => 
        MAC_0_MDC, MSSPADDR(19) => 
        \uC_0_MSS_MASTER_APB_PADDR_[19]\, MSSPADDR(18) => 
        \uC_0_MSS_MASTER_APB_PADDR_[18]\, MSSPADDR(17) => 
        \uC_0_MSS_MASTER_APB_PADDR_[17]\, MSSPADDR(16) => 
        \uC_0_MSS_MASTER_APB_PADDR_[16]\, MSSPADDR(15) => 
        \uC_0_MSS_MASTER_APB_PADDR_[15]\, MSSPADDR(14) => 
        \uC_0_MSS_MASTER_APB_PADDR_[14]\, MSSPADDR(13) => 
        \uC_0_MSS_MASTER_APB_PADDR_[13]\, MSSPADDR(12) => 
        \uC_0_MSS_MASTER_APB_PADDR_[12]\, MSSPADDR(11) => 
        \uC_0_MSS_MASTER_APB_PADDR_[11]\, MSSPADDR(10) => 
        \uC_0_MSS_MASTER_APB_PADDR_[10]\, MSSPADDR(9) => 
        \uC_0_MSS_MASTER_APB_PADDR_[9]\, MSSPADDR(8) => 
        \uC_0_MSS_MASTER_APB_PADDR_[8]\, MSSPADDR(7) => 
        \uC_0_MSS_MASTER_APB_PADDR_[7]\, MSSPADDR(6) => 
        \uC_0_MSS_MASTER_APB_PADDR_[6]\, MSSPADDR(5) => 
        \uC_0_MSS_MASTER_APB_PADDR_[5]\, MSSPADDR(4) => 
        \uC_0_MSS_MASTER_APB_PADDR_[4]\, MSSPADDR(3) => 
        \uC_0_MSS_MASTER_APB_PADDR_[3]\, MSSPADDR(2) => 
        \uC_0_MSS_MASTER_APB_PADDR_[2]\, MSSPADDR(1) => 
        \uC_0_MSS_MASTER_APB_PADDR_[1]\, MSSPADDR(0) => 
        \uC_0_MSS_MASTER_APB_PADDR_[0]\, MSSPRDATA(31) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[31]\, MSSPRDATA(30) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[30]\, MSSPRDATA(29) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[29]\, MSSPRDATA(28) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[28]\, MSSPRDATA(27) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[27]\, MSSPRDATA(26) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[26]\, MSSPRDATA(25) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[25]\, MSSPRDATA(24) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[24]\, MSSPRDATA(23) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[23]\, MSSPRDATA(22) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[22]\, MSSPRDATA(21) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[21]\, MSSPRDATA(20) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[20]\, MSSPRDATA(19) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[19]\, MSSPRDATA(18) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[18]\, MSSPRDATA(17) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[17]\, MSSPRDATA(16) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[16]\, MSSPRDATA(15) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[15]\, MSSPRDATA(14) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[14]\, MSSPRDATA(13) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[13]\, MSSPRDATA(12) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[12]\, MSSPRDATA(11) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[11]\, MSSPRDATA(10) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[10]\, MSSPRDATA(9) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[9]\, MSSPRDATA(8) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[8]\, MSSPRDATA(7) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[7]\, MSSPRDATA(6) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[6]\, MSSPRDATA(5) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[5]\, MSSPRDATA(4) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[4]\, MSSPRDATA(3) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[3]\, MSSPRDATA(2) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[2]\, MSSPRDATA(1) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[1]\, MSSPRDATA(0) => 
        \uC_0_MSS_MASTER_APB_PRDATA_[0]\, MSSPWDATA(31) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[31]\, MSSPWDATA(30) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[30]\, MSSPWDATA(29) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[29]\, MSSPWDATA(28) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[28]\, MSSPWDATA(27) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[27]\, MSSPWDATA(26) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[26]\, MSSPWDATA(25) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[25]\, MSSPWDATA(24) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[24]\, MSSPWDATA(23) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[23]\, MSSPWDATA(22) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[22]\, MSSPWDATA(21) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[21]\, MSSPWDATA(20) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[20]\, MSSPWDATA(19) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[19]\, MSSPWDATA(18) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[18]\, MSSPWDATA(17) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[17]\, MSSPWDATA(16) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[16]\, MSSPWDATA(15) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[15]\, MSSPWDATA(14) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[14]\, MSSPWDATA(13) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[13]\, MSSPWDATA(12) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[12]\, MSSPWDATA(11) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[11]\, MSSPWDATA(10) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[10]\, MSSPWDATA(9) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[9]\, MSSPWDATA(8) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[8]\, MSSPWDATA(7) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[7]\, MSSPWDATA(6) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[6]\, MSSPWDATA(5) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[5]\, MSSPWDATA(4) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[4]\, MSSPWDATA(3) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[3]\, MSSPWDATA(2) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[2]\, MSSPWDATA(1) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[1]\, MSSPWDATA(0) => 
        \uC_0_MSS_MASTER_APB_PWDATA_[0]\, DMAREADY(1) => GND_net, 
        DMAREADY(0) => net_2, MAC_0_RXD(1) => MAC_0_RXD(1), 
        MAC_0_RXD(0) => MAC_0_RXD(0), MAC_0_TXD(1) => 
        MAC_0_TXD(1), MAC_0_TXD(0) => MAC_0_TXD(0));
    
    SPI_APB_ADC_0 : entity work.SPI_APB_ADC
      port map(PCLK => uC_0_FAB_CLK, PRESETn => uC_0_M2F_RESET_N, 
        PSEL => CoreAPB3_0_APBmslave0_PSELx, PENABLE => 
        CoreAPB3_0_APBmslave0_PENABLE, PWRITE => 
        CoreAPB3_0_APBmslave0_PWRITE, PREADY => 
        CoreAPB3_0_APBmslave0_PREADY, PSLVERR => 
        CoreAPB3_0_APBmslave0_PSLVERR, SCLK => SPI_APB_ADC_0_SCLK, 
        CSn => SPI_APB_ADC_0_CSn, sample_rdy => net_2, PADDR(31)
         => GND_net, PADDR(30) => GND_net, PADDR(29) => GND_net, 
        PADDR(28) => GND_net, PADDR(27) => GND_net, PADDR(26) => 
        GND_net, PADDR(25) => GND_net, PADDR(24) => GND_net, 
        PADDR(23) => \CoreAPB3_0_APBmslave0_PADDR_[23]\, 
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
        \CoreAPB3_0_APBmslave0_PADDR_[0]\, PWDATA(31) => 
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
        \CoreAPB3_0_APBmslave0_PRDATA_[0]\, SDATA(1) => 
        uC_0_IO_7_Y, SDATA(2) => uC_0_IO_6_Y);
    
    \GND\ : GND
      port map(Y => GND_net);
    

end DEF_ARCH; 
