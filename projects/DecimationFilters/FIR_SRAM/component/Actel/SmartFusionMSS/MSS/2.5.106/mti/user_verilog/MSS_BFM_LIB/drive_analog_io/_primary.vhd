library verilog;
use verilog.vl_types.all;
entity drive_analog_io is
    port(
        parallel_in     : in     vl_logic_vector(63 downto 0);
        serial_out      : out    vl_logic
    );
end drive_analog_io;
