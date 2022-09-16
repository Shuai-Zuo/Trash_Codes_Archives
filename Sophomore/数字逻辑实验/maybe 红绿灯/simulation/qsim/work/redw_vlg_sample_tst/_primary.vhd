library verilog;
use verilog.vl_types.all;
entity redw_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        gre             : in     vl_logic_vector(5 downto 0);
        ldn             : in     vl_logic;
        red             : in     vl_logic_vector(5 downto 0);
        rst             : in     vl_logic;
        rst_fre         : in     vl_logic;
        s1              : in     vl_logic;
        s2              : in     vl_logic;
        stop            : in     vl_logic;
        yel             : in     vl_logic_vector(5 downto 0);
        sampler_tx      : out    vl_logic
    );
end redw_vlg_sample_tst;
