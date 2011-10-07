library verilog;
use verilog.vl_types.all;
entity FABRICIF_FM is
    port(
        HCLK            : in     vl_logic;
        HRESETN         : in     vl_logic;
        ahbMode         : in     vl_logic;
        apb32           : in     vl_logic;
        lastCycle       : in     vl_logic;
        APB16_XHOLD     : out    vl_logic_vector(15 downto 0);
        DS_FM_HADDR     : out    vl_logic_vector(31 downto 0);
        DS_FM_HMASTLOCK : out    vl_logic;
        DS_FM_HSIZE     : out    vl_logic_vector(1 downto 0);
        DS_FM_HTRANS1   : out    vl_logic;
        DS_FM_HWRITE    : out    vl_logic;
        DS_FM_HWDATA    : out    vl_logic_vector(31 downto 0);
        DS_FM_HRDATA    : in     vl_logic_vector(31 downto 0);
        DS_FM_HREADY    : in     vl_logic;
        DS_FM_HRESP     : in     vl_logic;
        F_FM_ADDR       : in     vl_logic_vector(31 downto 0);
        F_FM_WDATA      : in     vl_logic_vector(31 downto 0);
        F_FM_RDATA      : out    vl_logic_vector(31 downto 0);
        F_FM_HMASTLOCK  : in     vl_logic;
        F_FM_HSIZE      : in     vl_logic_vector(1 downto 0);
        F_FM_HTRANS1    : in     vl_logic;
        F_FM_HWRITE     : in     vl_logic;
        F_FM_HSEL       : in     vl_logic;
        F_FM_HREADY     : in     vl_logic;
        F_FM_HREADYOUT  : out    vl_logic;
        F_FM_HRESP      : out    vl_logic;
        F_FM_PSEL       : in     vl_logic;
        F_FM_PENABLE    : in     vl_logic;
        F_FM_PWRITE     : in     vl_logic;
        F_FM_PREADY     : out    vl_logic;
        F_FM_PSLVERR    : out    vl_logic
    );
end FABRICIF_FM;
