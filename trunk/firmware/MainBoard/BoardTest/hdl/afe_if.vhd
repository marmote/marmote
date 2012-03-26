-- APB_IF.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.0
-- TARGET DEVICE: A2F500M3G (256 FBGA)
--   
-- Copyright (c) 2006-2012, Vanderbilt University
-- All rights reserved.
--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose, without fee, and without written agreement is
-- hereby granted, provided that the above copyright notice, the following
-- two paragraphs and the author appear in all copies of this software.
--
-- IN NO EVENT SHALL THE VANDERBILT UNIVERSITY BE LIABLE TO ANY PARTY FOR
-- DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
-- OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE VANDERBILT
-- UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-- THE VANDERBILT UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
-- INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
-- AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
-- ON AN "AS IS" BASIS, AND THE VANDERBILT UNIVERSITY HAS NO OBLIGATION TO
-- PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
------------------------------------------------------------------------------


------------------------------------------------------------------------------
-- Description: This is an interface module for the MAX19706 analog front-end
--              (AFE) data signals.
--
-- Design considerations:
--    -Block uses SDR-specific signal names (e.g. I/Q suffices)
--    -No APB inteface included
--    -Parallel data interface complying with datasheet timing requirements
--     (TBD: constarints on input clock)
--    -Single clock domain operation
--       -CLK_OUT is simply connected to CLK)
--       -Data is transmitted/received on every clock cycle
--          -TX holds last value if not updated
--          -RX reads data continuously when enabled and in RX mode
--    -Enable input puts the MAX19706 either in RX or SHDN mode (TBD)
--    -DDR
--
------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
library smartfusion;
use smartfusion.all;
use IEEE.numeric_std.all;

entity AFE_IF is
	port (
         -- Internal interface
         CLK        : in  std_logic;
         RST        : in  std_logic;

         ENABLE     : in  std_logic;
         TX_RXn     : in  std_logic;
         READY      : in  std_logic;
    
         RX_STROBE  : out std_logic;
	     RX_I       : in  std_logic_vector(9 downto 0);
	     RX_Q       : in  std_logic_vector(9 downto 0);
         TX_STROBE  : in  std_logic;
	     TX_I       : out std_logic_vector(9 downto 0);
	     TX_Q       : out std_logic_vector(9 downto 0);

		 -- MAX19706 interface
         CLK_pin    : out std_logic; -- output clock
         SHDNn_pin  : out std_logic; -- shutdown
         T_Rn_pin   : out std_logic; -- T/Rn transmit/receive mode select
         DATA_pin   : inout std_logic_vector(9 downto 0)
		 );
end entity;

architecture Behavioral of AFE_IF is

    -- Components
    component BIBUF_LVCMOS33
        port( PAD : inout   std_logic;
              D   : in    std_logic := 'U';
              E   : in    std_logic := 'U';
              Y   : out   std_logic
          );
    end component;

    component DDR_OUT
        port( DR  : in    std_logic := 'U';
              DF  : in    std_logic := 'U';
              CLK : in    std_logic := 'U';
              CLR : in    std_logic := 'U';
              Q   : out   std_logic
          );
    end component;

    component DDR_REG
        port( D   : in    std_logic := 'U';
              CLK : in    std_logic := 'U';
              CLR : in    std_logic := 'U';
              QR  : out   std_logic;
              QF  : out   std_logic
          );
    end component;

    component INV
        port( A : in    std_logic := 'U';
              Y : out   std_logic
          );
    end component;
    
	-- Constants

	-- Signals
    signal s_obuf : std_logic_vector(9 downto 0); -- Bi-directional buffer output
    signal s_ibuf : std_logic_vector(9 downto 0); -- Bi-directional buffer input
    signal s_oe   : std_logic;                    -- Bi-directional buffer enable

begin

    g_DDR_INTERFACE : for i in 0 to 9 generate

        BIBUF_LVCMOS33
        port map (
            PAD => DATA_pin(i),
            D   => s_do(i),
            E   => s_oe,
            Y   => s_di(i)
        );

        DDR_OUT
        port map (
            CLK => CLK,
            CLR => RST,
            DF  => s_tx_i(i),
            DR  => s_tx_q(i),
            Q   => s_di(i)
        );

        DDR_REG
        port map (
            CLK => CLK,
            CLR => RST,
            D   => s_di(i),
            QF  => s_rx_i(i),
            QR  => s_rx_q(i)
        );
            
    end generate g_DDR_INTERFACE;

    p_reg_update : process (rst, clk)
    begin
        if rst = '1' then
            s_tx_rxn <= '0';
            s_rx_strobe <= '0';
        elsif rising_edge(clk) then
            s_tx_rxn <= '0';
            s_rx_strobe <= '0';
            if enable = '1' then
                s_tx_rxn <= TX_RXn;
                s_rx_strobe <= s_ready;
            end if;
        end if;
    end process p_reg_update;


    s_oe <= ENABLE and TX_RXn and s_ready and TX_STROBE; -- TODO: consider adding registers to these signals

    CLK_pin     <= CLK;
    T_Rn_pin    <= s_TX_RXn;
    SHDNn_pin   <= '1';

end Behavioral;

