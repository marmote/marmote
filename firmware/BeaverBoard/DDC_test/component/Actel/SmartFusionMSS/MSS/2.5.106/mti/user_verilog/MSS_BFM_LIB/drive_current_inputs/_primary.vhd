library verilog;
use verilog.vl_types.all;
entity drive_current_inputs is
    port(
        current_vect    : in     vl_logic_vector(63 downto 0);
        resistor_vect   : in     vl_logic_vector(63 downto 0);
        temp_vect       : in     vl_logic_vector(63 downto 0);
        ac              : out    vl_logic;
        at              : out    vl_logic
    );
end drive_current_inputs;
