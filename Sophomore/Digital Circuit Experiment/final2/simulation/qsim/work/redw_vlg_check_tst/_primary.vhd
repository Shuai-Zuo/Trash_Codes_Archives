library verilog;
use verilog.vl_types.all;
entity redw_vlg_check_tst is
    port(
        count           : in     vl_logic_vector(7 downto 0);
        in1             : in     vl_logic_vector(3 downto 0);
        in2             : in     vl_logic_vector(3 downto 0);
        in4             : in     vl_logic_vector(3 downto 0);
        in5             : in     vl_logic_vector(3 downto 0);
        lighto1         : in     vl_logic_vector(2 downto 0);
        lighto2         : in     vl_logic_vector(2 downto 0);
        sampler_rx      : in     vl_logic
    );
end redw_vlg_check_tst;
