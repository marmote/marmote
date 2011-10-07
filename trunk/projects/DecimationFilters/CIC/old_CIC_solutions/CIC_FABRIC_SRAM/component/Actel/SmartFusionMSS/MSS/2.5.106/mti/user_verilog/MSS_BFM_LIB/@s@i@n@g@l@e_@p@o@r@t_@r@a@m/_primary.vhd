library verilog;
use verilog.vl_types.all;
entity SINGLE_PORT_RAM is
    generic(
        DEPTH           : integer := 9;
        WIDTH           : integer := 16
    );
    port(
        CLK             : in     vl_logic;
        WEN             : in     vl_logic;
        ADDR            : in     vl_logic_vector;
        WD              : in     vl_logic_vector;
        RD              : out    vl_logic_vector
    );
end SINGLE_PORT_RAM;
