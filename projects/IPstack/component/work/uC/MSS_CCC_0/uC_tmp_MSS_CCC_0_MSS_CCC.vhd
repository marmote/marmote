-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity uC_tmp_MSS_CCC_0_MSS_CCC is

    port( CLKA           : in    std_logic;
          CLKA_PAD       : in    std_logic;
          CLKA_PADP      : in    std_logic;
          CLKA_PADN      : in    std_logic;
          CLKB           : in    std_logic;
          CLKB_PAD       : in    std_logic;
          CLKB_PADP      : in    std_logic;
          CLKB_PADN      : in    std_logic;
          CLKC           : in    std_logic;
          CLKC_PAD       : in    std_logic;
          CLKC_PADP      : in    std_logic;
          CLKC_PADN      : in    std_logic;
          MAINXIN        : in    std_logic;
          LPXIN          : in    std_logic;
          MAC_CLK        : in    std_logic;
          GLA0           : out   std_logic;
          GLA            : out   std_logic;
          FAB_CLK        : out   std_logic;
          FAB_LOCK       : out   std_logic;
          MSS_LOCK       : out   std_logic;
          GLB            : out   std_logic;
          YB             : out   std_logic;
          GLC            : out   std_logic;
          YC             : out   std_logic;
          MAC_CLK_CCC    : out   std_logic;
          MAC_CLK_IO     : out   std_logic;
          RCOSC_CLKOUT   : out   std_logic;
          MAINXIN_CLKOUT : out   std_logic;
          LPXIN_CLKOUT   : out   std_logic
        );

end uC_tmp_MSS_CCC_0_MSS_CCC;

