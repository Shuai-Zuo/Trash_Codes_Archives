library verilog;
use verilog.vl_types.all;
entity experiment31 is
    port(
        clr             : in     vl_logic;
        pressed         : in     vl_logic;
        key             : in     vl_logic_vector(3 downto 0);
        clk             : in     vl_logic;
        en              : in     vl_logic;
        sel             : in     vl_logic_vector(2 downto 0);
        \out\           : out    vl_logic_vector(3 downto 0);
        in1             : out    vl_logic_vector(3 downto 0);
        in2             : out    vl_logic_vector(3 downto 0);
        in3             : out    vl_logic_vector(3 downto 0);
        in4             : out    vl_logic_vector(3 downto 0);
        in5             : out    vl_logic_vector(3 downto 0);
        in6             : out    vl_logic_vector(3 downto 0);
        in7             : out    vl_logic_vector(3 downto 0);
        in8             : out    vl_logic_vector(3 downto 0);
        flag            : out    vl_logic
    );
end experiment31;
