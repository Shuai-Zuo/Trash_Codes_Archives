library verilog;
use verilog.vl_types.all;
entity exp8_top_vlg_sample_tst is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        C               : in     vl_logic;
        CLK             : in     vl_logic;
        CLRN            : in     vl_logic;
        D               : in     vl_logic;
        DSL             : in     vl_logic;
        DSR             : in     vl_logic;
        S               : in     vl_logic_vector(1 downto 0);
        rst             : in     vl_logic;
        switch          : in     vl_logic_vector(1 downto 0);
        sampler_tx      : out    vl_logic
    );
end exp8_top_vlg_sample_tst;
