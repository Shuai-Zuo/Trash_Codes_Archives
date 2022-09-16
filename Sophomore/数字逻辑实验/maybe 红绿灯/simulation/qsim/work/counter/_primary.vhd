library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        clk             : in     vl_logic;
        red             : in     vl_logic_vector(5 downto 0);
        yel             : in     vl_logic_vector(5 downto 0);
        gre             : in     vl_logic_vector(5 downto 0);
        con             : out    vl_logic;
        \mod\           : in     vl_logic_vector(1 downto 0)
    );
end counter;
