library verilog;
use verilog.vl_types.all;
entity experiment31_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        en              : in     vl_logic;
        key             : in     vl_logic_vector(3 downto 0);
        pressed         : in     vl_logic;
        sel             : in     vl_logic_vector(2 downto 0);
        sampler_tx      : out    vl_logic
    );
end experiment31_vlg_sample_tst;
