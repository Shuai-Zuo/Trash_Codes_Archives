library verilog;
use verilog.vl_types.all;
entity t2 is
    port(
        inc_Floor       : out    vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        set_call        : in     vl_logic_vector(5 downto 0);
        set_dest        : in     vl_logic_vector(3 downto 0);
        red_Floor       : out    vl_logic;
        ce              : out    vl_logic;
        up_d            : out    vl_logic;
        stop_r          : out    vl_logic;
        rst             : out    vl_logic;
        out_state_run   : out    vl_logic;
        out_state_dir   : out    vl_logic;
        result          : out    vl_logic;
        cuir_Floor      : out    vl_logic_vector(1 downto 0);
        get_call        : out    vl_logic_vector(5 downto 0);
        get_dest        : out    vl_logic_vector(3 downto 0);
        state           : out    vl_logic_vector(3 downto 0)
    );
end t2;
