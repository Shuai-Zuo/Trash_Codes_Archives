library verilog;
use verilog.vl_types.all;
entity exp6_top is
    port(
        CLRN            : in     vl_logic;
        LDN             : in     vl_logic;
        ENP             : in     vl_logic;
        ENT             : in     vl_logic;
        CLK             : in     vl_logic;
        A1              : in     vl_logic;
        B1              : in     vl_logic;
        C1              : in     vl_logic;
        D1              : in     vl_logic;
        RCO             : out    vl_logic;
        a               : out    vl_logic;
        b               : out    vl_logic;
        c               : out    vl_logic;
        d               : out    vl_logic;
        e               : out    vl_logic;
        f               : out    vl_logic;
        g               : out    vl_logic;
        sel             : out    vl_logic
    );
end exp6_top;
