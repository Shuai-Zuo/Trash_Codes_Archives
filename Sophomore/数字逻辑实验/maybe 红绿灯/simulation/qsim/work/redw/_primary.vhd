library verilog;
use verilog.vl_types.all;
entity redw is
    port(
        count           : out    vl_logic_vector(7 downto 0);
        stop            : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ldn             : in     vl_logic;
        s1              : in     vl_logic;
        s2              : in     vl_logic;
        gre             : in     vl_logic_vector(5 downto 0);
        red             : in     vl_logic_vector(5 downto 0);
        yel             : in     vl_logic_vector(5 downto 0);
        in1             : out    vl_logic_vector(3 downto 0);
        in2             : out    vl_logic_vector(3 downto 0);
        in4             : out    vl_logic_vector(3 downto 0);
        in5             : out    vl_logic_vector(3 downto 0);
        lighto1         : out    vl_logic_vector(2 downto 0);
        lighto2         : out    vl_logic_vector(2 downto 0);
        rst_fre         : in     vl_logic
    );
end redw;
