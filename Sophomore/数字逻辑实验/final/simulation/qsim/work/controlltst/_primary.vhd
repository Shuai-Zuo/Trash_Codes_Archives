library verilog;
use verilog.vl_types.all;
entity controlltst is
    port(
        inc_Floor       : out    vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        result_Con      : in     vl_logic;
        red_Floor       : out    vl_logic;
        ce              : out    vl_logic;
        up_d            : out    vl_logic;
        stop_r          : out    vl_logic;
        rst             : out    vl_logic;
        sel_Con         : out    vl_logic_vector(1 downto 0);
        state           : out    vl_logic_vector(3 downto 0)
    );
end controlltst;
