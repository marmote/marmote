-- PN_GENERATOR.VHD
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
-- Description: Pseudo random sequence generator for spectrum spreading.
--
-----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PN_GENERATOR_tb is
    end;

architecture bench of PN_GENERATOR_tb is

    component PN_GENERATOR
        port (
                 CLK        : in  std_logic;
                 RST        : in  std_logic;
                 EN         : in  std_logic;
                 MASK       : in  std_logic_vector(31 downto 0);
                 SEED       : in  std_logic_vector(31 downto 0);
                 SEQ        : out std_logic_vector(1 downto 0)
             );
    end component;

    signal CLK: std_logic;
    signal RST: std_logic;
    signal EN: std_logic;
    signal MASK: std_logic_vector(31 downto 0);
    signal SEED: std_logic_vector(31 downto 0);
    signal SEQ: std_logic_vector(1 downto 0) ;

    constant clock_period: time := 50 ns;
    signal stop_the_clock: boolean;

begin

    uut: PN_GENERATOR
    port map (
         CLK  => CLK,
         RST  => RST,
         EN   => EN,
         MASK => MASK,
         SEED => SEED,
         SEQ  => SEQ
     );

    stimulus: process
    begin
        mask <= (others => '0');
        seed <= ((4) => '1', others => '0');
        en <= '0';

        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        en <= '1';

        wait for 100 * clock_period;

        stop_the_clock <= true;
        wait;
    end process;

    clocking: process
    begin
        while not stop_the_clock loop
            clk <= '0', '1' after clock_period / 2;
            wait for clock_period;
        end loop;
        wait;
    end process;

end;
