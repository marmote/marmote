library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_RAMS is
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        SSE_RAM_ADDR    : in     vl_logic_vector(8 downto 0);
        SSE_RAM_CSN     : in     vl_logic;
        SSE_RAM_RWN     : in     vl_logic;
        SSE_RAM_WDATA   : in     vl_logic_vector(15 downto 0);
        SSE_RAM_RDATA   : out    vl_logic_vector(15 downto 0);
        PPE_RAM_ADDR    : in     vl_logic_vector(9 downto 0);
        PPE_RAM_CSN     : in     vl_logic;
        PPE_RAM_RWN     : in     vl_logic;
        PPE_RAM_WDATA   : in     vl_logic_vector(15 downto 0);
        PPE_RAM_RDATA   : out    vl_logic_vector(15 downto 0)
    );
end F2DSS_ACE_RAMS;
