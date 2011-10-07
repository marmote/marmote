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


    function OR_signal(a : std_logic_vector) return std_logic;


-----------------------------------------
--          Common Constants           --
-----------------------------------------
    -- FPGA system clock frequency
    constant c_FAB_CLK : integer := 50000000;

    constant c_ADC_SAMPLING     : integer := 18; -- How many cycles does it take, to get one sample?

    constant c_COEF_WIDTH       : integer := 16; -- should be less than or equal to 18
    constant c_COEF_NUMBER      : integer := 511; -- should be less than or equal to 511

    constant c_SAMPLE_WIDTH     : integer := 22;  
    constant c_SAMPLE_NUMBER    : integer := c_COEF_NUMBER+1; -- should be less than or equal to 512


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


    function OR_signal(a : std_logic_vector) return std_logic is
        variable result: std_logic := '0';
    begin

        for i in a'range loop
            result := result or a(i);
        end loop;

        return result;
    end function;

end COMMON;