library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_MISC_STICKYFLAG32 is
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        SET             : in     vl_logic_vector(31 downto 0);
        CLR             : in     vl_logic_vector(31 downto 0);
        FLAG            : out    vl_logic_vector(31 downto 0)
    );
end F2DSS_ACE_MISC_STICKYFLAG32;
