library verilog;
use verilog.vl_types.all;
entity indoor_request is
    port(
        request_in      : in     vl_logic_vector(3 downto 0);
        rst             : in     vl_logic;
        opnd            : in     vl_logic;
        current_floor   : in     vl_logic_vector(1 downto 0);
        request_in_seq  : out    vl_logic_vector(3 downto 0)
    );
end indoor_request;
