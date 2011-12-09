library verilog;
use verilog.vl_types.all;
entity drive_current_monitor is
    port(
        temp_vect       : in     vl_logic_vector(63 downto 0);
        resistor_vect   : in     vl_logic_vector(63 downto 0);
        current_vect    : in     vl_logic_vector(63 downto 0);
        serial_out      : out    vl_logic
    );
end drive_current_monitor;
