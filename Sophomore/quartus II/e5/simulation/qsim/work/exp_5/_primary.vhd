library verilog;
use verilog.vl_types.all;
entity exp_5 is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end exp_5;
