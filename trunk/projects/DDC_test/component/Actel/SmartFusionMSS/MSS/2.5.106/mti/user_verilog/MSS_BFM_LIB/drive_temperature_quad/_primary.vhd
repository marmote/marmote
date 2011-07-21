library verilog;
use verilog.vl_types.all;
entity drive_temperature_quad is
    port(
        temp_celsius    : in     vl_logic_vector(63 downto 0);
        serial_out      : out    vl_logic
    );
end drive_temperature_quad;
