--****************************************************************
--Actel Corporation Proprietary and Confidential
--Copyright 2009 Actel Corporation.  All rights reserved
--
--ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
--ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
--IN ADVANCE IN WRITING.
--
--Description: CoreCORDIC
--             Word-serial architecture
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
------------  countDec  -----------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.all;
USE work.cordic_components.all;

ENTITY countDec IS
  GENERIC (WIDTH    : integer := 6;
           TERM_CNT : integer := 47;
		   BIT_WIDTH: integer := 48);
  PORT (CLK, NGRST, RST, LDDATA : IN std_logic;
        tc              : OUT std_logic;
        Q               : OUT std_logic_vector(WIDTH-1 DOWNTO 0)  );
END ENTITY countDec;

ARCHITECTURE translated OF countDec IS

  SIGNAL tc_int : std_logic;
  SIGNAL Q_int  : std_logic_vector(WIDTH - 1 DOWNTO 0);
  CONSTANT const0001 : std_logic_vector(BIT_WIDTH-1 DOWNTO 0):= (0=>'1', OTHERS=>'0');
BEGIN
  tc <= tc_int;
  Q <= Q_int;
  tc_int <= to_logic(Q_int = CONV_STD_LOGIC_VECTOR(TERM_CNT, WIDTH));

  PROCESS (CLK, NGRST)
  BEGIN
    IF (NOT NGRST = '1') THEN
      Q_int <= (OTHERS => '0');
    ELSIF (CLK'EVENT AND CLK = '1') THEN
      IF (RST = '1' OR LDDATA = '1') THEN
        Q_int <= (OTHERS => '0')  ;
      ELSIF (tc_int = '0') THEN
        Q_int <= Q_int + const0001(WIDTH-1 DOWNTO 0)  ;
      END IF;    --RST
    END IF;        --posedge CLK
  END PROCESS;
END ARCHITECTURE translated;

----------  cordicSm  -------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE work.cordic_components.all;

ENTITY cordicSm IS
  GENERIC (COUNTSIZE	 : integer := 6;
		       ITERATIONS	: integer := 48;
		       BIT_WIDTH  : integer := 48);
  PORT (CLK, NGRST, RST, i_datRdy                  	: IN std_logic;
    o_ldData, o_rdyOut								: OUT std_logic;
    iterCount        : OUT std_logic_vector(COUNTSIZE-1 DOWNTO 0));
END ENTITY cordicSm;

ARCHITECTURE translated OF cordicSm IS

  COMPONENT countDec IS
    GENERIC (WIDTH 		: integer := 6;
             TERM_CNT   : integer := 47;
             BIT_WIDTH	: integer := 48);
    PORT (CLK, NGRST, RST, LDDATA    : IN std_logic;
          tc                 : OUT std_logic;
          Q                  : OUT std_logic_vector(WIDTH-1 DOWNTO 0)  );
  END COMPONENT;

  SIGNAL smDatRdy, smCordicDone, oneDelay, waitForFirstData : std_logic;
--  SIGNAL rstCount_w, start_w, o_rdyOutShort_int             : std_logic;		--4/29/10
  SIGNAL rstCount_w							                : std_logic;
  SIGNAL o_ldData_int, o_rdyOut_int, o_preRdyOut_int        : std_logic;
  SIGNAL iterCount_int         : std_logic_vector(COUNTSIZE-1 DOWNTO 0);

BEGIN
  o_ldData <= o_ldData_int;
  o_rdyOut <= o_rdyOut_int;
--  o_preRdyOut <= o_preRdyOut_int;
--  o_rdyOutShort <= o_rdyOutShort_int;
  iterCount <= iterCount_int;

  iterCount_0 : countDec
    GENERIC MAP (WIDTH => COUNTSIZE,
                 TERM_CNT => ITERATIONS-1, BIT_WIDTH => BIT_WIDTH)
    PORT MAP (CLK => CLK, NGRST => NGRST, RST => rstCount_w, LDDATA => i_datRdy,
              tc => o_preRdyOut_int, Q => iterCount_int);

  o_ldData_int <= smDatRdy AND smCordicDone ;
  o_rdyOut_int <= smCordicDone AND NOT waitForFirstData ;
--  start_w <= o_ldData_int OR RST ;							--4/29/10
--  o_rdyOutShort_int <= o_rdyOut_int AND NOT oneDelay ;
  rstCount_w <= smCordicDone OR RST ;

  PROCESS (CLK, NGRST)
  BEGIN
--    WAIT UNTIL (CLK'EVENT AND CLK = '1') OR (NGRST'EVENT AND NGRST = '0');
--    oneDelay <= o_rdyOut_int  ;
	IF ((NOT NGRST) = '1') THEN					--4/29/10 >
      smDatRdy <= '0';
      smCordicDone <= '0';
      oneDelay <= '0';
      waitForFirstData <= '1';
	ELSIF (CLK'EVENT AND CLK = '1') THEN
	
	  IF (RST = '1') THEN
	    smDatRdy <= '0';
        smCordicDone <= '0';
        oneDelay <= '0';
        waitForFirstData <= '1';
      ELSIF (i_datRdy = '1') THEN	
        smDatRdy <= '1'  ;
		smCordicDone <= '0';
		oneDelay <= '0';
		waitForFirstData <= '0';
		  
      ELSIF (o_ldData_int = '1') THEN
        waitForFirstData <= '1'  ;
        smDatRdy <= '0'  ;
        smCordicDone <= '0'  ;
        oneDelay <= '0'  ;
      ELSE
        IF (o_preRdyOut_int = '1') THEN
          smCordicDone <= '1'  ;
        END IF;
      oneDelay <= o_rdyOut_int;
	  END IF;
    END IF;									--4/29/10^
  END PROCESS;
END ARCHITECTURE translated;

----------  cROM  -----------------------------------------
--USE IEEE.std_logic_1164.all;
--USE work.cordic_components.all;
--USE work.cordic_lut.all;

--ENTITY cROM IS
--  GENERIC ( BIT_WIDTH  : integer := 48;
--            LOGITER	   : integer := 6;
--            ITERATIONS : integer:= 48);
--  PORT (iter   : IN std_logic_vector(LOGITER-1 DOWNTO 0);
--        arctan : OUT std_logic_vector(BIT_WIDTH-1 DOWNTO 0)  );
--END ENTITY cROM;

--ARCHITECTURE translated OF cROM IS
--  SIGNAL carry         : std_logic_vector(5 downto 0);
--  SIGNAL arctan_int : std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
--BEGIN
--  carry(LOGITER-1 DOWNTO 0) <= iter;
--  arctan <= arctan_int;
-- --  WITH to_integer(carry) SELECT
-- --    arctan_int <= 
-- --        arctanLut(to_integer(iter)) WHEN 0 to (BIT_WIDTH-1),
-- --        (OTHERS=>'-') WHEN OTHERS;


--  PROCESS (carry)
--  BEGIN
--    CASE to_integer(carry) IS
--      WHEN 0 to (ITERATIONS-1) => arctan_int <= arctanLut(to_integer(iter));
--	  WHEN OTHERS => arctan_int <= (OTHERS=>'-');
--    END CASE;
    
--  END PROCESS;
----  PROCESS (carry)

----  BEGIN
----    CASE carry IS
--      WHEN "000000" => arctan_int <= "001000000000000000000000000000000000000000000000";
--      WHEN "000001" => arctan_int <= "000100101110010000000101000111011001110111110011";
--      WHEN "000010" => arctan_int <= "000010011111101100111000010110110101111011100100";
--      WHEN "000011" => arctan_int <= "000001010001000100010001110101000001110111011110";
--      WHEN "000100" => arctan_int <= "000000101000101100001101010000110000111001011001";
--      WHEN "000101" => arctan_int <= "000000010100010111010111111000010101100100000100";
--      WHEN "000110" => arctan_int <= "000000001010001011110110000111100101110000101000";
--      WHEN "000111" => arctan_int <= "000000000101000101111100010101010001000111010100";
--      WHEN "001000" => arctan_int <= "000000000010100010111110010100110100011011010001";
--      WHEN "001001" => arctan_int <= "000000000001010001011111001011101011101100110001";
--      WHEN "001010" => arctan_int <= "000000000000101000101111100110000000000010010010";
--      WHEN "001011" => arctan_int <= "000000000000010100010111110011000001010010101000";
--      WHEN "001100" => arctan_int <= "000000000000001010001011111001100000110011100000";
--      WHEN "001101" => arctan_int <= "000000000000000101000101111100110000011011000001";
--     WHEN "001110" => arctan_int <= "000000000000000010100010111110011000001101101011";
--      WHEN "001111" => arctan_int <= "000000000000000001010001011111001100000110110111";
--      WHEN "010000" => arctan_int <= "000000000000000000101000101111100110000011011100";
--      WHEN "010001" => arctan_int <= "000000000000000000010100010111110011000001101110";
--      WHEN "010010" => arctan_int <= "000000000000000000001010001011111001100000110111";
--      WHEN "010011" => arctan_int <= "000000000000000000000101000101111100110000011011";
--      WHEN "010100" => arctan_int <= "000000000000000000000010100010111110011000001110";
--      WHEN "010101" => arctan_int <= "000000000000000000000001010001011111001100000111";
--      WHEN "010110" => arctan_int <= "000000000000000000000000101000101111100110000011";
--      WHEN "010111" => arctan_int <= "000000000000000000000000010100010111110011000010";
--      WHEN "011000" => arctan_int <= "000000000000000000000000001010001011111001100001";
--      WHEN "011001" => arctan_int <= "000000000000000000000000000101000101111100110000";
--      WHEN "011010" => arctan_int <= "000000000000000000000000000010100010111110011000";
--      WHEN "011011" => arctan_int <= "000000000000000000000000000001010001011111001100";
--      WHEN "011100" => arctan_int <= "000000000000000000000000000000101000101111100110";
--      WHEN "011101" => arctan_int <= "000000000000000000000000000000010100010111110011";
--      WHEN "011110" => arctan_int <= "000000000000000000000000000000001010001011111010";
--      WHEN "011111" => arctan_int <= "000000000000000000000000000000000101000101111101";
--      WHEN "100000" => arctan_int <= "000000000000000000000000000000000010100010111110";
--      WHEN "100001" => arctan_int <= "000000000000000000000000000000000001010001011111";
--      WHEN "100010" => arctan_int <= "000000000000000000000000000000000000101000110000";
--      WHEN "100011" => arctan_int <= "000000000000000000000000000000000000010100011000";
--      WHEN "100100" => arctan_int <= "000000000000000000000000000000000000001010001100";
--      WHEN "100101" => arctan_int <= "000000000000000000000000000000000000000101000110";
--      WHEN "100110" => arctan_int <= "000000000000000000000000000000000000000010100011";
--      WHEN "100111" => arctan_int <= "000000000000000000000000000000000000000001010001";
--      WHEN "101000" => arctan_int <= "000000000000000000000000000000000000000000101001";
--      WHEN "101001" => arctan_int <= "000000000000000000000000000000000000000000010100";
--      WHEN "101010" => arctan_int <= "000000000000000000000000000000000000000000001010";
--      WHEN "101011" => arctan_int <= "000000000000000000000000000000000000000000000101";
--      WHEN "101100" => arctan_int <= "000000000000000000000000000000000000000000000011";
--      WHEN "101101" => arctan_int <= "000000000000000000000000000000000000000000000001";
--      WHEN "101110" => arctan_int <= "000000000000000000000000000000000000000000000001";
--      WHEN "101111" => arctan_int <= "000000000000000000000000000000000000000000000000";
--      WHEN OTHERS => arctan_int <= (OTHERS=>'-');
--    END CASE;
--  END PROCESS;
--END ARCHITECTURE translated;

------------  calculator  ---------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
USE work.cordic_components.all;

ENTITY calculator IS
  GENERIC (MODE 		: integer := 0;
		   BIT_WIDTH 	: integer := 48;
		   LOGITER		: integer := 6);  --Rotating = 0; vectoring = 1
  PORT (CLK, NGRST, RST    : IN std_logic;
    X0, Y0, A0             : IN std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
    XN, YN, AN             : OUT std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
    LDDATA                 : IN std_logic;
    iter                   : IN std_logic_vector(LOGITER-1 DOWNTO 0);
    aRom                   : IN std_logic_vector(BIT_WIDTH-1 DOWNTO 0));
END ENTITY calculator;

ARCHITECTURE translated OF calculator IS
--  CONSTANT FILLER         : std_logic_vector (47-BIT_WIDTH downto 0):= (others => '0');

  SIGNAL XshiftOut, YshiftOut   : std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
  SIGNAL d, d_int               : std_logic;
  SIGNAL xn_int, yn_int, an_int : std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
  
BEGIN
  XN <= xn_int;
  YN <= yn_int;
  AN <= an_int;
--  XshiftOut <= shftRA(BIT_WIDTH, FILLER & yn_int, to_integer(iter)) AFTER tscale;
  XshiftOut <= shftRA(BIT_WIDTH, yn_int, to_integer(iter)) ;
  YshiftOut <= shftRA(BIT_WIDTH, xn_int, to_integer(iter)) ;
  --d_int <= NOT yn_int(BIT_WIDTH-1) WHEN (MODE) /= 0 ELSE an_int(BIT_WIDTH-1);
  --d <= d_int ;
  d <= NOT yn_int(BIT_WIDTH-1) WHEN (MODE) /= 0 ELSE an_int(BIT_WIDTH-1);

  PROCESS (CLK, NGRST)
  BEGIN
 --   WAIT UNTIL (CLK'EVENT AND CLK = '1') OR (NGRST'EVENT AND NGRST = '0');
    IF ((NOT NGRST) = '1') THEN
      an_int <= (others => '0') ;
      xn_int <= (others => '0') ;
      yn_int <= (others => '0')  ;
    ELSIF(CLK'EVENT AND CLK = '1') THEN
	  IF (RST = '1') THEN
		an_int <= (others => '0') ;
		xn_int <= (others => '0') ;
		yn_int <= (others => '0')  ;
      ELSIF (LDDATA = '1') THEN
        an_int <= A0  ;
        xn_int <= X0  ;
        yn_int <= Y0  ;
      ELSE
        IF (d = '1') THEN
          an_int <= an_int + aRom  ;
          xn_int <= xn_int + XshiftOut  ;
          yn_int <= yn_int - YshiftOut  ;
        ELSE
          an_int <= an_int - aRom  ;
          xn_int <= xn_int - XshiftOut  ;
          yn_int <= yn_int + YshiftOut  ;
        END IF;
      END IF;
    END IF;
  END PROCESS;
END ARCHITECTURE translated;

------------  CORECORDIC  ----------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE work.cordic_components.all;

ENTITY CORECORDIC IS
  GENERIC ( FAMILY   : integer:=11;
            BIT_WIDTH   : integer:=48;
            ITERATIONS : integer:=48;
            MODE        : integer:=0;
			ARCH        : integer:=0); --Vectoring Not Rotation mode: 0=rotation
  PORT (CLK, NGRST, RST, LDDATA, CLKEN    : IN std_logic;
    RDYOUT             : OUT std_logic;
    XN, YN, AN    : OUT std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
    X0, Y0, A0    : IN std_logic_vector(BIT_WIDTH-1 DOWNTO 0));
END ENTITY CORECORDIC;

ARCHITECTURE translated OF CORECORDIC IS

  CONSTANT LOGWORDSIZE: integer:=log2(BIT_WIDTH); --log2(BIT_WIDTH) rounded up
  CONSTANT LOGITER    : integer:=log2(ITERATIONS); --log2(ITERATIONS) rounded up
  CONSTANT COUNTSIZE  : integer:=log2(ITERATIONS+1); --log2(ITERATIONS+1) rounded up
  
  COMPONENT cordicSm IS  
    GENERIC (COUNTSIZE	  : integer := 6;
			       ITERATIONS  : integer := 48;
			       BIT_WIDTH   : integer := 48);
    PORT (
      CLK, NGRST, RST, i_datRdy     : IN std_logic;
      o_ldData, o_rdyOut			: OUT std_logic;
      iterCount                		: OUT std_logic_vector(COUNTSIZE-1 DOWNTO 0));
  END COMPONENT;

  COMPONENT cROM IS
   GENERIC ( BIT_WIDTH	: integer := 48;
			 LOGITER		 : integer := 6;
			 LOGWORDSIZE  : integer:=6;
			 ITERATIONS: integer := 48);
    PORT (iter   : IN std_logic_vector(LOGITER-1 DOWNTO 0);
        arctan : OUT std_logic_vector(BIT_WIDTH-1 DOWNTO 0)  );
  END COMPONENT;

  COMPONENT calculator IS
    GENERIC (MODE 		: integer := 0;
		         BIT_WIDTH 	: integer := 48;
		         LOGITER	: integer := 6);
    PORT (CLK, NGRST, RST    : IN std_logic;
      X0, Y0, A0             : IN std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
      XN, YN, AN             : OUT std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
      LDDATA                 : IN std_logic;
      iter                   : IN std_logic_vector(LOGITER-1 DOWNTO 0);
      aRom                   : IN std_logic_vector(BIT_WIDTH-1 DOWNTO 0));
  END COMPONENT;
  
  SIGNAL tc_w, IFO_RDYOUT_int, IFO_LDDATA_int, IFO_LDDATA   : std_logic;
--  SIGNAL IFO_PRERDYOUT_int, IFO_RDYOUTSHORT_int : std_logic;
--  SIGNAL IFO_PRERDYOUT, FO_RDYOUT   : std_logic;
  SIGNAL count_w                  : std_logic_vector(LOGITER-1 DOWNTO 0);
  SIGNAL count_ww                 : std_logic_vector(COUNTSIZE-1 DOWNTO 0);
  SIGNAL romAngle_w, angleAccum_w : std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
  SIGNAL xn_int, yn_int, an_int   : std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
    
BEGIN
-- RDYOUT <= IFO_RDYOUT_int;
  RDYOUT <= IFO_LDDATA_int;
  IFO_LDDATA <= IFO_LDDATA_int;
--  IFO_PRERDYOUT <= IFO_PRERDYOUT_int;
--  FO_RDYOUT <= IFO_RDYOUTSHORT_int;
  XN <= xn_int;
  YN <= yn_int;
  AN <= an_int;
  count_w <= count_ww(LOGITER-1 DOWNTO 0);

  sm_0 : cordicSm
    GENERIC MAP (COUNTSIZE => COUNTSIZE, ITERATIONS => ITERATIONS, BIT_WIDTH => BIT_WIDTH)
    PORT MAP (CLK => CLK, NGRST => NGRST, RST => RST, i_datRdy => LDDATA,
      o_ldData => IFO_LDDATA_int, o_rdyOut => IFO_RDYOUT_int,
--      o_preRdyOut => IFO_PRERDYOUT_int,o_rdyOutShort => IFO_RDYOUTSHORT_int, 
		iterCount => count_ww);

  cordicRam : cROM
   GENERIC MAP ( BIT_WIDTH => BIT_WIDTH, LOGITER => LOGITER, LOGWORDSIZE  => LOGWORDSIZE, ITERATIONS => ITERATIONS)
    PORT MAP (iter => count_w, arctan => romAngle_w);

  calculator_0 : calculator
    GENERIC MAP (MODE => MODE, BIT_WIDTH => BIT_WIDTH, LOGITER => LOGITER)
    PORT MAP (RST => RST, NGRST => NGRST, CLK => CLK,
      X0 => X0, Y0 => Y0, A0 => A0, XN => xn_int, YN => yn_int,
      AN => an_int, LDDATA => LDDATA, iter => count_w,
      aRom => romAngle_w);
END ARCHITECTURE translated;
