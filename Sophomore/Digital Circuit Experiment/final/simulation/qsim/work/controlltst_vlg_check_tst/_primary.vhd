library verilog;
use verilog.vl_types.all;
entity controlltst_vlg_check_tst is
    port(
        ce              : in     vl_logic;
        inc_Floor       : in     vl_logic;
        red_Floor       : in     vl_logic;
        rst             : in     vl_logic;
        sel_Con         : in     vl_logic_vector(1 downto 0);
        state           : in     vl_logic_vector(3 downto 0);
        stop_r          : in     vl_logic;
        up_d            : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end controlltst_vlg_check_tst;
