library verilog;
use verilog.vl_types.all;
entity red_vlg_check_tst is
    port(
        \out\           : in     vl_logic_vector(1 downto 0);
        pin_name1       : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end red_vlg_check_tst;
