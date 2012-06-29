library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
  

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Package definition
--
------------------------------------------------------------------------------
package COMMON is

-----------------------------------------
--            Common Types             --
-----------------------------------------


-----------------------------------------
--          Common Constants           --
-----------------------------------------
    -- FPGA system clock frequency
--    constant c_FAB_CLK : integer    := 50000000;


	constant	c_FRAME_SMPLS				: integer := 127;						-- The number of samples (IQ pair is one) in one frame
	constant	c_FROM_ADC_SMPL_CNTR_MAX	: integer := c_FRAME_SMPLS - 1;		
	constant	c_TO_TEMPREG_SMPL_CNTR_MAX	: integer := c_FRAME_SMPLS;						

-------------------------------------------
--   Common Functions and Procedures   --
-----------------------------------------

    ---
    --- Find minimum number of bits required to
    --- represent N as an unsigned binary number
    ---
    function log2_ceil(constant s: integer) return integer;


    function pow2(constant s: integer) return integer;

    ---
    --- Reverse a vector
    ---
    function reverse_vector(a : std_logic_vector) return std_logic_vector;

end COMMON;



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--
--  Package body
--
------------------------------------------------------------------------------
package body COMMON is

     function pow2(constant s: integer) return integer is
        variable m, n : integer;
    begin
        m := 0;
        n := 1;
        while (m < s)  loop
            m := m + 1;
            n := n*2;
        end loop;
        return n;
    end function;


    function log2_ceil(constant s: integer) return integer is
        variable m, n : integer;
    begin
        m := 0;
        n := 1;  
        while (n < s)  loop        
            m := m + 1;
            n := n*2;    
        end loop;  
        return m;
    end function;


    function reverse_vector(a : std_logic_vector) return std_logic_vector is
        variable result : std_logic_vector(a'reverse_range);
    begin
        for i in a'range loop
            result(i) := a(i);
        end loop;
        return result;
    end function;

end COMMON;
