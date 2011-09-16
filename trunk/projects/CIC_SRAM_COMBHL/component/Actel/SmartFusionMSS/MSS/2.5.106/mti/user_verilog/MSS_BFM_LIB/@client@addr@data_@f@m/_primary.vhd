library verilog;
use verilog.vl_types.all;
entity ClientAddrData_FM is
    port(
        HCLK            : in     vl_logic;
        HRESETN         : in     vl_logic;
        ahbMode         : in     vl_logic;
        hRegWrite       : in     vl_logic;
        hRegSize        : in     vl_logic_vector(1 downto 0);
        hRegMastLock    : in     vl_logic;
        regAddr         : in     vl_logic_vector(31 downto 0);
        F_FM_ADDR       : in     vl_logic_vector(31 downto 0);
        pRegWrite       : in     vl_logic;
        wrapperWData    : in     vl_logic_vector(31 downto 0);
        wrapperRData    : out    vl_logic_vector(31 downto 0);
        addrClkEn       : in     vl_logic;
        dataClkEn       : in     vl_logic;
        DS_FM_HADDR     : out    vl_logic_vector(31 downto 0);
        DS_FM_HMASTLOCK : out    vl_logic;
        DS_FM_HSIZE     : out    vl_logic_vector(1 downto 0);
        DS_FM_HWRITE    : out    vl_logic;
        DS_FM_HWDATA    : out    vl_logic_vector(31 downto 0);
        DS_FM_HRDATA    : in     vl_logic_vector(31 downto 0)
    );
end ClientAddrData_FM;
