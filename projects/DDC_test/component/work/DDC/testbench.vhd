----------------------------------------------------------------------
-- Created by Actel SmartDesign Thu Oct 20 10:04:17 2011
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
            PSEL_0 : in std_logic;
            PENABLE_0 : in std_logic;
            PWRITE_0 : in std_logic;
            sample_rdy_in : in std_logic;
            PADDR_0 : in std_logic_vector(31 downto 0);
            PWDATA_0 : in std_logic_vector(31 downto 0);
            I_B : in std_logic_vector(13 downto 0);
            Q_B : in std_logic_vector(13 downto 0);

            -- Outputs
            PREADY_0 : out std_logic;
            PSLVERR_0 : out std_logic;
            SMPL_RDY : out std_logic;
            PRDATA_0 : out std_logic_vector(31 downto 0)

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
            PSEL_0 => '0',
            PENABLE_0 => '0',
            PWRITE_0 => '0',
            sample_rdy_in => '0',
            PADDR_0 => (others=> '0'),
            PWDATA_0 => (others=> '0'),
            I_B => (others=> '0'),
            Q_B => (others=> '0'),

            -- Outputs
            PREADY_0 =>  open,
            PSLVERR_0 =>  open,
            SMPL_RDY =>  open,
            PRDATA_0 => open

            -- Inouts

        );

end behavioral;

