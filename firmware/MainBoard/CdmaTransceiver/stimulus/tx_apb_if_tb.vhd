-- TX_APB_IF_TB.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.1 SP3
-- TARGET DEVICE: A2F500M3G (256 FBGA)
--   
-- Copyright (c) 2006-2013, Vanderbilt University
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
-- Description: 
--
-----------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TX_APB_IF_tb is
end;

architecture bench of TX_APB_IF_tb is

    component TX_APB_IF
    port (
             PCLK    : in  std_logic;
             PRESETn : in  std_logic;
             PADDR	 : in  std_logic_vector(31 downto 0);
             PSEL	 : in  std_logic;
             PENABLE : in  std_logic;
             PWRITE  : in  std_logic;
             PWDATA  : in  std_logic_vector(31 downto 0);
             PREADY  : out std_logic;
             PRDATA  : out std_logic_vector(31 downto 0);
             PSLVERR : out std_logic;

             TX_DONE_IRQ : out std_logic;
             TX_EN      : out std_logic;
             TX_I       : out std_logic_vector(10 downto 0);
             TX_Q       : out std_logic_vector(10 downto 0)
         );
    end component;

	-- Addresses
	constant c_ADDR_CTRL        : unsigned(7 downto 0) := x"00"; -- W (START)
	constant c_ADDR_FIFO        : unsigned(7 downto 0) := x"04"; -- W

    signal PCLK: std_logic;
    signal PRESETn: std_logic;
    signal PADDR: std_logic_vector(31 downto 0);
    signal PSEL: std_logic;
    signal PENABLE: std_logic;
    signal PWRITE: std_logic;
    signal PWDATA: std_logic_vector(31 downto 0);
    signal PREADY: std_logic;
    signal PRDATA: std_logic_vector(31 downto 0);
    signal PSLVERR: std_logic;
    signal TX_DONE_IRQ: std_logic;
    signal TX_EN: std_logic;
    signal TX_I: std_logic_vector(10 downto 0);
    signal TX_Q: std_logic_vector(10 downto 0) ;

    constant clock_period: time := 50 ns;
    signal stop_the_clock: boolean;

    procedure p_write_apb
    (
        constant addr   : in  unsigned(7 downto 0);
        constant data   : in  unsigned(31 downto 0);

        signal PCLK     : in  std_logic;
        signal PADDR    : out std_logic_vector(31 downto 0);
        signal PWRITE   : out std_logic;
        signal PSEL	    : out std_logic;
        signal PENABLE  : out std_logic;
        signal PWDATA   : out std_logic_vector(31 downto 0)
     ) is
     begin
        wait until rising_edge(PCLK);
        -- Setup phase
        PADDR <= x"000000" & std_logic_vector(addr); 
        PWDATA <= std_logic_vector(data);
        PWRITE <= '1';
        PSEL <= '1';

        wait until rising_edge(PCLK);
        -- Access phase
        PENABLE <= '1';

        wait_for_pready : loop
            wait until rising_edge(PCLK);

            assert PREADY = '1'
            report "WARNING: PREADY is not asserted, inserting wait loop at " & time'image(now)
            severity warning;

            exit when PREADY = '1';
        end loop wait_for_pready;

        PADDR <= (others => 'Z');
        PWDATA <= (others => 'Z');
        PWRITE <= '0';
        PSEL <= '0';
        PENABLE <= '0';

     end p_write_apb;

begin


    uut: TX_APB_IF
    port map (
                 PCLK        => PCLK,
                 PRESETn     => PRESETn,
                 PADDR       => PADDR,
                 PSEL        => PSEL,
                 PENABLE     => PENABLE,
                 PWRITE      => PWRITE,
                 PWDATA      => PWDATA,
                 PREADY      => PREADY,
                 PRDATA      => PRDATA,
                 PSLVERR     => PSLVERR,
                 TX_DONE_IRQ => TX_DONE_IRQ,
                 TX_EN       => TX_EN,
                 TX_I        => TX_I,
                 TX_Q        => TX_Q
             );

    stimulus: process
    begin

        PADDR <= (others => 'Z');
        PWDATA <= (others => 'Z');
        PSEL <= '0';
        PENABLE <= '0';
        PWRITE <= '0';
        PRESETn <= '0';
        wait for 100 ns;
        PRESETn <= '1';
        wait for 100 ns;

        p_write_apb(c_ADDR_FIFO, x"000000_0A", PCLK, PADDR, PWRITE, PSEL, PENABLE, PWDATA);
        p_write_apb(c_ADDR_FIFO, x"000000_0B", PCLK, PADDR, PWRITE, PSEL, PENABLE, PWDATA);
        p_write_apb(c_ADDR_FIFO, x"000000_0C", PCLK, PADDR, PWRITE, PSEL, PENABLE, PWDATA);
        p_write_apb(c_ADDR_FIFO, x"000000_0D", PCLK, PADDR, PWRITE, PSEL, PENABLE, PWDATA);

        p_write_apb(c_ADDR_CTRL, x"000000_01", PCLK, PADDR, PWRITE, PSEL, PENABLE, PWDATA);

        wait until TX_DONE_IRQ = '1';
        report "TX DONE";
        wait for 5000 ns;

        p_write_apb(c_ADDR_FIFO, x"000000_1A", PCLK, PADDR, PWRITE, PSEL, PENABLE, PWDATA);
        p_write_apb(c_ADDR_FIFO, x"000000_1B", PCLK, PADDR, PWRITE, PSEL, PENABLE, PWDATA);
        p_write_apb(c_ADDR_FIFO, x"000000_1C", PCLK, PADDR, PWRITE, PSEL, PENABLE, PWDATA);
        p_write_apb(c_ADDR_FIFO, x"000000_1D", PCLK, PADDR, PWRITE, PSEL, PENABLE, PWDATA);

        p_write_apb(c_ADDR_CTRL, x"000000_01", PCLK, PADDR, PWRITE, PSEL, PENABLE, PWDATA);

        wait until TX_DONE_IRQ = '1';
        report "TX DONE";
        wait for 1000 ns;

        stop_the_clock <= true;
        wait;

    end process;

    clocking: process
    begin
        while not stop_the_clock loop
            PCLK <= '0', '1' after clock_period / 2;
            wait for clock_period;
        end loop;
        wait;
    end process;

end;
