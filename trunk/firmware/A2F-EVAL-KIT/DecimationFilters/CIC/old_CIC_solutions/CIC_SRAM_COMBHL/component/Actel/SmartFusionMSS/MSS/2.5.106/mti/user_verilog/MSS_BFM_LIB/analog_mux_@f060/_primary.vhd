library verilog;
use verilog.vl_types.all;
entity analog_mux_F060 is
    generic(
        WARNING_MSGS_ON : integer := 1
    );
    port(
        CHNUMBER_I      : in     vl_logic_vector(4 downto 0);
        AV01            : in     vl_logic_vector(63 downto 0);
        AV02            : in     vl_logic_vector(63 downto 0);
        AC0             : in     vl_logic_vector(63 downto 0);
        AT0             : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_0 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_1 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_2 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_3 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_4 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_5 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_6 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_7 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_8 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_9 : in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_10: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_11: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_12: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_13: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_14: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_15: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_16: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_17: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_18: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_19: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_20: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_21: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_22: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_23: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_24: in     vl_logic_vector(63 downto 0);
        ADC_IN_VECTOR_25: in     vl_logic_vector(63 downto 0);
        DAC_VECTOR      : in     vl_logic_vector(63 downto 0);
        MUXOUT          : out    vl_logic_vector(63 downto 0)
    );
end analog_mux_F060;
