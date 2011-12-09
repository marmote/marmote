library verilog;
use verilog.vl_types.all;
entity read_analog_io is
    port(
        serial_in       : in     vl_logic;
        read_enb        : in     vl_logic;
        parallel_out    : out    vl_logic_vector(63 downto 0)
    );
end read_analog_io;
