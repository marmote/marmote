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
    constant c_FAB_CLK : integer    := 50000000;

    constant SAMPLE_WIDTH : integer := 14;  -- Has got to be less then or equal to 16 
 --   constant ADC_ZERO_LEVEL : sample_type := x"0080"; --128   

    constant c_CIC_WIDTH            : integer := 22;
    constant c_CIC_ORDER            : integer := 4;

    constant c_CORDIC_WIDTH         : integer := 16;
--    constant c_COUNTER_WIDTH    : integer := 5; -- 2^c_COUNTER_WIDTH > c_CORDIC_WIDTH+2
    constant c_CORDIC_OUTPUT_WIDTH  : integer := 8;
-----------------------------------------
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
