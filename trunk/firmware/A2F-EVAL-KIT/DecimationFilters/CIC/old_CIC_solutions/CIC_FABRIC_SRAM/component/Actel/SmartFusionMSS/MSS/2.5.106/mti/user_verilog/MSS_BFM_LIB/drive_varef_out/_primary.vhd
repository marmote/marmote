library verilog;
use verilog.vl_types.all;
entity drive_varef_out is
    port(
        parallel_in     : in     vl_logic_vector(63 downto 0);
        en_out          : in     vl_logic;
        serial_out      : out    vl_logic
    );
end drive_varef_out;
