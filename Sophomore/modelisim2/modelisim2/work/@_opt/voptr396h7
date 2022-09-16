library verilog;
use verilog.vl_types.all;
entity npc is
    port(
        PC              : in     vl_logic_vector(29 downto 0);
        \IMM\           : in     vl_logic_vector(25 downto 0);
        nPC_sel         : in     vl_logic_vector(2 downto 0);
        rs              : in     vl_logic_vector(29 downto 0);
        NPC             : out    vl_logic_vector(29 downto 0);
        DPC             : out    vl_logic_vector(31 downto 0);
        imm             : in     vl_logic_vector(15 downto 0);
        busA            : in     vl_logic_vector(31 downto 0)
    );
end npc;
