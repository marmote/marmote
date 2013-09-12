-- DATA_PATH_MUX.VHD
------------------------------------------------------------------------------
-- MODULE: Marmote Main Board
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.1 SP2
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
--
-- Description: 
--
------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DATA_PATH_MUX is
	port (
        MUX_SEL     : in  std_logic_vector(1 downto 0);

        IN_0_STROBE : in  std_logic;
        IN_0_I      : in  std_logic_vector(9 downto 0);
        IN_0_Q      : in  std_logic_vector(9 downto 0);

        IN_1_STROBE : in  std_logic;
        IN_1_I      : in  std_logic_vector(9 downto 0);
        IN_1_Q      : in  std_logic_vector(9 downto 0);

        IN_2_STROBE : in  std_logic;
        IN_2_I      : in  std_logic_vector(9 downto 0);
        IN_2_Q      : in  std_logic_vector(9 downto 0);

        IN_3_STROBE : in  std_logic;
        IN_3_I      : in  std_logic_vector(9 downto 0);
        IN_3_Q      : in  std_logic_vector(9 downto 0);

        OUT_STROBE  : out std_logic;
        OUT_I       : out std_logic_vector(9 downto 0);
        OUT_Q       : out std_logic_vector(9 downto 0)
     );

end entity;

architecture Behavioral of DATA_PATH_MUX is

begin
    with MUX_SEL select
        OUT_STROBE <= IN_0_STROBE when "00",
                      IN_1_STROBE when "01",
                      IN_2_STROBE when "10",
                      IN_3_STROBE when others;

    with MUX_SEL select
        OUT_I <= IN_0_I when "00",
                 IN_1_I when "01",
                 IN_2_I when "10",
                 IN_3_I when others;

    with MUX_SEL select
        OUT_Q <= IN_0_Q when "00",
                 IN_1_Q when "01",
                 IN_2_Q when "10",
                 IN_3_Q when others;

end Behavioral;
