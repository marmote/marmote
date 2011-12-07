library verilog;
use verilog.vl_types.all;
entity F2DSS_ACE_MISC_INT_LOGIC is
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        PADDR           : in     vl_logic_vector(12 downto 0);
        PSEL            : in     vl_logic;
        PENABLE         : in     vl_logic;
        PWRITE          : in     vl_logic;
        PWDATA          : in     vl_logic_vector(31 downto 0);
        ADC0_CALIBRATE_rise: in     vl_logic;
        ADC1_CALIBRATE_rise: in     vl_logic;
        ADC2_CALIBRATE_rise: in     vl_logic;
        ADC0_CALIBRATE_fall: in     vl_logic;
        ADC1_CALIBRATE_fall: in     vl_logic;
        ADC2_CALIBRATE_fall: in     vl_logic;
        ADC0_DATAVALID_rise: in     vl_logic;
        ADC1_DATAVALID_rise: in     vl_logic;
        ADC2_DATAVALID_rise: in     vl_logic;
        PC0_FLAGS       : in     vl_logic_vector(3 downto 0);
        PC1_FLAGS       : in     vl_logic_vector(3 downto 0);
        PC2_FLAGS       : in     vl_logic_vector(3 downto 0);
        SSE_IRQ         : out    vl_logic_vector(20 downto 0);
        SSE_IRQ_EN      : out    vl_logic_vector(20 downto 0);
        COMPARATOR      : in     vl_logic_vector(11 downto 0);
        COMP_IRQ        : out    vl_logic_vector(23 downto 0);
        COMP_IRQ_EN     : out    vl_logic_vector(23 downto 0);
        PPE_FLAGS0      : in     vl_logic_vector(31 downto 0);
        PPE_FLAGS1      : in     vl_logic_vector(31 downto 0);
        PPE_FLAGS2      : in     vl_logic_vector(31 downto 0);
        PPE_FLAGS3      : in     vl_logic_vector(31 downto 0);
        PPE_SFFLAGS     : in     vl_logic_vector(31 downto 0);
        PPE_FLAGS0_IRQ  : out    vl_logic_vector(31 downto 0);
        PPE_FLAGS0_IRQ_EN: out    vl_logic_vector(31 downto 0);
        PPE_FLAGS1_IRQ  : out    vl_logic_vector(31 downto 0);
        PPE_FLAGS1_IRQ_EN: out    vl_logic_vector(31 downto 0);
        PPE_FLAGS2_IRQ  : out    vl_logic_vector(31 downto 0);
        PPE_FLAGS2_IRQ_EN: out    vl_logic_vector(31 downto 0);
        PPE_FLAGS3_IRQ  : out    vl_logic_vector(31 downto 0);
        PPE_FLAGS3_IRQ_EN: out    vl_logic_vector(31 downto 0);
        PPE_SFFLAGS_IRQ : out    vl_logic_vector(31 downto 0);
        PPE_SFFLAGS_IRQ_EN: out    vl_logic_vector(31 downto 0);
        PPE_BUSY        : in     vl_logic;
        ADC0_FIFO_FULL  : in     vl_logic;
        ADC0_FIFO_AFULL : in     vl_logic;
        ADC1_FIFO_FULL  : in     vl_logic;
        ADC1_FIFO_AFULL : in     vl_logic;
        ADC2_FIFO_FULL  : in     vl_logic;
        ADC2_FIFO_AFULL : in     vl_logic;
        ADC0_FIFO_EMPTY : in     vl_logic;
        ADC1_FIFO_EMPTY : in     vl_logic;
        ADC2_FIFO_EMPTY : in     vl_logic;
        PPE_FIFO_IRQ    : out    vl_logic_vector(8 downto 0);
        PPE_FIFO_IRQ_EN : out    vl_logic_vector(8 downto 0);
        FPGA_FLAGS_SEL  : out    vl_logic_vector(9 downto 0);
        FPGA_FLAGS      : out    vl_logic_vector(31 downto 0);
        INTERRUPT       : out    vl_logic_vector(85 downto 0)
    );
end F2DSS_ACE_MISC_INT_LOGIC;