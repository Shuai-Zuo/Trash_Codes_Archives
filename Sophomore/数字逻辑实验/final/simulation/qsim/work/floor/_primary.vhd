library verilog;
use verilog.vl_types.all;
entity floor is
    port(
        inc_Floor       : in     vl_logic;
        red_Floor       : in     vl_logic;
        rst             : in     vl_logic;
        cur_Floor       : out    vl_logic_vector(1 downto 0)
    );
end floor;
