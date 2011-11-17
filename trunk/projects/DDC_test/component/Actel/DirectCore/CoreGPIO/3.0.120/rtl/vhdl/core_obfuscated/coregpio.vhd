-- Copyright 2007 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision:  $
library Ieee;
use ieeE.std_LOgic_1164.all;
use ieee.STd_logic_unsigneD.all;
use ieee.NUMERIC_STD.all;
library WORK;
use work.coregpIO_PKG.all;
entity coregpio is
generic (family: inTEGER range 0 to 63 := 17;
io_nuM: INTEGER range 1 to 32 := 32;
aPB_WIDTH: intEGER range 8 to 32 := 32;
OE_Type: integER range 0 to 1 := 0;
int_bus: INTEGER range 0 to 1 := 0;
fixeD_CONFIG_0: integer range 0 to 1 := 0;
Fixed_config_1: integer range 0 to 1 := 0;
FIxed_config_2: INTEGER range 0 to 1 := 0;
FIXED_CONfig_3: inteGER range 0 to 1 := 0;
fiXED_CONFIG_4: integer range 0 to 1 := 0;
FIXED_CONFIG_5: integer range 0 to 1 := 0;
FIXED_CONFIG_6: integer range 0 to 1 := 0;
fixed_confiG_7: INTEGer range 0 to 1 := 0;
fixed_config_8: INTEGER range 0 to 1 := 0;
fixed_CONFIG_9: Integer range 0 to 1 := 0;
FIXED_COnfig_10: integeR range 0 to 1 := 0;
FIXED_Config_11: intEGER range 0 to 1 := 0;
fixed_config_12: INTEGER range 0 to 1 := 0;
fixed_confiG_13: INTEGER range 0 to 1 := 0;
FIXed_config_14: integer range 0 to 1 := 0;
fiXED_CONFIG_15: INTEger range 0 to 1 := 0;
fixed_config_16: integer range 0 to 1 := 0;
FIXED_config_17: integer range 0 to 1 := 0;
fixed_confIG_18: INTEGER range 0 to 1 := 0;
fixed_config_19: intEGER range 0 to 1 := 0;
fixed_confIG_20: integER range 0 to 1 := 0;
FIxed_config_21: integer range 0 to 1 := 0;
FIXED_CONFIg_22: INTEGER range 0 to 1 := 0;
FIXED_CONFIG_23: INTEGEr range 0 to 1 := 0;
fixed_cONFIG_24: INTEGER range 0 to 1 := 0;
fixED_CONFIG_25: INTEGER range 0 to 1 := 0;
FIXED_CONFIG_26: INTEGER range 0 to 1 := 0;
FIXed_config_27: INTEger range 0 to 1 := 0;
FIXEd_config_28: INTEGER range 0 to 1 := 0;
FIXED_CONFig_29: INTEGER range 0 to 1 := 0;
fixed_confIG_30: integer range 0 to 1 := 0;
fiXED_CONFIG_31: integeR range 0 to 1 := 0;
IO_TYPE_0: integer range 0 to 2 := 0;
io_tYPE_1: INTeger range 0 to 2 := 0;
io_type_2: integer range 0 to 2 := 0;
io_type_3: INTEGER range 0 to 2 := 0;
IO_TYPE_4: INTEger range 0 to 2 := 0;
IO_type_5: integer range 0 to 2 := 0;
io_tyPE_6: INTEGER range 0 to 2 := 0;
IO_type_7: integer range 0 to 2 := 0;
IO_TYpe_8: INTeger range 0 to 2 := 0;
IO_Type_9: Integer range 0 to 2 := 0;
IO_TYPe_10: INTEger range 0 to 2 := 0;
IO_TYPE_11: INTEGER range 0 to 2 := 0;
Io_type_12: integer range 0 to 2 := 0;
IO_TYPE_13: INTEGER range 0 to 2 := 0;
io_TYPE_14: INTEGER range 0 to 2 := 0;
io_type_15: integer range 0 to 2 := 0;
IO_TYPE_16: INTEGER range 0 to 2 := 0;
io_type_17: integer range 0 to 2 := 0;
IO_TYPE_18: INTEGER range 0 to 2 := 0;
io_type_19: INTEger range 0 to 2 := 0;
iO_TYPE_20: integER range 0 to 2 := 0;
IO_TYPE_21: integeR range 0 to 2 := 0;
Io_type_22: INTEGER range 0 to 2 := 0;
Io_type_23: INTEGER range 0 to 2 := 0;
io_type_24: INTEGER range 0 to 2 := 0;
IO_TYPE_25: INTEGER range 0 to 2 := 0;
IO_TYPE_26: integER range 0 to 2 := 0;
IO_TYPE_27: integer range 0 to 2 := 0;
IO_type_28: inTEGER range 0 to 2 := 0;
io_TYPE_29: INTeger range 0 to 2 := 0;
Io_type_30: integER range 0 to 2 := 0;
io_tyPE_31: INTEGER range 0 to 2 := 0;
Io_int_type_0: integER range 0 to 7 := 0;
IO_INT_TYPE_1: integer range 0 to 7 := 0;
io_int_tYPE_2: INTEGER range 0 to 7 := 0;
IO_INT_type_3: integer range 0 to 7 := 0;
IO_INT_TYpe_4: integer range 0 to 7 := 0;
IO_Int_type_5: integer range 0 to 7 := 0;
io_int_typE_6: INTEGER range 0 to 7 := 0;
IO_INT_TYPE_7: INTeger range 0 to 7 := 0;
IO_INT_TYPe_8: Integer range 0 to 7 := 0;
IO_INT_TYPe_9: INTeger range 0 to 7 := 0;
IO_INT_type_10: Integer range 0 to 7 := 0;
IO_INT_TYPE_11: INTEGER range 0 to 7 := 0;
IO_Int_type_12: Integer range 0 to 7 := 0;
IO_INT_TYPE_13: INTEGER range 0 to 7 := 0;
io_int_TYPE_14: intEGER range 0 to 7 := 0;
IO_INT_TYPE_15: INTEGER range 0 to 7 := 0;
io_int_type_16: INTEger range 0 to 7 := 0;
io_int_type_17: INTeger range 0 to 7 := 0;
io_int_TYPE_18: inteGER range 0 to 7 := 0;
IO_INt_type_19: INTEGER range 0 to 7 := 0;
io_int_type_20: integer range 0 to 7 := 0;
io_int_TYPE_21: integer range 0 to 7 := 0;
iO_INT_TYPE_22: integeR range 0 to 7 := 0;
io_INT_TYPE_23: integer range 0 to 7 := 0;
io_iNT_TYPE_24: integer range 0 to 7 := 0;
io_int_type_25: INTEGER range 0 to 7 := 0;
IO_int_type_26: INTEGER range 0 to 7 := 0;
IO_Int_type_27: iNTEGER range 0 to 7 := 0;
io_int_TYPE_28: Integer range 0 to 7 := 0;
io_int_type_29: INTEGER range 0 to 7 := 0;
io_int_type_30: INTEGER range 0 to 7 := 0;
io_int_typE_31: INTEGER range 0 to 7 := 0;
io_val_0: integeR range 0 to 1 := 0;
IO_val_1: INteger range 0 to 1 := 0;
IO_VAL_2: INTEGER range 0 to 1 := 0;
IO_val_3: INTEGEr range 0 to 1 := 0;
IO_VAl_4: INTEGER range 0 to 1 := 0;
IO_VAL_5: INTEGER range 0 to 1 := 0;
io_val_6: integer range 0 to 1 := 0;
io_vAL_7: integer range 0 to 1 := 0;
io_VAL_8: integer range 0 to 1 := 0;
io_VAL_9: integeR range 0 to 1 := 0;
io_vaL_10: integer range 0 to 1 := 0;
IO_VAL_11: inTEGER range 0 to 1 := 0;
IO_Val_12: INTEGER range 0 to 1 := 0;
IO_VAL_13: INTEGER range 0 to 1 := 0;
IO_VAL_14: INTEGER range 0 to 1 := 0;
io_val_15: INTEGER range 0 to 1 := 0;
IO_val_16: INTEGER range 0 to 1 := 0;
IO_VAL_17: integER range 0 to 1 := 0;
IO_VAL_18: integeR range 0 to 1 := 0;
io_val_19: INTEGEr range 0 to 1 := 0;
io_vAL_20: INTEger range 0 to 1 := 0;
io_val_21: inTEGER range 0 to 1 := 0;
io_val_22: INTEGer range 0 to 1 := 0;
IO_VAl_23: integer range 0 to 1 := 0;
io_val_24: INTEGER range 0 to 1 := 0;
io_val_25: INTEGER range 0 to 1 := 0;
io_VAL_26: INTEGER range 0 to 1 := 0;
IO_VAL_27: INTeger range 0 to 1 := 0;
IO_val_28: integer range 0 to 1 := 0;
IO_val_29: integer range 0 to 1 := 0;
IO_VAL_30: Integer range 0 to 1 := 0;
io_vAL_31: INTEGER range 0 to 1 := 0); port (preSETN: in STD_Logic;
pclK: in std_logiC;
PSEL: in STD_LOGIC;
PENABLE: in STD_LOGIC;
PWRITE: in std_loGIC;
pslverr: out Std_logic;
PREADY: out stD_LOGIC;
PADDR: in std_LOGIC_VECTOR(7 downto 0);
pwdata: in STD_LOGIC_VECtor(APB_WIDTH-1 downto 0);
prdata: out STD_LOGic_vector(APB_width-1 downto 0);
int: out std_logIC_VECTOR(IO_NUM-1 downto 0);
INT_OR: out STD_logic;
GPIO_IN: in std_logic_VECTOR(IO_NUM-1 downto 0);
GPIO_OUT: out Std_logic_vector(io_NUM-1 downto 0);
gpio_oe: out std_logic_vector(IO_NUM-1 downto 0));
end entity corEGPIO;

