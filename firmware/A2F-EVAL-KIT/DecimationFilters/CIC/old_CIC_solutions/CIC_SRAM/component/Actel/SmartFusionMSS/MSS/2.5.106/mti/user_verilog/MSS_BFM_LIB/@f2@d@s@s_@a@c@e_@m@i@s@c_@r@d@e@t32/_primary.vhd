library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_MISC_RDET32 is
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        D               : in     vl_logic_vector(31 downto 0);
        RISE            : out    vl_logic_vector(31 downto 0)
    );
end F2DSS_ACE_MISC_RDET32;
