library verilog;
use verilog.vl_types.all;
entity mss_clockgen is
    generic(
        CLKDIVISORS     : vl_logic_vector(7 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        SYSCLK          : in     vl_logic;
        F2MRESETN       : in     vl_logic;
        MSSRESETN       : in     vl_logic;
        ESRAM0_SOFTRESET: in     vl_logic;
        ESRAM1_SOFTRESET: in     vl_logic;
        ENVM_SOFTRESET  : in     vl_logic;
        EMC_SOFTRESET   : in     vl_logic;
        ACE_SOFTRESET   : in     vl_logic;
        FPGA_SOFTRESET  : in     vl_logic;
        USERRESETACTIVE : in     vl_logic;
        PADRESETENABLE  : in     vl_logic;
        M3_HCLK         : out    vl_logic;
        PER0_PCLK       : out    vl_logic;
        PER1_PCLK       : out    vl_logic;
        ACE_PCLK        : out    vl_logic;
        ACE_HCLK        : out    vl_logic;
        M3_HRESETN      : out    vl_logic;
        FIC_HRESETN     : out    vl_logic;
        ESRAM0_HRESETN  : out    vl_logic;
        ESRAM1_HRESETN  : out    vl_logic;
        ENVM_HRESETN    : out    vl_logic;
        EMC_HRESETN     : out    vl_logic;
        ACE_PRESETN     : out    vl_logic;
        PER0_PRESETN    : out    vl_logic;
        PER1_PRESETN    : out    vl_logic;
        CORERESETN      : out    vl_logic;
        PER0_DIV        : out    vl_logic_vector(1 downto 0);
        PER1_DIV        : out    vl_logic_vector(1 downto 0);
        ACEPCLK_DIV     : out    vl_logic_vector(1 downto 0)
    );
    attribute CLKDIVISORS_mti_vect_attrib : integer;
    attribute CLKDIVISORS_mti_vect_attrib of CLKDIVISORS : constant is 0;
end mss_clockgen;
