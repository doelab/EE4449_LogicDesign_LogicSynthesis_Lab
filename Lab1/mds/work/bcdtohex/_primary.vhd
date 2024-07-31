library verilog;
use verilog.vl_types.all;
entity bcdtohex is
    port(
        bcd             : in     vl_logic_vector(3 downto 0);
        segment         : out    vl_logic_vector(6 downto 0)
    );
end bcdtohex;
