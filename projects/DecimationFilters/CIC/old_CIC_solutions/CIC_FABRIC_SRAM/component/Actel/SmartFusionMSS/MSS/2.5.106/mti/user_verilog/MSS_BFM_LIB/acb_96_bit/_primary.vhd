library verilog;
use verilog.vl_types.all;
entity acb_96_bit is
    generic(
        ANALOG_QUAD_NUM : integer := 6;
        ACB_BYTES_NUM_PER_QUAD: integer := 12;
        WARNING_MSGS_ON : integer := 1
    );
    port(
        ACB_RST         : in     vl_logic;
        ACB_WEN         : in     vl_logic;
        ACB_ADDR        : in     vl_logic_vector(7 downto 0);
        ACB_WDATA       : in     vl_logic_vector(7 downto 0);
        ACB_RDATA       : out    vl_logic_vector(7 downto 0);
        AQO_AV1_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQO_AV2_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQO_AC_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQO_AT_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQ0_DAC_MUX_SEL : out    vl_logic_vector(1 downto 0);
        AQ1_AV1_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQ1_AV2_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQ1_AC_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQ1_AT_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQ1_DAC_MUX_SEL : out    vl_logic_vector(1 downto 0);
        AQ2_AV1_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQ2_AV2_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQ2_AC_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQ2_AT_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQ2_DAC_MUX_SEL : out    vl_logic_vector(1 downto 0);
        AQ3_AV1_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQ3_AV2_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQ3_AC_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQ3_AT_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQ3_DAC_MUX_SEL : out    vl_logic_vector(1 downto 0);
        AQ4_AV1_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQ4_AV2_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQ4_AC_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQ4_AT_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQ4_DAC_MUX_SEL : out    vl_logic_vector(1 downto 0);
        AQ5_AV1_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQ5_AV2_CONFIG  : out    vl_logic_vector(3 downto 0);
        AQ5_AC_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQ5_AT_CONFIG   : out    vl_logic_vector(7 downto 0);
        AQ5_DAC_MUX_SEL : out    vl_logic_vector(1 downto 0);
        DAC0_CONFIG     : out    vl_logic_vector(1 downto 0);
        DAC1_CONFIG     : out    vl_logic_vector(1 downto 0);
        DAC2_CONFIG     : out    vl_logic_vector(1 downto 0)
    );
end acb_96_bit;