architecture CGPIOO of COREGPIO is

constant CGPIOL: STD_Logic_vector(0 to 31) := (INT2SLV(FIXED_CONFig_0,
1)&int2slv(fixed_coNFIG_1,
1)&INT2slv(fixed_config_2,
1)&int2slv(fixed_CONFIG_3,
1)&inT2SLV(fiXED_CONFIG_4,
1)&INT2SLV(FIXED_CONFIG_5,
1)&INT2SLV(fixed_config_6,
1)&iNT2SLV(fixed_confIG_7,
1)&int2SLV(fixED_CONFIG_8,
1)&int2slv(fixed_config_9,
1)&int2slv(FIXED_config_10,
1)&Int2slv(fixeD_CONFIG_11,
1)&INT2slv(FIXED_CONFIG_12,
1)&int2slv(fixed_conFIG_13,
1)&int2SLV(fixed_config_14,
1)&int2slv(fixed_config_15,
1)&INT2slv(FIXED_config_16,
1)&int2SLV(Fixed_config_17,
1)&inT2SLV(Fixed_config_18,
1)&INT2SLv(fixed_config_19,
1)&int2slv(fixed_config_20,
1)&INT2slv(fixed_confIG_21,
1)&INT2SLV(FIXEd_config_22,
1)&INT2SLV(fixed_coNFIG_23,
1)&int2SLV(FIXED_Config_24,
1)&int2slv(FIXED_CONFIG_25,
1)&INT2slv(fixed_confIG_26,
1)&int2slv(fixed_CONFIG_27,
1)&int2slv(FIXEd_config_28,
1)&INT2SLV(FIXED_config_29,
1)&int2slv(fixed_cONFIG_30,
1)&int2slv(Fixed_config_31,
1));

