----------------------------------------------------------------------
-- Created by Actel SmartDesign Fri Aug 10 16:33:28 2012
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

    component USB_FIFO_IF
        -- ports
        port( 
            -- Inputs
            USB_CLK_pin : in std_logic;
            USB_TXE_n_pin : in std_logic;
            CLK : in std_logic;
            RST_n : in std_logic;
            FROM_ADC_SMPL_RDY : in std_logic;
            USB_RXF_n_pin : in std_logic;
            READ_SUCCESSFUL : in std_logic;
            ADC_Q : in std_logic_vector(31 downto 16);
            ADC_I : in std_logic_vector(15 downto 0);

            -- Outputs
            USB_WR_n_pin : out std_logic;
            USB_SIWU_N : out std_logic;
            USB_RD_n_pin : out std_logic;
            USB_OE_n_pin : out std_logic;
            FROM_USB_RDY : out std_logic;
            READ_FROM_USB_REG : out std_logic_vector(7 downto 0);

            -- Inouts
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

    -- Instantiate Unit Under Test:  USB_FIFO_IF
    USB_FIFO_IF_0 : USB_FIFO_IF
        -- port map
        port map( 
            -- Inputs
            USB_CLK_pin => SYSCLK,
            USB_TXE_n_pin => '0',
            CLK => SYSCLK,
            RST_n => NSYSRESET,
            FROM_ADC_SMPL_RDY => '0',
            USB_RXF_n_pin => '0',
            READ_SUCCESSFUL => '0',
            ADC_Q => (others=> '0'),
            ADC_I => (others=> '0'),

            -- Outputs
            USB_WR_n_pin =>  open,
            USB_SIWU_N =>  open,
            USB_RD_n_pin =>  open,
            USB_OE_n_pin =>  open,
            FROM_USB_RDY =>  open,
            READ_FROM_USB_REG => open,

            -- Inouts
            USB_DATA_pin => open

        );

end behavioral;

