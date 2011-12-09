-- (c) Copyright 2005 Actel Corporation
-- Rev:                 2.1 24Jan05 TFB - Production
library Ieee;
use IEEe.std_lOGIC_1164.all;
use ieeE.STd_logic_UNSIGNEd.all;
entity SPI_Slave is
port (sysclk: in Std_logIC;
Nreset: in Std_logiC;
ENable: in STD_logic;
scK: in std_logiC;
MIso: out stD_LOGic;
MOSI: in sTD_LOGIc;
ss: in std_LOGIc;
Cpol: in STD_logic;
CPHA: in Std_logiC;
rx_dATA_REg: out std_logIC_VECtor(7 downto 0);
RX_DATa_ready: out std_logiC;
RX_reg_re: in std_lOGIC;
Tx_data_REG: in std_logIC_VECtor(7 downto 0);
TX_reg_we: in std_logIC;
tx_rEG_EMPty: out stD_LOGIc;
cleaR_ERROR: in Std_logiC;
RX_error: out std_lOGIC);
end spi_slAVE;

architecture CSPIO of spi_slavE is

signal CSPILO1: STD_logic;

signal CSPIio1: STD_LOgic;

signal CSPIlIOL: Std_logic;

signal CSPIIIOl: std_logIC;

signal CSPIil1: std_lOGIC;

signal CSPIo0ol: sTD_LOgic;

signal CSPIl0oL: STD_LOgic;

signal CSPII0OL: STD_logic_vECTOR(7 downto 0);

signal CSPIO1ol: std_logiC;

signal CSPIOLOL: STD_LOgic;

signal CSPIIOol: Std_logic;

signal COUnt: Std_logic_VECTOr(3 downto 0);

signal CSPIL1ol: STD_logic;

begin
process (sySCLK,nreseT)
begin
if NReset = '0' then
CSPIlo1 <= '0';
CSPIIO1 <= '0';
CSPIlIOL <= '0';
CSPIIIOL <= '0';
CSPIil1 <= '1';
CSPIo0ol <= '1';
elsif Rising_EDGE(sysclk) then
if eNABLE = '1' then
CSPIiioL <= mosi;
CSPIO0ol <= ss;
if cpol = '0' and Cpha = '0' then
CSPIlo1 <= sCK;
elsif CPOL = '0' and CPHA = '1' then
CSPILo1 <= not sck;
elsif cPOL = '1' and cPHA = '0' then
CSPILO1 <= not sCK;
else
CSPIlo1 <= sck;
end if;
CSPIio1 <= CSPIlo1;
CSPILIOL <= CSPIiiol;
CSPIIL1 <= CSPIo0ol;
else
CSPIO0ol <= '1';
end if;
end if;
end process;
process (Sysclk,NReset)
begin
if NRESET = '0' then
CSPII0ol <= ( others => '0');
CSPIl1ol <= '0';
elsif Rising_edGE(sysclk) then
if CSPIil1 = '1' then
CSPII0ol <= tX_DATA_reg;
elsif CSPIlo1 = '1' and CSPIio1 = '0' then
CSPII0OL(0) <= CSPIliol;
CSPIi0ol(7 downto 1) <= CSPIi0OL(6 downto 0);
end if;
if CSPIlo1 = '1' and CSPIiO1 = '0'
and CSPIIl1 = '0' then
CSPIL1OL <= '1';
else
CSPIL1ol <= '0';
end if;
end if;
end process;
mISO <= CSPII0Ol(7);
process (sysCLK,NRESET)
begin
if NRESet = '0' then
COUNT <= "0000";
elsif RISing_edgE(Sysclk) then
if CSPIil1 = '1' or count = "1000" then
count <= "0000";
elsif CSPIl1ol = '1' then
counT <= COUNT+"0001";
end if;
end if;
end process;
CSPIo1OL <= count(3) and (not Count(2))
and (not couNT(1))
and (not count(0));
process (syscLK,NRESET)
begin
if nreSET = '0' then
TX_REg_empty <= '1';
CSPIl0ol <= '0';
elsif risinG_Edge(SYSclk) then
if CSPIiL1 = '0' and CSPIl0ol = '1' then
tx_REG_EMpty <= '1';
elsif tX_REG_we = '1' then
Tx_reg_eMPTY <= '0';
end if;
CSPIl0ol <= CSPIil1;
end if;
end process;
rx_DATA_Ready <= CSPIoloL;
process (sYSCLK,NREset)
begin
if nrESET = '0' then
CSPIOLOL <= '0';
CSPIIool <= '0';
elsif RISING_edge(sysclk) then
if Clear_eRROR = '1' then
CSPIOLOL <= '0';
CSPIIOol <= '0';
elsif CSPIO1ol = '1' then
if CSPIoloL = '1' then
CSPIiooL <= '1';
end if;
CSPIOLol <= '1';
elsif rx_reg_RE = '1' then
CSPIOLOL <= '0';
end if;
end if;
end process;
Rx_error <= CSPIiool;
process (sysclK,NRESET)
begin
if NReset = '0' then
RX_data_REG <= "00000000";
elsif Rising_edGE(SYSCLK) then
if Enable = '1' then
if CSPIo1oL = '1' then
rx_DATA_Reg <= CSPII0OL;
end if;
end if;
end if;
end process;
end CSPIO;
