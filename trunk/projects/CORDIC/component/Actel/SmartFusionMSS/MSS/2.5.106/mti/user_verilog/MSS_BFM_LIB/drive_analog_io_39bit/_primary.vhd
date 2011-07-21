library verilog;
use verilog.vl_types.all;
entity drive_analog_io_39bit is
    port(
        parallel_in     : in     vl_logic_vector(38 downto 0);
        serial_out      : out    vl_logic
    );
end drive_analog_io_39bit;
