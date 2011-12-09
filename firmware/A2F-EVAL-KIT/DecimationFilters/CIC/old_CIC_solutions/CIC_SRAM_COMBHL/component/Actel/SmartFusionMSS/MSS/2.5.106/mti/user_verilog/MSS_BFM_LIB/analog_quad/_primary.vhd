library verilog;
use verilog.vl_types.all;
entity analog_quad is
    generic(
        WIDTH           : integer := 32;
        WARNING_MSGS_ON : integer := 1
    );
    port(
        VAREF_IN        : in     vl_logic_vector(63 downto 0);
        VAREF_DAC       : in     vl_logic;
        AV1_IN          : in     vl_logic;
        AV2_IN          : in     vl_logic;
        AC_IN           : in     vl_logic;
        AT_IN           : in     vl_logic;
        AT_GND          : in     vl_logic;
        DIRECT_ANALOG0  : in     vl_logic;
        DIRECT_ANALOG1  : in     vl_logic;
        AV1_CONFIG      : in     vl_logic_vector(3 downto 0);
        AV2_CONFIG      : in     vl_logic_vector(3 downto 0);
        AC_CONFIG       : in     vl_logic_vector(7 downto 0);
        AT_CONFIG       : in     vl_logic_vector(7 downto 0);
        AV1_OUT         : out    vl_logic_vector(63 downto 0);
        AV2_OUT         : out    vl_logic_vector(63 downto 0);
        AC_OUT          : out    vl_logic_vector(63 downto 0);
        AT_OUT          : out    vl_logic_vector(63 downto 0);
        AC_COMP_OUT     : out    vl_logic;
        AT_COMP_OUT     : out    vl_logic
    );
end analog_quad;
