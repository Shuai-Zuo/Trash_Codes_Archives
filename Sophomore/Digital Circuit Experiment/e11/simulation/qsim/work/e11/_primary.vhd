library verilog;
use verilog.vl_types.all;
entity e11 is
    port(
        swr             : in     vl_logic_vector(3 downto 0);
        swc             : out    vl_logic_vector(3 downto 0);
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
        h               : out    vl_logic;
        rst_freq        : in     vl_logic;
        rst             : in     vl_logic;
        clk_50MHz       : in     vl_logic;
        en              : in     vl_logic
    );
end e11;
