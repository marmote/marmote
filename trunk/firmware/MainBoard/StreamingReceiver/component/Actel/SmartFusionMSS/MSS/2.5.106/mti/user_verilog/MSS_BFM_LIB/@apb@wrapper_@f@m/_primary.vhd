library verilog;
use verilog.vl_types.all;
entity ApbWrapper_FM is
    port(
        HCLK            : in     vl_logic;
        HRESETN         : in     vl_logic;
        ahbMode         : in     vl_logic;
        apb32           : in     vl_logic;
        lastCycle       : in     vl_logic;
        clientReady     : in     vl_logic;
        clientError     : in     vl_logic;
        dataPhAck       : in     vl_logic;
        pRegReq         : out    vl_logic;
        pRegWrite       : out    vl_logic;
        pFMInvalidXfer  : out    vl_logic;
        wrapperWData    : out    vl_logic_vector(31 downto 0);
        wrapperRData    : in     vl_logic_vector(31 downto 0);
        F_FM_ADDR       : in     vl_logic_vector(31 downto 0);
        APB16_XHOLD     : out    vl_logic_vector(15 downto 0);
        F_FM_WDATA      : in     vl_logic_vector(31 downto 0);
        F_FM_RDATA      : out    vl_logic_vector(31 downto 0);
        F_FM_PSEL       : in     vl_logic;
        F_FM_PENABLE    : in     vl_logic;
        F_FM_PWRITE     : in     vl_logic;
        F_FM_PREADY     : out    vl_logic;
        F_FM_PSLVERR    : out    vl_logic;
        F_FM_HREADYOUT  : in     vl_logic
    );
end ApbWrapper_FM;
