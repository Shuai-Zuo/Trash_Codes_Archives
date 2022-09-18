module zuo_2(B,clk,Q,mflag,S);
input B,clk,mfalg;
output [15:0]Q;
reg[15:0]Q;
output S;
reg S;
always@(posedge clk or posedge B)
