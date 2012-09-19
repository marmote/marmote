-- DATA_FRAMER.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.1
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
-------------------------------------------------------------------------------
-- Revisions     :
-- Date            Version  Author			Description
-- 2012-09-18      1.1      Sandor Szilvasi	Added SEQ and I/Q FIFOs
-- 2012-09-18      1.0      Sandor Szilvasi	Transmits empty frames
------------------------------------------------------------------------------
--
-- Description: Interface module to serialize and frame the parallel data
--              streams to be transmitted through the FT232H USB (FTDI) chip.
--
--              The module receives 2x16-bit data streams and passes them
--              through synchronizer FIFOs along with sequence numbers.
--
-- TODO:        Simplify checksum calculation.
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library smartfusion;
use smartfusion.all;

entity DATA_FRAMER is
    generic (
        g_MSG_LEN   : integer := 128
    );
    port (
        -- System clock region
        CLK         : in  std_logic;
        RST         : in  std_logic;

        TX_I        : in  std_logic_vector(15 downto 0);
        TX_Q        : in  std_logic_vector(15 downto 0);
        TX_STROBE   : in  std_logic;

        -- USB clock region
        USB_CLK     : in  std_logic;
        
        TXD_REQ     : out std_logic;
        TXD_RD      : in  std_logic;
        TXD         : out std_logic_vector(7 downto 0)
    );
end entity;


architecture Behavioral of DATA_FRAMER is

    -- Components

    component FIFO_256x16 is
    generic (
        g_AFULL     : integer := 192;
        g_AEMPTY    : integer := 128
    );
    port (
        DATA   : in    std_logic_vector(15 downto 0);
        Q      : out   std_logic_vector(15 downto 0);
        WE     : in    std_logic;
        RE     : in    std_logic;
        WCLOCK : in    std_logic;
        RCLOCK : in    std_logic;
        FULL   : out   std_logic;
        EMPTY  : out   std_logic;
        RESET  : in    std_logic;
        AEMPTY : out   std_logic;
        AFULL  : out   std_logic
    );
    end component;
    

    -- Constants

    constant c_SYNC_CHAR_1 : unsigned(7 downto 0) := x"B5";
    constant c_SYNC_CHAR_2 : unsigned(7 downto 0) := x"63";

    constant c_MSG_CLASS   : unsigned(7 downto 0) := x"0E"; -- FIXME
    constant c_MSG_ID      : unsigned(7 downto 0) := x"0F"; -- FIXME

    constant c_MSG_LEN     : unsigned(15 downto 0) := to_unsigned(g_MSG_LEN, 16);

    -- Pre-calculate the first two CHK steps
    constant c_CHK_A       : unsigned(7 downto 0) := c_MSG_CLASS + c_MSG_ID; 
    constant c_CHK_B       : unsigned(7 downto 0) := c_MSG_CLASS + c_CHK_A;


    -- Signals

    alias USB_RST is RST;

    type framer_state_t is (
        st_IDLE,
        st_SYNC_1,
        st_SYNC_2,
        st_MSG_CLASS,
        st_MSG_ID,
        st_LEN_1,
        st_LEN_2,
        st_SEQ_MSB,
        st_SEQ_LSB,
        st_DATA_I_MSB,
        st_DATA_I_LSB,
        st_DATA_Q_MSB,
        st_DATA_Q_LSB,
        st_CHK_A,
        st_CHK_B
    );

    signal s_state      : framer_state_t := st_IDLE;
    signal s_state_next : framer_state_t;

    signal s_msg_ctr        : unsigned(7 downto 0);
    signal s_msg_ctr_next   : unsigned(7 downto 0);

    signal s_chk_a      : unsigned(7 downto 0);
    signal s_chk_b      : unsigned(7 downto 0);
    signal s_chk_a_next : unsigned(7 downto 0);
    signal s_chk_b_next : unsigned(7 downto 0);

    signal s_txd        : unsigned(7 downto 0);
    signal s_txd_next   : unsigned(7 downto 0);
    signal s_txd_req    : std_logic;
    signal s_txd_req_next   : std_logic;

    -- FIFOs
    signal s_fifo_rd        : std_logic;
    signal s_fifo_empty     : std_logic;
    signal s_fifo_aempty    : std_logic;

    signal s_seq_num_ctr    : unsigned(15 downto 0);
    signal s_seq_fifo_out   : std_logic_vector(15 downto 0);
    signal s_i_fifo_out     : std_logic_vector(15 downto 0);
    signal s_q_fifo_out     : std_logic_vector(15 downto 0);

