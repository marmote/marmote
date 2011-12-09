library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_PPE_FIFO is
    generic(
        WIDTH           : integer := 16;
        DEPTH           : integer := 4
    );
    port(
        RB              : in     vl_logic;
        CLR             : in     vl_logic;
        CLK             : in     vl_logic;
        WR              : in     vl_logic;
        RD              : in     vl_logic;
        D               : in     vl_logic_vector;
        Q               : out    vl_logic_vector;
        STORE           : out    vl_logic_vector;
        WR_PTR          : out    vl_logic_vector;
        RD_PTR          : out    vl_logic_vector;
        EMPTY           : out    vl_logic;
        FULL            : out    vl_logic;
        AFULL           : out    vl_logic
    );
end F2DSS_ACE_PPE_FIFO;
