library verilog;
use verilog.vl_types.all;
entity keyboard_scan_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        swr             : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end keyboard_scan_vlg_sample_tst;
