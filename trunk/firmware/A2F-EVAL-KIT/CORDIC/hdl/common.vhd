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
--	constant c_FAB_CLK : integer := 40000000;	

	------------------------------ A/D sampling ------------------------------
	constant c_CORDIC_WIDTH     : integer := 16;
	constant c_COUNTER_WIDTH    : integer := 5; 
    -- This has to be true: 2^c_COUNTER_WIDTH > c_CORDIC_WIDTH

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

