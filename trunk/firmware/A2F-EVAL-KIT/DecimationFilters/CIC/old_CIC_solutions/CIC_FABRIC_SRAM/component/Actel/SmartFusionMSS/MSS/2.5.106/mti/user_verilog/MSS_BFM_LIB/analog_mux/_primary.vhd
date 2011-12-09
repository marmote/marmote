library verilog;
use verilog.vl_types.all;
entity analog_mux is
    generic(
        WARNING_MSGS_ON : integer := 1
    );
    port(
        CHNUMBER_I      : in     vl_logic_vector(4 downto 0);
        AV01            : in     vl_logic_vector(63 downto 0);
        AV02            : in     vl_logic_vector(63 downto 0);
        AC0             : in     vl_logic_vector(63 downto 0);
        AT0             : in     vl_logic_vector(63 downto 0);
        AV11            : in     vl_logic_vector(63 downto 0);
        AV12            : in     vl_logic_vector(63 downto 0);
        AC1             : in     vl_logic_vector(63 downto 0);
        AT1             : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_0 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_1 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_2 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_3 : in     vl_logic_vector(63 downto 0);
        DAC_VECTOR      : in     vl_logic_vector(63 downto 0);
        MUXOUT          : out    vl_logic_vector(63 downto 0)
    );
end analog_mux;
