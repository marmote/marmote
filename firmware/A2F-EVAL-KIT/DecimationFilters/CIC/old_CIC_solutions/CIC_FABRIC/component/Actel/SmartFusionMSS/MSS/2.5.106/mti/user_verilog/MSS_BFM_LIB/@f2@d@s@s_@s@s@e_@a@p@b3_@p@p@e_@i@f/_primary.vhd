library verilog;
use verilog.vl_types.all;
entity F2DSS_SSE_APB3_PPE_IF is
    port(
        PRESETN         : in     vl_logic;
        PCLK            : in     vl_logic;
        TDM_CNT         : in     vl_logic_vector(2 downto 0);
        PSEL            : in     vl_logic;
        PENABLE         : in     vl_logic;
        PWRITE          : in     vl_logic;
        PADDR           : in     vl_logic_vector(11 downto 0);
        PWDATA          : in     vl_logic_vector(31 downto 0);
        PRDATA          : out    vl_logic_vector(15 downto 0);
        PREADY          : out    vl_logic;
        PSLVERR         : out    vl_logic;
        PPE_PSEL        : in     vl_logic;
        PPE_PENABLE     : in     vl_logic;
        PPE_PWRITE      : in     vl_logic;
        PPE_PADDR       : in     vl_logic_vector(11 downto 0);
        PPE_PWDATA      : in     vl_logic_vector(15 downto 0);
        PPE_PRDATA      : out    vl_logic_vector(15 downto 0);
        PPE_PREADY      : out    vl_logic;
        PPE_PSLVERR     : out    vl_logic;
        SSE_RWB         : out    vl_logic;
        SSE_ADDR        : out    vl_logic_vector(9 downto 0);
        SSE_WDATA       : out    vl_logic_vector(15 downto 0);
        SSE_RDATA       : in     vl_logic_vector(15 downto 0);
        PDMA_decode     : out    vl_logic
    );
end F2DSS_SSE_APB3_PPE_IF;
