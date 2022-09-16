module _212(stop,clk,clko);
input stop;
input clk;
output clko;
assign clko=(stop)?clk:1'b0;
endmodule