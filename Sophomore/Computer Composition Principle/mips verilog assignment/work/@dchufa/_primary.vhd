library verilog;
use verilog.vl_types.all;
entity Dchufa is
    port(
        state_in        : in     vl_logic_vector(3 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        state_out       : out    vl_logic_vector(3 downto 0)
    );
end Dchufa;
