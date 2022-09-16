library verilog;
use verilog.vl_types.all;
entity a31_vlg_sample_tst is
    port(
        en              : in     vl_logic;
        in1             : in     vl_logic_vector(3 downto 0);
        in2             : in     vl_logic_vector(3 downto 0);
        sel0            : in     vl_logic;
        sel1            : in     vl_logic;
        sel2            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end a31_vlg_sample_tst;
