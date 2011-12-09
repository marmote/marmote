library verilog;
use verilog.vl_types.all;
entity read_39bit_analog_io is
    port(
        serial_in       : in     vl_logic;
        read_enb        : in     vl_logic;
        parallel_out    : out    vl_logic_vector(38 downto 0)
    );
end read_39bit_analog_io;
