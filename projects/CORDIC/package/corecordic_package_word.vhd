--****************************************************************
--Actel Corporation Proprietary and Confidential
--Copyright 2009 Actel Corporation.  All rights reserved
--
--ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
--ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
--IN ADVANCE IN WRITING.
--
--Description: CoreCORDIC
--             CORDIC package
--
--Rev:
--v3.0 12/16/09  Sana : Maintenance Update
--
--SVN Revision Information:
--SVN$Revision:$
--SVN$Date:$
--
--Resolved SARS
--19458 10/14/09 Sana No longer requires package directory
--19459 10/14/09 Sana No longer requires package directory
--
--Notes:
--
--****************************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
USE std.textio.all;
use ieee.numeric_std.all;
use IEEE.MATH_REAL.all;
use IEEE.math_complex.all;

package CORDIC_COMPONENTS is

--  CONSTANT const0001 : 
--               std_logic_vector(WORDSIZE-1 DOWNTO 0):= (0=>'1', OTHERS=>'0');
  TYPE ROMARRAY IS ARRAY (0 to 47) OF std_logic_vector(47 DOWNTO 0);
    
  function to_logic  ( x : integer) return std_logic;
  function to_logic  ( x : boolean) return std_logic;
  FUNCTION to_integer( sig : std_logic_vector) return integer;
  function to_signReal(sig : std_logic_vector; BIT_WIDTH : integer) return real;
  function to_integer( x : boolean) return integer;
  function to_byte   ( x : integer ) return std_logic_vector;
  function to_word   ( x : integer ) return std_logic_vector;
  function to_dword  ( x : integer ) return std_logic_vector;
--  FUNCTION reverse   (x : std_logic_vector(LOGITER-2 DOWNTO 0)) RETURN bit_vector;
--  FUNCTION reverseStd(x : std_logic_vector(LOGITER-2 DOWNTO 0)) RETURN std_logic_vector;
  FUNCTION shftRA    (BIT_WIDTH : integer; x : std_logic_vector; shft : integer) 
                      RETURN std_logic_vector;
  FUNCTION to_signInteger ( din : std_logic_vector; BIT_WIDTH : integer ) return integer;
  FUNCTION log2 (x	: integer) RETURN integer;

--  FUNCTION calc_data (BIT_WIDTH : integer; ITERATIONS: integer) return ROMARRAY;
--  COMPONENT counter
--    GENERIC (
--      WIDTH  :  integer := LOGITER-1;
--      TERMCOUNT     :  integer := WORDSIZE-1 );    
--    PORT (
--      CLK, NGRST, RST, cntEn  : IN  std_logic;
--      tc                      : OUT std_logic;
--      Q                       : OUT std_logic_vector(WIDTH-1 DOWNTO 0));
--  END COMPONENT;

--  COMPONENT bcounter
--    GENERIC (
--      WIDTH  :  integer := LOGITER-1);    
--    PORT (
--      CLK, NGRST, RST, cntEn  : IN std_logic;   
--      Q                       : OUT std_logic_vector(WIDTH-1 DOWNTO 0)  );
--  END COMPONENT;

  COMPONENT edgeDetect
    GENERIC (
      INPIPE  :integer := 0; --if (INPIPE==1) insert input pipeline reg
      FEDGE   :integer := 0);--If FEDGE==1 detect falling edge, else-rising edge
    PORT (
      CLK, CLKEN, edgeIn   : IN std_logic;   
      edgeOut              : OUT std_logic);
  END COMPONENT;

end CORDIC_COMPONENTS;

