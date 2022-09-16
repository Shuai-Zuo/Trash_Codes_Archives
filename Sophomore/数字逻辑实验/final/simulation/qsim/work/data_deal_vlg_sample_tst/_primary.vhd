library verilog;
use verilog.vl_types.all;
entity data_deal_vlg_sample_tst is
    port(
        inc_Floor       : in     vl_logic;
        red_Floor       : in     vl_logic;
        rst             : in     vl_logic;
        stop_r          : in     vl_logic;
        up_d            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end data_deal_vlg_sample_tst;
