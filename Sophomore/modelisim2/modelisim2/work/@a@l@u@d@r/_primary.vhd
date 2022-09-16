library verilog;
use verilog.vl_types.all;
entity ALUDR is
    port(
        data_in         : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        data_out        : out    vl_logic_vector(31 downto 0)
    );
end ALUDR;
