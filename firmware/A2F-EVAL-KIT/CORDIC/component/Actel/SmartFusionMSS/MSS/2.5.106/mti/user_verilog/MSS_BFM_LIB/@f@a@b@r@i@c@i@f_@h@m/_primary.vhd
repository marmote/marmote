library verilog;
use verilog.vl_types.all;
entity FABRICIF_HM is
    port(
        HCLK            : in     vl_logic;
        HRESETN         : in     vl_logic;
        ahbMode         : in     vl_logic;
        apb32           : in     vl_logic;
        lastCycle       : in     vl_logic;
        FPGAGOOD        : in     vl_logic;
        DS_HM_HADDR     : in     vl_logic_vector(19 downto 0);
        DS_HM_HMASTLOCK : in     vl_logic;
        DS_HM_HSIZE     : in     vl_logic_vector(1 downto 0);
        DS_HM_HTRANS1   : in     vl_logic;
        DS_HM_HSEL      : in     vl_logic;
        DS_HM_HWRITE    : in     vl_logic;
        DS_HM_HWDATA    : in     vl_logic_vector(31 downto 0);
        DS_HM_HREADY    : in     vl_logic;
        DS_HM_HREADYOUT : out    vl_logic;
        DS_HM_HRESP     : out    vl_logic;
        DS_HM_HRDATA    : out    vl_logic_vector(31 downto 0);
        F_HM_ADDR       : out    vl_logic_vector(19 downto 0);
        F_HM_WDATA      : out    vl_logic_vector(31 downto 0);
        F_HM_RDATA      : in     vl_logic_vector(31 downto 0);
        F_HM_HMASTLOCK  : out    vl_logic;
        F_HM_HSIZE      : out    vl_logic_vector(1 downto 0);
        F_HM_HTRANS1    : out    vl_logic;
        F_HM_HWRITE     : out    vl_logic;
        F_HM_HREADY     : in     vl_logic;
        F_HM_HRESP      : in     vl_logic;
        F_HM_PSEL       : out    vl_logic;
        F_HM_PENABLE    : out    vl_logic;
        F_HM_PWRITE     : out    vl_logic;
        F_HM_PREADY     : in     vl_logic;
        F_HM_PSLVERR    : in     vl_logic
    );
end FABRICIF_HM;
