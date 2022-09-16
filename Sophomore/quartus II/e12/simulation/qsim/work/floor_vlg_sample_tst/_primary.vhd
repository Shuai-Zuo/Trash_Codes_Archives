library verilog;
use verilog.vl_types.all;
entity floor_vlg_sample_tst is
    port(
        current_floor   : in     vl_logic_vector(1 downto 0);
        opnd            : in     vl_logic;
        request_in      : in     vl_logic_vector(3 downto 0);
        request_out_down: in     vl_logic_vector(2 downto 0);
        request_out_up  : in     vl_logic_vector(2 downto 0);
        rst             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end floor_vlg_sample_tst;