begin

    assert c_MSG_LEN <= 128
    report "ERROR: c_MSG_LEN longer than 128 is not supported"
    severity failure;

    -- Port maps

    u_SEQ_FIFO : FIFO_256x16
    generic map (
        g_AFULL     => 8,
        g_AEMPTY    => g_MSG_LEN
    )
    port map (
        RESET   => RST,
        WCLOCK  => CLK,
        WE      => TX_STROBE,
        DATA    => std_logic_vector(s_seq_num_ctr),
        Q       => s_seq_fifo_out,
        RCLOCK  => USB_CLK,
        RE      => s_fifo_rd,
        FULL    => open,
        EMPTY   => s_fifo_empty,
        AFULL   => open,
        AEMPTY  => s_fifo_aempty
    );

    u_DATA_I_FIFO : FIFO_256x16
    generic map (
        g_AFULL     => 8,
        g_AEMPTY    => g_MSG_LEN
    )
    port map (
        RESET   => RST,
        WCLOCK  => CLK,
        WE      => TX_STROBE,
        DATA    => TX_I,
        Q       => s_i_fifo_out,
        RCLOCK  => USB_CLK,
        RE      => s_fifo_rd,
        FULL    => open,
        EMPTY   => open,
        AFULL   => open,
        AEMPTY  => open
    );

    u_DATA_Q_FIFO : FIFO_256x16
    generic map (
        g_AFULL     => 8,
        g_AEMPTY    => g_MSG_LEN
    )
    port map (
        RESET   => RST,
        WCLOCK  => CLK,
        WE      => TX_STROBE,
        DATA    => TX_Q,
        Q       => s_q_fifo_out,
        RCLOCK  => USB_CLK,
        RE      => s_fifo_rd,
        FULL    => open,
        EMPTY   => open,
        AFULL   => open,
        AEMPTY  => open
    );


    -- Processes

    p_framer_sync : process (USB_RST, USB_CLK)
    begin
        if USB_RST = '1' then
            s_state <= st_IDLE;
            s_msg_ctr <= (others => '0');
            s_txd <= (others => '0');
            s_txd_req <= '0';
            s_chk_a <= c_CHK_A;
            s_chk_b <= c_CHK_B;
        elsif rising_edge(USB_CLK) then
            s_state <= s_state_next;
            s_msg_ctr <= s_msg_ctr_next;
            s_txd <= s_txd_next;
            s_txd_req <= s_txd_req_next;
            s_chk_a <= s_chk_a_next;
            s_chk_b <= s_chk_b_next;
        end if;
    end process p_framer_sync;

    p_framer_comb : process (
        s_state,
        s_msg_ctr,
        TXD_RD,
        s_txd,
        s_chk_a,
        s_chk_b,
        s_seq_fifo_out,
        s_fifo_aempty
    )
    begin
        -- Default assignments
        s_state_next <= s_state;
        s_msg_ctr_next <= s_msg_ctr;
        s_txd_next <= s_txd;
        s_txd_req_next <= s_txd_req;

        s_chk_a_next <= s_chk_a;
        s_chk_b_next <= s_chk_b;

        s_fifo_rd <= '0';

        -- Next state and output logic
        case s_state is

            when st_IDLE =>
                s_txd_next <= c_SYNC_CHAR_1;
                if s_fifo_aempty = '0' then
                    s_txd_req_next <= '1';
                    s_chk_a_next <= c_CHK_A;
                    s_chk_b_next <= c_CHK_B;
                    s_state_next <= st_SYNC_1;
                end if;

            when st_SYNC_1 =>
                if TXD_RD = '1' then
                    s_txd_next <= c_SYNC_CHAR_2;
                    s_state_next <= st_SYNC_2;
                end if;

            when st_SYNC_2 =>
                if TXD_RD = '1' then
                    s_txd_next <= c_MSG_CLASS;
                    s_state_next <= st_MSG_CLASS;
                end if;

            when st_MSG_CLASS =>
                if TXD_RD = '1' then
                    s_txd_next <= c_MSG_ID;
                    s_state_next <= st_MSG_ID;
                end if;

            when st_MSG_ID =>
                if TXD_RD = '1' then
                    s_txd_next <= c_MSG_LEN(7 downto 0);
                    s_state_next <= st_LEN_1;
                end if;

            when st_LEN_1 =>
                if TXD_RD = '1' then
                    s_chk_a_next <= s_chk_a + s_txd;
                    s_txd_next <= c_MSG_LEN(15 downto 8);
                    s_state_next <= st_LEN_2;
                    s_fifo_rd <= '1';
                end if;

            when st_LEN_2 =>
                if TXD_RD = '1' then
                    s_chk_a_next <= s_chk_a + s_txd;
                    s_chk_b_next <= s_chk_b + s_chk_a;
                    s_txd_next <= unsigned(s_seq_fifo_out(15 downto 8));
                    s_msg_ctr_next <= (others => '0');
                    s_state_next <= st_SEQ_MSB;
                end if;

            when st_SEQ_MSB => 
                if TXD_RD = '1' then
                    s_chk_a_next <= s_chk_a + s_txd;
                    s_chk_b_next <= s_chk_b + s_chk_a;
                    s_txd_next <= unsigned(s_seq_fifo_out(7 downto 0));
                    s_state_next <= st_SEQ_LSB;
                end if;

            when st_SEQ_LSB => 
                if TXD_RD = '1' then
                    s_chk_a_next <= s_chk_a + s_txd;
                    s_chk_b_next <= s_chk_b + s_chk_a;
                    s_txd_next <= unsigned(s_i_fifo_out(15 downto 8));
                    s_state_next <= st_DATA_I_MSB;
                end if;

            when st_DATA_I_MSB => 
                if TXD_RD = '1' then
                    s_msg_ctr_next <= s_msg_ctr + 1;
                    s_chk_a_next <= s_chk_a + s_txd;
                    s_chk_b_next <= s_chk_b + s_chk_a;
                    s_txd_next <= unsigned(s_i_fifo_out(7 downto 0));
                    s_state_next <= st_DATA_I_LSB;
                end if;

            when st_DATA_I_LSB => 
                if TXD_RD = '1' then
                    s_chk_a_next <= s_chk_a + s_txd;
                    s_chk_b_next <= s_chk_b + s_chk_a;
                    s_txd_next <= unsigned(s_q_fifo_out(15 downto 8));
                    s_state_next <= st_DATA_Q_MSB;
                end if;

            when st_DATA_Q_MSB => 
                if TXD_RD = '1' then
                    s_chk_a_next <= s_chk_a + s_txd;
                    s_chk_b_next <= s_chk_b + s_chk_a;
                    s_txd_next <= unsigned(s_q_fifo_out(7 downto 0));
                    s_state_next <= st_DATA_Q_LSB;
                end if;

            when st_DATA_Q_LSB => 
                if TXD_RD = '1' then
                    s_chk_a_next <= s_chk_a + s_txd;
                    s_chk_b_next <= s_chk_b + s_chk_a;
                    if s_msg_ctr < c_MSG_LEN then
                        s_txd_next <= unsigned(s_i_fifo_out(15 downto 8));
                        s_state_next <= st_DATA_I_MSB;
                    else
                        s_txd_next <= s_chk_a + s_txd;
                        s_state_next <= st_CHK_A;
                    end if;
                end if;

            when st_CHK_A =>
                if TXD_RD = '1' then
                    s_txd_next <= s_chk_b + s_chk_a;
                    s_state_next <= st_CHK_B;
                end if;

            when st_CHK_B =>
                if TXD_RD = '1' then
                    s_txd_next <= (others => '0');
                    s_txd_req_next <= '0';
                    s_state_next <= st_IDLE;
                end if;

            when others =>
                null;

        end case;

    end process p_framer_comb;

    p_seq_counter : process (RST, CLK)
    begin
        if rst = '1' then
            s_seq_num_ctr <= (others => '0');
        elsif rising_edge(CLK) then
            if TX_STROBE = '1' then
                s_seq_num_ctr <= s_seq_num_ctr + 1;
            end if;
        end if;
    end process p_seq_counter;


    -- Output assignments

    TXD_REQ <= s_txd_req;
    TXD <= std_logic_vector(s_txd);



end Behavioral;

