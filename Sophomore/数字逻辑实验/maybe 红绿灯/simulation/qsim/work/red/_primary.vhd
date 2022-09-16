library verilog;
use verilog.vl_types.all;
entity red is
    port(
        pin_name1       : out    vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        gre             : in     vl_logic_vector(5 downto 0);
        red             : in     vl_logic_vector(5 downto 0);
        yel             : in     vl_logic_vector(5 downto 0);
        \out\           : out    vl_logic_vector(1 downto 0)
    );
end red;
