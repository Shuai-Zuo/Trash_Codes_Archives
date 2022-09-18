library verilog;
use verilog.vl_types.all;
entity scan_vlg_check_tst is
    port(
        QA              : in     vl_logic;
        QB              : in     vl_logic;
        QC              : in     vl_logic;
        QD              : in     vl_logic;
        QE              : in     vl_logic;
        QF              : in     vl_logic;
        QG              : in     vl_logic;
        QH              : in     vl_logic;
        SEL             : in     vl_logic_vector(2 downto 0);
        sampler_rx      : in     vl_logic
    );
end scan_vlg_check_tst;
