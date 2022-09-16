library verilog;
use verilog.vl_types.all;
entity top is
    port(
        updown          : out    vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        outside         : in     vl_logic_vector(5 downto 0);
        inside          : in     vl_logic_vector(3 downto 0);
        stoprun         : out    vl_logic;
        ce              : out    vl_logic;
        rst_con         : out    vl_logic;
        red             : out    vl_logic;
        inc             : out    vl_logic;
        curfloor        : out    vl_logic_vector(1 downto 0);
        indoor          : out    vl_logic_vector(3 downto 0);
        outdoor         : out    vl_logic_vector(5 downto 0);
        state           : out    vl_logic_vector(3 downto 0)
    );
end top;
