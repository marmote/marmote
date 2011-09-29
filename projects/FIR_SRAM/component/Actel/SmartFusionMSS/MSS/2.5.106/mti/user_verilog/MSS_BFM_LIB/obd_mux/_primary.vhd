library verilog;
use verilog.vl_types.all;
entity obd_mux is
    port(
        DAC_0           : in     vl_logic;
        DAC_1           : in     vl_logic;
        DAC_2           : in     vl_logic;
        DAC_SELECT      : in     vl_logic_vector(1 downto 0);
        DAC_MUX_OUT     : out    vl_logic
    );
end obd_mux;
