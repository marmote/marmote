----------------------------------------------------------------------
-- Created by Actel SmartDesign Tue Jun 05 12:43:51 2012
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

    component lwIPTest
        -- ports
        port( 
            -- Inputs
            MAC_CRSDV : in std_logic;
            MAC_RXER : in std_logic;
            MSS_RESET_N : in std_logic;
            MAINXIN : in std_logic;
            MAC_RXD : in std_logic_vector(1 downto 0);

            -- Outputs
            MAC_MDC : out std_logic;
            MAC_TXEN : out std_logic;
            MAC_TXD : out std_logic_vector(1 downto 0);
            MAC_EN : out std_logic;

            -- Inouts
            MAC_MDIO : inout std_logic

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

    -- Instantiate Unit Under Test:  lwIPTest
    lwIPTest_0 : lwIPTest
        -- port map
        port map( 
            -- Inputs
            MAC_CRSDV => '0',
            MAC_RXER => '0',
            MSS_RESET_N => NSYSRESET,
            MAINXIN => '0',
            MAC_RXD => (others=> '0'),

            -- Outputs
            MAC_MDC =>  open,
            MAC_TXEN =>  open,
            MAC_TXD => open,
            MAC_EN =>  open,

            -- Inouts
            MAC_MDIO =>  open

        );

end behavioral;

