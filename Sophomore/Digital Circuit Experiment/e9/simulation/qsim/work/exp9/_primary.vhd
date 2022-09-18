library verilog;
use verilog.vl_types.all;
entity exp9 is
    port(
        clk             : in     vl_logic;
        x               : in     vl_logic;
        reset           : in     vl_logic;
        z               : out    vl_logic;
        current_state   : out    vl_logic_vector(2 downto 0);
        next_state      : out    vl_logic_vector(2 downto 0)
    );
end exp9;
