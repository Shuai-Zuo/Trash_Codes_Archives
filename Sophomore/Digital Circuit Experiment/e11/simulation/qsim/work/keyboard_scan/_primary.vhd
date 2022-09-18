library verilog;
use verilog.vl_types.all;
entity keyboard_scan is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        swc             : out    vl_logic_vector(3 downto 0);
        swr             : in     vl_logic_vector(3 downto 0);
        key             : out    vl_logic_vector(3 downto 0);
        pressed         : out    vl_logic
    );
end keyboard_scan;
