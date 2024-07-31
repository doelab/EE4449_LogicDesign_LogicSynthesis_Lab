library verilog;
use verilog.vl_types.all;
entity sumitup is
    port(
        clk             : in     vl_logic;
        reset_l         : in     vl_logic;
        go_l            : in     vl_logic;
        inA             : in     vl_logic_vector(7 downto 0);
        done            : out    vl_logic;
        sum             : out    vl_logic_vector(7 downto 0)
    );
end sumitup;
