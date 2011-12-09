library verilog;
use verilog.vl_types.all;
entity MSS_SYSREG is
    generic(
        DEBUG           : integer := 1;
        INITFILE        : string  := ""
    );
    port(
        EM_CONFIG0      : out    vl_logic_vector(31 downto 0);
        EM_CONFIG1      : out    vl_logic_vector(31 downto 0);
        COM_ESRAMFWREMAP: out    vl_logic;
        COM_ENVMREMAPSIZE: out    vl_logic_vector(4 downto 0);
        COM_ENVMREMAPBASE: out    vl_logic_vector(19 downto 0);
        COM_ENVMFABREMAPBASE: out    vl_logic_vector(19 downto 0);
        COM_PROTREGIONSIZE: out    vl_logic_vector(4 downto 0);
        COM_PROTREGIONBASE: out    vl_logic_vector(31 downto 0);
        COM_MASTERENABLE: out    vl_logic_vector(2 downto 0);
        COM_CLEARSTATUS : out    vl_logic_vector(4 downto 0);
        COM_WEIGHTEDMODE: out    vl_logic;
        COM_ERRORSTATUS : in     vl_logic_vector(4 downto 0);
        COM_ERRORINTERRUPT: in     vl_logic;
        F2_LARGE_CT_XS  : out    vl_logic;
        FAB_AHBIF       : out    vl_logic;
        FAB_APB32       : out    vl_logic;
        GLBDIVISOR      : out    vl_logic_vector(1 downto 0);
        FAB_AHB_BYPASS  : out    vl_logic;
        APB16_XHOLD     : in     vl_logic_vector(15 downto 0);
        CALIBSTART      : out    vl_logic;
        CALIBFAIL       : in     vl_logic;
        APB_SOFTRESETS  : out    vl_logic_vector(10 downto 0);
        ACE_SOFTRESET   : out    vl_logic;
        ESRAM0_SOFTRESET: out    vl_logic;
        ESRAM1_SOFTRESET: out    vl_logic;
        ENVM_SOFTRESET  : out    vl_logic;
        EMC_SOFTRESET   : out    vl_logic;
        FPGA_SOFTRESET  : out    vl_logic;
        USERRESETACTIVE : out    vl_logic;
        PADRESETENABLE  : out    vl_logic;
        HCLK            : in     vl_logic;
        HRESETN         : in     vl_logic;
        HSEL            : in     vl_logic;
        HWRITE          : in     vl_logic;
        HADDR           : in     vl_logic_vector(11 downto 0);
        HWDATA          : in     vl_logic_vector(31 downto 0);
        HRDATA          : out    vl_logic_vector(31 downto 0);
        HREADYIN        : in     vl_logic;
        HREADYOUT       : out    vl_logic;
        HTRANS          : in     vl_logic_vector(1 downto 0);
        HSIZE           : in     vl_logic_vector(2 downto 0);
        HBURST          : in     vl_logic_vector(2 downto 0);
        HMASTLOCK       : in     vl_logic;
        HPROT           : in     vl_logic_vector(3 downto 0);
        HRESP           : out    vl_logic
    );
end MSS_SYSREG;
