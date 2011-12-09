library verilog;
use verilog.vl_types.all;
entity F2DSS_SSE_TDM_FSM is
    port(
        PRESETN         : in     vl_logic;
        PCLK            : in     vl_logic;
        SSE_TS_CTRL0    : in     vl_logic;
        FPGA_TRIGGER    : in     vl_logic;
        TDM_CNT         : out    vl_logic_vector(2 downto 0);
        APB_SLOT        : out    vl_logic
    );
end F2DSS_SSE_TDM_FSM;
