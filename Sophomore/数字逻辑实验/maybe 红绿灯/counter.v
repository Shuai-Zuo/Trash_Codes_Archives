module counter(clk,red,yel,gre,con,mod,rst);
input clk;
input rst;
input [1:0]mod;
input[5:0]red,yel,gre;
output reg con=1'b0;
reg [32:0]num=0;
always@(posedge clk or posedge rst)
begin
if(rst)
begin
	num<=1'b0;
	con<=1'b0;
end
else
	if(con)
	begin
		if(num<1'b1)
			num<=num+1'b1;
		else
		begin
			num<=1'b0;
			con<=1'b0;
		end
	end
	else
	begin
		case(mod)
		2'b00:begin
			if(num<red*3'd5)
				num<=num+1'b1;
			else
			begin
				num<=1'b0;
				con<=1'b1;
			end
		end
		2'b01:begin
			if(num<yel*3'd5)
				num<=num+1'b1;
			else
			begin
				num<=1'b0;
				con<=1'b1;
			end
		end
		2'b10:begin
			if(num<gre*3'd5)
				num<=num+1'b1;
			else
			begin
				num<=1'b0;
				con<=1'b1;
			end
		end
		2'b11:begin
			if(num<red)
				num<=num+1'b1;
			else
			begin
				num<=1'b0;
				con<=1'b1;
			end
		end
	endcase
	end
end
endmodule