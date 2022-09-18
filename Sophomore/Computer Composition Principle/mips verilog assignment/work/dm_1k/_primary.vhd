library verilog;
use verilog.vl_types.all;
entity dm_1k is
    port(
        addr            : in     vl_logic_vector(9 downto 0);
        din             : in     vl_logic_vector(31 downto 0);
        dout            : out    vl_logic_vector(31 downto 0);
        we              : in     vl_logic;
        sbsel           : in     vl_logic
    );
end dm_1k;
