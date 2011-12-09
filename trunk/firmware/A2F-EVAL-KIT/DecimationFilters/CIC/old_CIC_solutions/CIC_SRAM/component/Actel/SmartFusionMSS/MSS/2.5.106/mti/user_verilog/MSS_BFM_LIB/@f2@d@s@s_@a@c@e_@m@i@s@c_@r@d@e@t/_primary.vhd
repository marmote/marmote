library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_MISC_RDET is
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        D               : in     vl_logic;
        RISE            : out    vl_logic
    );
end F2DSS_ACE_MISC_RDET;
