----------------------------------------------------------------------
-- Created by Actel SmartDesign Tue Jul 19 15:02:10 2011
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

    component sincos_gen
        -- ports
        port( 
            -- Inputs
            CLK : in std_logic;
            RST : in std_logic;
            DPHASE_EN : in std_logic;
            DPHASE : in std_logic_vector(15 downto 0);

            -- Outputs
            COS_OUT : out std_logic_vector(15 downto 0);
            SIN_OUT : out std_logic_vector(15 downto 0);
            RDYOUT : out std_logic

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

    -- Instantiate Unit Under Test:  sincos_gen
    sincos_gen_0 : sincos_gen
        -- port map
        port map( 
            -- Inputs
            CLK => SYSCLK,
            RST => NSYSRESET,
            DPHASE_EN => '0',
            DPHASE => (others=> '0'),

            -- Outputs
            COS_OUT => open,
            SIN_OUT => open,
            RDYOUT =>  open

            -- Inouts

        );

end behavioral;

