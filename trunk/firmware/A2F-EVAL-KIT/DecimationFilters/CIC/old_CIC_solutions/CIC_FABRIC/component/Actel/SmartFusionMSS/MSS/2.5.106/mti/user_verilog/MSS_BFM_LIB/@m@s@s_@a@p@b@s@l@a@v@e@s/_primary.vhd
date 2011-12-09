library verilog;
use verilog.vl_types.all;
entity MSS_APBSLAVES is
    generic(
        AWIDTH          : integer := 12;
        DEPTH           : integer := 256;
        DWIDTH          : integer := 32;
        INITFILE        : string  := " ";
        ID              : integer := 0;
        TPD             : integer := 0;
        ENFUNC          : integer := 0;
        DEBUG           : integer := 1
    );
    port(
        PCLK            : in     vl_logic;
        PRESETN         : in     vl_logic;
        PENABLE         : in     vl_logic;
        PWRITE          : in     vl_logic;
        PSEL            : in     vl_logic_vector(15 downto 0);
        PADDR           : in     vl_logic_vector;
        PWDATA          : in     vl_logic_vector;
        PRDATA          : out    vl_logic_vector;
        PREADY          : out    vl_logic;
        PSLVERR         : out    vl_logic;
        GPIO_IN         : in     vl_logic_vector(31 downto 0);
        GPIO_OUT        : out    vl_logic_vector(31 downto 0);
        GPIO_OE         : out    vl_logic_vector(31 downto 0);
        GPIO_INT        : out    vl_logic_vector(31 downto 0);
        SOFTRESETS      : in     vl_logic_vector(10 downto 0)
    );
end MSS_APBSLAVES;
