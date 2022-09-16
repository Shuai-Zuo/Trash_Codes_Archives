library verilog;
use verilog.vl_types.all;
entity gpr is
    port(
        ReadReg1        : in     vl_logic_vector(4 downto 0);
        ReadReg2        : in     vl_logic_vector(4 downto 0);
        WriteReg        : in     vl_logic_vector(4 downto 0);
        WriteData       : in     vl_logic_vector(31 downto 0);
        ReadData1       : out    vl_logic_vector(31 downto 0);
        ReadData2       : out    vl_logic_vector(31 downto 0);
        RegWrite        : in     vl_logic;
        rst             : in     vl_logic;
        \OF\            : in     vl_logic
    );
end gpr;
