-- (c) Copyright 2005 Actel Corporation
-- Rev:                 2.1 24Jan05 TFB - Production
library Ieee;
use ieee.std_logic_1164.all;
entity CSPIL is
generic (USE_masteR: IntegeR := 1;
Use_slaVE: inteGER := 1); port (SysCLK: in Std_lOGIC;
Nreset: in std_logic;
m_sck: out std_LOGic;
M_miso: in STd_logic;
m_mosi: out Std_logiC;
m_sS: out stD_logic_VECTor(7 downto 0);
s_sck: in sTD_logiC;
s_MIso: out Std_logiC;
S_MOSI: in STD_logic;
S_Ss: in Std_logic;
enabLE_MASter: out Std_logic;
enable_SLAVE: out STD_logic;
CSPII: in STD_LOgic_vecTOR(7 downto 0);
CSPIol: out stD_LOGIC_vector(7 downto 0);
CSPIll: in STD_logic_vECTOR(1 downto 0);
CSPIil: in STD_logic;
rE: in STD_Logic;
interruPT: out std_loGIC;
tX_REG_Empty: out Std_logic;
RX_data_rEADY: out std_loGIC);
end CSPIL;

architecture CSPIo of CSPIl is

component SPI_master
port (sySCLK: in Std_logic;
NRESet: in STD_logic;
enABLE: in std_loGIC;
SCK: out sTD_Logic;
MISO: in std_LOGIC;
MOsi: out std_loGIC;
ss: out sTD_LOGic;
CPol: in STD_logic;
cphA: in STD_LOgic;
CLOCKSel: in STD_logic_VECTOR(2 downto 0);
RX_Data_reg: out sTD_LOGic_vectOR(7 downto 0);
Rx_data_READY: out std_logiC;
rx_reg_RE: in STd_logic;
TX_data_reG: in STD_logic_vECTOR(7 downto 0);
TX_Reg_emptY: out std_loGIC;
busy: out STD_logic;
tx_reg_WE: in STd_logic;
CLEAR_error: in STD_logic;
rx_erROR: out std_logiC);
end component;

component sPI_SLave
port (sysclk: in STD_logic;
nreset: in stD_LOGIc;
ENABle: in STd_logic;
SCK: in STD_Logic;
miso: out Std_logiC;
mosi: in STD_logic;
SS: in STD_Logic;
CPol: in STD_logic;
CPHA: in std_LOGIC;
RX_data_reG: out std_LOGIC_vector(7 downto 0);
Rx_data_rEADY: out std_lOGIC;
rx_REG_Re: in std_logIC;
Tx_data_rEG: in std_logIC_VECtor(7 downto 0);
TX_REG_we: in STD_logic;
tx_reg_EMPTY: out sTD_LOGIc;
cleAR_ERROr: in stD_LOGIC;
rx_erroR: out STd_logic);
end component;

signal CPOL: STD_Logic;

signal Cpha: STD_logic;

signal CSPIo1: std_lOGIC;

signal CSPIl1: STD_LOgic;

signal CSPIi1: STd_logic;

signal CSPIOOL: STd_logic_VECTOR(7 downto 0);

signal CSPIlol: std_LOGIC_vector(7 downto 0);

signal CSPIiol: std_LOGIC;

signal CSPIOll: STD_LOgic;

signal CSPIlll: STD_logic;

signal TX_reg_we: std_lOGIC;

signal RX_reg_re: STD_logic;

signal CSPIill: Std_logic;

signal CSPIOil: Std_logIC_VECtor(2 downto 0);

signal CSPIlil: std_LOGIC;

signal CSPIIil: std_logiC;

signal CSPIo0l: sTD_logic;

signal CSPIl0l: STD_logic_vECTOR(7 downto 0);

signal CSPIi0l: STD_logic_VECTOR(7 downto 0);

signal CSPIo1L: STD_logic_vECTOR(7 downto 0);

signal CSPIl1l: STD_Logic_veCTOR(7 downto 0);

signal CSPIi1L: std_LOGIC;

signal CSPIooI: Std_logiC;

signal CSPIloi: STd_logic;

signal tx_daTA_REG: std_logiC_VECTor(7 downto 0);

signal CSPIioi: std_logIC;

