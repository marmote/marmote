library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_PPE_FSM_STFILT is
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        PWDATA          : in     vl_logic_vector(31 downto 0);
        SF_reg_move_target: in     vl_logic;
        SF_reg_apbwr    : in     vl_logic;
        xfer_din_mux    : in     vl_logic_vector(31 downto 0);
        C_reg_31        : in     vl_logic;
        st_filt_cnt_clr : in     vl_logic;
        st_filt_cnt_inc : in     vl_logic;
        st_filt_st_one  : in     vl_logic;
        st_filt_st_zero : in     vl_logic;
        st_filt_curr_st : out    vl_logic;
        st_filt_next_qual: out    vl_logic;
        st_filt_0to1_eq : out    vl_logic;
        st_filt_1to0_eq : out    vl_logic;
        SF_reg_out      : out    vl_logic_vector(31 downto 0)
    );
end F2DSS_ACE_PPE_FSM_STFILT;
