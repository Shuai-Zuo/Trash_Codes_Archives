library verilog;
use verilog.vl_types.all;
entity e11_vlg_sample_tst is
    port(
        clk_50MHz       : in     vl_logic;
        en              : in     vl_logic;
        rst             : in     vl_logic;
        rst_freq        : in     vl_logic;
        swr             : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end e11_vlg_sample_tst;
