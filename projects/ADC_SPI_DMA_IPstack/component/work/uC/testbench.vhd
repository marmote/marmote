----------------------------------------------------------------------
-- Created by Actel SmartDesign Wed Oct 26 15:34:23 2011
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

    component uC
        -- ports
        port( 
            -- Inputs
            MAINXIN : in std_logic;
            FABINT : in std_logic;
            IO_8_D : in std_logic;
            IO_5_D : in std_logic;
            MSSPREADY : in std_logic;
            MSSPSLVERR : in std_logic;
            MSSPRDATA : in std_logic_vector(31 downto 0);
            DMAREADY : in std_logic_vector(1 downto 0);
            MAC_0_RXD : in std_logic_vector(1 downto 0);
            MAC_0_CRSDV : in std_logic;
            MAC_0_RXER : in std_logic;
            MSS_RESET_N : in std_logic;
            IO_6_PADIN : in std_logic;
            IO_7_PADIN : in std_logic;

            -- Outputs
            FAB_CLK : out std_logic;
            M2F_RESET_N : out std_logic;
            IO_7_Y : out std_logic;
            IO_6_Y : out std_logic;
            MSSPSEL : out std_logic;
            MSSPENABLE : out std_logic;
            MSSPWRITE : out std_logic;
            GLC : out std_logic;
            MSSPADDR : out std_logic_vector(19 downto 0);
            MSSPWDATA : out std_logic_vector(31 downto 0);
            MAC_0_TXD : out std_logic_vector(1 downto 0);
            MAC_0_TXEN : out std_logic;
            MAC_0_MDC : out std_logic;
            IO_5_PADOUT : out std_logic;
            IO_8_PADOUT : out std_logic;

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

    -- Instantiate Unit Under Test:  uC
    uC_0 : uC
        -- port map
        port map( 
            -- Inputs
            MAINXIN => '0',
            FABINT => '0',
            IO_8_D => '0',
            IO_5_D => '0',
            MSSPREADY => '0',
            MSSPSLVERR => '0',
            MSSPRDATA => (others=> '0'),
            DMAREADY => (others=> '0'),
            MAC_0_RXD => (others=> '0'),
            MAC_0_CRSDV => '0',
            MAC_0_RXER => '0',
            MSS_RESET_N => NSYSRESET,
            IO_6_PADIN => '0',
            IO_7_PADIN => '0',

            -- Outputs
            FAB_CLK =>  open,
            M2F_RESET_N =>  open,
            IO_7_Y =>  open,
            IO_6_Y =>  open,
            MSSPSEL =>  open,
            MSSPENABLE =>  open,
            MSSPWRITE =>  open,
            GLC =>  open,
            MSSPADDR => open,
            MSSPWDATA => open,
            MAC_0_TXD => open,
            MAC_0_TXEN =>  open,
            MAC_0_MDC =>  open,
            IO_5_PADOUT =>  open,
            IO_8_PADOUT =>  open,

            -- Inouts
            MAC_0_MDIO =>  open

        );

end behavioral;

