library verilog;
use verilog.vl_types.all;
entity a31 is
    port(
        a               : out    vl_logic;
        en              : in     vl_logic;
        in1             : in     vl_logic_vector(3 downto 0);
        in2             : in     vl_logic_vector(3 downto 0);
        sel2            : in     vl_logic;
        sel1            : in     vl_logic;
        sel0            : in     vl_logic;
        b               : out    vl_logic;
        c               : out    vl_logic;
        d               : out    vl_logic;
        e               : out    vl_logic;
        f               : out    vl_logic;
        g               : out    vl_logic;
        sel             : out    vl_logic
    );
end a31;
