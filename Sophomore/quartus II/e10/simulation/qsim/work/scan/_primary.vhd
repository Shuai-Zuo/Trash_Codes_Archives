library verilog;
use verilog.vl_types.all;
entity scan is
    port(
        CLK             : in     vl_logic;
        QH              : out    vl_logic;
        QG              : out    vl_logic;
        QF              : out    vl_logic;
        QE              : out    vl_logic;
        QD              : out    vl_logic;
        QC              : out    vl_logic;
        QB              : out    vl_logic;
        QA              : out    vl_logic;
        SEL             : out    vl_logic_vector(2 downto 0)
    );
end scan;
