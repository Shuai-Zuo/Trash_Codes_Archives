library verilog;
use verilog.vl_types.all;
entity floor_vlg_check_tst is
    port(
        cur_Floor       : in     vl_logic_vector(1 downto 0);
        sampler_rx      : in     vl_logic
    );
end floor_vlg_check_tst;
