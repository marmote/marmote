library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_PPE_MULT is
    port(
        d               : in     vl_logic_vector(15 downto 0);
        e               : in     vl_logic_vector(15 downto 0);
        p               : out    vl_logic_vector(31 downto 0)
    );
end F2DSS_ACE_PPE_MULT;