constant CGPIOI: STD_LOgic_vector(0 to 95) := (Int2slv(IO_INT_TYPE_0,
3)&INT2SLV(IO_INT_TYPE_1,
3)&int2slv(iO_INT_TYPE_2,
3)&int2SLV(IO_INT_type_3,
3)&INT2SLV(io_int_type_4,
3)&inT2SLV(io_int_type_5,
3)&INT2slv(io_INT_TYPE_6,
3)&INT2slv(IO_INT_TYPE_7,
3)&int2sLV(io_INT_TYPE_8,
3)&int2slv(io_int_TYPE_9,
3)&int2slv(Io_int_type_10,
3)&inT2SLV(IO_INT_TYPe_11,
3)&INT2Slv(io_inT_TYPE_12,
3)&int2slv(Io_int_type_13,
3)&int2SLV(io_int_type_14,
3)&INT2SLv(IO_Int_type_15,
3)&int2slv(io_int_type_16,
3)&int2slv(iO_INT_TYPE_17,
3)&INT2slv(io_int_type_18,
3)&INT2SLV(io_int_type_19,
3)&int2slv(io_inT_TYPE_20,
3)&int2slv(IO_INT_TYPE_21,
3)&INT2Slv(IO_INT_type_22,
3)&inT2SLV(Io_int_type_23,
3)&int2slv(io_int_type_24,
3)&INT2SLV(IO_INT_TYPE_25,
3)&INT2SLV(IO_int_type_26,
3)&int2SLV(io_int_type_27,
3)&int2SLV(IO_INT_type_28,
3)&int2slv(io_int_type_29,
3)&iNT2SLV(Io_int_type_30,
3)&INT2SLV(iO_INT_TYPE_31,
3));

constant CGPIOol: std_logic_VECTOR(0 to 63) := (inT2SLV(io_type_0,
2)&int2slv(IO_type_1,
2)&int2slv(io_TYPE_2,
2)&INT2SLV(io_type_3,
2)&INT2slv(IO_type_4,
2)&INT2SLV(IO_TYPE_5,
2)&int2slv(io_type_6,
2)&int2slv(io_type_7,
2)&INt2slv(IO_TYpe_8,
2)&int2slv(io_type_9,
2)&Int2slv(io_type_10,
2)&int2slv(IO_TYPE_11,
2)&INT2SLV(IO_type_12,
2)&iNT2SLV(io_type_13,
2)&int2slv(io_tyPE_14,
2)&INT2Slv(IO_Type_15,
2)&INT2SLv(IO_TYPE_16,
2)&int2slv(io_type_17,
2)&INT2slv(IO_TYPE_18,
2)&int2slv(io_type_19,
2)&int2slv(IO_type_20,
2)&int2slv(io_tyPE_21,
2)&int2slv(IO_TYPE_22,
2)&int2slv(io_type_23,
2)&int2slv(io_type_24,
2)&INT2Slv(io_type_25,
2)&Int2slv(IO_Type_26,
2)&Int2slv(io_typE_27,
2)&inT2SLV(IO_TYPE_28,
2)&int2slv(IO_TYPE_29,
2)&INT2SLV(IO_type_30,
2)&int2SLV(io_type_31,
2));

constant CGPIOll: STD_logic_vector(0 to 31) := (INT2slv(io_val_0,
1)&int2slv(IO_val_1,
1)&int2slV(IO_VAL_2,
1)&INT2slv(io_val_3,
1)&Int2slv(IO_VAL_4,
1)&INT2SLv(iO_VAL_5,
1)&int2SLV(Io_val_6,
1)&int2slv(Io_val_7,
1)&int2slv(IO_val_8,
1)&INT2SLV(IO_val_9,
1)&int2slv(Io_val_10,
1)&int2slv(Io_val_11,
1)&INT2slv(IO_val_12,
1)&int2slv(io_VAL_13,
1)&Int2slv(io_val_14,
1)&INT2SLV(io_vAL_15,
1)&iNT2SLV(IO_val_16,
1)&int2slv(io_val_17,
1)&Int2slv(iO_VAL_18,
1)&INt2slv(Io_val_19,
1)&int2SLV(IO_val_20,
1)&int2slv(IO_val_21,
1)&INT2SLV(io_val_22,
1)&INT2SLV(io_val_23,
1)&INT2SLV(io_VAL_24,
1)&INT2SLV(IO_VAl_25,
1)&INT2SLV(IO_VAL_26,
1)&int2slv(io_val_27,
1)&int2slv(io_val_28,
1)&int2slv(iO_VAL_29,
1)&iNT2SLV(io_val_30,
1)&INt2slv(io_val_31,
1));

type CGPIOIl is array (0 to IO_num-1) of std_lOGIC_VECTOR(7 downto 0);

signal CGPIOOI: CGPIOIl;

signal CGPIOLI: std_logic_vector(APB_WIDTH-1 downto 0);

signal CGPIOii: STD_LOGIC_vector(32-1 downto 0);

signal CGPIOo0: sTD_LOGIC_VECTOr(32-1 downto 0);

signal CGPIOL0: std_logiC_VECTOR(32-1 downto 0);

signal CGPIOi0: STD_LOGIc_vector(IO_NUM-1 downto 0);

signal CGPIOo1: std_LOGIC_VECTOR(io_num-1 downto 0);

signal CGPIOL1: Std_logic_vector(APB_WIdth-1 downto 0);

signal CGPIOI1: std_logic_VECTOR(IO_num-1 downto 0);

signal CGPIOOOL: STd_logic_vector(IO_NUM-1 downto 0);

signal CGPIOlol: std_logIC_VECTOR(Io_num-1 downto 0);

signal CGPIOIOL: STD_LOGIc_vector(iO_NUM-1 downto 0);

signal CGPIOOLL: STD_LOGIC_VEctor(io_num-1 downto 0);

signal CGPIOlll: std_logic_vector(io_nUM-1 downto 0);

signal CGPIOill: std_logic_vECTOR(IO_NUM-1 downto 0);

signal CGPIOoil: STD_logic_vector(io_nUM-1 downto 0);

signal CGPIOLIL: std_LOGIC_VECTOR(IO_NUM-1 downto 0);

signal CGPIOiil: STD_LOGIC_vector(Io_num-1 downto 0);

signal CGPIOO0L: std_logiC_VECTOR(io_nuM-1 downto 0);

signal CGPIOL0l: inteGER;

signal CGPIOi0l: std_loGIC_VECTOR(5 downto 0);

