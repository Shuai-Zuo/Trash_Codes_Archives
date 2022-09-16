/*module selection_8t1(key,pressed,en,clk,sel,out,in1,in2,in3,in4,in5,in6,in7,in8);
input[3:0]key;
input pressed;
input en,clk;
input [2:0] sel;
wire[3:0]sel_num;
wire[2:0]sel_bit;
output [3:0] out;
output[3:0] in1,in2,in3,in4,in5,in6,in7,in8;
selection(key,pressed,sel_num,sel_bit);
experiment31(sel_bit,sel_num,clk,en,sel,out,in1,in2,in3,in4,in5,in6,in7,in8);
endmodule*/