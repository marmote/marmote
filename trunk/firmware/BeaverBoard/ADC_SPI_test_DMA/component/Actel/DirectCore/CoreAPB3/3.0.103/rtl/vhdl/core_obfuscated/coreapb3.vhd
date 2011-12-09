-- Actel Corporation Proprietary and Confidential
-- Copyright 2010 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
-- Revision Information:
-- 05Feb10              Production Release Version 3.0
-- SVN Revision Information:
-- SVN $Revision: 12350 $
-- SVN $Date: 2010-02-27 22:46:22 -0800 (Sat, 27 Feb 2010) $
library Ieee;
use IEEE.STD_logic_1164.all;
use iEEE.NUMERIC_std.all;
entity CoreAPB3 is
generic (APB_DWIDTH: INTeger range 8 to 32 := 32;
rANGESIZE: INTeger range 256 to 1048576 := 256;
iaddr_ENABLE: INTEGEr range 0 to 1 := 0;
aPBSLOT0ENAble: integer range 0 to 1 := 1;
APBSLOT1enable: integer range 0 to 1 := 1;
aPBSLOT2ENAble: integer range 0 to 1 := 1;
APBSLOT3enable: integer range 0 to 1 := 1;
aPBSLOT4ENAble: INteger range 0 to 1 := 1;
APBSLOt5enable: integer range 0 to 1 := 1;
apbslot6ENABLE: inTEGER range 0 to 1 := 1;
APBSLOT7enable: INteger range 0 to 1 := 1;
apbslot8enaBLE: integer range 0 to 1 := 1;
APBSlot9enable: integer range 0 to 1 := 1;
apbslot10enABLE: integer range 0 to 1 := 1;
APBSLOT11enable: INTeger range 0 to 1 := 1;
APbslot12enablE: INteger range 0 to 1 := 1;
apbSLOT13ENAble: INTEGER range 0 to 1 := 1;
APBslot14enable: INTEger range 0 to 1 := 1;
aPBSLOT15Enable: INTEGER range 0 to 1 := 1); port (presetn: in std_logIC;
pclk: in STd_logic;
PADDR: in STD_LOGic_vector(23 downto 0);
pwrite: in STD_LOGic;
penABLE: in Std_logic;
psel: in std_logic;
PWDATA: in std_loGIC_VECTOR(31 downto 0);
PRDATA: out stD_LOGIC_VEctor(31 downto 0);
Pready: out STD_LOGIC;
pslverr: out std_logiC;
PADDRS: out STD_LOGIC_vector(23 downto 0);
PADDRS0: out std_lOGIC_VECTOr((((1-IADDR_ENABLE)*24)+((IADDR_ENABLE)*32))-1 downto 0);
pwrites: out STd_logic;
pENABLES: out STD_LOGic;
PWDATAS: out STD_LOGic_vector(31 downto 0);
PSELS0: out std_logIC;
PSELS1: out std_logiC;
PSELS2: out STD_logic;
PSELs3: out std_logic;
psels4: out STD_LOGIC;
psels5: out Std_logic;
psels6: out std_logic;
PSELS7: out Std_logic;
PSEls8: out STD_Logic;
PSELS9: out STd_logic;
psels10: out STd_logic;
PSELS11: out STD_LOGIC;
psels12: out sTD_LOGIC;
psELS13: out std_logic;
PSELS14: out STD_LOGIC;
Psels15: out Std_logic;
PRDATAS0: in STD_LOGIC_vector(31 downto 0);
PRDATAS1: in std_logic_VECTOR(31 downto 0);
PRDATAS2: in Std_logic_vectOR(31 downto 0);
PRDATAS3: in std_logIC_VECTOR(31 downto 0);
PRDATAS4: in STD_LOGIC_vector(31 downto 0);
PRDATAS5: in sTD_LOGIC_Vector(31 downto 0);
PRDATAS6: in std_logic_VECTOR(31 downto 0);
PRDATAS7: in STD_logic_vector(31 downto 0);
PRDATAS8: in STD_LOGic_vector(31 downto 0);
PRDATAS9: in STD_LOGIc_vector(31 downto 0);
PRDATAS10: in stD_LOGIC_VEctor(31 downto 0);
PRDATAS11: in std_lOGIC_VECTOr(31 downto 0);
PRDATAS12: in std_LOGIC_VECTOr(31 downto 0);
PRDATAS13: in Std_logic_vecTOR(31 downto 0);
PRDATAS14: in STD_LOGIC_vector(31 downto 0);
PRDATAS15: in std_loGIC_VECTOR(31 downto 0);
preadys0: in STD_LOGIC;
preadys1: in std_LOGIC;
preadys2: in Std_logic;
preADYS3: in stD_LOGIC;
preadys4: in std_logic;
PREADYs5: in STD_logic;
preadyS6: in std_lOGIC;
PREadys7: in STD_logic;
pREADYS8: in STD_LOgic;
preADYS9: in STD_LOgic;
preadys10: in std_logic;
preaDYS11: in std_LOGIC;
PREADYS12: in std_LOGIC;
PREadys13: in std_logic;
preADYS14: in STD_LOGIC;
PREAdys15: in STD_logic;
pslvERRS0: in STD_LOGIC;
PSLVERrs1: in STD_logic;
pslverrs2: in std_logic;
pslverrS3: in std_logiC;
pSLVERRS4: in stD_LOGIC;
PSLVERRS5: in STD_LOGIC;
PSLVERRS6: in stD_LOGIC;
pslvERRS7: in std_logic;
pslverrs8: in STD_LOgic;
PSLVERRS9: in std_LOGIC;
PSLVERRS10: in std_lOGIC;
pslverRS11: in std_logic;
PSLverrs12: in STD_LOGIC;
PSLVERRS13: in std_logIC;
pslverrs14: in STD_LOGIc;
pSLVERRS15: in std_logic);
end entity CoreAPB3;

