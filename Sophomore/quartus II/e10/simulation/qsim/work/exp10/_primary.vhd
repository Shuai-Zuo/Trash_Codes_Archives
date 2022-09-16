library verilog;
use verilog.vl_types.all;
entity exp10 is
    port(
        rst_freq        : in     vl_logic;
        QA              : out    vl_logic;
        QB              : out    vl_logic;
        QC              : out    vl_logic;
        QD              : out    vl_logic;
        QE              : out    vl_logic;
        QF              : out    vl_logic;
        QG              : out    vl_logic;
        QH              : out    vl_logic;
        a               : out    vl_logic;
        b               : out    vl_logic;
        c               : out    vl_logic;
        d               : out    vl_logic;
        e               : out    vl_logic;
        f               : out    vl_logic;
        g               : out    vl_logic;
        data            : out    vl_logic_vector(3 downto 0);
        en              : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        stop            : in     vl_logic
    );
end exp10;
