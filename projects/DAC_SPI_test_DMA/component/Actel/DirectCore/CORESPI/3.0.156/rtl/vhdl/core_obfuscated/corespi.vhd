-- (c) Copyright 2005 Actel Corporation
library Ieee;
use IEEe.std_logIC_1164.all;
entity cORESPI is
generic (fAMILY: iNTEGER := 17;
uSE_MASter: INTEGEr := 1;
USE_Slave: INteger := 1); port (PCLK: in STD_logic;
presETN: in STD_LOgic;
M_sck: out std_loGIC;
M_miso: in STD_Logic;
m_moSI: out std_logIC;
m_sS: out STD_LOgic_vecTOR(7 downto 0);
S_sck: in STD_logic;
s_miso: out STD_logic;
S_mosi: in std_lOGIC;
S_Ss: in STD_logic;
ENable_masTER: out STD_Logic;
ENABLE_slave: out Std_logiC;
PWDAta: in STD_logic_VECTOR(7 downto 0);
Prdata: out STd_logic_VECTOR(7 downto 0);
PADDR: in std_loGIC_VEctor(3 downto 0);
penaBLE: in STD_logic;
PSEL: in std_loGIC;
Pwrite: in stD_LOGIc;
InterrupT: out Std_logiC;
Tx_reg_eMPTY: out Std_logic;
RX_data_reADY: out STD_logic);
end cORESPI;

architecture CSPIo of CORESPi is

component CSPIl
generic (USE_Master: INTEGEr := 1;
USE_Slave: Integer := 1);
port (SYSCLK: in std_LOGIC;
nreset: in std_logiC;
M_SCK: out std_LOGIc;
M_MISO: in std_loGIC;
m_MOSI: out STD_logic;
m_ss: out STd_logic_VECTOR(7 downto 0);
s_SCK: in sTD_LOGIc;
S_miso: out STD_logic;
s_MOSI: in STD_logic;
s_ss: in std_LOGIC;
ENABLe_master: out STD_logic;
enable_sLAVE: out Std_logiC;
CSPIi: in STD_logic_vECTOR(7 downto 0);
CSPIOl: out std_logIC_VECTor(7 downto 0);
CSPILL: in STD_logic_vECTOR(1 downto 0);
CSPIIL: in Std_logiC;
Re: in STD_logic;
interruPT: out STd_logic;
tx_reg_EMPTY: out std_logIC;
RX_DATa_ready: out stD_LOGIc);
end component;

signal CSPIOI: std_LOGIC_Vector(7 downto 0);

signal CSPIli: STD_LOGic_vectOR(7 downto 0);

signal CSPIII: STd_logic_VECTOR(1 downto 0);

signal CSPIO0: std_loGIC;

signal CSPIl0: std_loGIC;

begin
CSPIo0 <= PWrite and PSel
and PENAble;
CSPIl0 <= (not pwrite) and PSEL
and PENable;
CSPIoi <= pwdata;
CSPIiI <= PADDr(3 downto 2);
prdata <= CSPIli;
CSPIi0: CSPIl
generic map (uSE_MASter => use_masTER,
USE_Slave => USE_slave)
port map (SYSCLK => pCLK,
nRESET => PRESETN,
m_SCK => m_SCK,
m_misO => m_MISO,
m_mosI => m_MOSI,
M_ss => M_ss,
s_sck => S_sck,
S_MIso => S_Miso,
s_mosi => s_mOSI,
s_ss => s_SS,
enablE_MASTer => ENABLE_master,
Enable_sLAVE => enable_SLAVE,
CSPII => CSPIoI,
CSPIOL => CSPILI,
CSPIll => CSPIii,
CSPIIl => CSPIO0,
RE => CSPIl0,
INterrupt => interruPT,
tx_REG_Empty => Tx_reg_eMPTY,
RX_DATA_ready => rX_DATA_ready);
end CSPIo;