architecture CAPB3I0L of COREAPB3 is

function CAPB3o1l(VAL: in Integer)
return integER is
variable v: integer;
variable CAPB3L1L: INteger;
begin
V := val;
CAPB3L1l := 0;
while (v > 1)
loop
v := V/2;
CAPB3l1l := CAPB3l1l+1;
end loop;
return (CAPB3L1L);
end CAPB3O1L;

function CAPB3i1l(CAPB3OOI: in BOOLEAN)
return naturAL is
variable CAPB3loi: Natural range 0 to 1;
begin
if (CAPB3ooI) then
CAPB3loi := 1;
else
CAPB3LOI := 0;
end if;
return CAPB3loi;
end CAPB3i1L;

constant CAPB3ioi: INTEGER := CAPB3O1L(RANGESIZE);

constant CAPB3OLI: INTeger := (CAPB3ioi*CAPB3I1l(RANGESIZE < 65536))+(15*CAPB3I1L(RANGESIZE >= 65536));

constant CAPB3lli: STD_LOGIC_vector(CAPB3IOI-1 downto 0) := STD_logic_vector(TO_Unsigned(12,
CAPB3ioi));

constant CAPB3ILI: STD_LOGic_vector(CAPB3ioi-1 downto 0) := std_logic_VECTOR(TO_unsigned(8,
CAPB3ioi));

constant CAPB3oii: std_logIC_VECTOR(CAPB3ioi-1 downto 0) := STD_Logic_vector(to_UNSIGNED(4,
CAPB3IOi));

constant CAPB3LII: Std_logic_vectoR(CAPB3ioi-1 downto 0) := stD_LOGIC_VECtor(TO_unsigned(0,
CAPB3IOI));

constant CAPB3iii: std_logic_VECTOR(CAPB3IOI-1 downto 0) := std_logic_VECTOR(to_UNSIGNEd(4,
CAPB3ioi));

constant CAPB3o0i: std_logIC_VECTOR(CAPB3ioi-1 downto 0) := stD_LOGIC_VECtor(TO_unsigned(0,
CAPB3ioi));

constant CAPB3l0i: STd_logic_vectoR(CAPB3ioi-1 downto 0) := STD_logic_vector(tO_UNSIGNED(0,
CAPB3ioi));

constant CAPB3I0i: STD_LOGIc_vector(15 downto 0) := std_LOGIC_VECTOr(TO_unsigned((APBSLOT0ENABLE*(2**0)),
16));

constant CAPB3o1i: std_logic_VECTOR(15 downto 0) := std_LOGIC_VECTor(to_unsIGNED((APBSLOT1ENABLE*(2**1)),
16));

constant CAPB3l1i: STd_logic_vectoR(15 downto 0) := sTD_LOGIC_VEctor(TO_UNSIgned((APBSLOT2ENABLE*(2**2)),
16));

constant CAPB3i1i: STD_LOGic_vector(15 downto 0) := std_LOGIC_VECTOr(TO_UNSIGNed((APBSLOT3ENABLE*(2**3)),
16));

constant CAPB3oo0: stD_LOGIC_VECtor(15 downto 0) := std_LOGIC_VECTor(To_unsigned((APBSLOT4ENABLE*(2**4)),
16));

constant CAPB3lo0: sTD_LOGIC_Vector(15 downto 0) := std_logic_veCTOR(TO_UNSIGNEd((APBSLOT5ENABLE*(2**5)),
16));

constant CAPB3IO0: std_lOGIC_VECTOR(15 downto 0) := STD_logic_vector(To_unsigned((APBSLOT6ENABLE*(2**6)),
16));

constant CAPB3ol0: stD_LOGIC_VEctor(15 downto 0) := STD_LOGIc_vector(to_UNSIGNED((APBSLOT7ENABLE*(2**7)),
16));

constant CAPB3LL0: std_lOGIC_VECTOR(15 downto 0) := sTD_LOGIC_VEctor(to_unsigned((APBSLOT8ENABLE*(2**8)),
16));

constant CAPB3IL0: std_logic_vecTOR(15 downto 0) := STD_LOGIC_vector(TO_unsigned((APBSLOT9ENABLE*(2**9)),
16));

constant CAPB3oi0: std_logic_vectOR(15 downto 0) := STD_logic_vector(tO_UNSIGNED((APBSLOT10ENABLE*(2**10)),
16));

