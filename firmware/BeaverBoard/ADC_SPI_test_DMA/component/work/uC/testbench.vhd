----------------------------------------------------------------------
-- Created by Actel SmartDesign Fri Apr 01 16:25:52 2011
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
            MSSPREADY : in std_logic;
            MSSPSLVERR : in std_logic;
            IO_8_D : in std_logic;
            IO_5_D : in std_logic;
            FABINT : in std_logic;
            MSSPRDATA : in std_logic_vector(31 downto 0);
            DMAREADY : in std_logic_vector(1 downto 0);
            MSS_RESET_N : in std_logic;
            IO_6_PADIN : in std_logic;
            IO_7_PADIN : in std_logic;

            -- Outputs
            MSSPSEL : out std_logic;
            MSSPENABLE : out std_logic;
            MSSPWRITE : out std_logic;
            FAB_CLK : out std_logic;
            IO_7_Y : out std_logic;
            IO_6_Y : out std_logic;
            M2F_RESET_N : out std_logic;
            MSSPADDR : out std_logic_vector(19 downto 0);
            MSSPWDATA : out std_logic_vector(31 downto 0);
            IO_5_PADOUT : out std_logic;
            IO_8_PADOUT : out std_logic

            -- Inouts

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
            MSSPREADY => '0',
            MSSPSLVERR => '0',
            IO_8_D => '0',
            IO_5_D => '0',
            FABINT => '0',
            MSSPRDATA => (others=> '0'),
            DMAREADY => (others=> '0'),
            MSS_RESET_N => NSYSRESET,
            IO_6_PADIN => '0',
            IO_7_PADIN => '0',

            -- Outputs
            MSSPSEL =>  open,
            MSSPENABLE =>  open,
            MSSPWRITE =>  open,
            FAB_CLK =>  open,
            IO_7_Y =>  open,
            IO_6_Y =>  open,
            M2F_RESET_N =>  open,
            MSSPADDR => open,
            MSSPWDATA => open,
            IO_5_PADOUT =>  open,
            IO_8_PADOUT =>  open

            -- Inouts

        );

end behavioral;

