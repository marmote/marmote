library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_PPE_ADDER is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        ci              : in     vl_logic;
        pos_sat_en      : in     vl_logic;
        neg_sat_en      : in     vl_logic;
        s               : out    vl_logic_vector(31 downto 0);
        co              : out    vl_logic;
        pos_sat         : out    vl_logic;
        neg_sat         : out    vl_logic
    );
end F2DSS_ACE_PPE_ADDER;
