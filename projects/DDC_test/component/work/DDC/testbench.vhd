----------------------------------------------------------------------
-- Created by Actel SmartDesign Thu Sep 15 11:10:34 2011
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

    component DDC
        -- ports
        port( 
            -- Inputs
            RST : in std_logic;
            CLK : in std_logic;
            SDATA : in std_logic_vector(1 downto 2);

            -- Outputs
            SCLK : out std_logic;
            CSn : out std_logic;
            CH1 : out std_logic_vector(13 downto 0);
            CH2 : out std_logic_vector(13 downto 0);
            OUTPUT_0 : out std_logic_vector(46 downto 0);
            OUTPUT_1 : out std_logic_vector(46 downto 0)

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

    -- Instantiate Unit Under Test:  DDC
    DDC_0 : DDC
        -- port map
        port map( 
            -- Inputs
            RST => NSYSRESET,
            CLK => SYSCLK,
            SDATA => (others=> '0'),

            -- Outputs
            SCLK =>  open,
            CSn =>  open,
            CH1 => open,
            CH2 => open,
            OUTPUT_0 => open,
            OUTPUT_1 => open

            -- Inouts

        );

end behavioral;

