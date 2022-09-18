module exp10(rst,stop,en,clk,rst_freq,QA,QB,QC,QD,QE,QF,QG,QH,a,b,c,d,e,f,g);
input rst,stop,en,clk,rst_freq;
output a,b,c,d,e,f,g;
output QA,QB,QC,QD,QE,QF,QG,QH;
wire[2:0]sel;
wire[3:0]data;
wire clk_50MHz,clk_1Hz,clk_10Hz,clk_100Hz,clk_1KHz;
nambscld(data,a,b,c,d,e,f,g);
scan2(clk,sel,QA,QB,QC,QD,QE,QF,QG,QH);
exp7(rst,clk_50MHz,clk_1Hz,clk_10Hz,clk_100Hz,clk_1KHz);
experimentIII(rst,stop,en,sel,data,clk);
endmodule