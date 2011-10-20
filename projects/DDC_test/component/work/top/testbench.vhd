----------------------------------------------------------------------
-- Created by Actel SmartDesign Thu Oct 20 10:04:22 2011
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
            MAINXIN : in std_logic;
            IO_7_PADIN : in std_logic;
            IO_6_PADIN : in std_logic;
            MAC_0_CRSDV : in std_logic;
            MAC_0_RXER : in std_logic;
            MAC_0_RXD : in std_logic_vector(1 downto 0);

            -- Outputs
            IO_8_PADOUT : out std_logic;
            IO_5_PADOUT : out std_logic;
            MAC_0_TXEN : out std_logic;
            MAC_0_MDC : out std_logic;
            GLC : out std_logic;
            SMPL_RDY : out std_logic;
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
            MAINXIN => '0',
            IO_7_PADIN => '0',
            IO_6_PADIN => '0',
            MAC_0_CRSDV => '0',
            MAC_0_RXER => '0',
            MAC_0_RXD => (others=> '0'),

            -- Outputs
            IO_8_PADOUT =>  open,
            IO_5_PADOUT =>  open,
            MAC_0_TXEN =>  open,
            MAC_0_MDC =>  open,
            GLC =>  open,
            SMPL_RDY =>  open,
            MAC_0_TXD => open,

            -- Inouts
            MAC_0_MDIO =>  open

        );

end behavioral;

