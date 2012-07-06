library verilog;
use verilog.vl_types.all;
entity AhbWrapper_HM is
    port(
        HCLK            : in     vl_logic;
        HRESETN         : in     vl_logic;
        ahbMode         : in     vl_logic;
        apb32           : in     vl_logic;
        FPGAGOOD        : in     vl_logic;
        DS_HM_HWRITE    : in     vl_logic;
        DS_HM_HSIZE     : in     vl_logic_vector(1 downto 0);
        DS_HM_HMASTLOCK : in     vl_logic;
        DS_HM_HTRANS1   : in     vl_logic;
        DS_HM_HREADY    : in     vl_logic;
        DS_HM_HSEL      : in     vl_logic;
        DS_HM_HADDR     : in     vl_logic_vector(19 downto 0);
        DS_HM_HRESP     : out    vl_logic;
        DS_HM_HREADYOUT : out    vl_logic;
        hAddrPhAck      : in     vl_logic;
        hDataPhAck      : in     vl_logic;
        hError          : in     vl_logic;
        pAddrPhAck      : in     vl_logic;
        pDataPhAck      : in     vl_logic;
        pError          : in     vl_logic;
        regReq          : out    vl_logic;
        mergedReq       : out    vl_logic;
        regWrite        : out    vl_logic;
        mergedWrite     : out    vl_logic;
        mergedHsize     : out    vl_logic_vector(1 downto 0);
        regAddr         : out    vl_logic_vector(19 downto 0);
        mergedAddr      : out    vl_logic_vector(19 downto 0);
        mergedHmastlock : out    vl_logic;
        invalidXfer     : out    vl_logic
    );
end AhbWrapper_HM;
