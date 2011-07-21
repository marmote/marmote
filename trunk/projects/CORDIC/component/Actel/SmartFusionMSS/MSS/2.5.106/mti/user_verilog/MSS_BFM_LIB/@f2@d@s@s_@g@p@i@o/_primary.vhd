library verilog;
use verilog.vl_types.all;
entity F2DSS_GPIO is
    port(
        PRESETN         : in     vl_logic;
        PCLK            : in     vl_logic;
        PSEL            : in     vl_logic;
        PENABLE         : in     vl_logic;
        PWRITE          : in     vl_logic;
        PADDR           : in     vl_logic_vector(7 downto 0);
        PWDATA          : in     vl_logic_vector(31 downto 0);
        PRDATA          : out    vl_logic_vector(31 downto 0);
        INT             : out    vl_logic_vector(31 downto 0);
        GPIO_IN         : in     vl_logic_vector(31 downto 0);
        GPIO_OUT        : out    vl_logic_vector(31 downto 0);
        GPIO_OE         : out    vl_logic_vector(31 downto 0)
    );
end F2DSS_GPIO;
