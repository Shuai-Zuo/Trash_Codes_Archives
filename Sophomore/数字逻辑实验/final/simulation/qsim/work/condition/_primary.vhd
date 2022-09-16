library verilog;
use verilog.vl_types.all;
entity condition is
    port(
        get_dest        : in     vl_logic_vector(3 downto 0);
        get_call        : in     vl_logic_vector(5 downto 0);
        cur_Floor       : in     vl_logic_vector(1 downto 0);
        sel_condition   : in     vl_logic_vector(1 downto 0);
        clk             : in     vl_logic;
        result          : out    vl_logic
    );
end condition;
