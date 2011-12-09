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
library ieEE;
use ieee.STD_LOGic_1164.all;
use ieeE.nUMERIC_STD.all;
entity CAPB3o is
port (CAPB3L: in std_loGIC_VECTOR(15 downto 0);
PRDATAS0: in STD_Logic_vector(31 downto 0);
PRDATAS1: in STD_Logic_vector(31 downto 0);
PRDATAS2: in STD_LOGIC_vector(31 downto 0);
PRDATAS3: in STD_Logic_vector(31 downto 0);
PRDATAS4: in std_LOGIC_VECTor(31 downto 0);
PRDATAS5: in STD_Logic_vector(31 downto 0);
PRDATAS6: in std_LOGIC_VECTOr(31 downto 0);
PRDATAS7: in STD_LOGIC_vector(31 downto 0);
PRDATAS8: in std_logiC_VECTOR(31 downto 0);
PRDATAS9: in std_logic_veCTOR(31 downto 0);
PRDATAS10: in STd_logic_vectoR(31 downto 0);
PRDATAS11: in STD_logic_vectoR(31 downto 0);
PRDATAS12: in STD_LOGIC_vector(31 downto 0);
PRDATAS13: in STD_LOGic_vector(31 downto 0);
PRDATAS14: in std_logic_vECTOR(31 downto 0);
PRDATAS15: in std_logic_VECTOR(31 downto 0);
CAPB3i: in std_logic_vecTOR(15 downto 0);
CAPB3oL: in STD_logic_vector(15 downto 0);
PREADY: out STD_LOGic;
PSLVERR: out std_logiC;
PRDATA: out std_logic_VECTOR(31 downto 0));
end entity CAPB3O;

architecture CAPB3ll of CAPB3O is

constant CAPB3il: STD_logic_vector(3 downto 0) := "0000";

constant CAPB3OI: std_logic_vECTOR(3 downto 0) := "0001";

constant CAPB3li: STD_LOGIC_vector(3 downto 0) := "0010";

constant CAPB3II: STD_logic_vector(3 downto 0) := "0011";

constant CAPB3o0: STD_LOGIC_vector(3 downto 0) := "0100";

constant CAPB3L0: STD_LOGIc_vector(3 downto 0) := "0101";

constant CAPB3i0: std_logic_veCTOR(3 downto 0) := "0110";

constant CAPB3o1: STd_logic_vectOR(3 downto 0) := "0111";

constant CAPB3L1: STD_LOGIC_vector(3 downto 0) := "1000";

constant CAPB3i1: STD_logic_vectoR(3 downto 0) := "1001";

constant CAPB3OOL: sTD_LOGIC_Vector(3 downto 0) := "1010";

constant CAPB3LOl: STD_LOGIC_Vector(3 downto 0) := "1011";

constant CAPB3IOL: std_LOGIC_VECtor(3 downto 0) := "1100";

constant CAPB3OLL: std_logic_vecTOR(3 downto 0) := "1101";

constant CAPB3LLL: Std_logic_vecTOR(3 downto 0) := "1110";

constant CAPB3Ill: std_logIC_VECTOR(3 downto 0) := "1111";

signal CAPB3oil: Std_logic;

signal CAPB3lil: STD_logic;

signal CAPB3iiL: std_LOGIC_VECtor(31 downto 0);

signal CAPB3O0L: sTD_LOGIC_Vector(3 downto 0);

signal CAPB3L0L: stD_LOGIC_VEctor(31 downto 0);

