library verilog;
use verilog.vl_types.all;
entity exp6 is
    port(
        CLRN            : in     vl_logic;
        LDN             : in     vl_logic;
        ENP             : in     vl_logic;
        ENT             : in     vl_logic;
        CLK             : in     vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic;
        C               : in     vl_logic;
        D               : in     vl_logic;
        RCO             : out    vl_logic;
        QA              : out    vl_logic;
        QB              : out    vl_logic;
        QC              : out    vl_logic;
        QD              : out    vl_logic
    );
end exp6;
