library verilog;
use verilog.vl_types.all;
entity AhbWrapper_FM is
    port(
        HCLK            : in     vl_logic;
        HRESETN         : in     vl_logic;
        ahbMode         : in     vl_logic;
        lastCycle       : in     vl_logic;
        hRegReq         : out    vl_logic;
        hFMInvalidXfer  : out    vl_logic;
        clientReady     : in     vl_logic;
        clientError     : in     vl_logic;
        dataPhAck       : in     vl_logic;
        hRegSize        : out    vl_logic_vector(1 downto 0);
        hRegMastLock    : out    vl_logic;
        hRegWrite       : out    vl_logic;
        regAddr         : out    vl_logic_vector(31 downto 0);
        F_FM_ADDR       : in     vl_logic_vector(31 downto 0);
        F_FM_HMASTLOCK  : in     vl_logic;
        F_FM_HSIZE      : in     vl_logic_vector(1 downto 0);
        F_FM_HTRANS1    : in     vl_logic;
        F_FM_HWRITE     : in     vl_logic;
        F_FM_HSEL       : in     vl_logic;
        F_FM_HREADY     : in     vl_logic;
        F_FM_HREADYOUT  : out    vl_logic;
        F_FM_HRESP      : out    vl_logic
    );
end AhbWrapper_FM;
