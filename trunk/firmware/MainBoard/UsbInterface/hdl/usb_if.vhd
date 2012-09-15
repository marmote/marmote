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
--              The module transmits 8-bit data from and to the FTDI chip on 1
--              channel.
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

    component FIFO_512x8 is
    port (
        DATA    : in  std_logic_vector(7 downto 0);
        Q       : out std_logic_vector(7 downto 0);
        WE      : in  std_logic;
        RE      : in  std_logic;
        WCLOCK  : in  std_logic;
        RCLOCK  : in  std_logic;
        FULL    : out std_logic;
        EMPTY   : out std_logic;
        RESET   : in  std_logic
    );
    end component;

    -- Constants

    -- Signals

    -- Arbiter SM
    type arb_state_t is (
        st_ARB_IDLE,
        st_ARB_RX,
        st_ARB_TX
    );

    signal s_arb_state      : arb_state_t;


    signal usb_clk      : std_logic;

    -- BIBUF
    signal s_oe         : std_logic;
    signal s_obuf       : std_logic_vector(7 downto 0);
    signal s_obuf_reg   : std_logic_vector(7 downto 0);
    signal s_ibuf       : std_logic_vector(7 downto 0);
    signal s_ibuf_reg   : std_logic_vector(7 downto 0);

    -- USB read
    signal s_oe_n       : std_logic;
    signal s_rd_n       : std_logic;
    signal s_rxd        : std_logic_vector(7 downto 0);
    signal s_rxd_buf    : std_logic_vector(7 downto 0); -- Debug
    signal s_rx_strobe  : std_logic;

    signal s_wr_n       : std_logic;

    -- Control FIFO
    signal s_ctrl_data_loopback : std_logic_vector(7 downto 0);

    signal s_tx_ctrl_fifo_we    : std_logic;
    signal s_tx_ctrl_fifo_rd    : std_logic;
    signal s_tx_ctrl_fifo_empty : std_logic;
    signal s_tx_ctrl_fifo_fetched  : std_logic;

    signal s_rx_ctrl_fifo_full  : std_logic;
    signal s_rx_ctrl_fifo_we    : std_logic;
    signal s_rx_ctrl_fifo_rd    : std_logic;
    signal s_rx_ctrl_fifo_empty : std_logic;
    

begin

    -- Port maps

    u_USB_CLKBUF : CLKBUF
      port map(PAD => USB_CLK_pin, Y => usb_clk);


    g_USB_SYNC_FIFO_DATA : for i in 0 to 7 generate

        u_BIBUF_LVCMOS33 : BIBUF_LVCMOS33
        port map (
            PAD => DATA_pin(i),
            D   => s_obuf_reg(i),
            E   => s_oe,
            Y   => s_ibuf(i)
        );

    end generate g_USB_SYNC_FIFO_DATA;


    -- Control FIFOs
    u_TX_CTRL_FIFO : FIFO_512x8
    port map (
        RESET   => RST,
        DATA    => s_ctrl_data_loopback, -- FIXME: loopback for testing only
        Q       => s_obuf,
        WCLOCK  => CLK,
        WE      => s_tx_ctrl_fifo_we,
        RCLOCK  => usb_clk,
        RE      => s_tx_ctrl_fifo_rd,
        FULL    => open,
        EMPTY   => s_tx_ctrl_fifo_empty
    );


    u_RX_CTRL_FIFO : FIFO_512x8
    port map (
        RESET   => RST,
        DATA    => s_ibuf_reg,
        Q       => s_ctrl_data_loopback, -- FIXME: loopback for testing only
        WCLOCK  => usb_clk,
        WE      => s_rx_ctrl_fifo_we,
        RCLOCK  => CLK,
        RE      => s_rx_ctrl_fifo_rd,
        FULL    => s_rx_ctrl_fifo_full,
        EMPTY   => s_rx_ctrl_fifo_empty
    );

    s_rx_ctrl_fifo_rd <= not s_rx_ctrl_fifo_empty;


    p_ctrl_fifo_loopback : process (rst, clk)
    begin
        if rst = '1' then
            s_tx_ctrl_fifo_we <= '0';
        elsif rising_edge(clk) then
            s_tx_ctrl_fifo_we <= '0';
            if s_rx_ctrl_fifo_rd = '1' then
                s_tx_ctrl_fifo_we <= '1';
            end if;
        end if;
    end process p_ctrl_fifo_loopback;

    
    p_usb_transfer_sync : process (rst, usb_clk)
    begin
        if rst = '1' then
            s_arb_state <= st_ARB_IDLE;
            s_oe_n <= '1';
            s_rd_n <= '1';
            s_rx_ctrl_fifo_we <= '0';
            s_ibuf_reg <= (others => '0');

            s_oe <= '0';
            s_wr_n <= '1';
            s_obuf_reg <= (others => '0');

            s_tx_ctrl_fifo_fetched <= '0';
        elsif rising_edge(usb_clk) then

            -- Default values
            s_oe_n <= '1';
            s_rd_n <= '1';
            s_rx_ctrl_fifo_we <= '0';
            s_ibuf_reg <= (others => '0');

            s_oe <= '0';
            s_wr_n <= '1';
            s_obuf_reg <= (others => '0');

            if s_tx_ctrl_fifo_rd = '1' then
                s_tx_ctrl_fifo_fetched <= not s_tx_ctrl_fifo_empty;
            end if;

            case s_arb_state is

                when st_ARB_IDLE =>


                    -- USB read
                    if RXF_n_pin = '0' and s_rx_ctrl_fifo_full = '0' then
                        s_oe_n <= '0';
                        s_arb_state <= st_ARB_RX;

                    -- USB write
                    elsif TXE_n_pin = '0' and s_tx_ctrl_fifo_fetched = '1' then
                        s_arb_state <= st_ARB_TX;
                    end if;


                when st_ARB_RX =>

                    if RXF_n_pin = '0' and s_rx_ctrl_fifo_full = '0' and s_oe_n = '0' then
                        s_oe_n <= '0';
                        s_rd_n <= '0';
                        if s_rd_n = '0' then
                            s_ibuf_reg <= s_ibuf;
                            s_rx_ctrl_fifo_we <= '1';
                        end if;
                    else
                        s_arb_state <= st_ARB_IDLE;
                    end if;


                when st_ARB_TX =>
                    if TXE_n_pin = '0' and s_tx_ctrl_fifo_fetched = '1' then
                        s_oe <= '1';
                        s_wr_n <= '0';
                        s_obuf_reg <= s_obuf;
                    else
                        s_arb_state <= st_ARB_IDLE;
                    end if;


                when others =>
                    null;

            end case;

        end if;
    end process p_usb_transfer_sync;


    s_tx_ctrl_fifo_rd <= '1' when
         (s_tx_ctrl_fifo_fetched = '0' and s_tx_ctrl_fifo_empty = '0') or -- auto fetch
         (TXE_n_pin = '0' and s_tx_ctrl_fifo_fetched = '1' and s_arb_state = st_ARB_TX)
         else '0';


    -- Output assignments

    OE_n_pin <= s_oe_n;
    RD_n_pin <= s_rd_n;
    WR_n_pin <= s_wr_n;

    SIWU_n_pin <= '1'; -- Send only full packets

    RX_STROBE <= s_tx_ctrl_fifo_we;
    RXD <= s_ctrl_data_loopback;
--    RX_STROBE <= s_rx_strobe;
--    RXD <= s_rxd;
    RXD <= s_rxd_buf;

end Behavioral;
