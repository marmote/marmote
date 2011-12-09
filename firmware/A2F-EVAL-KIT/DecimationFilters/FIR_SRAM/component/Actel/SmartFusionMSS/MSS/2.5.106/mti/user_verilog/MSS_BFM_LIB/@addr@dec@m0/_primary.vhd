library verilog;
use verilog.vl_types.all;
entity AddrDecM0 is
    port(
        addr            : in     vl_logic_vector(31 downto 0);
        write           : in     vl_logic;
        COM_ESRAMFWREMAP: in     vl_logic;
        F2_TESTREMAPENABLE: in     vl_logic;
        F2_TESTESRAM1REMAP: in     vl_logic;
        COM_ENVMREMAPBASE: in     vl_logic_vector(19 downto 0);
        COM_ENVMREMAPSIZE: in     vl_logic_vector(4 downto 0);
        F2_ESRAMSIZE    : in     vl_logic_vector(1 downto 0);
        F2_ENVMPOWEREDDOWN: in     vl_logic;
        addrDec         : out    vl_logic_vector(8 downto 0);
        absoluteAddr    : out    vl_logic_vector(31 downto 0)
    );
end AddrDecM0;
