----------------------------------------------------------------------
-- Created by Actel SmartDesign Wed Sep 26 12:09:06 2012
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

    component StreamingReceiver_RF
        -- ports
        port( 
            -- Inputs
            SPI_1_DI : in std_logic;
            MSS_RESET_N : in std_logic;
            LD : in std_logic;
            MAINXIN : in std_logic;
            USB_CLK_pin : in std_logic;
            USB_TXE_n_pin : in std_logic;
            USB_RXF_n_pin : in std_logic;

            -- Outputs
            SPI_1_DO : out std_logic;
            RXTX : out std_logic;
            ANTSEL : out std_logic;
            RXHP : out std_logic;
            nSHDN : out std_logic;
            AFE2_CLK_pin : out std_logic;
            AFE2_SHDN_n_pin : out std_logic;
            AFE2_T_R_n_pin : out std_logic;
            USB_WR_n_pin : out std_logic;
            USB_OE_n_pin : out std_logic;
            USB_RD_n_pin : out std_logic;
            USB_SIWU_N : out std_logic;
            LED1 : out std_logic;
            AFE1_CLK_pin : out std_logic;
            AFE1_SHDN_n_pin : out std_logic;
            AFE1_T_R_n_pin : out std_logic;

            -- Inouts
            SPI_1_SS : inout std_logic;
            SPI_1_CLK : inout std_logic;
            AFE2_DATA_pin : inout std_logic_vector(9 downto 0);
            USB_DATA_pin : inout std_logic_vector(7 downto 0);
            AFE1_DATA_pin : inout std_logic_vector(9 downto 0)

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

    -- Instantiate Unit Under Test:  StreamingReceiver_RF
    StreamingReceiver_RF_0 : StreamingReceiver_RF
        -- port map
        port map( 
            -- Inputs
            SPI_1_DI => '0',
            MSS_RESET_N => NSYSRESET,
            LD => '0',
            MAINXIN => '0',
            USB_CLK_pin => SYSCLK,
            USB_TXE_n_pin => '0',
            USB_RXF_n_pin => '0',

            -- Outputs
            SPI_1_DO =>  open,
            RXTX =>  open,
            ANTSEL =>  open,
            RXHP =>  open,
            nSHDN =>  open,
            AFE2_CLK_pin =>  open,
            AFE2_SHDN_n_pin =>  open,
            AFE2_T_R_n_pin =>  open,
            USB_WR_n_pin =>  open,
            USB_OE_n_pin =>  open,
            USB_RD_n_pin =>  open,
            USB_SIWU_N =>  open,
            LED1 =>  open,
            AFE1_CLK_pin =>  open,
            AFE1_SHDN_n_pin =>  open,
            AFE1_T_R_n_pin =>  open,

            -- Inouts
            SPI_1_SS =>  open,
            SPI_1_CLK =>  open,
            AFE2_DATA_pin => open,
            USB_DATA_pin => open,
            AFE1_DATA_pin => open

        );

end behavioral;

