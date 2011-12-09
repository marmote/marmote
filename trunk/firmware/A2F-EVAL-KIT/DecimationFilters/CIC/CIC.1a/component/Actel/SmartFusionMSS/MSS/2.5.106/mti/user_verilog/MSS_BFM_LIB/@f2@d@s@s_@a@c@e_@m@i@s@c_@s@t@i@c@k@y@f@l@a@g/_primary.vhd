library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_MISC_STICKYFLAG is
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        SET             : in     vl_logic;
        CLR             : in     vl_logic;
        FLAG            : out    vl_logic
    );
end F2DSS_ACE_MISC_STICKYFLAG;
