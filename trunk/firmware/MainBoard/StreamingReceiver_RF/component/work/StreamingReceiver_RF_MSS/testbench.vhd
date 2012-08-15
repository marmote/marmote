----------------------------------------------------------------------
-- Created by Actel SmartDesign Wed Aug 15 14:33:39 2012
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

    component StreamingReceiver_RF_MSS
        -- ports
        port( 
            -- Inputs
            MSSPREADY : in std_logic;
            MSSPSLVERR : in std_logic;
            F2M_GPI_12 : in std_logic;
            MAINXIN : in std_logic;
            FABINT : in std_logic;
            MSSPRDATA : in std_logic_vector(31 downto 0);
            SPI_1_DI : in std_logic;
            MSS_RESET_N : in std_logic;

            -- Outputs
            MSSPSEL : out std_logic;
            MSSPENABLE : out std_logic;
            MSSPWRITE : out std_logic;
            M2F_GPO_15 : out std_logic;
            M2F_GPO_14 : out std_logic;
            M2F_GPO_13 : out std_logic;
            M2F_RESET_N : out std_logic;
            GLB : out std_logic;
            FAB_CLK : out std_logic;
            MSSPADDR : out std_logic_vector(19 downto 0);
            MSSPWDATA : out std_logic_vector(31 downto 0);
            SPI_1_DO : out std_logic;
            GPIO_28_OUT : out std_logic;

            -- Inouts
            SPI_1_CLK : inout std_logic;
            SPI_1_SS : inout std_logic

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

    -- Instantiate Unit Under Test:  StreamingReceiver_RF_MSS
    StreamingReceiver_RF_MSS_0 : StreamingReceiver_RF_MSS
        -- port map
        port map( 
            -- Inputs
            MSSPREADY => '0',
            MSSPSLVERR => '0',
            F2M_GPI_12 => '0',
            MAINXIN => '0',
            FABINT => '0',
            MSSPRDATA => (others=> '0'),
            SPI_1_DI => '0',
            MSS_RESET_N => NSYSRESET,

            -- Outputs
            MSSPSEL =>  open,
            MSSPENABLE =>  open,
            MSSPWRITE =>  open,
            M2F_GPO_15 =>  open,
            M2F_GPO_14 =>  open,
            M2F_GPO_13 =>  open,
            M2F_RESET_N =>  open,
            GLB =>  open,
            FAB_CLK =>  open,
            MSSPADDR => open,
            MSSPWDATA => open,
            SPI_1_DO =>  open,
            GPIO_28_OUT =>  open,

            -- Inouts
            SPI_1_CLK =>  open,
            SPI_1_SS =>  open

        );

end behavioral;

