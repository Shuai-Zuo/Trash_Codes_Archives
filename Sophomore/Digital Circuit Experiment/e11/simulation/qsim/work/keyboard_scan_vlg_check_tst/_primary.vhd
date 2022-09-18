library verilog;
use verilog.vl_types.all;
entity keyboard_scan_vlg_check_tst is
    port(
        key             : in     vl_logic_vector(3 downto 0);
        pressed         : in     vl_logic;
        swc             : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end keyboard_scan_vlg_check_tst;