architecture DEF_ARCH of uC_tmp_MSS_CCC_0_MSS_CCC is 

  component MSS_CCC
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
          OADIV     : in    std_logic_vector(4 downto 0) := (others => 'U');
          OADIVHALF : in    std_logic := 'U';
          OAMUX     : in    std_logic_vector(2 downto 0) := (others => 'U');
          BYPASSA   : in    std_logic := 'U';
          DLYGLA    : in    std_logic_vector(4 downto 0) := (others => 'U');
          DLYGLAMSS : in    std_logic_vector(4 downto 0) := (others => 'U');
          DLYGLAFAB : in    std_logic_vector(4 downto 0) := (others => 'U');
          OBDIV     : in    std_logic_vector(4 downto 0) := (others => 'U');
          OBDIVHALF : in    std_logic := 'U';
          OBMUX     : in    std_logic_vector(2 downto 0) := (others => 'U');
          BYPASSB   : in    std_logic := 'U';
          DLYGLB    : in    std_logic_vector(4 downto 0) := (others => 'U');
          OCDIV     : in    std_logic_vector(4 downto 0) := (others => 'U');
          OCDIVHALF : in    std_logic := 'U';
          OCMUX     : in    std_logic_vector(2 downto 0) := (others => 'U');
          BYPASSC   : in    std_logic := 'U';
          DLYGLC    : in    std_logic_vector(4 downto 0) := (others => 'U');
          FINDIV    : in    std_logic_vector(6 downto 0) := (others => 'U');
          FBDIV     : in    std_logic_vector(6 downto 0) := (others => 'U');
          FBDLY     : in    std_logic_vector(4 downto 0) := (others => 'U');
          FBSEL     : in    std_logic_vector(1 downto 0) := (others => 'U');
          XDLYSEL   : in    std_logic := 'U';
          GLMUXSEL  : in    std_logic_vector(1 downto 0) := (others => 'U');
          GLMUXCFG  : in    std_logic_vector(1 downto 0) := (others => 'U')
        );
  end component;

  component MSS_XTLOSC
    port( XTL    : in    std_logic := 'U';
          CLKOUT : out   std_logic
        );
  end component;

  component RCOSC
    port( CLKOUT : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal N_CLKA_XTLOSC, N_GND, N_VCC : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;

begin 

    GLA <= N_GND;
    FAB_CLK <= N_GND;
    GLB <= N_GND;
    YB <= N_GND;
    YC <= N_GND;
    MAC_CLK_IO <= N_GND;
    N_GND <= GND_power_net1;
    N_VCC <= VCC_power_net1;

    I_MSSCCC : MSS_CCC
      generic map(VCOFREQUENCY => 100.000)

      port map(CLKA => N_CLKA_XTLOSC, EXTFB => N_GND, GLA => OPEN, 
        GLAMSS => GLA0, LOCK => FAB_LOCK, LOCKMSS => MSS_LOCK, 
        CLKB => N_GND, GLB => OPEN, YB => OPEN, CLKC => N_GND, 
        GLC => GLC, YC => OPEN, MACCLK => MAC_CLK_CCC, OADIV(4)
         => N_GND, OADIV(3) => N_GND, OADIV(2) => N_GND, OADIV(1)
         => N_GND, OADIV(0) => N_GND, OADIVHALF => N_GND, 
        OAMUX(2) => N_VCC, OAMUX(1) => N_GND, OAMUX(0) => N_GND, 
        BYPASSA => N_GND, DLYGLA(4) => N_GND, DLYGLA(3) => N_GND, 
        DLYGLA(2) => N_GND, DLYGLA(1) => N_GND, DLYGLA(0) => 
        N_GND, DLYGLAMSS(4) => N_GND, DLYGLAMSS(3) => N_GND, 
        DLYGLAMSS(2) => N_GND, DLYGLAMSS(1) => N_GND, 
        DLYGLAMSS(0) => N_GND, DLYGLAFAB(4) => N_GND, 
        DLYGLAFAB(3) => N_GND, DLYGLAFAB(2) => N_GND, 
        DLYGLAFAB(1) => N_GND, DLYGLAFAB(0) => N_GND, OBDIV(4)
         => N_GND, OBDIV(3) => N_GND, OBDIV(2) => N_GND, OBDIV(1)
         => N_GND, OBDIV(0) => N_GND, OBDIVHALF => N_GND, 
        OBMUX(2) => N_GND, OBMUX(1) => N_GND, OBMUX(0) => N_GND, 
        BYPASSB => N_VCC, DLYGLB(4) => N_GND, DLYGLB(3) => N_GND, 
        DLYGLB(2) => N_GND, DLYGLB(1) => N_GND, DLYGLB(0) => 
        N_GND, OCDIV(4) => N_GND, OCDIV(3) => N_GND, OCDIV(2) => 
        N_GND, OCDIV(1) => N_GND, OCDIV(0) => N_VCC, OCDIVHALF
         => N_GND, OCMUX(2) => N_VCC, OCMUX(1) => N_GND, OCMUX(0)
         => N_GND, BYPASSC => N_GND, DLYGLC(4) => N_GND, 
        DLYGLC(3) => N_GND, DLYGLC(2) => N_GND, DLYGLC(1) => 
        N_GND, DLYGLC(0) => N_GND, FINDIV(6) => N_GND, FINDIV(5)
         => N_GND, FINDIV(4) => N_GND, FINDIV(3) => N_GND, 
        FINDIV(2) => N_GND, FINDIV(1) => N_VCC, FINDIV(0) => 
        N_VCC, FBDIV(6) => N_GND, FBDIV(5) => N_GND, FBDIV(4) => 
        N_VCC, FBDIV(3) => N_GND, FBDIV(2) => N_GND, FBDIV(1) => 
        N_VCC, FBDIV(0) => N_VCC, FBDLY(4) => N_GND, FBDLY(3) => 
        N_GND, FBDLY(2) => N_GND, FBDLY(1) => N_GND, FBDLY(0) => 
        N_VCC, FBSEL(1) => N_GND, FBSEL(0) => N_VCC, XDLYSEL => 
        N_GND, GLMUXSEL(1) => N_GND, GLMUXSEL(0) => N_GND, 
        GLMUXCFG(1) => N_GND, GLMUXCFG(0) => N_GND);
    
    I_XTLOSC : MSS_XTLOSC
      port map(XTL => MAINXIN, CLKOUT => N_CLKA_XTLOSC);
    
    I_RCOSC : RCOSC
      port map(CLKOUT => OPEN);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
