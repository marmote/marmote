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
    subtype sample_type is std_logic_vector(31 downto 0);
    type sample_vector is array ( natural range <> ) of sample_type;


-----------------------------------------
--          Common Constants           --
-----------------------------------------
    constant SAMPLE_WIDTH : integer := sample_type'length;   
    constant ADC_ZERO_LEVEL : sample_type := x"00000080"; --128   

    -- FPGA system clock frequency
    constant c_FAB_CLK : integer := 40000000;


-----------------------------------------
--   Common Functions and Procedures   --
-----------------------------------------

    ---
    --- Find minimum number of bits required to
    --- represent N as an unsigned binary number
    ---
    function log2_ceil(constant s: integer) return integer;


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


    function reverse_vector(a : std_logic_vector) return std_logic_vector is
        variable result : std_logic_vector(a'reverse_range);
    begin
        for i in a'range loop
            result(i) := a(i);
        end loop;
        return result;
    end function;

end COMMON;