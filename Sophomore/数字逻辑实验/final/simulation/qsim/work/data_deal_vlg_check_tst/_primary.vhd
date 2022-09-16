library verilog;
use verilog.vl_types.all;
entity data_deal_vlg_check_tst is
    port(
        cur_Floor       : in     vl_logic_vector(1 downto 0);
        out_state_dir   : in     vl_logic;
        out_state_run   : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end data_deal_vlg_check_tst;
