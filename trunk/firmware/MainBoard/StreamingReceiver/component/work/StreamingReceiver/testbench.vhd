----------------------------------------------------------------------
-- Created by Actel SmartDesign Fri Aug 10 10:27:52 2012
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

    component StreamingReceiver
        -- ports
        port( 
            -- Inputs
            MSS_RESET_N : in std_logic;
            MAINXIN : in std_logic;
            TXE_n_pin : in std_logic;
            USB_CLK_pin : in std_logic;

            -- Outputs
            AFE2_CLK : out std_logic;
            AFE2_SHDN_n : out std_logic;
            AFE2_TR_n : out std_logic;
            OE_n_pin : out std_logic;
            RD_n_pin : out std_logic;
            WR_n_pin : out std_logic;
            SIWU_n_pin : out std_logic;

            -- Inouts
            DATA_pin : inout std_logic_vector(9 downto 0);
            USB_DATA_pin : inout std_logic_vector(7 downto 0)

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

    -- Instantiate Unit Under Test:  StreamingReceiver
    StreamingReceiver_0 : StreamingReceiver
        -- port map
        port map( 
            -- Inputs
            MSS_RESET_N => NSYSRESET,
            MAINXIN => '0',
            TXE_n_pin => '0',
            USB_CLK_pin => SYSCLK,

            -- Outputs
            AFE2_CLK =>  open,
            AFE2_SHDN_n =>  open,
            AFE2_TR_n =>  open,
            OE_n_pin =>  open,
            RD_n_pin =>  open,
            WR_n_pin =>  open,
            SIWU_n_pin =>  open,

            -- Inouts
            DATA_pin => open,
            USB_DATA_pin => open

        );

end behavioral;

