-- (c) Copyright 2005 Actel Corporation
-- Rev:                 2.1 24Jan05 TFB - Production
library Ieee;
use IEee.std_loGIC_1164.all;
use ieee.stD_LOGic_unsiGNED.all;
entity spi_mastER is
port (SYSclk: in STD_logic;
NReset: in sTD_LOGic;
Enable: in stD_LOGIc;
SCk: out std_LOGIC;
MISO: in STD_logic;
mosi: out Std_logic;
ss: out Std_logic;
CPOl: in Std_logiC;
CPha: in STD_Logic;
CLOcksel: in STD_LOGic_vectOR(2 downto 0);
rx_datA_REG: out Std_logiC_VECTOr(7 downto 0);
rx_daTA_REAdy: out STD_logic;
rX_REG_re: in STd_logic;
tx_DATA_reg: in STD_logic_VECtor(7 downto 0);
tx_rEG_EMPTy: out STD_LOgic;
busy: out std_LOGIC;
TX_REg_we: in STD_Logic;
cleAR_ERRor: in sTD_LOGic;
rx_errOR: out sTD_LOGIc);
end SPi_master;

architecture CSPIo of spi_MASTER is

type CSPIoi0 is (CSPILI0,CSPIiI0,CSPIo00,CSPIL00,CSPII00,d3,D2,D1,d0,CSPIo10,CSPIl10);

signal CSPIi10: CSPIoi0;

signal CSPIoo1: CSPIoi0;

signal CSPILO1: sTD_LOgic;

signal CSPIIO1: sTD_LOGic;

signal CSPIOL1: std_LOGIC;

signal CSPILL1: STD_logic;

signal CSPIil1: Std_logic;

signal CSPIoi1: STD_logic;

signal CSPIioi: STD_Logic;

signal CSPIli1: Std_logic_VECTOR(7 downto 0);

signal CSPIii1: std_loGIC;

signal CSPIo01: sTD_LOGic;

signal CSPIL01: STD_LOgic_vectOR(7 downto 0);

signal CSPIi01: sTD_LOGIc_vectoR(7 downto 0);

signal CSPIo11: sTD_LOgic;

signal CSPIL11: std_LOGIC;

signal CSPII11: Std_logiC;

signal CSPIOOol: std_logiC;

signal CSPIlool: std_loGIC;

signal CSPIIool: STd_logic;

signal CSPIolol: std_loGIC;

signal CSPIllol: std_LOGIC;

signal CSPIILOL: stD_LOGIc;

signal CSPIOIOL: STD_LOgic;

