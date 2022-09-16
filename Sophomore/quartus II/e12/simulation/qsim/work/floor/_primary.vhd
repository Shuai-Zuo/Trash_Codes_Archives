library verilog;
use verilog.vl_types.all;
entity floor is
    port(
        request_in_seq  : out    vl_logic_vector(3 downto 0);
        rst             : in     vl_logic;
        opnd            : in     vl_logic;
        current_floor   : in     vl_logic_vector(1 downto 0);
        request_in      : in     vl_logic_vector(3 downto 0);
        request_out_seq : out    vl_logic_vector(5 downto 0);
        request_out_down: in     vl_logic_vector(2 downto 0);
        request_out_up  : in     vl_logic_vector(2 downto 0)
    );
end floor;
