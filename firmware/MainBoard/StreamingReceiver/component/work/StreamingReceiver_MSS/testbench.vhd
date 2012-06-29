----------------------------------------------------------------------
-- Created by Actel SmartDesign Fri Jun 22 10:15:32 2012
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

    component StreamingReceiver_MSS
        -- ports
        port( 
            -- Inputs
            MAINXIN : in std_logic;
            MSS_RESET_N : in std_logic;

            -- Outputs
            M2F_RESET_N : out std_logic;
            GLB : out std_logic

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

    -- Instantiate Unit Under Test:  StreamingReceiver_MSS
    StreamingReceiver_MSS_0 : StreamingReceiver_MSS
        -- port map
        port map( 
            -- Inputs
            MAINXIN => '0',
            MSS_RESET_N => NSYSRESET,

            -- Outputs
            M2F_RESET_N =>  open,
            GLB =>  open

            -- Inouts

        );

end behavioral;

