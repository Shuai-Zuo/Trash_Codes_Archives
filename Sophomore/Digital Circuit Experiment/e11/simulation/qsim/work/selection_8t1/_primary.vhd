library verilog;
use verilog.vl_types.all;
entity selection_8t1 is
    port(
        key             : in     vl_logic_vector(3 downto 0);
        pressed         : in     vl_logic;
        en              : in     vl_logic;
        clk             : in     vl_logic;
        sel             : in     vl_logic_vector(2 downto 0);
        \out\           : out    vl_logic_vector(3 downto 0);
        in1             : out    vl_logic_vector(3 downto 0);
        in2             : out    vl_logic_vector(3 downto 0);
        in3             : out    vl_logic_vector(3 downto 0);
        in4             : out    vl_logic_vector(3 downto 0);
        in5             : out    vl_logic_vector(3 downto 0);
        in6             : out    vl_logic_vector(3 downto 0);
        in7             : out    vl_logic_vector(3 downto 0);
        in8             : out    vl_logic_vector(3 downto 0)
    );
end selection_8t1;
