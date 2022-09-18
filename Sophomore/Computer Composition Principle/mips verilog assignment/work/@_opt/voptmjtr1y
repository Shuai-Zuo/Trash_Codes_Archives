library verilog;
use verilog.vl_types.all;
entity nextstate is
    generic(
        \IF\            : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi0);
        ID              : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi1);
        MA              : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi0);
        MR              : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi1);
        MemWB           : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi0, Hi0);
        MW              : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi0, Hi1);
        Exe             : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi1, Hi0);
        WB              : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi1, Hi1);
        Branch          : vl_logic_vector(3 downto 0) := (Hi1, Hi0, Hi0, Hi0);
        Jump            : vl_logic_vector(3 downto 0) := (Hi1, Hi0, Hi0, Hi1)
    );
    port(
        state_in        : in     vl_logic_vector(3 downto 0);
        opcode          : in     vl_logic_vector(5 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        state_next      : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of \IF\ : constant is 2;
    attribute mti_svvh_generic_type of ID : constant is 2;
    attribute mti_svvh_generic_type of MA : constant is 2;
    attribute mti_svvh_generic_type of MR : constant is 2;
    attribute mti_svvh_generic_type of MemWB : constant is 2;
    attribute mti_svvh_generic_type of MW : constant is 2;
    attribute mti_svvh_generic_type of Exe : constant is 2;
    attribute mti_svvh_generic_type of WB : constant is 2;
    attribute mti_svvh_generic_type of Branch : constant is 2;
    attribute mti_svvh_generic_type of Jump : constant is 2;
end nextstate;
