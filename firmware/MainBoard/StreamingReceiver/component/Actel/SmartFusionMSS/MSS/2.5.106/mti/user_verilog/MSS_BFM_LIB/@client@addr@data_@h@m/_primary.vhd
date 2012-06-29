library verilog;
use verilog.vl_types.all;
entity ClientAddrData_HM is
    port(
        HCLK            : in     vl_logic;
        HRESETN         : in     vl_logic;
        ahbMode         : in     vl_logic;
        mergedWrite     : in     vl_logic;
        mergedHsize     : in     vl_logic_vector(1 downto 0);
        mergedHmastlock : in     vl_logic;
        mergedAddr      : in     vl_logic_vector(19 downto 0);
        regAddr         : in     vl_logic_vector(19 downto 0);
        regWrite        : in     vl_logic;
        hAddrPhAck      : in     vl_logic;
        hDataClkEn      : in     vl_logic;
        pAddrPhAck      : in     vl_logic;
        pDataClkEn      : in     vl_logic;
        F_HM_HMASTLOCK  : out    vl_logic;
        F_HM_HWRITE     : out    vl_logic;
        F_HM_HSIZE      : out    vl_logic_vector(1 downto 0);
        F_HM_PWRITE     : out    vl_logic;
        F_HM_ADDR       : out    vl_logic_vector(19 downto 0);
        F_HM_WDATA      : out    vl_logic_vector(31 downto 0);
        F_HM_RDATA      : in     vl_logic_vector(31 downto 0);
        DS_HM_HRDATA    : out    vl_logic_vector(31 downto 0);
        DS_HM_HWDATA    : in     vl_logic_vector(31 downto 0)
    );
end ClientAddrData_HM;
