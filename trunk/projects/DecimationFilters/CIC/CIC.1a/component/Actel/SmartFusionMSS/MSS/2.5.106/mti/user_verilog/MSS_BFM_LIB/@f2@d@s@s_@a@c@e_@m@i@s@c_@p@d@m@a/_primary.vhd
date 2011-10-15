library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_MISC_PDMA is
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        PADDR           : in     vl_logic_vector(12 downto 0);
        PSEL            : in     vl_logic;
        PENABLE         : in     vl_logic;
        PWRITE          : in     vl_logic;
        PWDATA          : in     vl_logic_vector(31 downto 0);
        PREADY_MISC_PDMA: out    vl_logic;
        PPE_PDMA_DATAOUT_reg_move_target: in     vl_logic;
        PPE_PDMA_DATAOUT_chan_en: in     vl_logic;
        PPE_PDMA_DATAOUT_raw_en: in     vl_logic;
        PPE_PDMA_DATAOUT_tag_en: in     vl_logic;
        PPE_PDMA_CTRL_reg_move_target: in     vl_logic;
        xfer_din_mux    : in     vl_logic_vector(31 downto 0);
        CURRENT_ADC_CHAN: in     vl_logic_vector(5 downto 0);
        ACE_INREADY     : in     vl_logic;
        ACE_OUTREADY    : out    vl_logic;
        PPE_PDMA_CTRL   : out    vl_logic_vector(31 downto 0);
        PDMA_STATUS     : out    vl_logic_vector(31 downto 0);
        PPE_PDMA_DATAOUT: out    vl_logic_vector(31 downto 0)
    );
end F2DSS_ACE_MISC_PDMA;
