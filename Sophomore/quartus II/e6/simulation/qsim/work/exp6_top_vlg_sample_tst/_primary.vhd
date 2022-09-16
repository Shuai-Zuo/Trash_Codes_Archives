library verilog;
use verilog.vl_types.all;
entity exp6_top_vlg_sample_tst is
    port(
        A1              : in     vl_logic;
        B1              : in     vl_logic;
        C1              : in     vl_logic;
        CLK             : in     vl_logic;
        CLRN            : in     vl_logic;
        D1              : in     vl_logic;
        ENP             : in     vl_logic;
        ENT             : in     vl_logic;
        LDN             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end exp6_top_vlg_sample_tst;