begin
CAPB3L0l <= ( others => '0');
CAPB3o0L(3) <= CAPB3l(15) or CAPB3L(14)
or CAPB3L(13)
or CAPB3l(12)
or CAPB3l(11)
or CAPB3L(10)
or CAPB3L(9)
or CAPB3l(8);
CAPB3O0L(2) <= CAPB3l(15) or CAPB3l(14)
or CAPB3L(13)
or CAPB3l(12)
or CAPB3l(7)
or CAPB3l(6)
or CAPB3L(5)
or CAPB3l(4);
CAPB3o0l(1) <= CAPB3l(15) or CAPB3L(14)
or CAPB3L(11)
or CAPB3L(10)
or CAPB3l(7)
or CAPB3l(6)
or CAPB3l(3)
or CAPB3L(2);
CAPB3o0l(0) <= CAPB3L(15) or CAPB3L(13)
or CAPB3l(11)
or CAPB3l(9)
or CAPB3l(7)
or CAPB3l(5)
or CAPB3l(3)
or CAPB3l(1);
process (CAPB3o0l,CAPB3L,PRDATAS0,CAPB3l0L,PRDATAS1,PRDATAS2,PRDATAS3,PRDATAS4,PRDATAS5,PRDATAS6,PRDATAS7,PRDATAS8,PRDATAS9,PRDATAS10,PRDATAS11,PRDATAS12,PRDATAS13,PRDATAS14,PRDATAS15)
begin
case CAPB3O0L is
when CAPB3il =>
if ((CAPB3l(0)) = '1') then
CAPB3iil(31 downto 0) <= PRDATAS0(31 downto 0);
else
CAPB3Iil(31 downto 0) <= CAPB3L0l(31 downto 0);
end if;
when CAPB3oi =>
CAPB3iil(31 downto 0) <= PRDATAS1(31 downto 0);
when CAPB3LI =>
CAPB3IIL(31 downto 0) <= PRDATAS2(31 downto 0);
when CAPB3II =>
CAPB3iil(31 downto 0) <= PRDATAS3(31 downto 0);
when CAPB3o0 =>
CAPB3IIL(31 downto 0) <= PRDATAS4(31 downto 0);
when CAPB3l0 =>
CAPB3iil(31 downto 0) <= PRDATAS5(31 downto 0);
when CAPB3i0 =>
CAPB3IIL(31 downto 0) <= PRDATAS6(31 downto 0);
when CAPB3O1 =>
CAPB3iil(31 downto 0) <= PRDATAS7(31 downto 0);
when CAPB3l1 =>
CAPB3Iil(31 downto 0) <= PRDATAS8(31 downto 0);
when CAPB3i1 =>
CAPB3iil(31 downto 0) <= PRDATAS9(31 downto 0);
when CAPB3OOL =>
CAPB3iil(31 downto 0) <= PRDATAS10(31 downto 0);
when CAPB3LOL =>
CAPB3IIL(31 downto 0) <= PRDATAS11(31 downto 0);
when CAPB3ioL =>
CAPB3IIL(31 downto 0) <= PRDATAS12(31 downto 0);
when CAPB3oll =>
CAPB3IIL(31 downto 0) <= PRDATAS13(31 downto 0);
when CAPB3lll =>
CAPB3iil(31 downto 0) <= PRDATAS14(31 downto 0);
when CAPB3ill =>
CAPB3IIL(31 downto 0) <= PRDATAS15(31 downto 0);
when others =>
CAPB3iil(31 downto 0) <= CAPB3L0L(31 downto 0);
end case;
end process;
process (CAPB3o0L,CAPB3l,CAPB3I)
begin
case CAPB3O0L is
when CAPB3il =>
if ((CAPB3L(0)) = '1') then
CAPB3oil <= CAPB3I(0);
else
CAPB3OIL <= '1';
end if;
when CAPB3OI =>
CAPB3oil <= CAPB3i(1);
when CAPB3li =>
CAPB3OIL <= CAPB3I(2);
when CAPB3ii =>
CAPB3oil <= CAPB3i(3);
when CAPB3o0 =>
CAPB3oil <= CAPB3i(4);
when CAPB3l0 =>
CAPB3oil <= CAPB3I(5);
when CAPB3I0 =>
CAPB3OIL <= CAPB3i(6);
when CAPB3O1 =>
CAPB3OIl <= CAPB3I(7);
when CAPB3l1 =>
CAPB3OIL <= CAPB3i(8);
when CAPB3i1 =>
CAPB3oil <= CAPB3I(9);
when CAPB3ooL =>
CAPB3oil <= CAPB3I(10);
when CAPB3lol =>
CAPB3Oil <= CAPB3i(11);
when CAPB3ioL =>
CAPB3oil <= CAPB3i(12);
when CAPB3OLL =>
CAPB3OIL <= CAPB3i(13);
when CAPB3LLL =>
CAPB3oil <= CAPB3i(14);
when CAPB3ILL =>
CAPB3oIL <= CAPB3I(15);
when others =>
CAPB3oil <= '1';
end case;
end process;
process (CAPB3o0l,CAPB3L,CAPB3ol)
begin
case CAPB3o0l is
when CAPB3il =>
if ((CAPB3l(0)) = '1') then
CAPB3liL <= CAPB3OL(0);
else
CAPB3LIL <= '0';
end if;
when CAPB3oi =>
CAPB3LIL <= CAPB3ol(1);
when CAPB3Li =>
CAPB3lil <= CAPB3ol(2);
when CAPB3II =>
CAPB3Lil <= CAPB3ol(3);
when CAPB3o0 =>
CAPB3lil <= CAPB3ol(4);
when CAPB3L0 =>
CAPB3lil <= CAPB3ol(5);
when CAPB3i0 =>
CAPB3lil <= CAPB3ol(6);
when CAPB3O1 =>
CAPB3lil <= CAPB3OL(7);
when CAPB3L1 =>
CAPB3LIL <= CAPB3ol(8);
when CAPB3i1 =>
CAPB3LIL <= CAPB3ol(9);
when CAPB3ool =>
CAPB3LIL <= CAPB3ol(10);
when CAPB3lol =>
CAPB3lil <= CAPB3OL(11);
when CAPB3iol =>
CAPB3lil <= CAPB3ol(12);
when CAPB3OLL =>
CAPB3LIL <= CAPB3OL(13);
when CAPB3lll =>
CAPB3LIL <= CAPB3OL(14);
when CAPB3ILL =>
CAPB3liL <= CAPB3OL(15);
when others =>
CAPB3LIL <= '0';
end case;
end process;
PREADY <= CAPB3oil;
PSLVERR <= CAPB3lil;
PRDATA <= CAPB3iil(31 downto 0);
end architecture CAPB3LL;