begin
PSlverr <= '0';
pREADY <= '1';
prdata(APB_Width-1 downto 0) <= CGPIOl1(apb_widtH-1 downto 0);
CGPIOo1l:
if (int_bus = 1)
generate
constant CGPIOL1L: std_logic_vector(IO_NUM-1 downto 0) := ( others => '0');
begin
INT_Or <= '0' when (CGPIOIIL = CGPIOl1l) else
'1';
end generate;
CGPIOi1l:
if (inT_BUS = 0)
generate
begin
int_or <= '0';
end generate;
CGPIOOOI:
if (io_num < 32)
generate
begin
CGPIOloi:
for j in IO_num to 31
generate
begin
CGPIOl0(j) <= '0';
CGPIOo0(j) <= '0';
CGPIOII(J) <= '0';
end generate;
end generate;
CGPIOiOI:
for CGPIOOli in 0 to (Io_num-1)
generate
begin
CGPIOILL(CGPIOOLI) <= CGPIOool(CGPIOoli);
CGPIOLIL(CGPIOoli) <= CGPIOlol(CGPIOoli);
CGPIOOIL(CGPIOoli) <= not CGPIOLOL(CGPIOoli);
int(CGPIOOLI) <= CGPIOIIL(CGPIOoli);
gpio_oe <= CGPIOO1;
process (pclk,presetN)
begin
if (presetN = '0') then
CGPIOI1(CGPIOoli) <= '0';
CGPIOool(CGPIOoli) <= '0';
elsif risiNG_EDGE(PCLK) then
CGPIOi1(CGPIOoli) <= gpio_iN(CGPIOoli);
CGPIOool(CGPIOoli) <= CGPIOi1(CGPIOoli);
end if;
end process;
process (PCLK,presetn)
begin
if (presetn = '0') then
CGPIOlol(CGPIOoli) <= '0';
elsif RISING_EDGE(pclk) then
CGPIOlOL(CGPIOoli) <= CGPIOill(CGPIOolI);
end if;
end process;
CGPIOLLI:
if (CGPIOl(CGPIOoli) = '0')
generate
begin
CGPIOo0L(CGPIOoLI) <= CGPIOLIL(CGPIOoli) when (CGPIOoi(CGPIOOLI)(7 downto 5) = "000") else
CGPIOoil(CGPIOOLI) when (CGPIOoI(CGPIOOLi)(7 downto 5) = "001") else
CGPIOIOL(CGPIOoli) when (CGPIOOI(CGPIOOLI)(7 downto 5) = "010") else
CGPIOLLL(CGPIOoli) when (CGPIOoi(CGPIOOLI)(7 downto 5) = "011") else
CGPIOoll(CGPIOolI) when (CGPIOoi(CGPIOOLI)(7 downto 5) = "100") else
'0';
CGPIOiiL(CGPIOolI) <= CGPIOo0l(CGPIOoli) when (CGPIOoi(CGPIOoli)(3) = '1') else
'0';
end generate;
CGPIOILi:
if (CGPIOl(CGPIOOLi) = '1')
generate
begin
CGPIOo0l(CGPIOolI) <= CGPIOlil(CGPIOOLI) when (CGPIOi(3*CGPIOoLI to 3*CGPIOoli+2) = "000") else
CGPIOOIL(CGPIOoli) when (CGPIOI(3*CGPIOoli to 3*CGPIOoli+2) = "001") else
CGPIOiOL(CGPIOOLI) when (CGPIOi(3*CGPIOoli to 3*CGPIOolI+2) = "010") else
CGPIOLLL(CGPIOOLI) when (CGPIOi(3*CGPIOOLI to 3*CGPIOOLI+2) = "011") else
CGPIOoll(CGPIOoli) when (CGPIOi(3*CGPIOoli to 3*CGPIOoli+2) = "100") else
'0';
CGPIOIIL(CGPIOOLI) <= CGPIOo0l(CGPIOOLI) when (CGPIOi(3*CGPIOoli to 3*CGPIOOLI+2) /= "111") else
'0';
end generate;
CGPIOOII:
if (CGPIOL(CGPIOoli) = '0')
generate
begin
CGPIOl0(CGPIOoli) <= CGPIOlol(CGPIOOLI) when (CGPIOoi(CGPIOoli)(1) = '1') else
'0';
end generate;
CGPIOLii:
if (CGPIOl(CGPIOOLI) = '1')
generate
begin
CGPIOL0(CGPIOoLI) <= CGPIOlol(CGPIOOLI) when (CGPIOOL(2*CGPIOOLI to 2*CGPIOoli+1) /= "01") else
'0';
end generate;
CGPIOIII:
if (CGPIOl(CGPIOoli) = '0')
generate
begin
CGPIOI0(CGPIOolI) <= CGPIOO0(CGPIOoli) when (CGPIOoi(CGPIOoLI)(0) = '1') else
'0';
CGPIOo1(CGPIOOLI) <= '1' when ((CGPIOoi(CGPIOOLI)(2) = '1') and (CGPIOOI(CGPIOoli)(0) = '1')) else
'0';
end generate;
CGPIOo0i:
if (CGPIOL(CGPIOOLI) = '1')
generate
begin
CGPIOi0(CGPIOOLI) <= CGPIOO0(CGPIOOLi) when (CGPIOol(2*CGPIOoli to 2*CGPIOoli+1) /= "00") else
'0';
CGPIOo1(CGPIOOLI) <= '1';
end generate;
CGPIOL0I:
if (OE_TYPe = 0)
generate
begin
gpio_out(CGPIOoli) <= CGPIOi0(CGPIOoli);
end generate;
CGPIOi0i:
if (OE_TYPE = 1)
generate
begin
GPIO_OUT(CGPIOoli) <= CGPIOI0(CGPIOOLI) when (CGPIOO1(CGPIOoli) = '1') else
'Z';
end generate;
CGPIOO1I:
if (CGPIOl(CGPIOOLi) = '0')
generate
begin
process (pclK,presETN)
begin
if (presetN = '0') then
CGPIOOI(CGPIOOLI)(7 downto 0) <= ( others => '0');
elsif risiNG_EDGE(PCLK) then
if ((PSel = '1') and (PWRITe = '1')
and (PENABLE = '1')
and (paddr(7 downto 0) = int2SLV(CGPIOoli*4,
8))) then
CGPIOoi(CGPIOoli)(7 downto 0) <= PWDATA(7 downto 0);
else
CGPIOoi(CGPIOOLI)(7 downto 0) <= CGPIOoi(CGPIOOLI)(7 downto 0);
end if;
end if;
end process;
end generate;
CGPIOl1i:
if (CGPIOl(CGPIOoli) = '1')
generate
begin
CGPIOOI(CGPIOOLI)(7 downto 0) <= X"00";
end generate;
CGPIOI1I:
if (APB_WIDth = 32)
generate
begin
process (pclk,presetn)
begin
if (presetn = '0') then
CGPIOioL(CGPIOoli) <= '0';
elsif rising_edge(PCLK) then
if (((CGPIOL(CGPIOoli) = '1') and (CGPIOi((3*CGPIOoli) to (3*CGPIOOLI+2)) = "010")) or ((CGPIOl(CGPIOoli) = '0') and (CGPIOOI(CGPIOoli)(3) = '1'))) then
if ((CGPIOILL(CGPIOoli) = '1') and (not CGPIOLOL(CGPIOoli) = '1')) then
CGPIOiol(CGPIOOLI) <= '1';
elsif ((psel = '1') and (PWRITE = '1')
and (PENAble = '1')
and (paddr(7 downto 0) = X"80")) then
CGPIOIOL(CGPIOoli) <= CGPIOiol(CGPIOoli) and (not PWData(CGPIOoli));
else
CGPIOIOL(CGPIOOLI) <= CGPIOiol(CGPIOoli);
end if;
else
CGPIOIOL(CGPIOOLi) <= '0';
end if;
end if;
end process;
process (pclk,preseTN)
begin
if (PRESETN = '0') then
CGPIOlll(CGPIOoli) <= '0';
elsif rising_edge(pclk) then
if (((CGPIOl(CGPIOOLI) = '1') and (CGPIOI((3*CGPIOOLI) to (3*CGPIOoli+2)) = "011")) or ((CGPIOL(CGPIOOLI) = '0') and (CGPIOoI(CGPIOoli)(3) = '1'))) then
if ((not CGPIOILL(CGPIOOLI) = '1') and (CGPIOlol(CGPIOoli) = '1')) then
CGPIOlll(CGPIOOLI) <= '1';
elsif ((psel = '1') and (pwriTE = '1')
and (penable = '1')
and (paddr(7 downto 0) = X"80")) then
CGPIOLLL(CGPIOoli) <= CGPIOlll(CGPIOoli) and (not PWData(CGPIOoli));
else
CGPIOLLL(CGPIOOLI) <= CGPIOLLL(CGPIOoli);
end if;
else
CGPIOLLL(CGPIOoli) <= '0';
end if;
end if;
end process;
process (PCLK,PRESETN)
begin
if (PRESETN = '0') then
CGPIOoll(CGPIOoli) <= '0';
elsif Rising_edge(pclk) then
if (((CGPIOl(CGPIOoli) = '1') and (CGPIOI((3*CGPIOOLI) to (3*CGPIOoli+2)) = "100")) or ((CGPIOl(CGPIOOLi) = '0') and (CGPIOOI(CGPIOoli)(3) = '1'))) then
if ((CGPIOILl(CGPIOoli) = '1') xor (CGPIOLOL(CGPIOoli) = '1')) then
CGPIOOLL(CGPIOolI) <= '1';
elsif ((psel = '1') and (PWRITE = '1')
and (pENABLE = '1')
and (PADDR(7 downto 0) = X"80")) then
CGPIOOLL(CGPIOOLI) <= CGPIOoll(CGPIOoli) and (not pwdata(CGPIOOLI));
else
CGPIOoll(CGPIOOLI) <= CGPIOOLl(CGPIOolI);
end if;
else
CGPIOoll(CGPIOoli) <= '0';
end if;
end if;
end process;
process (pclk,presetn)
begin
if (presetn = '0') then
CGPIOII(CGPIOOLI) <= '0';
elsif rising_edgE(pclk) then
if ((pSEL = '1') and (PWRITE = '1')
and (penabLE = '1')) then
case (paddr(7 downto 0)) is
when X"80" =>
CGPIOII(CGPIOoli) <= CGPIOii(CGPIOoli) and (not pwdata(CGPIOoli));
when others =>
CGPIOii(CGPIOoli) <= CGPIOiil(CGPIOoLI);
end case;
else
CGPIOii(CGPIOOLI) <= CGPIOiil(CGPIOoli);
end if;
end if;
end process;
process (PCLK,PRESETN)
begin
if (PRESEtn = '0') then
CGPIOO0(CGPIOOLI) <= CGPIOLL(CGPIOOLI);
elsif RISING_EDGe(pclk) then
if ((PSEL = '1') and (PWRIte = '1')
and (penabLE = '1')) then
case (paddr(7 downto 0)) is
when X"a0" =>
CGPIOo0(CGPIOoli) <= pwdata(CGPIOOli);
when others =>
CGPIOo0(CGPIOoli) <= CGPIOo0(CGPIOOLI);
end case;
else
CGPIOo0(CGPIOOLi) <= CGPIOO0(CGPIOoli);
end if;
end if;
end process;
end generate;
CGPIOoo0:
if (Apb_width = 16)
generate
begin
process (PCLK,PRESEtn)
begin
if (PRESEtn = '0') then
CGPIOiol(CGPIOoli) <= '0';
elsif rising_edge(pclk) then
if (((CGPIOL(CGPIOOli) = '1') and (CGPIOi((3*CGPIOoli) to (3*CGPIOoli+2)) = "010")) or ((CGPIOl(CGPIOoli) = '0') and (CGPIOoi(CGPIOOLI)(3) = '1'))) then
if ((CGPIOIll(CGPIOoli) = '1') and (not CGPIOlol(CGPIOoli) = '1')) then
CGPIOiol(CGPIOOLI) <= '1';
elsif ((PSEL = '1') and (PWRITE = '1')
and (pENABLE = '1')
and (PADDR(7 downto 0) = X"80")
and (CGPIOoli < 16)) then
CGPIOIOl(CGPIOOLI) <= CGPIOiol(CGPIOoli) and (not PWDATA(CGPIOoli));
elsif ((psel = '1') and (Pwrite = '1')
and (PENABle = '1')
and (PAddr(7 downto 0) = X"84")
and (CGPIOOLI >= 16)) then
CGPIOIOL(CGPIOoli) <= CGPIOiol(CGPIOoli) and (not PWDATA(CGPIOOLI-16));
else
CGPIOioL(CGPIOoli) <= CGPIOioL(CGPIOOLI);
end if;
else
CGPIOiol(CGPIOoli) <= '0';
end if;
end if;
end process;
process (PClk,PREsetn)
begin
if (presetn = '0') then
CGPIOLLL(CGPIOOLI) <= '0';
elsif rising_edGE(pclk) then
if (((CGPIOL(CGPIOoli) = '1') and (CGPIOi((3*CGPIOoli) to (3*CGPIOoli+2)) = "011")) or ((CGPIOl(CGPIOolI) = '0') and (CGPIOoi(CGPIOoli)(3) = '1'))) then
if ((not CGPIOill(CGPIOoli) = '1') and (CGPIOlOL(CGPIOoli) = '1')) then
CGPIOLLL(CGPIOoli) <= '1';
elsif ((Psel = '1') and (pwriTE = '1')
and (penable = '1')
and (paddr(7 downto 0) = X"80")
and (CGPIOoli < 16)) then
CGPIOlll(CGPIOOLI) <= CGPIOLLL(CGPIOoli) and (not pwdaTA(CGPIOOLI));
elsif ((PSEL = '1') and (PWRITE = '1')
and (PENABLE = '1')
and (PADDR(7 downto 0) = X"84")
and (CGPIOoli >= 16)) then
CGPIOLll(CGPIOOLI) <= CGPIOLLL(CGPIOoli) and (not PWDATA(CGPIOOLI-16));
else
CGPIOLLL(CGPIOOLI) <= CGPIOlll(CGPIOoli);
end if;
else
CGPIOlll(CGPIOoli) <= '0';
end if;
end if;
end process;
process (PCLK,PRESETN)
begin
if (PRESetn = '0') then
CGPIOOLL(CGPIOoli) <= '0';
elsif RISING_EDge(PCLK) then
if (((CGPIOl(CGPIOoli) = '1') and (CGPIOi((3*CGPIOOLi) to (3*CGPIOoli+2)) = "100")) or ((CGPIOl(CGPIOOLI) = '0') and (CGPIOoi(CGPIOoli)(3) = '1'))) then
if ((CGPIOill(CGPIOOLI) = '1') xor (CGPIOLOL(CGPIOoli) = '1')) then
CGPIOoll(CGPIOoLI) <= '1';
elsif ((Psel = '1') and (pwrite = '1')
and (penaBLE = '1')
and (PADDR(7 downto 0) = X"80")
and (CGPIOolI < 16)) then
CGPIOOLL(CGPIOoli) <= CGPIOoll(CGPIOOLI) and (not PWdata(CGPIOOLI));
elsif ((PSEL = '1') and (PWRITE = '1')
and (penable = '1')
and (paddr(7 downto 0) = X"84")
and (CGPIOOli >= 16)) then
CGPIOoll(CGPIOOLI) <= CGPIOoll(CGPIOOLI) and (not PWDATA(CGPIOolI-16));
else
CGPIOOLL(CGPIOoli) <= CGPIOoll(CGPIOoli);
end if;
else
CGPIOOLL(CGPIOOLI) <= '0';
end if;
end if;
end process;
process (pclk,presetn)
begin
if (presetn = '0') then
CGPIOII(CGPIOoli) <= '0';
elsif rising_edge(pclk) then
if ((psel = '1') and (pwrite = '1')
and (PENABLE = '1')
and (PADDR(7 downto 0) = X"80")
and (CGPIOOli < 16)) then
CGPIOii(CGPIOoli) <= CGPIOII(CGPIOoli) and (not PWDATA(CGPIOOLI));
elsif ((psel = '1') and (pwrite = '1')
and (PENABLE = '1')
and (PADDR(7 downto 0) = X"84")
and (CGPIOoli >= 16)) then
CGPIOii(CGPIOoli) <= CGPIOii(CGPIOoli) and (not pwdata(CGPIOOLi-16));
else
CGPIOII(CGPIOOLi) <= CGPIOiIL(CGPIOoli);
end if;
end if;
end process;
process (PCLK,PRESETN)
begin
if (PRESETN = '0') then
CGPIOo0(CGPIOoli) <= CGPIOLL(CGPIOoli);
elsif risING_EDGE(pclk) then
if ((PSEL = '1') and (Pwrite = '1')
and (PENABLE = '1')
and (paddr(7 downto 0) = X"a0")
and (CGPIOOLI < 16)) then
CGPIOO0(CGPIOoli) <= PWDATA(CGPIOoli);
elsif ((psel = '1') and (PWRite = '1')
and (PENABLE = '1')
and (PADDR(7 downto 0) = X"a4")
and (CGPIOOLI >= 16)) then
CGPIOo0(CGPIOOLI) <= pwdata(CGPIOoli-16);
else
CGPIOo0(CGPIOolI) <= CGPIOO0(CGPIOoli);
end if;
end if;
end process;
end generate;
CGPIOLO0:
if (apB_WIDTH = 8)
generate
begin
process (PCLK,PRESETN)
begin
if (pRESETN = '0') then
CGPIOiol(CGPIOOLI) <= '0';
elsif RISING_EDGe(PCLK) then
if (((CGPIOL(CGPIOoli) = '1') and (CGPIOi((3*CGPIOoli) to (3*CGPIOOLI+2)) = "010")) or ((CGPIOl(CGPIOOLi) = '0') and (CGPIOoi(CGPIOOLI)(3) = '1'))) then
if ((CGPIOILL(CGPIOoli) = '1') and (not CGPIOLOL(CGPIOOLI) = '1')) then
CGPIOiol(CGPIOoli) <= '1';
elsif ((pSEL = '1') and (PWRITE = '1')
and (PENABLE = '1')
and (PADdr(7 downto 0) = X"80")
and (CGPIOoli < 8)) then
CGPIOIOL(CGPIOOLI) <= CGPIOIOL(CGPIOOLI) and (not pwdata(CGPIOOLI));
elsif ((PSEL = '1') and (pwRITE = '1')
and (penablE = '1')
and (paddr(7 downto 0) = X"84")
and (CGPIOoli >= 8)
and (CGPIOoli < 16)) then
CGPIOiol(CGPIOOLI) <= CGPIOIol(CGPIOoli) and (not pwdata(CGPIOoli-8));
elsif ((PSEL = '1') and (PWRITE = '1')
and (PENABLE = '1')
and (Paddr(7 downto 0) = X"88")
and (CGPIOOli >= 16)
and (CGPIOOLI < 24)) then
CGPIOIOL(CGPIOoli) <= CGPIOiol(CGPIOOLI) and (not pwdata(CGPIOOLI-16));
elsif ((psel = '1') and (PWrite = '1')
and (PENABLE = '1')
and (PADDR(7 downto 0) = X"8c")
and (CGPIOoli >= 24)) then
CGPIOIol(CGPIOoli) <= CGPIOIOL(CGPIOoli) and (not Pwdata(CGPIOoli-24));
else
CGPIOiol(CGPIOoli) <= CGPIOiol(CGPIOolI);
end if;
else
CGPIOIOl(CGPIOoli) <= '0';
end if;
end if;
end process;
process (PCLK,PRESETN)
begin
if (presetn = '0') then
CGPIOLLL(CGPIOOLI) <= '0';
elsif RISING_EDGE(PCLK) then
if (((CGPIOL(CGPIOoli) = '1') and (CGPIOI((3*CGPIOOli) to (3*CGPIOoli+2)) = "011")) or ((CGPIOL(CGPIOoli) = '0') and (CGPIOoi(CGPIOoli)(3) = '1'))) then
if ((not CGPIOILL(CGPIOOLI) = '1') and (CGPIOLOL(CGPIOOli) = '1')) then
CGPIOllL(CGPIOoli) <= '1';
elsif ((psEL = '1') and (PWRITE = '1')
and (penABLE = '1')
and (PADDR(7 downto 0) = X"80")
and (CGPIOoli < 8)) then
CGPIOLLL(CGPIOOLI) <= CGPIOLLL(CGPIOoli) and (not pwdata(CGPIOoli));
elsif ((psel = '1') and (PWRITE = '1')
and (PENABle = '1')
and (PAddr(7 downto 0) = X"84")
and (CGPIOoli >= 8)
and (CGPIOOLi < 16)) then
CGPIOLLL(CGPIOoli) <= CGPIOlll(CGPIOoli) and (not pwdata(CGPIOOLI-8));
elsif ((pseL = '1') and (pwrite = '1')
and (penable = '1')
and (Paddr(7 downto 0) = X"88")
and (CGPIOOLI >= 16)
and (CGPIOolI < 24)) then
CGPIOlll(CGPIOOLI) <= CGPIOlll(CGPIOOLI) and (not Pwdata(CGPIOOLI-16));
elsif ((PSEL = '1') and (PWRITE = '1')
and (PENABLE = '1')
and (paDDR(7 downto 0) = X"8c")
and (CGPIOoli >= 24)) then
CGPIOLLL(CGPIOoli) <= CGPIOlll(CGPIOOLi) and (not PWdata(CGPIOOLI-24));
else
CGPIOLLL(CGPIOoli) <= CGPIOlLL(CGPIOOLi);
end if;
else
CGPIOlll(CGPIOoli) <= '0';
end if;
end if;
end process;
process (pclk,PREsetn)
begin
if (presetn = '0') then
CGPIOoll(CGPIOoli) <= '0';
elsif RISING_edge(PCLK) then
if (((CGPIOL(CGPIOOLI) = '1') and (CGPIOi((3*CGPIOoli) to (3*CGPIOoLI+2)) = "100")) or ((CGPIOl(CGPIOOli) = '0') and (CGPIOoi(CGPIOoli)(3) = '1'))) then
if ((CGPIOill(CGPIOOLi) = '1') xor (CGPIOloL(CGPIOOLI) = '1')) then
CGPIOoll(CGPIOOLI) <= '1';
elsif ((psel = '1') and (pWRITE = '1')
and (Penable = '1')
and (paddr(7 downto 0) = X"80")
and (CGPIOoli < 8)) then
CGPIOOLL(CGPIOoli) <= CGPIOoll(CGPIOoli) and (not PWDATA(CGPIOoli));
elsif ((Psel = '1') and (PWRITE = '1')
and (PENABLE = '1')
and (PADdr(7 downto 0) = X"84")
and (CGPIOOLI >= 8)
and (CGPIOoli < 16)) then
CGPIOOll(CGPIOOLI) <= CGPIOoll(CGPIOoli) and (not pwDATA(CGPIOoli-8));
elsif ((PSEL = '1') and (pWRITE = '1')
and (PENABLE = '1')
and (PADDr(7 downto 0) = X"88")
and (CGPIOolI >= 16)
and (CGPIOoli < 24)) then
CGPIOoll(CGPIOOLI) <= CGPIOoll(CGPIOoli) and (not Pwdata(CGPIOoli-16));
elsif ((psEL = '1') and (PWRITE = '1')
and (penabLE = '1')
and (paddr(7 downto 0) = X"8c")
and (CGPIOOLI >= 24)) then
CGPIOoLL(CGPIOOLi) <= CGPIOOLL(CGPIOoli) and (not PWData(CGPIOOLI-24));
else
CGPIOOLL(CGPIOoli) <= CGPIOoll(CGPIOoli);
end if;
else
CGPIOOLL(CGPIOOLI) <= '0';
end if;
end if;
end process;
process (PCLK,prESETN)
begin
if (PRESETN = '0') then
CGPIOii(CGPIOOLI) <= '0';
elsif rising_edge(pclk) then
if ((psel = '1') and (Pwrite = '1')
and (penabLE = '1')
and (paddr(7 downto 0) = X"80")
and (CGPIOolI < 8)) then
CGPIOiI(CGPIOOLI) <= CGPIOII(CGPIOOLI) and (not PWDATA(CGPIOOLI));
elsif ((PSel = '1') and (PWRITE = '1')
and (PENABLE = '1')
and (paddr(7 downto 0) = X"84")
and (CGPIOOLI >= 8)
and (CGPIOoli < 16)) then
CGPIOII(CGPIOoli) <= CGPIOii(CGPIOOLI) and (not pwdata(CGPIOOLI-8));
elsif ((PSel = '1') and (PWRITE = '1')
and (penable = '1')
and (PADDR(7 downto 0) = X"88")
and (CGPIOoli >= 16)
and (CGPIOOLI < 24)) then
CGPIOii(CGPIOoli) <= CGPIOii(CGPIOOLI) and (not pwdata(CGPIOOLi-16));
elsif ((Psel = '1') and (PWRITE = '1')
and (penable = '1')
and (paddr(7 downto 0) = X"8c")
and (CGPIOoli >= 24)) then
CGPIOII(CGPIOOLI) <= CGPIOII(CGPIOOLI) and (not pwdaTA(CGPIOOli-24));
else
CGPIOii(CGPIOOLI) <= CGPIOiil(CGPIOOLI);
end if;
end if;
end process;
process (PCLK,prESETN)
begin
if (presetn = '0') then
CGPIOo0(CGPIOOLI) <= CGPIOll(CGPIOOLI);
elsif rising_edge(PCLK) then
if ((psel = '1') and (PWRIte = '1')
and (penable = '1')
and (PADDR(7 downto 0) = X"a0")
and (CGPIOoli < 8)) then
CGPIOo0(CGPIOOLi) <= Pwdata(CGPIOOli);
elsif ((PSel = '1') and (PWRITE = '1')
and (penable = '1')
and (paddr(7 downto 0) = X"a4")
and (CGPIOOLI >= 8)
and (CGPIOoli < 16)) then
CGPIOO0(CGPIOoli) <= PWDATA(CGPIOOLI-8);
elsif ((PSEL = '1') and (pwrite = '1')
and (pENABLE = '1')
and (paddr(7 downto 0) = X"a8")
and (CGPIOOLI >= 16)
and (CGPIOOli < 24)) then
CGPIOo0(CGPIOOLI) <= PWdata(CGPIOOLI-16);
elsif ((PSel = '1') and (PWRITE = '1')
and (penable = '1')
and (PADDR(7 downto 0) = X"ac")
and (CGPIOoli >= 24)) then
CGPIOO0(CGPIOOLi) <= pwdata(CGPIOOli-24);
else
CGPIOo0(CGPIOoli) <= CGPIOo0(CGPIOoli);
end if;
end if;
end process;
end generate;
end generate;
CGPIOI0L(5 downto 0) <= PADDR(7 downto 2);
CGPIOl0l <= sl2int(CGPIOi0l);
process (CGPIOoi,PADDR,CGPIOL0L)
begin
case (CGPIOl0l) is
when 0 to 31 =>
CGPIOli(7 downto 0) <= CGPIOoi(CGPIOl0L)(7 downto 0);
when others =>
CGPIOli(7 downto 0) <= X"00";
end case;
end process;
CGPIOio0:
if (apb_wiDTH = 32)
generate
begin
CGPIOLI(31 downto 8) <= X"000000";
CGPIOL1(31 downto 0) <= CGPIOLI(31 downto 0) when (pADDR(7 downto 0) < X"80") else
CGPIOII(31 downto 0) when (PADDR(7 downto 0) = X"80") else
CGPIOl0(31 downto 0) when (paddr(7 downto 0) = X"90") else
CGPIOo0(31 downto 0) when (PADdr(7 downto 0) = X"a0") else
X"00000000";
end generate;
CGPIOOL0:
if (Apb_width = 16)
generate
begin
CGPIOli(15 downto 8) <= X"00";
CGPIOl1(15 downto 0) <= CGPIOLI(15 downto 0) when (PADDR(7 downto 0) < X"80") else
CGPIOII(15 downto 0) when (Paddr(7 downto 0) = X"80") else
CGPIOIi(31 downto 16) when (paddr(7 downto 0) = X"84") else
CGPIOl0(15 downto 0) when (paddr(7 downto 0) = X"90") else
CGPIOL0(31 downto 16) when (PAddr(7 downto 0) = X"94") else
CGPIOO0(15 downto 0) when (pADDR(7 downto 0) = X"a0") else
CGPIOo0(31 downto 16) when (paddr(7 downto 0) = X"a4") else
X"0000";
end generate;
CGPIOLL0:
if (apB_WIDTH = 8)
generate
begin
CGPIOL1(7 downto 0) <= CGPIOLI(7 downto 0) when (paddr(7 downto 0) < X"80") else
CGPIOii(7 downto 0) when (PADDR(7 downto 0) = X"80") else
CGPIOii(15 downto 8) when (padDR(7 downto 0) = X"84") else
CGPIOII(23 downto 16) when (PADDR(7 downto 0) = X"88") else
CGPIOII(31 downto 24) when (paddr(7 downto 0) = X"8c") else
CGPIOl0(7 downto 0) when (paddr(7 downto 0) = X"90") else
CGPIOl0(15 downto 8) when (PADDR(7 downto 0) = X"94") else
CGPIOl0(23 downto 16) when (paddr(7 downto 0) = X"98") else
CGPIOl0(31 downto 24) when (paddr(7 downto 0) = X"9c") else
CGPIOO0(7 downto 0) when (PADDR(7 downto 0) = X"a0") else
CGPIOO0(15 downto 8) when (PADDR(7 downto 0) = X"a4") else
CGPIOo0(23 downto 16) when (paddr(7 downto 0) = X"a8") else
CGPIOO0(31 downto 24) when (PADdr(7 downto 0) = X"ac") else
X"00";
end generate;
end CGPIOo;
