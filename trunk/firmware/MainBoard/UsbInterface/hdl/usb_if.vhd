-- USB_IF.VHD
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
--
-- Description: Interface module for the FT232H USB (FTDI) chip operating in
--              synchronous FIFO mode.
--
--              The module transmits 16-bit data to the FTDI chip on 2
--              channels.
--
-- TODO:
--  - Add framing control state machine in the USB clock region
--  - Add a control channel
--  - Add a flush mechanism to the TX FIFO SM
--  - Make FIFO AFULL, AEMPTY accessible from this module
--
--  - Add logic to sense USB (FTDI) chip presence
--  - Determine the maximum system clock frequency (<60MHz?)
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library smartfusion;
use smartfusion.all;

entity USB_IF is
    generic (
         g_NUMBER_OF_CHANNELS : integer := 2
    );
    port (
        -- Internal interface
        CLK         : in  std_logic;
        RST         : in  std_logic;

        TX_STROBE   : in  std_logic;
        TXD_I       : in  std_logic_vector(15 downto 0);
        TXD_Q       : in  std_logic_vector(15 downto 0);
        RX_STROBE   : out std_logic;
        RXD         : out std_logic_vector(7 downto 0);

        -- USB (FTDI) interface
        USB_CLK_pin : in std_logic;

        DATA_pin    : inout std_logic_vector(7 downto 0);
        OE_n_pin    : out std_logic;
        RD_n_pin    : out std_logic;
        WR_n_pin    : out std_logic;

        RXF_n_pin   : in  std_logic;
        TXE_n_pin   : in  std_logic;

        SIWU_n_pin  : out std_logic;
        ACBUS8_pin  : in  std_logic;
        ACBUS9_pin  : in  std_logic
    );
end entity;


architecture Behavioral of USB_IF is

    -- Components

    component CLKBUF
        port( PAD : in    std_logic := 'U';
              Y   : out   std_logic
          );
    end component;

    component BIBUF_LVCMOS33
        port( PAD : inout   std_logic;
              D   : in    std_logic := 'U';
              E   : in    std_logic := 'U';
              Y   : out   std_logic
          );
    end component;

    -- Constants

    -- Signals

    signal usb_clk      : std_logic;

    -- BIBUF
    signal s_oe         : std_logic;
    signal s_obuf       : std_logic_vector(7 downto 0);
    signal s_ibuf       : std_logic_vector(7 downto 0);

    -- USB read
    signal s_oe_n       : std_logic;
    signal s_rd_n       : std_logic;
    signal s_rxd        : std_logic_vector(7 downto 0);
    signal s_rxd_buf    : std_logic_vector(7 downto 0); -- Debug
    signal s_rx_strobe  : std_logic;

    signal s_wr_n       : std_logic;

begin

    -- Port maps

    u_USB_CLKBUF : CLKBUF
      port map(PAD => USB_CLK_pin, Y => usb_clk);


    g_USB_SYNC_FIFO_DATA : for i in 0 to 7 generate

        u_BIBUF_LVCMOS33 : BIBUF_LVCMOS33
        port map (
            PAD => DATA_pin(i),
            D   => s_obuf(i),
            E   => s_oe,
            Y   => s_ibuf(i)
        );

    end generate g_USB_SYNC_FIFO_DATA;

    
    p_usb_read : process (rst, usb_clk)
    begin
        if rst = '1' then
            s_oe_n <= '1';
            s_rd_n <= '1';
            s_rxd <= (others => '0');
            s_rx_strobe <= '0';
        elsif rising_edge(usb_clk) then

            s_oe_n <= '1';
            s_rd_n <= '1';
            s_rxd <= s_rxd;
            s_rx_strobe <= '0';

            if RXF_n_pin = '0' then
                s_oe_n <= '0';

                if s_oe_n = '0' then
                    s_rd_n <= '0';

                    if s_rd_n = '0' then
                        s_rxd <= s_ibuf;
                        s_rx_strobe <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process p_usb_read;

    s_oe <= '0';
    s_wr_n <= '1';
    s_obuf <= (others => '0');

    p_rxd_buf_for_debug : process (rst, usb_clk)
    begin
        if rst = '1' then
            s_rxd_buf <= (others => '0');
        elsif rising_edge(usb_clk) then
            if s_rx_strobe = '1' then
                s_rxd_buf <= s_rxd;
            end if;
        end if;
    end process p_rxd_buf_for_debug;


    ----------------------------------------
    -- 8-bit single channel tx no framing --
    ----------------------------------------
--    p_usb_write : process (rst, usb_clk)
--    begin
--        if rst = '1' then
--            s_wr_n <= '1';
--            s_oe <= '0';
--        elsif rising_edge(usb_clk) then
--            s_oe <= '0';
--            s_wr_n <= '1';
--            if TXE_n_pin = '0' and s_tx_i_fifo_empty = '0' then
--                s_oe <= '1';
--                s_wr_n <= '0';
--            end if;
--        end if;
--    end process p_usb_write;
--
--    s_tx_fifo_re <= '1' when TXE_n_pin = '0' and s_tx_i_fifo_empty = '0' else '0';
    -------------------------------------


    -- Output assignments

    OE_n_pin <= s_oe_n;
    RD_n_pin <= s_rd_n;
    WR_n_pin <= s_wr_n;

    SIWU_n_pin <= '1'; -- Send only full packets

    RX_STROBE <= s_rx_strobe;
--    RXD <= s_rxd;
    RXD <= s_rxd_buf;

end Behavioral;
