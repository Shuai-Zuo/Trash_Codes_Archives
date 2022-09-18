library verilog;
use verilog.vl_types.all;
entity condition_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        cur_Floor       : in     vl_logic_vector(1 downto 0);
        get_call        : in     vl_logic_vector(5 downto 0);
        get_dest        : in     vl_logic_vector(3 downto 0);
        sel_condition   : in     vl_logic_vector(1 downto 0);
        sampler_tx      : out    vl_logic
    );
end condition_vlg_sample_tst;
