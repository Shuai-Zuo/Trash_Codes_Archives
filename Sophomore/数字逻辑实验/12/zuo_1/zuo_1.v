module zuo_1(A,takeA,W,mflag);
input A,takeA;
output[16:0]W;
output mflag;
reg [16:0]W;
reg mflag;
always@(posedge A or posedge takeA)
begin
	if(takeA)
	W=4'b1011111111111111;
	if(A)
	begin
	W=4'b0000000000000000;
	mflag=1;
	end
	
end
endmodule