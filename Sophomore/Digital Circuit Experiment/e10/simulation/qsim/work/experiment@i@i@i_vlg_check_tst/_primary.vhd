library verilog;
use verilog.vl_types.all;
entity experimentIII_vlg_check_tst is
    port(
        in1             : in     vl_logic_vector(3 downto 0);
        in2             : in     vl_logic_vector(3 downto 0);
        in3             : in     vl_logic_vector(3 downto 0);
        in4             : in     vl_logic_vector(3 downto 0);
        in5             : in     vl_logic_vector(3 downto 0);
        in6             : in     vl_logic_vector(3 downto 0);
        in7             : in     vl_logic_vector(3 downto 0);
        in8             : in     vl_logic_vector(3 downto 0);
        \out\           : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end experimentIII_vlg_check_tst;
