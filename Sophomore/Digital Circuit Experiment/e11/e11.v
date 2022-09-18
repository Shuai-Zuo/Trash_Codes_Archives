module e11(swr,swc,QA,QB,QC,QD,QE,QF,QG,QH,a,b,c,d,e,f,g,h,rst_freq,rst,clk_50MHz,en);
input[3:0]swr;
input rst_freq,rst,en;
input clk_50MHz;
output[3:0]swc;
output QA,QB,QC,QD,QE,QF,QG,QH;
output a,b,c,d,e,f,g,h;
wire clk_1Hz,clk_10Hz,clk_100Hz,clk_1KHz,pressed;
wire[3:0]key;
wire[3:0]out;
wire[2:0]sel;
wire flag;
keyboard_scan(clk_50MHz,rst,swc,swr,key,pressed);
nambscld(out,a,b,c,d,e,f,g,h);
scan2(clk_50MHz,sel,QA,QB,QC,QD,QE,QF,QG,QH);
exp7(rst_freq,clk_50MHz,clk_1Hz,clk_10Hz,clk_100Hz,clk_1KHz);
experiment31(clk_50MHz,rst,pressed,key,en,sel,out,flag);
endmodule