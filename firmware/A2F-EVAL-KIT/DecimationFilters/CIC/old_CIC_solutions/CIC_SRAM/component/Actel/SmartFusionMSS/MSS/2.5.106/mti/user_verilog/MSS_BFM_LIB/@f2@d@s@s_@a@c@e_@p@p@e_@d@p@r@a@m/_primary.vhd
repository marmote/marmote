library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_PPE_DPRAM is
    port(
        CLKA            : in     vl_logic;
        CSBA            : in     vl_logic;
        RWBA            : in     vl_logic;
        AA              : in     vl_logic_vector(8 downto 0);
        DIA             : in     vl_logic_vector(31 downto 0);
        DOA             : out    vl_logic_vector(31 downto 0);
        CLKB            : in     vl_logic;
        CSBB            : in     vl_logic;
        RWBB            : in     vl_logic;
        AB              : in     vl_logic_vector(8 downto 0);
        DIB             : in     vl_logic_vector(31 downto 0);
        DOB             : out    vl_logic_vector(31 downto 0);
        TEST_MODE       : in     vl_logic;
        RB_TEST         : in     vl_logic;
        RB_CSBA         : in     vl_logic;
        RB_CSBB         : in     vl_logic;
        RB_RWBA         : in     vl_logic;
        RB_RWBB         : in     vl_logic;
        RB_ADA          : in     vl_logic_vector(8 downto 0);
        RB_ADB          : in     vl_logic_vector(8 downto 0);
        RB_WDA          : in     vl_logic_vector(31 downto 0);
        RB_WDB          : in     vl_logic_vector(31 downto 0);
        RB_RDA          : out    vl_logic_vector(31 downto 0);
        RB_RDB          : out    vl_logic_vector(31 downto 0)
    );
end F2DSS_ACE_PPE_DPRAM;
