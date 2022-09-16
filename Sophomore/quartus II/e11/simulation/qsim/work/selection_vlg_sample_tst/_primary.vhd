library verilog;
use verilog.vl_types.all;
entity selection_vlg_sample_tst is
    port(
        key             : in     vl_logic_vector(3 downto 0);
        pressed         : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end selection_vlg_sample_tst;
