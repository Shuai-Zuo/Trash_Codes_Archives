library verilog;
use verilog.vl_types.all;
entity LB is
    port(
        addr            : in     vl_logic_vector(1 downto 0);
        ReadData        : in     vl_logic_vector(31 downto 0);
        lbsel           : in     vl_logic;
        LBout           : out    vl_logic_vector(31 downto 0)
    );
end LB;
