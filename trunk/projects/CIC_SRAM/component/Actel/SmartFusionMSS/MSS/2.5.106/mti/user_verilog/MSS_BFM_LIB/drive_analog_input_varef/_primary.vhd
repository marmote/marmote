library verilog;
use verilog.vl_types.all;
entity drive_analog_input_varef is
    port(
        parallel_in     : in     vl_logic_vector(63 downto 0);
        ADC_varef_sel   : in     vl_logic;
        serial_out      : out    vl_logic
    );
end drive_analog_input_varef;
