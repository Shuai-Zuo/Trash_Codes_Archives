module experiment31(clk,clr,pressed,key,en,sel,out,flag);
input en,pressed,clr,clk;
input [2:0] sel;
input [3:0] key;
reg[3:0] in1,in2,in3,in4,in5,in6,in7,in8;
output [3:0] out;
reg [3:0]out;
reg[2:0]count;
output flag;
reg flag;
always@(posedge pressed or negedge clr)
begin
	if(!clr)
	begin
		{in2,in3,in4,in5,in6,in7,in8}<=28'b0;
		count<=3'b000;
		flag<=1'b0;
	end
	else
	if(pressed)
		begin
			{in2,in3,in4,in5,in6,in7,in8}<={in1,in2,in3,in4,in5,in6,in7};
			if(count<3'b111)
				count<=count+1'b1;
			else
				flag<=1'b1;
		end
end

always@(posedge clk or negedge clr)
begin
	if(!clr)
		in1<=4'b0000;
	else
		if(pressed)
			in1<=key;
end
always @(en or sel)
	begin
		if(en)
			case(sel)
				3'b000:out=in1;
				3'b001:out=in2;
				3'b010:out=in3;
				3'b011:out=in4;
				3'b100:out=in5;
				3'b101:out=in6;
				3'b110:out=in7;
				3'b111:out=in8;
			endcase
		else out=4'b0000;
	end
endmodule

				