library verilog;
use verilog.vl_types.all;
entity counter_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        gre             : in     vl_logic_vector(5 downto 0);
        \mod\           : in     vl_logic_vector(1 downto 0);
        red             : in     vl_logic_vector(5 downto 0);
        yel             : in     vl_logic_vector(5 downto 0);
        sampler_tx      : out    vl_logic
    );
end counter_vlg_sample_tst;
