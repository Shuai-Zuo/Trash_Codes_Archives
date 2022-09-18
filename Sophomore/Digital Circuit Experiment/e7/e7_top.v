module e7_top(clk_50MHz,rst,reset,out);
input clk_50MHz,reset,rst;
output [15:0]out;
wire clk;
exp7(rst,clk_50MHz,clk);
exp_5(clk,reset,out);
endmodule