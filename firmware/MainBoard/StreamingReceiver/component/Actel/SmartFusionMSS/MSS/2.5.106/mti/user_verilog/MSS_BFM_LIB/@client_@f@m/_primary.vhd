library verilog;
use verilog.vl_types.all;
entity Client_FM is
    port(
        HCLK            : in     vl_logic;
        HRESETN         : in     vl_logic;
        ahbMode         : in     vl_logic;
        lastCycle       : in     vl_logic;
        DS_FM_HTRANS1   : out    vl_logic;
        DS_FM_HREADY    : in     vl_logic;
        DS_FM_HRESP     : in     vl_logic;
        addrClkEn       : out    vl_logic;
        dataClkEn       : out    vl_logic;
        hRegReq         : in     vl_logic;
        hRegWrite       : in     vl_logic;
        hFMInvalidXfer  : in     vl_logic;
        pRegReq         : in     vl_logic;
        pRegWrite       : in     vl_logic;
        pFMInvalidXfer  : in     vl_logic;
        clientReady     : out    vl_logic;
        clientError     : out    vl_logic;
        dataPhAck       : out    vl_logic
    );
end Client_FM;
