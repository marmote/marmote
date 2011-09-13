library verilog;
use verilog.vl_types.all;
entity DefaultSlaveSM is
    port(
        HCLK            : in     vl_logic;
        HRESETn         : in     vl_logic;
        defSlaveDataSel : in     vl_logic;
        defSlaveDataReady: out    vl_logic;
        HRESP_DEFAULT   : out    vl_logic
    );
end DefaultSlaveSM;
