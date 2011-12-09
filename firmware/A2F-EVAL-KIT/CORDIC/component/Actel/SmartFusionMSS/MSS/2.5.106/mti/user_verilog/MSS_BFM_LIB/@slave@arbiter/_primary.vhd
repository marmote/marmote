library verilog;
use verilog.vl_types.all;
entity SlaveArbiter is
    port(
        HCLK            : in     vl_logic;
        HRESETn         : in     vl_logic;
        mAddrSel        : in     vl_logic_vector(4 downto 0);
        addrPhEnd       : in     vl_logic;
        m1GatedHMASTLOCK: in     vl_logic;
        m2GatedHMASTLOCK: in     vl_logic;
        COM_WEIGHTEDMODE: in     vl_logic;
        masterAddrInProg: out    vl_logic_vector(4 downto 0)
    );
end SlaveArbiter;
