library verilog;
use verilog.vl_types.all;
entity AhbClient_HM is
    port(
        HCLK            : in     vl_logic;
        HRESETN         : in     vl_logic;
        ahbMode         : in     vl_logic;
        lastCycle       : in     vl_logic;
        hError          : out    vl_logic;
        hAddrPhAck      : out    vl_logic;
        hDataPhAck      : out    vl_logic;
        mergedReq       : in     vl_logic;
        invalidXfer     : in     vl_logic;
        hDataClkEn      : out    vl_logic;
        F_HM_HTRANS1    : out    vl_logic;
        F_HM_HREADY     : in     vl_logic;
        F_HM_HRESP      : in     vl_logic
    );
end AhbClient_HM;
