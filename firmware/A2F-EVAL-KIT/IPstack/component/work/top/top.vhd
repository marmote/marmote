-- Version: 9.1 SP1 9.1.1.7

library ieee;
use ieee.std_logic_1164.all;
library smartfusion;
use smartfusion.all;

entity top is

    port( MSS_RESET_N : in    std_logic;
          MAC_0_MDIO  : inout std_logic := 'Z';
          MAC_0_CRSDV : in    std_logic;
          MAC_0_RXER  : in    std_logic;
          MAC_0_TXEN  : out   std_logic;
          MAC_0_MDC   : out   std_logic;
          GLC         : out   std_logic;
          MAC_0_RXD   : in    std_logic_vector(1 downto 0);
          MAC_0_TXD   : out   std_logic_vector(1 downto 0);
          MAINXIN     : in    std_logic
        );

end top;

architecture DEF_ARCH of top is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component uC
    port( MSS_RESET_N : in    std_logic := 'U';
          MAC_0_MDIO  : inout   std_logic;
          MAC_0_CRSDV : in    std_logic := 'U';
          MAC_0_RXER  : in    std_logic := 'U';
          MAC_0_TXEN  : out   std_logic;
          MAC_0_MDC   : out   std_logic;
          GLC         : out   std_logic;
          MAINXIN     : in    std_logic := 'U';
          MAC_0_RXD   : in    std_logic_vector(1 downto 0) := (others => 'U');
          MAC_0_TXD   : out   std_logic_vector(1 downto 0)
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal GND_net, VCC_net : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net);
    
    uC_0 : uC
      port map(MSS_RESET_N => MSS_RESET_N, MAC_0_MDIO => 
        MAC_0_MDIO, MAC_0_CRSDV => MAC_0_CRSDV, MAC_0_RXER => 
        MAC_0_RXER, MAC_0_TXEN => MAC_0_TXEN, MAC_0_MDC => 
        MAC_0_MDC, GLC => GLC, MAINXIN => MAINXIN, MAC_0_RXD(1)
         => MAC_0_RXD(1), MAC_0_RXD(0) => MAC_0_RXD(0), 
        MAC_0_TXD(1) => MAC_0_TXD(1), MAC_0_TXD(0) => 
        MAC_0_TXD(0));
    
    \GND\ : GND
      port map(Y => GND_net);
    

end DEF_ARCH; 
