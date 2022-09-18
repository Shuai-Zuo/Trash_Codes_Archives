library verilog;
use verilog.vl_types.all;
entity data_deal is
    port(
        out_state_run   : out    vl_logic;
        rst             : in     vl_logic;
        stop_r          : in     vl_logic;
        out_state_dir   : out    vl_logic;
        up_d            : in     vl_logic;
        cur_Floor       : out    vl_logic_vector(1 downto 0);
        inc_Floor       : in     vl_logic;
        red_Floor       : in     vl_logic
    );
end data_deal;
