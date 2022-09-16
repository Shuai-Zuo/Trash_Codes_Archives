library verilog;
use verilog.vl_types.all;
entity top_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        inside          : in     vl_logic_vector(3 downto 0);
        outside         : in     vl_logic_vector(5 downto 0);
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end top_vlg_sample_tst;
