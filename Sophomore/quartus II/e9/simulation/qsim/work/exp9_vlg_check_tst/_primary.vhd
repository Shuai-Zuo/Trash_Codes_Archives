library verilog;
use verilog.vl_types.all;
entity exp9_vlg_check_tst is
    port(
        current_state   : in     vl_logic_vector(2 downto 0);
        next_state      : in     vl_logic_vector(2 downto 0);
        z               : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end exp9_vlg_check_tst;
