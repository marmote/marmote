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
-- Description: TBD
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity USB_IF is
    port (
        CLK         : in  std_logic;
        RST         : in  std_logic;

        USB_CLK_pin : in std_logic;

        DATA_pin    : inout std_logic_vector(7 downto 0);
        RXF_n_pin   : in  std_logic;
        TXE_n_pin   : in  std_logic;
        RD_n_pin    : out std_logic;
        WR_n_pin    : out std_logic;
        OE_n_pin    : out std_logic;

        SIWU_n_pin  : out std_logic;
        ACBUS8_pin  : in  std_logic;
        ACBUS9_pin  : in  std_logic
    );
end entity;


architecture Behavioral of USB_IF is

    -- Signals
    alias USB_CLK is USB_CLK_pin;

    -- Components

begin

    -- Port maps
    -- Processes


end Behavioral;
