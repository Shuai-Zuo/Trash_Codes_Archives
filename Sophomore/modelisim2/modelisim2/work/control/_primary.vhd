library verilog;
use verilog.vl_types.all;
entity control is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        zero            : in     vl_logic;
        PCWr            : out    vl_logic;
        IRWr            : out    vl_logic;
        RegDst          : out    vl_logic_vector(1 downto 0);
        MemtoReg        : out    vl_logic_vector(1 downto 0);
        RegWr           : out    vl_logic;
        ALUctr          : out    vl_logic_vector(2 downto 0);
        ALUsrc          : out    vl_logic;
        npc_sel         : out    vl_logic_vector(2 downto 0);
        MemWr           : out    vl_logic;
        Extop           : out    vl_logic;
        opcode          : in     vl_logic_vector(5 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        sbsel           : out    vl_logic;
        lbsel           : out    vl_logic;
        state_in        : out    vl_logic_vector(3 downto 0);
        state_out       : out    vl_logic_vector(3 downto 0)
    );
end control;
