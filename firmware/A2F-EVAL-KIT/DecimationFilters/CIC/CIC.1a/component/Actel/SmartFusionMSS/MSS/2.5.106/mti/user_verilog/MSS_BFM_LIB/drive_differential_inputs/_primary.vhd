library verilog;
use verilog.vl_types.all;
entity drive_differential_inputs is
    port(
        volt_vect       : in     vl_logic_vector(63 downto 0);
        delta_vect      : in     vl_logic_vector(63 downto 0);
        av              : out    vl_logic;
        ac              : out    vl_logic
    );
end drive_differential_inputs;
