library verilog;
use verilog.vl_types.all;
entity t2_vlg_check_tst is
    port(
        ce              : in     vl_logic;
        cuir_Floor      : in     vl_logic_vector(1 downto 0);
        get_call        : in     vl_logic_vector(5 downto 0);
        get_dest        : in     vl_logic_vector(3 downto 0);
        inc_Floor       : in     vl_logic;
        out_state_dir   : in     vl_logic;
        out_state_run   : in     vl_logic;
        red_Floor       : in     vl_logic;
        result          : in     vl_logic;
        rst             : in     vl_logic;
        state           : in     vl_logic_vector(3 downto 0);
        stop_r          : in     vl_logic;
        up_d            : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end t2_vlg_check_tst;
