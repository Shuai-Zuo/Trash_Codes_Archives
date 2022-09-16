library verilog;
use verilog.vl_types.all;
entity exp6_vlg_sample_tst is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        C               : in     vl_logic;
        CLK             : in     vl_logic;
        CLRN            : in     vl_logic;
        D               : in     vl_logic;
        ENP             : in     vl_logic;
        ENT             : in     vl_logic;
        LDN             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end exp6_vlg_sample_tst;
