library verilog;
use verilog.vl_types.all;
entity adc is
    generic(
        WARNING_MSGS_ON : integer := 1;
        FAST_ADC_CONV_SIM: integer := 0;
        VA_REF_INTERNAL : real    := 2.560000
    );
    port(
        VAREF_INPUT     : in     vl_logic_vector(63 downto 0);
        VAREFSEL        : in     vl_logic;
        A_IN            : in     vl_logic_vector(63 downto 0);
        PWRDWN          : in     vl_logic;
        ADCRESET        : in     vl_logic;
        SYSCLK          : in     vl_logic;
        CHNUMBER        : in     vl_logic_vector(4 downto 0);
        MODE            : in     vl_logic_vector(3 downto 0);
        TVC             : in     vl_logic_vector(7 downto 0);
        STC             : in     vl_logic_vector(7 downto 0);
        ADCSTART        : in     vl_logic;
        VAREFSEL_lat    : out    vl_logic;
        BUSY            : out    vl_logic;
        CALIBRATE       : out    vl_logic;
        DATAVALID       : out    vl_logic;
        SAMPLE          : out    vl_logic;
        RESULT          : out    vl_logic_vector(11 downto 0)
    );
end adc;
