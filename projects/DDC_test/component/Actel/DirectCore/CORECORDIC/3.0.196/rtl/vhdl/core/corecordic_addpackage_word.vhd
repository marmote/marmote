--****************************************************************
--Actel Corporation Proprietary and Confidential
--Copyright 2009 Actel Corporation.  All rights reserved
--
--ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
--ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
--IN ADVANCE IN WRITING.
--
--Description: CoreCORDIC
--             Word-Serial Package File
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
----------  cROM  -----------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE work.cordic_components.all;

ENTITY cROM IS
  GENERIC(
    BIT_WIDTH          : integer:=48;
    LOGITER            : integer:=6;
    LOGWORDSIZE        : integer:=6;
    ITERATIONS         : integer:=48);
  PORT (iter   : IN std_logic_vector(LOGITER-1 DOWNTO 0);
        arctan : OUT std_logic_vector(BIT_WIDTH-1 DOWNTO 0)  );
END ENTITY cROM;

ARCHITECTURE translated OF cROM IS
  SIGNAL carry         : std_logic_vector(5 downto 0);
  SIGNAL arctan_int : std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
BEGIN
  carry(LOGITER-1 DOWNTO 0) <= iter;
  arctan <= arctan_int;
  PROCESS (carry)
  BEGIN
    CASE to_integer(carry) IS
      WHEN 0 => arctan_int <= "0010000000000000";
      WHEN 1 => arctan_int <= "0001001011100100";
      WHEN 2 => arctan_int <= "0000100111111011";
      WHEN 3 => arctan_int <= "0000010100010001";
      WHEN 4 => arctan_int <= "0000001010001011";
      WHEN 5 => arctan_int <= "0000000101000110";
      WHEN 6 => arctan_int <= "0000000010100011";
      WHEN 7 => arctan_int <= "0000000001010001";
      WHEN 8 => arctan_int <= "0000000000101001";
      WHEN 9 => arctan_int <= "0000000000010100";
      WHEN 10 => arctan_int <= "0000000000001010";
      WHEN 11 => arctan_int <= "0000000000000101";
      WHEN 12 => arctan_int <= "0000000000000011";
      WHEN 13 => arctan_int <= "0000000000000001";
      WHEN 14 => arctan_int <= "0000000000000001";
      WHEN 15 => arctan_int <= "0000000000000000";
      WHEN OTHERS => arctan_int <= (OTHERS=>'-');
    END CASE;
  END PROCESS;
END ARCHITECTURE translated;