constant CAPB3li0: std_logic_veCTOR(15 downto 0) := STD_LOGIC_vector(to_UNSIGNED((APBSLOT11ENABLE*(2**11)),
16));

constant CAPB3II0: STD_LOgic_vector(15 downto 0) := std_logic_veCTOR(to_unsigned((APBSLOT12ENABLE*(2**12)),
16));

constant CAPB3o00: std_logiC_VECTOR(15 downto 0) := STD_Logic_vector(TO_UNSIGned((APBSLOT13ENABLE*(2**13)),
16));

constant CAPB3l00: STd_logic_vectoR(15 downto 0) := std_lOGIC_VECTOR(To_unsigned((APBSLOT14ENABLE*(2**14)),
16));

constant CAPB3I00: sTD_LOGIC_VEctor(15 downto 0) := STD_LOGIc_vector(to_unsIGNED((APBSLOT15ENABLE*(2**15)),
16));

component CAPB3O
port (CAPB3L: in STd_logic_vectoR(15 downto 0);
PRDATAS0: in sTD_LOGIC_VEctor(31 downto 0);
PRDATAS1: in std_logIC_VECTOR(31 downto 0);
PRDATAS2: in sTD_LOGIC_VEctor(31 downto 0);
PRDATAS3: in STD_LOGIC_vector(31 downto 0);
PRDATAS4: in std_logIC_VECTOR(31 downto 0);
PRDATAS5: in std_LOGIC_VECTOR(31 downto 0);
PRDATAS6: in std_logIC_VECTOR(31 downto 0);
PRDATAS7: in std_logIC_VECTOR(31 downto 0);
PRDATAS8: in std_logic_vECTOR(31 downto 0);
PRDATAS9: in STD_LOGIC_vector(31 downto 0);
PRDATAS10: in std_logIC_VECTOR(31 downto 0);
PRDATAS11: in STD_LOGIC_vector(31 downto 0);
PRDATAS12: in sTD_LOGIC_VEctor(31 downto 0);
PRDATAS13: in STD_Logic_vector(31 downto 0);
PRDATAS14: in std_logic_VECTOR(31 downto 0);
PRDATAS15: in STd_logic_vectoR(31 downto 0);
CAPB3I: in STD_LOGIC_vector(15 downto 0);
CAPB3ol: in STd_logic_vectoR(15 downto 0);
PREADY: out std_lOGIC;
PSLVERR: out STD_LOGIC;
PRDATA: out Std_logic_vectOR(31 downto 0));
end component;

signal CAPB3o10: STD_LOGIc_vector(31 downto 0);

signal CAPB3IIL: std_loGIC_VECTOR(31 downto 0);

signal CAPB3l10: std_logic_veCTOR(31 downto 0);

signal CAPB3i10: std_logic_VECTOR(31 downto 0);

signal CAPB3oo1: STD_logic_vector(31 downto 0);

signal CAPB3lo1: std_logic_veCTOR(31 downto 0);

signal CAPB3io1: STD_logic_vector(31 downto 0);

signal CAPB3ol1: STD_logic_vector(31 downto 0);

signal CAPB3ll1: STD_Logic_vector(31 downto 0);

signal CAPB3IL1: std_logIC_VECTOR(31 downto 0);

signal CAPB3oi1: sTD_LOGIC_Vector(31 downto 0);

signal CAPB3LI1: Std_logic_vectOR(31 downto 0);

signal CAPB3ii1: std_loGIC_VECTOR(31 downto 0);

signal CAPB3o01: stD_LOGIC_VEctor(31 downto 0);

signal CAPB3L01: std_logic_vecTOR(31 downto 0);

signal CAPB3i01: sTD_LOGIC_VEctor(31 downto 0);

signal CAPB3o11: std_logic_VECTOR(31 downto 0);

signal CAPB3l11: STD_LOGIC_vector(31 downto 0);

signal CAPB3i11: STD_logic_vector(31 downto 0);

signal CAPB3oOOL: std_logIC_VECTOR(15 downto 0);

signal CAPB3lool: std_logic_VECTOR(15 downto 0);

signal CAPB3iool: STD_LOgic_vector(15 downto 0);

signal CAPB3olol: STD_Logic_vector(3 downto 0);

signal CAPB3lLOL: std_logic_VECTOR(31 downto 0);

signal CAPB3ILOL: std_loGIC;

signal CAPB3oiol: std_logIC;

