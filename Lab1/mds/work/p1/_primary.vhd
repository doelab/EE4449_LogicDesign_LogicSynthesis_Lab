library verilog;
use verilog.vl_types.all;
entity p1 is
    port(
        CLOCK_50        : in     vl_logic;
        KEY0            : in     vl_logic;
        KEY2            : in     vl_logic;
        LED0            : out    vl_logic;
        HEX3            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX0            : out    vl_logic_vector(6 downto 0)
    );
end p1;