signal CSPIoli: std_loGIC;

signal CSPILLI: STD_logic;

signal CSPIILI: STD_logic;

signal CLEar_error: STD_LOGic;

signal CSPIOii: Std_logic;

signal CSPILII: std_logIC;

signal rx_erroR: STD_logic;

signal CSPIiii: std_loGIC;

signal CSPIO0I: STD_LOgic;

signal CSPIl0I: Std_logic_VECTOr(7 downto 0);

signal CSPII0i: STD_Logic;

begin
ENABle_masteR <= CSPIiii;
ENABLE_slave <= CSPIO0i;
TX_Reg_emptY <= CSPIIOI;
rx_data_READY <= CSPIOOI;
Tx_reg_we <= '1' when CSPIIL = '1' and CSPILL = "00" else
'0';
rx_reg_RE <= '1' when RE = '1' and CSPIll = "00" else
'0';
CSPIo1 <= '1' when CSPIIL = '1' and CSPIll = "01" else
'0';
CSPIl1 <= '1' when RE = '1' and CSPILL = "01" else
'0';
CSPII1 <= '1' when CSPIIL = '1' and CSPIll = "10" else
'0';
CSPIiol <= '1' when Re = '1' and CSPILl = "10" else
'0';
CSPIOll <= '1' when CSPIil = '1' and CSPIll = "11" else
'0';
CSPIlll <= '1' when Re = '1' and CSPIll = "11" else
'0';
process (syscLK,nreseT)
begin
if NRESEt = '0' then
CSPIOOl <= ( others => '0');
elsif Rising_EDGE(sysclk) then
if CSPIo1 = '1' then
CSPIool <= CSPIi;
end if;
end if;
end process;
CSPIoil(0) <= CSPIOOL(0);
CSPIoil(1) <= CSPIOOL(1);
CSPIOIL(2) <= CSPIool(2);
CPol <= CSPIOOL(3);
cPHA <= CSPIooL(4);
CSPIlil <= CSPIool(5);
CSPIo1I:
if use_Master = 1 and use_sLAVE = 1
generate
CSPIIIL <= CSPIOol(6);
end generate;
CSPIl1i:
if USE_master = 1 and USE_slave = 0
generate
CSPIiil <= '1';
end generate;
CSPII1I:
if Use_masTER = 0 and USE_slave = 1
generate
CSPIiIL <= '0';
end generate;
CSPIo0l <= CSPIoOL(7);
process (Sysclk,NRESET)
begin
if Nreset = '0' then
CLEAR_errOR <= '0';
CSPIIll <= '0';
elsif rising_EDGE(SYSclk) then
if CSPIi1 = '1' then
cLEAR_Error <= CSPIi(0);
CSPIill <= CSPII(7);
elsif cleaR_ERROr = '1' then
CLEar_error <= '0';
end if;
end if;
end process;
CSPIol <= CSPIl0l when Rx_reg_RE = '1' and CSPIlil = '0' else
CSPIl1l when rx_reg_RE = '1' and CSPILIl = '1' else
CSPIOOL when CSPIl1 = '1' else
CSPIlol when CSPIiol = '1' else
CSPIL0I when CSPIlll = '1' else
( others => '0');
CSPIl0l <= CSPII0l when CSPIIII = '1' else
CSPIO1L;
CSPIlol(0) <= rX_ERROR;
CSPIlol(1) <= CSPIooi;
CSPIlOL(2) <= CSPIioi;
CSPIlol(3) <= CSPIili when CSPIiil = '1' else
'0';
CSPIlol(6 downto 4) <= "000";
CSPIlol(7) <= CSPIilL;
RX_ERROr <= CSPIoii or CSPILii;
CSPIl1l(0) <= CSPIL0L(7);
CSPIL1l(1) <= CSPIl0l(6);
CSPIL1L(2) <= CSPIL0L(5);
CSPIL1l(3) <= CSPIl0l(4);
CSPIl1l(4) <= CSPIL0L(3);
CSPIl1l(5) <= CSPIl0L(2);
CSPIL1L(6) <= CSPIL0L(1);
CSPIL1L(7) <= CSPIL0L(0);
process (SYsclk,NREset)
begin
if NRESET = '0' then
tx_daTA_REG <= ( others => '0');
elsif risiNG_EDge(sysclk) then
if TX_Reg_we = '1' then
if CSPILIL = '0' then
TX_Data_reg <= CSPII;
else
TX_data_reg(0) <= CSPIi(7);
TX_data_reG(1) <= CSPIi(6);
TX_data_reG(2) <= CSPIi(5);
TX_data_reG(3) <= CSPIi(4);
TX_data_rEG(4) <= CSPIi(3);
TX_DATa_reg(5) <= CSPII(2);
TX_data_reG(6) <= CSPII(1);
tx_data_REG(7) <= CSPIi(0);
end if;
end if;
end if;
end process;
InterrupT <= CSPIill and (CSPIO0l and (CSPIIOI or CSPIOOi));
CSPIIOi <= CSPIOLI when CSPIiii = '1' else
CSPILli when CSPIO0I = '1' else
'0';
CSPIOOI <= CSPIi1l when CSPIiii = '1' else
CSPIloi when CSPIo0i = '1' else
'0';
CSPIOO0:
if USE_Master = 1
generate
process (sYSCLK,NReset)
begin
if nreSEt = '0' then
CSPIl0i <= ( others => '0');
elsif Rising_EDGE(SYSCLk) then
if CSPIoll = '1' then
CSPIl0i <= CSPIi;
end if;
end if;
end process;
CSPILo0: SPI_Master
port map (SYsclk => SYsclk,
NREset => nresET,
ENAble => CSPIiii,
SCK => m_scK,
MISO => m_miso,
mosi => m_mosi,
SS => CSPIi0i,
cpOL => CPOL,
Cpha => cpha,
CLOCksel => CSPIOIL,
rx_dATA_REG => CSPIi0l,
rx_DAta_reaDY => CSPIi1l,
rx_reg_RE => rx_Reg_re,
TX_data_rEG => TX_Data_reg,
Tx_reg_EMPTy => CSPIOLI,
Busy => CSPIili,
TX_reg_wE => tx_rEG_we,
clEAR_error => Clear_eRROR,
RX_Error => CSPIoii);
m_sS(0) <= CSPIi0i or (not CSPIl0i(0));
m_ss(1) <= CSPII0I or (not CSPIL0i(1));
M_SS(2) <= CSPIi0i or (not CSPIl0i(2));
M_ss(3) <= CSPIi0i or (not CSPIl0i(3));
M_Ss(4) <= CSPII0i or (not CSPIL0I(4));
M_ss(5) <= CSPIi0i or (not CSPIL0i(5));
m_sS(6) <= CSPIi0i or (not CSPIl0i(6));
M_SS(7) <= CSPIi0i or (not CSPIL0I(7));
end generate;
CSPIIO0:
if USE_Master = 0
generate
CSPIL0I <= "00000000";
m_sck <= '0';
m_MOSI <= '0';
CSPIi0i <= '0';
CSPII0l <= "00000000";
CSPII1l <= '0';
CSPIoli <= '0';
CSPIili <= '0';
CSPIOII <= '0';
m_SS <= "11111111";
end generate;
CSPIIII <= CSPIILL and CSPIIIL;
CSPIol0:
if use_slAVE = 1
generate
CSPIll0: spi_sLAVE
port map (SYSclk => sYSCLK,
nreSET => NRESET,
eNABLE => CSPIO0i,
sck => s_sck,
Miso => S_miso,
MOSI => s_MOSI,
ss => S_SS,
cpol => cpoL,
CPHA => CPHA,
Rx_data_REG => CSPIO1l,
rx_datA_READy => CSPIloi,
RX_REg_re => Rx_reg_rE,
TX_DATa_reg => tx_dATA_REG,
TX_REg_we => TX_REG_we,
tx_reg_EMPTY => CSPILli,
CLEAR_error => CLEar_error,
rx_erroR => CSPILIi);
end generate;
CSPIIL0:
if USe_slave = 0
generate
s_MISO <= '0';
CSPIo1L <= "00000000";
CSPILOI <= '0';
CSPIlli <= '0';
CSPILII <= '0';
end generate;
CSPIo0i <= CSPIilL and (not CSPIIIL);
end CSPIo;
