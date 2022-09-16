library verilog;
use verilog.vl_types.all;
entity e11_vlg_check_tst is
    port(
        QA              : in     vl_logic;
        QB              : in     vl_logic;
        QC              : in     vl_logic;
        QD              : in     vl_logic;
        QE              : in     vl_logic;
        QF              : in     vl_logic;
        QG              : in     vl_logic;
        QH              : in     vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : in     vl_logic;
        d               : in     vl_logic;
        e               : in     vl_logic;
        f               : in     vl_logic;
        g               : in     vl_logic;
        h               : in     vl_logic;
        swc             : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end e11_vlg_check_tst;
