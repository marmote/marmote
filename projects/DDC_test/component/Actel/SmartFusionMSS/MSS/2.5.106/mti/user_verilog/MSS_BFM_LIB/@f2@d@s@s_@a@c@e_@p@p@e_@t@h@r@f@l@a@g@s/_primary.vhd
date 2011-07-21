library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_PPE_THRFLAGS is
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        PADDR           : in     vl_logic_vector(12 downto 0);
        PSEL            : in     vl_logic;
        PENABLE         : in     vl_logic;
        PWRITE          : in     vl_logic;
        PWDATA          : in     vl_logic_vector(31 downto 0);
        PREADY_THRFLAGS : out    vl_logic;
        RAM_DO_A        : in     vl_logic_vector(31 downto 0);
        xfer_din_mux    : in     vl_logic_vector(31 downto 0);
        PPE_FPTR_busy   : in     vl_logic;
        PPE_FLAGS0_busy : in     vl_logic;
        PPE_FLAGS1_busy : in     vl_logic;
        PPE_FLAGS2_busy : in     vl_logic;
        PPE_FLAGS3_busy : in     vl_logic;
        PPE_SFFLAGS_busy: in     vl_logic;
        PPE_FPTR_reg_move_target: in     vl_logic;
        PPE_FLAGS0_reg_move_target: in     vl_logic;
        PPE_FLAGS1_reg_move_target: in     vl_logic;
        PPE_FLAGS2_reg_move_target: in     vl_logic;
        PPE_FLAGS3_reg_move_target: in     vl_logic;
        PPE_SFFLAGS_reg_move_target: in     vl_logic;
        PPE_FLAG_bit    : in     vl_logic;
        PPE_FLAG_bit_update: in     vl_logic;
        PPE_thresh_op_load: in     vl_logic;
        PPE_FPTR        : out    vl_logic_vector(31 downto 0);
        PPE_FLAGS0      : out    vl_logic_vector(31 downto 0);
        PPE_FLAGS1      : out    vl_logic_vector(31 downto 0);
        PPE_FLAGS2      : out    vl_logic_vector(31 downto 0);
        PPE_FLAGS3      : out    vl_logic_vector(31 downto 0);
        PPE_SFFLAGS     : out    vl_logic_vector(31 downto 0)
    );
end F2DSS_ACE_PPE_THRFLAGS;
