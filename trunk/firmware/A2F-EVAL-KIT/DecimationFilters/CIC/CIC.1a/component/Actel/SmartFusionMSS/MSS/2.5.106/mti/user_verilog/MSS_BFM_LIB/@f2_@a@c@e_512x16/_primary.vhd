library verilog;
use verilog.vl_types.all;
entity F2_ACE_512x16 is
    generic(
        FIFODEPTH       : integer := 9;
        DATAWIDTH       : integer := 16
    );
    port(
        CLK             : in     vl_logic;
        WEN             : in     vl_logic;
        ADDR            : in     vl_logic_vector;
        WDATA           : in     vl_logic_vector;
        RDATA           : out    vl_logic_vector
    );
end F2_ACE_512x16;
