library verilog;
use verilog.vl_types.all;
entity indoor_request_vlg_check_tst is
    port(
        request_in_seq  : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end indoor_request_vlg_check_tst;
