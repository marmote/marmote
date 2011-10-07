library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_PPE_SSE_CTRL is
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        xfer_din_mux    : in     vl_logic_vector(31 downto 0);
        PPE2SSE_PADDR_reg_move_target: in     vl_logic;
        PPE2SSE_PWDATA_LSB_reg_move_target: in     vl_logic;
        PPE2SSE_PWDATA_MSB_reg_move_target: in     vl_logic;
        PPE2SSE_wr      : in     vl_logic;
        PPE2SSE_rd_hold_en: in     vl_logic;
        PPE2SSE_sel     : in     vl_logic;
        PPE2SSE_en      : in     vl_logic;
        PPE2SSE_PRDATA  : in     vl_logic_vector(15 downto 0);
        PPE2SSE_PSEL    : out    vl_logic;
        PPE2SSE_PENABLE : out    vl_logic;
        PPE2SSE_PWRITE  : out    vl_logic;
        PPE2SSE_PADDR   : out    vl_logic_vector(11 downto 0);
        PPE2SSE_PWDATA  : out    vl_logic_vector(15 downto 0);
        PPE2SSE_PRDATA_rdhold: out    vl_logic_vector(15 downto 0)
    );
end F2DSS_ACE_PPE_SSE_CTRL;
