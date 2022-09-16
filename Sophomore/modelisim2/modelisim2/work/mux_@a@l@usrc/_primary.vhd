library verilog;
use verilog.vl_types.all;
entity mux_ALUsrc is
    port(
        ReadData2       : in     vl_logic_vector(31 downto 0);
        extOut          : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0);
        ALUsrc          : in     vl_logic
    );
end mux_ALUsrc;
