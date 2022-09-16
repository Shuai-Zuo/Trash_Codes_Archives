library verilog;
use verilog.vl_types.all;
entity t2_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        set_call        : in     vl_logic_vector(5 downto 0);
        set_dest        : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end t2_vlg_sample_tst;
