library verilog;
use verilog.vl_types.all;
entity exp10_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        en              : in     vl_logic;
        rst             : in     vl_logic;
        rst_freq        : in     vl_logic;
        stop            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end exp10_vlg_sample_tst;
