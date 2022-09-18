library verilog;
use verilog.vl_types.all;
entity top_vlg_check_tst is
    port(
        ce              : in     vl_logic;
        curfloor        : in     vl_logic_vector(1 downto 0);
        inc             : in     vl_logic;
        indoor          : in     vl_logic_vector(3 downto 0);
        outdoor         : in     vl_logic_vector(5 downto 0);
        red             : in     vl_logic;
        rst_con         : in     vl_logic;
        state           : in     vl_logic_vector(3 downto 0);
        stoprun         : in     vl_logic;
        updown          : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end top_vlg_check_tst;
