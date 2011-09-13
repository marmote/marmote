library verilog;
use verilog.vl_types.all;
entity obd is
    generic(
        RESOLUTION      : vl_logic_vector(1 downto 0) := (Hi0, Hi0)
    );
    port(
        OBD_CONFIG      : in     vl_logic_vector(1 downto 0);
        OBD_DIN         : in     vl_logic;
        OBD_CLKIN       : in     vl_logic;
        OBD_ENABLE      : in     vl_logic;
        DAC_OUT         : out    vl_logic
    );
    attribute RESOLUTION_mti_vect_attrib : integer;
    attribute RESOLUTION_mti_vect_attrib of RESOLUTION : constant is 0;
end obd;