begin
CAPB3llol <= ( others => '0');
CAPB3ILOL <= '1';
CAPB3oiol <= '0';
PADDRS <= CAPB3O10(23 downto 0);
PADDRS0 <= CAPB3O10((((1-IADDR_ENABLE)*24)+((IADDR_ENABLE)*32))-1 downto 0);
PWRITES <= PWRITE;
PENABLES <= PENABLE;
PWDATAS <= PWDATA;
CAPB3olol <= PADDR((CAPB3ioi+3) downto (CAPB3ioi+0));
CAPB3LIOL:
if (IADDR_ENABLE = 0)
generate
CAPB3o10(31 downto 0) <= (CAPB3Llol(31 downto (CAPB3ioi+4))&PADDR((CAPB3IOI+3) downto 0));
CAPB3i11(31 downto 0) <= CAPB3LLOL(31 downto 0);
end generate;
CAPB3iiOL:
if (not (IADDR_ENABLE = 0))
generate
CAPB3O0OL:
if (IADDR_ENABLE = 1)
generate
signal CAPB3L0OL: STD_logic_vector(31 downto 0);
begin
CAPB3i0ol:
if (APB_DWIDTH = 8)
generate
process (PCLK,PRESETN)
begin
if (PRESETN = '0') then
CAPB3L0OL(31 downto 0) <= ( others => '0');
elsif (PCLK'EVENT and PCLK = '1') then
if (RANGESIZE < 65536) then
if (CAPB3iool(1) = '1' and PWRITE = '1'
and PENABLE = '1'
and PADDR((CAPB3ioi-1) downto 0) = CAPB3oii((CAPB3IOI-1) downto 0)) then
CAPB3l0ol(15 downto CAPB3OLI) <= PWDATA(7 downto (CAPB3oli-8));
end if;
end if;
if (CAPB3iool(1) = '1' and PWRITE = '1'
and PENABLE = '1'
and PADDR((CAPB3ioi-1) downto 0) = CAPB3ili((CAPB3IOI-1) downto 0)) then
CAPB3l0OL(23 downto 16) <= PWDATA(7 downto 0);
end if;
if (CAPB3iool(1) = '1' and PWRITE = '1'
and PENABLE = '1'
and PADDR((CAPB3ioi-1) downto 0) = CAPB3LLI((CAPB3ioi-1) downto 0)) then
CAPB3L0OL(31 downto 24) <= PWDATA(7 downto 0);
end if;
end if;
end process;
CAPB3i11(7 downto 0) <= CAPB3L0OL(7 downto 0) when (PADDR((CAPB3Ioi-1) downto 0) = CAPB3lii((CAPB3Ioi-1) downto 0)) else
CAPB3l0ol(15 downto 8) when (PADDR((CAPB3IOI-1) downto 0) = CAPB3OII((CAPB3ioi-1) downto 0)) else
CAPB3l0OL(23 downto 16) when (PADDR((CAPB3ioi-1) downto 0) = CAPB3ILI((CAPB3IOi-1) downto 0)) else
CAPB3l0ol(31 downto 24) when (PADDR((CAPB3IOI-1) downto 0) = CAPB3Lli((CAPB3ioi-1) downto 0)) else
( others => '0');
end generate;
CAPB3o1ol:
if (not (APB_DWIDTH = 8))
generate
CAPB3L1OL:
if (APB_DWIDTH = 16)
generate
process (PCLK,PRESETN)
begin
if (PRESETN = '0') then
CAPB3L0OL(31 downto 0) <= ( others => '0');
elsif (PCLK'evenT and PCLK = '1') then
if (RANGESIZE < 65536) then
if (CAPB3IOOl(1) = '1' and PWRITE = '1'
and PENABLE = '1'
and PADDR((CAPB3IOI-1) downto 0) = CAPB3O0I((CAPB3ioi-1) downto 0)) then
CAPB3l0ol(15 downto CAPB3olI) <= PWDATA(15 downto CAPB3oli);
end if;
end if;
if (CAPB3iool(1) = '1' and PWRITE = '1'
and PENABLE = '1'
and PADDR((CAPB3IOI-1) downto 0) = CAPB3iii((CAPB3ioi-1) downto 0)) then
CAPB3L0OL(31 downto 16) <= PWDATA(15 downto 0);
end if;
end if;
end process;
CAPB3i11(15 downto 0) <= CAPB3l0ol(15 downto 0) when (PADDR((CAPB3IOI-1) downto 0) = CAPB3O0I((CAPB3ioi-1) downto 0)) else
CAPB3l0ol(31 downto 16) when (PADDR((CAPB3ioi-1) downto 0) = CAPB3iii((CAPB3Ioi-1) downto 0)) else
( others => '0');
end generate;
CAPB3i1ol:
if (not (APB_DWIDTH = 16))
generate
process (PCLK,PRESETN)
begin
if (PRESETN = '0') then
CAPB3L0OL(31 downto 0) <= ( others => '0');
elsif (PCLK'event and PCLK = '1') then
if (CAPB3iool(1) = '1' and PWRITE = '1'
and PENABLE = '1'
and PADDR((CAPB3IOI-1) downto 0) = CAPB3l0i((CAPB3IOI-1) downto 0)) then
CAPB3l0ol(31 downto CAPB3ioi) <= PWDATA(31 downto CAPB3IOi);
end if;
end if;
end process;
CAPB3i11(31 downto 0) <= CAPB3L0ol(31 downto 0) when (PADDR((CAPB3ioi-1) downto 0) = CAPB3L0I((CAPB3ioi-1) downto 0)) else
( others => '0');
end generate;
end generate;
CAPB3o10(31 downto CAPB3ioi) <= CAPB3l0ol(31 downto CAPB3IOI) when (CAPB3IOol(0) = '1') else
(CAPB3LLOl(31 downto CAPB3ioi+4)&PADDR((CAPB3ioi+3) downto (CAPB3IOI+0)));
CAPB3O10((CAPB3Ioi-1) downto 0) <= PADDR((CAPB3Ioi-1) downto 0);
end generate;
end generate;
process (PSEL,CAPB3OLOL)
begin
if (PSEL = '1') then
case CAPB3olol is
when "0000" =>
CAPB3iool <= CAPB3I0I;
when "0001" =>
CAPB3IOol <= CAPB3o1i;
when "0010" =>
CAPB3iool <= CAPB3l1i;
when "0011" =>
CAPB3iool <= CAPB3I1I;
when "0100" =>
CAPB3IOOL <= CAPB3oO0;
when "0101" =>
CAPB3iool <= CAPB3Lo0;
when "0110" =>
CAPB3IOOl <= CAPB3IO0;
when "0111" =>
CAPB3iool <= CAPB3ol0;
when "1000" =>
CAPB3IOOl <= CAPB3ll0;
when "1001" =>
CAPB3iool <= CAPB3IL0;
when "1010" =>
CAPB3IOOL <= CAPB3oi0;
when "1011" =>
CAPB3IOOL <= CAPB3li0;
when "1100" =>
CAPB3IOOL <= CAPB3ii0;
when "1101" =>
CAPB3IOOL <= CAPB3o00;
when "1110" =>
CAPB3IOOL <= CAPB3l00;
when "1111" =>
CAPB3Iool <= CAPB3i00;
when others =>
CAPB3IOOL <= ( others => '0');
end case;
else
CAPB3IOOL <= ( others => '0');
end if;
end process;
CAPB3oolL:
if (APBSLOT0ENABLE = 1)
generate
CAPB3L10(31 downto 0) <= PRDATAS0(31 downto 0);
end generate;
CAPB3LOLL:
if (not (APBSLOT0ENABLE = 1))
generate
CAPB3l10(31 downto 0) <= CAPB3LLOL(31 downto 0);
end generate;
CAPB3IOLL:
if (IADDR_ENABLE = 1)
generate
CAPB3I10(31 downto 0) <= CAPB3i11(31 downto 0);
end generate;
CAPB3olll:
if (not (IADDR_ENABLE = 1))
generate
CAPB3LLLL:
if (APBSLOT1ENABLE = 1)
generate
CAPB3I10(31 downto 0) <= PRDATAS1(31 downto 0);
end generate;
CAPB3illl:
if (not (APBSLOT1ENABLE = 1))
generate
CAPB3I10(31 downto 0) <= CAPB3llol(31 downto 0);
end generate;
end generate;
CAPB3oill:
if (APBSLOT2ENABLE = 1)
generate
CAPB3oo1(31 downto 0) <= PRDATAS2(31 downto 0);
end generate;
CAPB3liLL:
if (not (APBSLOT2ENABLE = 1))
generate
CAPB3oo1(31 downto 0) <= CAPB3llol(31 downto 0);
end generate;
CAPB3IILL:
if (APBSLOT3ENABLE = 1)
generate
CAPB3lo1(31 downto 0) <= PRDATAS3(31 downto 0);
end generate;
CAPB3O0LL:
if (not (APBSLOT3ENABLE = 1))
generate
CAPB3LO1(31 downto 0) <= CAPB3lLOL(31 downto 0);
end generate;
CAPB3l0ll:
if (APBSLOT4ENABLE = 1)
generate
CAPB3io1(31 downto 0) <= PRDATAS4(31 downto 0);
end generate;
CAPB3I0LL:
if (not (APBSLOT4ENABLE = 1))
generate
CAPB3io1(31 downto 0) <= CAPB3llol(31 downto 0);
end generate;
CAPB3o1ll:
if (APBSLOT5ENABLE = 1)
generate
CAPB3ol1(31 downto 0) <= PRDATAS5(31 downto 0);
end generate;
CAPB3L1LL:
if (not (APBSLOT5ENABLE = 1))
generate
CAPB3OL1(31 downto 0) <= CAPB3LLOl(31 downto 0);
end generate;
CAPB3I1ll:
if (APBSLOT6ENABLE = 1)
generate
CAPB3ll1(31 downto 0) <= PRDATAS6(31 downto 0);
end generate;
CAPB3OOIL:
if (not (APBSLOT6ENABLE = 1))
generate
CAPB3LL1(31 downto 0) <= CAPB3LLOL(31 downto 0);
end generate;
CAPB3LOIl:
if (APBSLOT7ENABLE = 1)
generate
CAPB3il1(31 downto 0) <= PRDATAS7(31 downto 0);
end generate;
CAPB3IOIL:
if (not (APBSLOT7ENABLE = 1))
generate
CAPB3il1(31 downto 0) <= CAPB3LLOL(31 downto 0);
end generate;
CAPB3olil:
if (APBSLOT8ENABLE = 1)
generate
CAPB3oi1(31 downto 0) <= PRDATAS8(31 downto 0);
end generate;
CAPB3LLIL:
if (not (APBSLOT8ENABLE = 1))
generate
CAPB3oi1(31 downto 0) <= CAPB3LLOL(31 downto 0);
end generate;
CAPB3ilil:
if (APBSLOT9ENABLE = 1)
generate
CAPB3LI1(31 downto 0) <= PRDATAS9(31 downto 0);
end generate;
CAPB3oiil:
if (not (APBSLOT9ENABLE = 1))
generate
CAPB3LI1(31 downto 0) <= CAPB3lloL(31 downto 0);
end generate;
CAPB3liil:
if (APBSLOT10ENABLE = 1)
generate
CAPB3ii1(31 downto 0) <= PRDATAS10(31 downto 0);
end generate;
CAPB3iiil:
if (not (APBSLOT10ENABLE = 1))
generate
CAPB3II1(31 downto 0) <= CAPB3llol(31 downto 0);
end generate;
CAPB3o0il:
if (APBSLOT11ENABLE = 1)
generate
CAPB3O01(31 downto 0) <= PRDATAS11(31 downto 0);
end generate;
CAPB3l0il:
if (not (APBSLOT11ENABLE = 1))
generate
CAPB3O01(31 downto 0) <= CAPB3llol(31 downto 0);
end generate;
CAPB3i0iL:
if (APBSLOT12ENABLE = 1)
generate
CAPB3L01(31 downto 0) <= PRDATAS12(31 downto 0);
end generate;
CAPB3o1IL:
if (not (APBSLOT12ENABLE = 1))
generate
CAPB3l01(31 downto 0) <= CAPB3llol(31 downto 0);
end generate;
CAPB3L1IL:
if (APBSLOT13ENABLE = 1)
generate
CAPB3i01(31 downto 0) <= PRDATAS13(31 downto 0);
end generate;
CAPB3I1IL:
if (not (APBSLOT13ENABLE = 1))
generate
CAPB3i01(31 downto 0) <= CAPB3llol(31 downto 0);
end generate;
CAPB3oo0l:
if (APBSLOT14ENABLE = 1)
generate
CAPB3o11(31 downto 0) <= PRDATAS14(31 downto 0);
end generate;
CAPB3lo0l:
if (not (APBSLOT14ENABLE = 1))
generate
CAPB3o11(31 downto 0) <= CAPB3llol(31 downto 0);
end generate;
CAPB3IO0L:
if (APBSLOT15ENABLE = 1)
generate
CAPB3L11(31 downto 0) <= PRDATAS15(31 downto 0);
end generate;
CAPB3ol0l:
if (not (APBSLOT15ENABLE = 1))
generate
CAPB3l11(31 downto 0) <= CAPB3llol(31 downto 0);
end generate;
CAPB3ll0L:
if (APBSLOT0ENABLE = 1)
generate
CAPB3OOOL(0) <= PREADYS0;
end generate;
CAPB3iL0L:
if (not (APBSLOT0ENABLE = 1))
generate
CAPB3ooOL(0) <= CAPB3ilol;
end generate;
CAPB3oi0l:
if (IADDR_ENABLE = 1)
generate
CAPB3oool(1) <= CAPB3iLOL;
end generate;
CAPB3li0l:
if (not (IADDR_ENABLE = 1))
generate
CAPB3ii0l:
if (APBSLOT1ENABLE = 1)
generate
CAPB3OOOL(1) <= PREADYS1;
end generate;
CAPB3o00l:
if (not (APBSLOT1ENABLE = 1))
generate
CAPB3OOOL(1) <= CAPB3ilol;
end generate;
end generate;
CAPB3L00l:
if (APBSLOT2ENABLE = 1)
generate
CAPB3ooOL(2) <= PREADYS2;
end generate;
CAPB3i00L:
if (not (APBSLOT2ENABLE = 1))
generate
CAPB3OOOL(2) <= CAPB3ILOl;
end generate;
CAPB3O10L:
if (APBSLOT3ENABLE = 1)
generate
CAPB3oooL(3) <= PREADYS3;
end generate;
CAPB3L10L:
if (not (APBSLOT3ENABLE = 1))
generate
CAPB3oool(3) <= CAPB3ILOl;
end generate;
CAPB3I10L:
if (APBSLOT4ENABLE = 1)
generate
CAPB3oool(4) <= PREADYS4;
end generate;
CAPB3oo1L:
if (not (APBSLOT4ENABLE = 1))
generate
CAPB3OOOL(4) <= CAPB3ilol;
end generate;
CAPB3lo1l:
if (APBSLOT5ENABLE = 1)
generate
CAPB3oool(5) <= PREADYS5;
end generate;
CAPB3io1l:
if (not (APBSLOT5ENABLE = 1))
generate
CAPB3Oool(5) <= CAPB3ilol;
end generate;
CAPB3ol1l:
if (APBSLOT6ENABLE = 1)
generate
CAPB3OOOL(6) <= PREADYS6;
end generate;
CAPB3LL1L:
if (not (APBSLOT6ENABLE = 1))
generate
CAPB3Oool(6) <= CAPB3ilol;
end generate;
CAPB3IL1L:
if (APBSLOT7ENABLE = 1)
generate
CAPB3oool(7) <= PREADYS7;
end generate;
CAPB3oi1l:
if (not (APBSLOT7ENABLE = 1))
generate
CAPB3OOOL(7) <= CAPB3ILOL;
end generate;
CAPB3LI1L:
if (APBSLOT8ENABLE = 1)
generate
CAPB3OOOL(8) <= PREADYS8;
end generate;
CAPB3ii1l:
if (not (APBSLOT8ENABLE = 1))
generate
CAPB3OOol(8) <= CAPB3ilol;
end generate;
CAPB3O01l:
if (APBSLOT9ENABLE = 1)
generate
CAPB3oool(9) <= PREADYS9;
end generate;
CAPB3L01L:
if (not (APBSLOT9ENABLE = 1))
generate
CAPB3oool(9) <= CAPB3ilol;
end generate;
CAPB3I01l:
if (APBSLOT10ENABLE = 1)
generate
CAPB3Oool(10) <= PREADYS10;
end generate;
CAPB3O11L:
if (not (APBSLOT10ENABLE = 1))
generate
CAPB3OOOL(10) <= CAPB3ILOL;
end generate;
CAPB3l11l:
if (APBSLOT11ENABLE = 1)
generate
CAPB3OOOL(11) <= PREADYS11;
end generate;
CAPB3i11l:
if (not (APBSLOT11ENABLE = 1))
generate
CAPB3OOOL(11) <= CAPB3ILOL;
end generate;
CAPB3OOOI:
if (APBSLOT12ENABLE = 1)
generate
CAPB3OOOL(12) <= PREADYS12;
end generate;
CAPB3LOOi:
if (not (APBSLOT12ENABLE = 1))
generate
CAPB3oool(12) <= CAPB3ilol;
end generate;
CAPB3iooi:
if (APBSLOT13ENABLE = 1)
generate
CAPB3oOOL(13) <= PREADYS13;
end generate;
CAPB3olOI:
if (not (APBSLOT13ENABLE = 1))
generate
CAPB3OOOL(13) <= CAPB3ilOL;
end generate;
CAPB3lloi:
if (APBSLOT14ENABLE = 1)
generate
CAPB3oool(14) <= PREADYS14;
end generate;
CAPB3iloi:
if (not (APBSLOT14ENABLE = 1))
generate
CAPB3OOOl(14) <= CAPB3ILOL;
end generate;
CAPB3oioi:
if (APBSLOT15ENABLE = 1)
generate
CAPB3oool(15) <= PREADYS15;
end generate;
CAPB3lioi:
if (not (APBSLOT15ENABLE = 1))
generate
CAPB3oool(15) <= CAPB3ILOL;
end generate;
CAPB3Iioi:
if (APBSLOT0ENABLE = 1)
generate
CAPB3LOOL(0) <= PSLVERRS0;
end generate;
CAPB3O0OI:
if (not (APBSLOT0ENABLE = 1))
generate
CAPB3looL(0) <= CAPB3oiol;
end generate;
CAPB3L0OI:
if (IADDR_ENABLE = 1)
generate
CAPB3lool(1) <= CAPB3oiol;
end generate;
CAPB3i0oi:
if (not (IADDR_ENABLE = 1))
generate
CAPB3o1oi:
if (APBSLOT1ENABLE = 1)
generate
CAPB3lool(1) <= PSLVERRS1;
end generate;
CAPB3l1oi:
if (not (APBSLOT1ENABLE = 1))
generate
CAPB3lool(1) <= CAPB3Oiol;
end generate;
end generate;
CAPB3i1oi:
if (APBSLOT2ENABLE = 1)
generate
CAPB3lool(2) <= PSLVERRS2;
end generate;
CAPB3Ooli:
if (not (APBSLOT2ENABLE = 1))
generate
CAPB3lool(2) <= CAPB3oiOL;
end generate;
CAPB3loli:
if (APBSLOT3ENABLE = 1)
generate
CAPB3lool(3) <= PSLVERRS3;
end generate;
CAPB3ioli:
if (not (APBSLOT3ENABLE = 1))
generate
CAPB3lool(3) <= CAPB3oiOL;
end generate;
CAPB3OLLI:
if (APBSLOT4ENABLE = 1)
generate
CAPB3LOOL(4) <= PSLVERRS4;
end generate;
CAPB3llli:
if (not (APBSLOT4ENABLE = 1))
generate
CAPB3LOOL(4) <= CAPB3oiol;
end generate;
CAPB3ILLI:
if (APBSLOT5ENABLE = 1)
generate
CAPB3lool(5) <= PSLVERRS5;
end generate;
CAPB3OILI:
if (not (APBSLOT5ENABLE = 1))
generate
CAPB3lool(5) <= CAPB3oiol;
end generate;
CAPB3lili:
if (APBSLOT6ENABLE = 1)
generate
CAPB3LOOL(6) <= PSLVERRS6;
end generate;
CAPB3iili:
if (not (APBSLOT6ENABLE = 1))
generate
CAPB3LOOL(6) <= CAPB3oiol;
end generate;
CAPB3o0lI:
if (APBSLOT7ENABLE = 1)
generate
CAPB3lool(7) <= PSLVERRS7;
end generate;
CAPB3l0li:
if (not (APBSLOT7ENABLE = 1))
generate
CAPB3loOL(7) <= CAPB3oiol;
end generate;
CAPB3I0LI:
if (APBSLOT8ENABLE = 1)
generate
CAPB3Lool(8) <= PSLVERRS8;
end generate;
CAPB3o1li:
if (not (APBSLOT8ENABLE = 1))
generate
CAPB3LOOl(8) <= CAPB3OIOL;
end generate;
CAPB3l1li:
if (APBSLOT9ENABLE = 1)
generate
CAPB3Lool(9) <= PSLVERRS9;
end generate;
CAPB3i1li:
if (not (APBSLOT9ENABLE = 1))
generate
CAPB3LOOL(9) <= CAPB3oiol;
end generate;
CAPB3ooii:
if (APBSLOT10ENABLE = 1)
generate
CAPB3lool(10) <= PSLVERRS10;
end generate;
CAPB3LOII:
if (not (APBSLOT10ENABLE = 1))
generate
CAPB3LOOL(10) <= CAPB3oioL;
end generate;
CAPB3IOII:
if (APBSLOT11ENABLE = 1)
generate
CAPB3lOOL(11) <= PSLVERRS11;
end generate;
CAPB3olii:
if (not (APBSLOT11ENABLE = 1))
generate
CAPB3lool(11) <= CAPB3oiol;
end generate;
CAPB3llII:
if (APBSLOT12ENABLE = 1)
generate
CAPB3lool(12) <= PSLVERRS12;
end generate;
CAPB3ilii:
if (not (APBSLOT12ENABLE = 1))
generate
CAPB3LOOL(12) <= CAPB3oiol;
end generate;
CAPB3oiii:
if (APBSLOT13ENABLE = 1)
generate
CAPB3lool(13) <= PSLVERRS13;
end generate;
CAPB3liii:
if (not (APBSLOT13ENABLE = 1))
generate
CAPB3LOOL(13) <= CAPB3oiol;
end generate;
CAPB3iiii:
if (APBSLOT14ENABLE = 1)
generate
CAPB3LOOL(14) <= PSLVERRS14;
end generate;
CAPB3o0ii:
if (not (APBSLOT14ENABLE = 1))
generate
CAPB3lool(14) <= CAPB3OIOL;
end generate;
CAPB3l0ii:
if (APBSLOT15ENABLE = 1)
generate
CAPB3LOOL(15) <= PSLVERRS15;
end generate;
CAPB3i0ii:
if (not (APBSLOT15ENABLE = 1))
generate
CAPB3lool(15) <= CAPB3OIOL;
end generate;
CAPB3O1II: CAPB3o
port map (CAPB3L => CAPB3iool(15 downto 0),
PRDATAS0 => CAPB3l10(31 downto 0),
PRDATAS1 => CAPB3I10(31 downto 0),
PRDATAS2 => CAPB3oo1(31 downto 0),
PRDATAS3 => CAPB3LO1(31 downto 0),
PRDATAS4 => CAPB3IO1(31 downto 0),
PRDATAS5 => CAPB3OL1(31 downto 0),
PRDATAS6 => CAPB3LL1(31 downto 0),
PRDATAS7 => CAPB3il1(31 downto 0),
PRDATAS8 => CAPB3oI1(31 downto 0),
PRDATAS9 => CAPB3li1(31 downto 0),
PRDATAS10 => CAPB3ii1(31 downto 0),
PRDATAS11 => CAPB3o01(31 downto 0),
PRDATAS12 => CAPB3l01(31 downto 0),
PRDATAS13 => CAPB3I01(31 downto 0),
PRDATAS14 => CAPB3O11(31 downto 0),
PRDATAS15 => CAPB3L11(31 downto 0),
CAPB3i => CAPB3oool(15 downto 0),
CAPB3ol => CAPB3Lool(15 downto 0),
PREADY => PREADY,
PSLVERR => PSLVERR,
PRDATA => CAPB3iIL(31 downto 0));
PRDATA(31 downto 0) <= CAPB3IIL(31 downto 0);
PSELS0 <= CAPB3iool(0);
CAPB3L1II:
if (IADDR_ENABLE = 1)
generate
PSELS1 <= '0';
end generate;
CAPB3i1ii:
if (not (IADDR_ENABLE = 1))
generate
PSELS1 <= CAPB3IOOl(1);
end generate;
PSELS2 <= CAPB3iool(2);
PSELS3 <= CAPB3iool(3);
PSELS4 <= CAPB3IOOL(4);
PSELS5 <= CAPB3iool(5);
PSELS6 <= CAPB3iool(6);
PSELS7 <= CAPB3iool(7);
PSELS8 <= CAPB3iooL(8);
PSELS9 <= CAPB3ioOL(9);
PSELS10 <= CAPB3iool(10);
PSELS11 <= CAPB3iool(11);
PSELS12 <= CAPB3iOOL(12);
PSELS13 <= CAPB3IOOL(13);
PSELS14 <= CAPB3iool(14);
PSELS15 <= CAPB3iool(15);
end architecture CAPB3I0l;
