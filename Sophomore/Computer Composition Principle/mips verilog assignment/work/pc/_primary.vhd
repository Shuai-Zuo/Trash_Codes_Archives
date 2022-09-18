library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        clk             : in     vl_logic;
        NPC             : in     vl_logic_vector(29 downto 0);
        PCWr            : in     vl_logic;
        PCout           : out    vl_logic_vector(29 downto 0);
        rst             : in     vl_logic
    );
end pc;