begin
process (syscLK,NRESet)
begin
if nreset = '0' then
CSPIli1 <= ( others => '0');
CSPIlo1 <= '0';
CSPIio1 <= '0';
elsif RIsing_edgE(SYSCLk) then
if enabLE = '1' then
CSPILi1 <= CSPIli1+"00000001";
end if;
case CLocksel is
when "000" =>
CSPILO1 <= CSPILI1(0);
when "001" =>
CSPIlo1 <= CSPIli1(1);
when "010" =>
CSPIlo1 <= CSPILi1(2);
when "011" =>
CSPIlo1 <= CSPILI1(3);
when "100" =>
CSPILO1 <= CSPIli1(4);
when "101" =>
CSPILO1 <= CSPIli1(5);
when "110" =>
CSPIlo1 <= CSPIli1(6);
when "111" =>
CSPIlO1 <= CSPIli1(7);
when others =>
CSPIlo1 <= CSPIli1(0);
end case;
CSPIio1 <= CSPILO1;
end if;
end process;
CSPIoL1 <= CSPIoool and CSPIio1 when CPHA = '1' and cpol = '0' else
CSPIOOOL nand CSPIIO1 when CPHA = '1' and cPOL = '1' else
CSPIoool and (not CSPIIO1) when cpha = '0' and Cpol = '0' else
CSPIoool nand (not CSPIio1);
process (sYSClk,nRESET)
begin
if nreseT = '0' then
CSPIlL1 <= '0';
elsif RISIng_edge(syscLK) then
CSPIlL1 <= CSPIol1;
end if;
end process;
process (sysclk,nRESET)
begin
if NREset = '0' then
CSPIoI1 <= '1';
elsif rising_eDGE(sysclk) then
CSPIOI1 <= CSPIIL1;
end if;
end process;
SCk <= CSPIlL1;
ss <= CSPIOI1;
process (syscLK,NRESet)
begin
if Nreset = '0' then
CSPIi10 <= CSPILI0;
elsif rising_eDGE(SYSClk) then
if enablE = '1' then
CSPIi10 <= CSPIoo1;
else
CSPIi10 <= CSPIli0;
end if;
end if;
end process;
process (CSPIi10,CSPIii1,CSPILO1,CSPIio1)
begin
CSPIo01 <= '0';
CSPIo11 <= '0';
CSPIl11 <= '0';
CSPIil1 <= '1';
CSPIOOOl <= '0';
CSPIlool <= '0';
case CSPII10 is
when CSPIli0 =>
if CSPIii1 = '1' and CSPILO1 = '1'
and CSPIIO1 = '0' then
CSPIo01 <= '1';
CSPIoo1 <= CSPIl10;
else
CSPIoo1 <= CSPIli0;
end if;
when CSPIL10 =>
CSPIl11 <= '1';
if CSPIIO1 = '0' then
CSPIIL1 <= '0';
if CSPIlO1 = '1' then
CSPIoO1 <= CSPIII0;
else
CSPIoO1 <= CSPIL10;
end if;
else
CSPIOO1 <= CSPIl10;
end if;
when CSPIIi0 =>
CSPIIL1 <= '0';
CSPIOOol <= '1';
if CSPILO1 = '1' and CSPIio1 = '0' then
CSPIo11 <= '1';
CSPIoo1 <= CSPIo00;
else
CSPIoo1 <= CSPIii0;
end if;
when CSPIo00 =>
CSPIIL1 <= '0';
CSPIooOL <= '1';
if CSPILO1 = '1' and CSPIio1 = '0' then
CSPIO11 <= '1';
CSPIOO1 <= CSPIl00;
else
CSPIoo1 <= CSPIO00;
end if;
when CSPIl00 =>
CSPIil1 <= '0';
CSPIoooL <= '1';
if CSPILO1 = '1' and CSPIIO1 = '0' then
CSPIO11 <= '1';
CSPIoo1 <= CSPIi00;
else
CSPIoo1 <= CSPIL00;
end if;
when CSPII00 =>
CSPIil1 <= '0';
CSPIOOOL <= '1';
if CSPIlO1 = '1' and CSPIio1 = '0' then
CSPIo11 <= '1';
CSPIoo1 <= d3;
else
CSPIoo1 <= CSPII00;
end if;
when d3 =>
CSPIIL1 <= '0';
CSPIoool <= '1';
if CSPIlo1 = '1' and CSPIio1 = '0' then
CSPIO11 <= '1';
CSPIoo1 <= d2;
else
CSPIOO1 <= D3;
end if;
when D2 =>
CSPIil1 <= '0';
CSPIoool <= '1';
if CSPILo1 = '1' and CSPIIo1 = '0' then
CSPIo11 <= '1';
CSPIOo1 <= d1;
else
CSPIoo1 <= D2;
end if;
when D1 =>
CSPIil1 <= '0';
CSPIoool <= '1';
if CSPIlo1 = '1' and CSPIio1 = '0' then
CSPIO11 <= '1';
CSPIOo1 <= D0;
else
CSPIoo1 <= D1;
end if;
when d0 =>
CSPIil1 <= '0';
CSPIoool <= '1';
if CSPILO1 = '1' and CSPIio1 = '0' then
CSPIo11 <= '1';
CSPIOO1 <= CSPIo10;
else
CSPIOO1 <= d0;
end if;
when CSPIo10 =>
if CSPIio1 = '1' then
CSPIIL1 <= '0';
CSPIoo1 <= CSPIo10;
else
CSPILOOL <= '1';
CSPIil1 <= '1';
if CSPIII1 = '1' and CSPIlo1 = '1' then
CSPIo01 <= '1';
CSPIoO1 <= CSPIL10;
else
CSPIOO1 <= CSPIli0;
end if;
end if;
end case;
end process;
process (CSPIIL1,CSPIol1,CSPILL1,CPOL,cPHA)
begin
if CSPIIl1 = '0' then
if (Cpol xor Cpha) = '0' then
CSPIllol <= CSPIOL1 and (not CSPILL1);
else
CSPILLOL <= (not CSPIol1) and CSPIll1;
end if;
else
CSPILLol <= '0';
end if;
end process;
process (SYsclk,NRESEt)
begin
if nrESET = '0' then
CSPIilol <= '0';
elsif riSING_EDge(SYSCLK) then
CSPIilol <= CSPILLOl;
end if;
end process;
CSPIoiol <= CSPIilol when (cLOCKSEL = "000") else
CSPIllOL;
process (sYSCLK,NRESET)
begin
if nreset = '0' then
CSPIi01 <= ( others => '0');
elsif RISIng_edge(sysclk) then
if CSPIOIOL = '1' then
CSPIi01(0) <= miSO;
CSPIi01(7 downto 1) <= CSPII01(6 downto 0);
end if;
end if;
end process;
process (sysCLK,NRESet)
begin
if nresET = '0' then
CSPIl01 <= ( others => '0');
mosi <= '0';
elsif rising_eDGE(sysCLK) then
if CSPIL11 = '1' then
CSPIL01 <= tx_data_REG;
elsif CSPIo11 = '1' then
CSPIL01(7 downto 1) <= CSPIL01(6 downto 0);
end if;
mOSI <= CSPIL01(7);
end if;
end process;
process (sysclk,NRESET)
begin
if NRESET = '0' then
RX_data_reG <= ( others => '0');
elsif rising_eDGE(sysclk) then
if ENABLE = '1' then
if CSPIlooL = '1' then
rx_data_REG <= CSPII01;
end if;
end if;
end if;
end process;
process (SYSCLk,Nreset)
begin
if NRESet = '0' then
CSPIoloL <= '0';
CSPIIOol <= '0';
elsif risinG_EDGE(sysclk) then
if rx_reG_RE = '1' then
CSPIOLOL <= '0';
elsif cLEAR_Error = '1' then
CSPIIOol <= '0';
elsif CSPIlool = '1' then
if CSPIolol = '1' then
CSPIIOol <= '1';
else
CSPIolol <= '1';
end if;
end if;
end if;
end process;
RX_error <= CSPIiool;
rx_DATA_ready <= CSPIolol;
process (SYSClk,NREset)
begin
if Nreset = '0' then
CSPIII1 <= '0';
CSPIIOi <= '1';
CSPIi11 <= '0';
elsif RISING_edge(sysclk) then
if tx_rEG_WE = '1' then
CSPIii1 <= '1';
CSPIIOi <= '0';
elsif CSPIo01 = '1' then
CSPIii1 <= '0';
elsif CSPIL11 = '0' and CSPIi11 = '1' then
CSPIioi <= '1';
end if;
CSPIi11 <= CSPIl11;
end if;
end process;
tx_REG_Empty <= CSPIiOI;
busy <= '1' when CSPIoi1 = '0' or (not CSPIioi) = '1'
or CSPII10 /= CSPILI0 else
'0';
end CSPIo;
