library verilog;
use verilog.vl_types.all;
entity exp8 is
    port(
        CLRN            : in     vl_logic;
        S               : in     vl_logic_vector(1 downto 0);
        DSL             : in     vl_logic;
        DSR             : in     vl_logic;
        CLK             : in     vl_logic;
        D               : in     vl_logic;
        C               : in     vl_logic;
        B               : in     vl_logic;
        A               : in     vl_logic;
        QD              : out    vl_logic;
        QC              : out    vl_logic;
        QB              : out    vl_logic;
        QA              : out    vl_logic
    );
end exp8;
