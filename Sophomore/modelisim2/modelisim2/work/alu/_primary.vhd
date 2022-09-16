library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        ReadData1       : in     vl_logic_vector(31 downto 0);
        ReadData2       : in     vl_logic_vector(31 downto 0);
        ALUout          : out    vl_logic_vector(31 downto 0);
        zero            : out    vl_logic;
        ALUctr          : in     vl_logic_vector(2 downto 0);
        \OF\            : out    vl_logic
    );
end alu;