package body CORDIC_COMPONENTS is

  function to_logic ( x : integer) return std_logic is
  variable y  : std_logic;
  begin
    if x = 0 then
      y := '0';
    else
      y := '1';
    end if;
    return y;
  end to_logic;

  function to_logic( x : boolean) return std_logic is
    variable y : std_logic;
  begin
    if x then 
      y := '1';
    else 
      y := '0';
    end if;
    return(y);
  end to_logic;

  function to_integer(sig : std_logic_vector) return integer is
    variable num : integer := 0;  -- descending sig as integer
  begin
    for i in sig'range loop
      if sig(i)='1' then
        num := num*2+1;
      else  -- take anything other than '1' as '0'
        num := num*2;
      end if;
    end loop;  -- i
    return num;
  end function to_integer;
  
  function to_signInteger ( din : std_logic_vector; BIT_WIDTH : integer ) return integer is
    variable x: integer;
  begin
    x := 0;
    if din(BIT_WIDTH-1)='0' then 
       x := conv_integer( din (BIT_WIDTH-2 downto 0));
    else
      x := conv_integer( din (BIT_WIDTH-2 downto 0));
      x := x - 2 ** (BIT_WIDTH-1);
    end if;
    return(x);
  end to_signInteger;

  FUNCTION to_signReal(sig : std_logic_vector; BIT_WIDTH : integer) return real is
    variable numReal: real := 0.0;
  begin
    for i in BIT_WIDTH-2 downto 0 loop
      if sig(i)='1' then
        numReal := numReal*2.0+1.0;
      else  -- take anything other than '1' as '0'
        numReal := numReal*2.0;
      end if;
    end loop;  -- i
    if sig(BIT_WIDTH-1)='0' then
      return numReal;
    else
      numReal := numReal - 2.0 ** (BIT_WIDTH-1);
      return(numReal);
    end if;  
  end function to_signReal;

  FUNCTION to_integer( x : boolean) return integer is
    variable y : integer;
  BEGIN
    if x then 
      y := 1;
    else 
      y := 0;
    end if;
    return(y);
  END to_integer;
  
  function to_byte ( x : integer ) return std_logic_vector is
    variable x1        : std_logic_vector(7 downto 0);
  begin
    x1 := conv_std_logic_vector( x, 8);
    return(x1);
  end to_byte;


  function to_word ( x : integer ) return std_logic_vector is
    variable x1        : std_logic_vector(15 downto 0);
  begin
    x1 := conv_std_logic_vector( x, 16);
    return(x1);
  end to_word;

  function to_dword ( x : integer ) return std_logic_vector is
    variable x1        : std_logic_vector(31 downto 0);
  begin
    x1 := conv_std_logic_vector( x, 32);
    return(x1);
  end to_dword;

--  FUNCTION reverse (x :IN std_logic_vector(LOGITER-2 DOWNTO 0)) 
--                    RETURN bit_vector IS
--    VARIABLE i              : integer;
--    VARIABLE reverse        : bit_vector(LOGITER-2 DOWNTO 0);
--  BEGIN
--    FOR i IN 0 TO (LOGITER-2) LOOP
--      reverse(i) := To_bit( x(LOGITER-2 - i));
--    END LOOP;
--    RETURN(reverse);
--  END FUNCTION reverse;

--  FUNCTION reverseStd (x :IN std_logic_vector(LOGITER-2 DOWNTO 0)) 
--                    RETURN std_logic_vector IS
--    VARIABLE i              : integer;
--    VARIABLE reverse        : std_logic_vector(LOGITER-2 DOWNTO 0);
--  BEGIN
--    FOR i IN 0 TO (LOGITER-2) LOOP
--      reverse(i) := x(LOGITER-2 - i);
--    END LOOP;
--    RETURN(reverse);
--  END FUNCTION reverseStd;

  FUNCTION shftRA (BIT_WIDTH : integer; x :std_logic_vector;
                   shft :IN integer) 
                   RETURN std_logic_vector IS
  VARIABLE x1 : bit_vector(BIT_WIDTH-1 DOWNTO 0);
  BEGIN
    x1 := To_bitvector(x) SRA shft;
    RETURN(To_StdLogicVector(x1) );
  END FUNCTION shftRA;
  
  FUNCTION log2(x	: integer) RETURN integer IS
  VARIABLE y : integer;
  BEGIN
   if(x<8) then
     y:=3;
   elsif(x<16) then
     y:=4;
   elsif(x<32) then
     y:=5;
   else
     y:=6;  
	 end if;
	 RETURN(y);
  END FUNCTION log2;
  
--  FUNCTION calc_data (BIT_WIDTH : integer; ITERATIONS: integer) 
--        return ROMARRAY is
--  variable scale : real :=1.0;
--  variable x: real;
--  variable anglefl : real;
--  variable carry: real;
--  variable lut: ROMARRAY;
--  begin
--    FOR i in 0 to ITERATIONS-1 loop
--      carry := (0.5)**(i);
--      anglefl := arctan(carry);
--    
--      FOR j in 0 to BIT_WIDTH-2 loop
--        scale := scale*2.0;
--      END LOOP;
--    
--      if (anglefl < 0.0) then
--        x := ((scale*anglefl)/math_pi) - 0.5;
--      else
--        x := ((scale*anglefl)/math_pi)+ 0.5;
--      end if; 
--      
--      lut(i) := (STD_LOGIC_VECTOR(CONV_SIGNED(INTEGER(x),BIT_WIDTH)));
--    end LOOP;
--    RETURN(lut);  
--  END FUNCTION calc_data;
END CORDIC_COMPONENTS;
