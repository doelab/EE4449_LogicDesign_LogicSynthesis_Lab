library verilog;
use verilog.vl_types.all;
entity downstream is
    port(
        clk             : in     vl_logic;
        reset_l         : in     vl_logic;
        done            : in     vl_logic;
        downstream_in   : in     vl_logic_vector(7 downto 0);
        downstream_out  : out    vl_logic_vector(7 downto 0)
    );
end downstream;
