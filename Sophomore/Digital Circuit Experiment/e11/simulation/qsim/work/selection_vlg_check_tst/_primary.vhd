library verilog;
use verilog.vl_types.all;
entity selection_vlg_check_tst is
    port(
        sel_bit         : in     vl_logic_vector(2 downto 0);
        sel_num         : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end selection_vlg_check_tst;
