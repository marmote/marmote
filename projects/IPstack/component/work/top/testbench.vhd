----------------------------------------------------------------------
-- Created by Actel SmartDesign Mon May 02 13:44:39 2011
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture behavioral of testbench is

    constant SYSCLK_PERIOD : time := 100 ns;

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    component top
        -- ports
        port( 
            -- Inputs
            MSS_RESET_N : in std_logic;
            MAC_0_CRSDV : in std_logic;
            MAC_0_RXER : in std_logic;
            MAC_0_RXD : in std_logic_vector(1 downto 0);
            MAINXIN : in std_logic;

            -- Outputs
            MAC_0_TXEN : out std_logic;
            MAC_0_MDC : out std_logic;
            GLC : out std_logic;
            MAC_0_TXD : out std_logic_vector(1 downto 0);

            -- Inouts
            MAC_0_MDIO : inout std_logic

        );
    end component;

begin

    process
        variable vhdl_initial : BOOLEAN := TRUE;

    begin
        if ( vhdl_initial ) then
            -- Assert Reset
            NSYSRESET <= '0';
            wait for ( SYSCLK_PERIOD * 10 );
            
            NSYSRESET <= '1';
            wait;
        end if;
    end process;

    -- 10MHz Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  top
    top_0 : top
        -- port map
        port map( 
            -- Inputs
            MSS_RESET_N => NSYSRESET,
            MAC_0_CRSDV => '0',
            MAC_0_RXER => '0',
            MAC_0_RXD => (others=> '0'),
            MAINXIN => '0',

            -- Outputs
            MAC_0_TXEN =>  open,
            MAC_0_MDC =>  open,
            GLC =>  open,
            MAC_0_TXD => open,

            -- Inouts
            MAC_0_MDIO =>  open

        );

end behavioral;

