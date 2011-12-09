library verilog;
use verilog.vl_types.all;
entity sp512x16 is
    generic(
        word_width      : integer := 16;
        word_depth      : integer := 512;
        nb_address      : integer := 9;
        MEMORYFILE      : string  := ""
    );
    port(
        A               : in     vl_logic_vector;
        DI              : in     vl_logic_vector;
        DO              : out    vl_logic_vector;
        WIB             : in     vl_logic_vector;
        CLK             : in     vl_logic;
        CSB             : in     vl_logic;
        RWB             : in     vl_logic
    );
end sp512x16;
