library verilog;
use verilog.vl_types.all;
entity floor_vlg_sample_tst is
    port(
        inc_Floor       : in     vl_logic;
        red_Floor       : in     vl_logic;
        rst             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end floor_vlg_sample_tst;
