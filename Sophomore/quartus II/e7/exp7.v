module exp7(rst,clk_50MHz,clk);
input rst,clk_50MHz;
output clk;
reg clk;
reg [31:0] cnt;
parameter N=25000000;//1hz
//parameter N=2500000;//10hz
//parameter N=250000;//100hz
//parameter N=25000;//1Khz
always@(posedge clk_50MHz)
	if(!rst)
		if(cnt==N)
		begin
			cnt<=1'b0;
			clk<=~clk;
		end
		else
		begin
			cnt<=cnt+1'b1;
		end
	else
	begin
		cnt<=1'b0;
		clk<=1'b0;
	end
endmodule