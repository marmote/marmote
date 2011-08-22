library verilog;
use verilog.vl_types.all;
entity F2DSS_SSE_PHASE_ACCUMS is
    port(
        PRESETN         : in     vl_logic;
        HCLK            : in     vl_logic;
        DAC0_IN         : in     vl_logic_vector(23 downto 0);
        DAC1_IN         : in     vl_logic_vector(23 downto 0);
        DAC2_IN         : in     vl_logic_vector(23 downto 0);
        DAC0_CTRL       : in     vl_logic_vector(7 downto 0);
        DAC1_CTRL       : in     vl_logic_vector(7 downto 0);
        DAC2_CTRL       : in     vl_logic_vector(7 downto 0);
        OBD_FPGA0_CLKOUT: in     vl_logic;
        OBD_FPGA1_CLKOUT: in     vl_logic;
        OBD_FPGA2_CLKOUT: in     vl_logic;
        OBD_FPGA0_DOUT  : in     vl_logic;
        OBD_FPGA1_DOUT  : in     vl_logic;
        OBD_FPGA2_DOUT  : in     vl_logic;
        OBD_DOUT0       : out    vl_logic;
        OBD_DOUT1       : out    vl_logic;
        OBD_DOUT2       : out    vl_logic;
        OBD_CLKOUT0     : out    vl_logic;
        OBD_CLKOUT1     : out    vl_logic;
        OBD_CLKOUT2     : out    vl_logic;
        OBD_ENABLE0     : out    vl_logic;
        OBD_ENABLE1     : out    vl_logic;
        OBD_ENABLE2     : out    vl_logic
    );
end F2DSS_SSE_PHASE_ACCUMS;
