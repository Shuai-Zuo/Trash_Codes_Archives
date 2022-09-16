library verilog;
use verilog.vl_types.all;
entity mux_MemtoReg is
    port(
        ALUout          : in     vl_logic_vector(31 downto 0);
        DMout           : in     vl_logic_vector(31 downto 0);
        DPC             : in     vl_logic_vector(31 downto 0);
        MemtoReg        : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end mux_MemtoReg;
