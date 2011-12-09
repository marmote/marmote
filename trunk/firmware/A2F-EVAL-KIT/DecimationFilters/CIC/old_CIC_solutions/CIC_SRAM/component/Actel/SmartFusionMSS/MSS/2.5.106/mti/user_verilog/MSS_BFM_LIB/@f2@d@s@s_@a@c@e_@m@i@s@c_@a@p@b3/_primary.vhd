library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_MISC_APB3 is
    port(
        PRESETN         : in     vl_logic;
        PRDATA_SSE      : in     vl_logic_vector(15 downto 0);
        PRDATA_PPE      : in     vl_logic_vector(31 downto 0);
        PRDATA_MISC     : in     vl_logic_vector(31 downto 0);
        PREADY_SSE      : in     vl_logic;
        PREADY_PPE      : in     vl_logic;
        PREADY_MISC     : in     vl_logic;
        PSEL_SSE        : out    vl_logic;
        PSEL_PPE        : out    vl_logic;
        PSEL_MISC       : out    vl_logic;
        PADDR           : in     vl_logic_vector(12 downto 0);
        PSEL            : in     vl_logic;
        PRDATA          : out    vl_logic_vector(31 downto 0);
        PREADY          : out    vl_logic;
        PSLVERR         : out    vl_logic
    );
end F2DSS_ACE_MISC_APB3;
