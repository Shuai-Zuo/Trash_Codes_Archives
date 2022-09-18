library verilog;
use verilog.vl_types.all;
entity experimentIII_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        en              : in     vl_logic;
        rst             : in     vl_logic;
        sel             : in     vl_logic_vector(2 downto 0);
        stop            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end experimentIII_vlg_sample_tst;
