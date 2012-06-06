----------------------------------------------------------------------
-- Created by Actel SmartDesign Tue May 22 13:52:37 2012
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

    component lwIPTest_MSS
        -- ports
        port( 
            -- Inputs
            MAINXIN : in std_logic;
            MSSPREADY : in std_logic;
            MSSPSLVERR : in std_logic;
            DMAREADY : in std_logic_vector(1 downto 0);
            MSSPRDATA : in std_logic_vector(31 downto 0);
            MAC_RXD : in std_logic_vector(1 downto 0);
            MAC_CRSDV : in std_logic;
            MAC_RXER : in std_logic;
            MSS_RESET_N : in std_logic;

            -- Outputs
            FAB_CLK : out std_logic;
            M2F_RESET_N : out std_logic;
            MSSPSEL : out std_logic;
            MSSPENABLE : out std_logic;
            MSSPWRITE : out std_logic;
            MSSPADDR : out std_logic_vector(19 downto 0);
            MSSPWDATA : out std_logic_vector(31 downto 0);
            MAC_TXD : out std_logic_vector(1 downto 0);
            MAC_TXEN : out std_logic;
            MAC_MDC : out std_logic;

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

    -- Instantiate Unit Under Test:  lwIPTest_MSS
    lwIPTest_MSS_0 : lwIPTest_MSS
        -- port map
        port map( 
            -- Inputs
            MAINXIN => '0',
            MSSPREADY => '0',
            MSSPSLVERR => '0',
            DMAREADY => (others=> '0'),
            MSSPRDATA => (others=> '0'),
            MAC_RXD => (others=> '0'),
            MAC_CRSDV => '0',
            MAC_RXER => '0',
            MSS_RESET_N => NSYSRESET,

            -- Outputs
            FAB_CLK =>  open,
            M2F_RESET_N =>  open,
            MSSPSEL =>  open,
            MSSPENABLE =>  open,
            MSSPWRITE =>  open,
            MSSPADDR => open,
            MSSPWDATA => open,
            MAC_TXD => open,
            MAC_TXEN =>  open,
            MAC_MDC =>  open,

            -- Inouts
            MAC_MDIO =>  open

        );

end behavioral;

