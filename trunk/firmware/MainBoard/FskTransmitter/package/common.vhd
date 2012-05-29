-- common.vhd
------------------------------------------------------------------------------
-- MODULE: Common (Marmote Platform - Teton Board)
-- AUTHORS: Sandor Szilvasi
-- AUTHOR CONTACT INFO.: Sandor Szilvasi <sandor.szilvasi@vanderbilt.edu>
-- TOOL VERSIONS: Libero 10.0 SP1
-- TARGET DEVICE: A2F500M3G
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package COMMON is

------------------------------------------------------------------------------
-- Common Types
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Common Constants
------------------------------------------------------------------------------

	-- FPGA system clock frequency
	constant c_FAB_CLK : integer := 20000000;	

	------------------------------ A/D sampling ------------------------------
	constant c_DCO_PHASE_WIDTH  : integer := 32;
	constant c_CORDIC_WIDTH     : integer := 10;
--	constant c_SDM_SAMPLE_WIDTH : integer := 16;

	---------------------------- FSK transmission ----------------------------
	constant c_DATA_LENGTH : integer := 8;

	------------------------------ FSK reception -----------------------------
--	constant c_LPF_SAMPLE_WIDTH : integer := 16;
	----------------------------------- LEDs ---------------------------------
	--constant NUMBER_OF_LEDS : integer := 8;

	-- Address constants

------------------------------------------------------------------------------
--						Common Functions and Procedures                     --
------------------------------------------------------------------------------

	---
	--- Find minimum number of bits required to
	--- represent N as an unsigned binary number
	---
	function log2_ceil(constant s: integer) return integer;

end COMMON;


package body COMMON is

	function log2_ceil(constant s: integer) return integer is
		variable m, n : integer;
	begin
		m := 0;
		n := 1;  
		while (n <= s)  loop 		
			m := m + 1;
			n := n*2;    
		end loop;  
		return m;  
	end function;

end COMMON;

