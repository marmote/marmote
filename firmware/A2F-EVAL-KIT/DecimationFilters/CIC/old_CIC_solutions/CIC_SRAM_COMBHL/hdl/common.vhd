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


-----------------------------------------
--          Common Constants           --
-----------------------------------------
    -- FPGA system clock frequency
    constant c_FAB_CLK : integer := 50000000;

    constant c_CIC_WIDTH        : integer := 22;
    constant c_CIC_ORDER        : integer := 5;

--    constant c_CIC_DECIMATION   : integer := pow2(c_CIC_ORDER);
--    constant c_CIC_INNER_WIDTH  : integer := c_CIC_WIDTH + c_CIC_ORDER * log2_ceil(c_CIC_DECIMATION);


-----------------------------------------
--            Common Types             --
-----------------------------------------
--    type sample_vector is array ( natural range <> ) of signed(c_CIC_INNER_WIDTH-1 downto 0);



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
        while (n < s)  loop        
            m := m + 1;
            n := n*2;    
        end loop;  
        return m;
    end function;


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


    function reverse_vector(a : std_logic_vector) return std_logic_vector is
        variable result : std_logic_vector(a'reverse_range);
    begin
        for i in a'range loop
            result(i) := a(i);
        end loop;
        return result;
    end function;

end COMMON;