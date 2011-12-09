--****************************************************************
--Actel Corporation Proprietary and Confidential
--Copyright 2009 Actel Corporation.  All rights reserved
--
--ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
--ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
--IN ADVANCE IN WRITING.
--
--Description: CoreCORDIC
--             Bit-serial architecture.  Test bench
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

library std;
USE std.textio.all;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
USE work.cordic_components.all;
USE work.cordic_data.all;
USE work.coreparameters.all;


ENTITY testbench IS
 END ENTITY testbench;

ARCHITECTURE translated OF testbench IS
  CONSTANT tscale         : time := 1 ns;
  CONSTANT VERBOSE        : Boolean := True;
  CONSTANT wordZeros : std_logic_vector(BIT_WIDTH-1 DOWNTO 0):= (OTHERS=>'0');
  CONSTANT wordOnes  : std_logic_vector(BIT_WIDTH-1 DOWNTO 0):= (OTHERS=>'1');
--  TYPE TSTVECT IS  -- tables have two extra lines to avoid MTI error message
--      ARRAY (0 TO 2*TABLEROWS+1) OF std_logic_vector(WORDSIZE-1 DOWNTO 0);
--  CONSTANT sinCosGold: TSTVECT := (  --LUT of SinCos golden test vector

--  CONSTANT sqrtAtanGold: TSTVECT := (  --LUT of SqrtAtan golden test vector

--  CONSTANT sqrtAtanTest: TSTVECT := (  --LUT of input test vector

  PROCEDURE print    (str : STRING);     
  PROCEDURE print_sine (arg : REAL;  sin : REAL; cos : REAL);  
  PROCEDURE print_sqrt(argX, argY : REAL;  sqrt, atan : REAL);
  
  PROCEDURE print(str : STRING) IS
    FILE FSTR : TEXT is out "STD_OUTPUT";
    VARIABLE ll   : LINE;
  BEGIN
    write( ll , str );
    writeline(FSTR, ll);
  END print;

  PROCEDURE print_sqrt(argX, argY : REAL;  sqrt, atan : REAL) is
    file FSTR : TEXT is out "STD_OUTPUT";
    variable ll   : LINE;
  BEGIN
    write( ll , STRING'("X=") );
    write( ll , argX );
    write( ll , STRING'(" Y=") );
    write( ll , argY );
    write( ll , STRING'(";   Sqrt*Scale=") );
    write( ll , sqrt );
    write( ll , STRING'("   Atan=") );
    write( ll , atan );
    write( ll , STRING'(" rad") );
    writeline(FSTR, ll);
  END print_sqrt;

  PROCEDURE print_sine(arg : REAL;  sin : REAL; cos : REAL) is
    file FSTR : TEXT is out "STD_OUTPUT";
    variable ll   : LINE;
  BEGIN
    write( ll , STRING'("Angle=") );
    write( ll , arg );
    write( ll , STRING'(" sin ") );
    write( ll , sin );
    write( ll , STRING'("; cos ") );
    write( ll , cos );
    writeline(FSTR, ll);
  END print_sine;



-----------------------------------------------------------
  COMPONENT CORECORDIC
  GENERIC (   
    FAMILY		: integer:=11;
    BIT_WIDTH   : integer:=48;
    ITERATIONS  : integer:=48;
    MODE        : integer:=0;
	ARCH		: integer:=0);
  PORT (CLK,CLKEN,NGRST,LDDATA,RST : IN std_logic;
    RDYOUT    : OUT std_logic;
    XN,YN,AN  : OUT std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
    X0,Y0,A0  : IN std_logic_vector(BIT_WIDTH-1 DOWNTO 0));
  END COMPONENT;
  
  SIGNAL argA,argX,argY,sqrtReal,atanReal,sinReal,cosReal : real;
  SIGNAL angleInc    : std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
  SIGNAL testVectCount              : integer := 0;
  SIGNAL CLK, RST, NGRST            : std_logic;
  SIGNAL argumentInA : std_logic_vector(BIT_WIDTH-1 DOWNTO 0):=wordZeros;
  SIGNAL argumentInX : std_logic_vector(BIT_WIDTH-1 DOWNTO 0):=wordZeros;
  SIGNAL argumentInY : std_logic_vector(BIT_WIDTH-1 DOWNTO 0):=wordZeros;
  SIGNAL cordicResY,cordicResX      :std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
  SIGNAL cordicResA                 :std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
  SIGNAL cordicResY_w, cordicResX_w :std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
  SIGNAL cordicResA_w               :std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
  SIGNAL goldResA,goldResX,goldResY :std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
  SIGNAL rdyOut_t1, rdyOut_w        : std_logic;
  SIGNAL ldArgument_w,ldArgument_t1 : std_logic;
  SIGNAL cordicResAFail_w, cordicResXFail_w : Boolean;
  SIGNAL cordicResYFail_w                   : Boolean;
  SIGNAL cordicResAFail, cordicResXFail     : std_logic;
  SIGNAL cordicResYFail                     : std_logic;
  SIGNAL stopClk                            : std_logic := '0';
BEGIN
  ldArgument_w <= rdyOut_t1 OR RST ;
  cordicResXFail_w <= (cordicResX /= goldResX) ;
  cordicResYFail_w <= (cordicResY /= goldResY) ;
  cordicResAFail_w <= (cordicResA /= goldResA) ;

  clock1: PROCESS
  BEGIN
    CLK <= '0';
    if stopClk = '1'  then   wait;
    end if;
    wait for 5*tscale;
    CLK <= '1';
    if stopClk = '1'  then   wait;
    end if;
    wait for 5*tscale;
  END PROCESS;
  		
  PROCESS
    VARIABLE initial_stage : BOOLEAN := TRUE;
  BEGIN  -- INIT PROCESS
    IF (initial_stage) THEN
      RST <= '0';
      NGRST <= '0';
      WAIT FOR 8 * tscale;
      NGRST <= '1';
      WAIT FOR 17*tscale;
      RST <= '1';
      WAIT FOR 10*tscale;
      RST <= '0';
      initial_stage := FALSE;
    ELSE
      WAIT;
    END IF;
  END PROCESS;

  PROCESS (CLK, NGRST)
  BEGIN
    IF (NOT NGRST = '1') THEN
      IF (MODE = 0) THEN
        argumentInA <= ANGLEINIT;
        argumentInX <= RCPRGAIN;
        argumentInY <= wordZeros;
      ELSE
        argumentInA <= wordZeros;
        argumentInX <= test_input(testVectCount);
        argumentInY <= test_input(testVectCount + 16);
      END IF;
      angleInc <= DELANGLE;
      testVectCount  <= 0;
      cordicResAFail <= '0';
      cordicResXFail <= '0';
      cordicResYFail <= '0';
      rdyOut_t1 <= '0';
      ldArgument_t1 <= '0';

    ELSIF (CLK'EVENT AND CLK = '1') THEN
      rdyOut_t1 <= rdyOut_w AFTER tscale;
      ldArgument_t1 <= ldArgument_w AFTER tscale;

      IF (ldArgument_t1 = '1') THEN
        IF (MODE = 1) THEN
          argumentInX <= test_input(testVectCount);
          argumentInY <= test_input(testVectCount + 16);
        ELSE
          argumentInA <= argumentInA + angleInc;
        END IF;
      END IF;

      IF (ldArgument_w = '1') THEN
        -- latch arguments to display 'em later on
        IF (MODE = 1) THEN
          argX <= RCPRSCALE*to_signReal(argumentInX, BIT_WIDTH) AFTER tscale;
          argY <= RCPRSCALE*to_signReal(argumentInY, BIT_WIDTH) AFTER tscale;
          goldResX <= gold_mp(testVectCount) AFTER tscale;
          goldResA <= gold_mp(testVectCount + 16) AFTER tscale;
        ELSE
          argA <= PIdivSCALE*to_signReal(argumentInA, BIT_WIDTH) AFTER tscale;
          goldResY <= gold_sc(testVectCount) AFTER tscale;
          goldResX <= gold_sc(testVectCount + 16) AFTER tscale;
        END IF;
        testVectCount <= testVectCount + 1;
      END IF;

      IF (rdyOut_w = '1') THEN
        IF (MODE = 1) THEN
          cordicResX <= cordicResX_w AFTER tscale;
          cordicResA <= cordicResA_w AFTER tscale;
          sqrtReal <= to_signReal(cordicResX_w, BIT_WIDTH)*RCPRSCALE AFTER tscale;
          atanReal <= to_signReal(cordicResA_w, BIT_WIDTH)*RCPRSCALE AFTER tscale;
        ELSE
          cordicResX <= cordicResX_w AFTER tscale;
          cordicResY <= cordicResY_w AFTER tscale;
          sinReal <= to_signReal(cordicResY_w, BIT_WIDTH)*RCPRSCALE AFTER tscale;
          cosReal <= to_signReal(cordicResX_w, BIT_WIDTH)*RCPRSCALE AFTER tscale;
        END IF;
      END IF;

      IF (rdyOut_t1 = '1') THEN
        IF (VERBOSE) THEN
          IF (MODE = 1) THEN
            print_sqrt(argX, argY, sqrtReal, atanReal);
          ELSE
            print_sine(argA, sinReal, cosReal);
          END IF;
        END IF;

        IF (cordicResXFail_w) THEN
          cordicResXFail <= '1' AFTER tscale;
        END IF;
        IF (cordicResYFail_w) THEN
          cordicResYFail <= '1' AFTER tscale;
        END IF;
        IF (cordicResAFail_w) THEN
          cordicResAFail <= '1' AFTER tscale;
        END IF;
      END IF;

      IF (testVectCount > TABLEROWS) THEN
        print("************************************************************");
        IF (MODE = 1) THEN
          IF ((cordicResXFail OR cordicResAFail) = '1') THEN
            print("**** Word-serial CORDIC Sqrt/Atan TEST FAILED *****");
          ELSE
            print("---- Word-serial CORDIC Sqrt/Atan test passed -----");
          END IF;
        ELSE
          IF ((cordicResXFail OR cordicResYFail) = '1') THEN
            print("**** Word-serial CORDIC Sin/Cos TEST FAILED *****");
          ELSE
            print("---- Word-serial CORDIC Sin/Cos test passed -----");
          END IF;
        END IF;
        print("**********************************************************");
        stopClk <= '1';
      END IF;
    END IF;
  END PROCESS;

  CORECORDIC_0 : CORECORDIC
    GENERIC MAP (FAMILY => FAMILY, MODE => MODE, BIT_WIDTH => BIT_WIDTH, ITERATIONS => ITERATIONS, ARCH => ARCH)
    PORT MAP (CLK => CLK, CLKEN => '1', NGRST => NGRST, RST =>'0',
      LDDATA => ldArgument_w, RDYOUT => rdyOut_w,
      XN => cordicResX_w, YN => cordicResY_w, AN => cordicResA_w,
      X0 => argumentInX, Y0 => argumentInY, A0 => argumentInA);
END ARCHITECTURE translated;
