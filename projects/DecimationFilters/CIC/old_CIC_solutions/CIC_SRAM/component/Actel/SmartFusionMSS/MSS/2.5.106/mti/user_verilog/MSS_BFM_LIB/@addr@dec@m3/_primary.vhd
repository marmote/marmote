library verilog;
use verilog.vl_types.all;
entity AddrDecM3 is
    port(
        addr            : in     vl_logic_vector(31 downto 0);
        F2_ESRAMSIZE    : in     vl_logic_vector(1 downto 0);
        COM_MASTERENABLE: in     vl_logic;
        addrDec         : out    vl_logic_vector(8 downto 0)
    );
end AddrDecM3;
