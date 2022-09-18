library verilog;
use verilog.vl_types.all;
entity selection is
    port(
        key             : in     vl_logic_vector(3 downto 0);
        pressed         : in     vl_logic;
        sel_num         : out    vl_logic_vector(3 downto 0);
        sel_bit         : out    vl_logic_vector(2 downto 0)
    );
end selection;
