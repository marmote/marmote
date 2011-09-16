library verilog;
use verilog.vl_types.all;
entity AddrDecM2 is
    port(
        addr            : in     vl_logic_vector(31 downto 0);
        F2_ESRAMSIZE    : in     vl_logic_vector(1 downto 0);
        F2_ENVMPOWEREDDOWN: in     vl_logic;
        COM_ENVMFABREMAPBASE: in     vl_logic_vector(19 downto 0);
        COM_ENVMREMAPSIZE: in     vl_logic_vector(4 downto 0);
        COM_PROTREGIONSIZE: in     vl_logic_vector(4 downto 0);
        COM_PROTREGIONBASE: in     vl_logic_vector(31 downto 0);
        COM_MASTERENABLE: in     vl_logic;
        addrDec         : out    vl_logic_vector(8 downto 0);
        absoluteAddr    : out    vl_logic_vector(31 downto 0)
    );
end AddrDecM2;
