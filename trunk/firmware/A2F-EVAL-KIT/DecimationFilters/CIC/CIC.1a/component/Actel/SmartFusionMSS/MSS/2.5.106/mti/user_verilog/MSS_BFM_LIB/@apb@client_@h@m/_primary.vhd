library verilog;
use verilog.vl_types.all;
entity ApbClient_HM is
    port(
        HCLK            : in     vl_logic;
        HRESETN         : in     vl_logic;
        ahbMode         : in     vl_logic;
        lastCycle       : in     vl_logic;
        pError          : out    vl_logic;
        pAddrPhAck      : out    vl_logic;
        pDataPhAck      : out    vl_logic;
        mergedReq       : in     vl_logic;
        mergedWrite     : in     vl_logic;
        invalidXfer     : in     vl_logic;
        pDataClkEn      : out    vl_logic;
        F_HM_PSEL       : out    vl_logic;
        F_HM_PENABLE    : out    vl_logic;
        F_HM_PREADY     : in     vl_logic;
        F_HM_PSLVERR    : in     vl_logic
    );
end ApbClient_HM;
