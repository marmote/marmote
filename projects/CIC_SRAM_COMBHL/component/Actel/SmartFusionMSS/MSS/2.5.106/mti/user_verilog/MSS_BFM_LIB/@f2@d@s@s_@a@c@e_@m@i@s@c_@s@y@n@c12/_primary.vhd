library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_MISC_SYNC12 is
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        D               : in     vl_logic_vector(11 downto 0);
        Q               : out    vl_logic_vector(11 downto 0)
    );
end F2DSS_ACE_MISC_SYNC12;
