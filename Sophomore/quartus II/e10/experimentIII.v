module experimentIII(rst,stop,en,sel,out,clk);
input en,clk,rst,stop;
input [2:0] sel;
output [3:0] out;
reg [3:0]out;
reg [3:0]in8,in7,in6,in5,in4,in3,in2,in1;
always@(posedge clk)
begin
	if(rst)
	begin
		if(stop)
		begin
			case(in8)
			4'b1001:in8<=4'b0000;
			default:in8<=in8+1'b1;
			endcase
			case(in7)
			4'b1001:if(in8==4'b1001)in7<=4'b0000;
			default:if(in8==4'b1001)in7<=in7+1'b1;
			endcase
			case(in6)
			4'b1001:if(in7==4'b1001&&in8==4'b1001)in6<=4'b0000;
			default:if(in7==4'b1001&&in8==4'b1001)in6<=in6+1'b1;
			endcase
			case(in5)
			4'b1001:if(in6==4'b1001&&in7==4'b1001&&in8==4'b1001)in5<=4'b0000;
			default:if(in6==4'b1001&&in7==4'b1001&&in8==4'b1001)in5<=in5+1'b1;
			endcase
			case(in4)
			4'b0110:if(in5==4'b1001&&in6==4'b1001&&in7==4'b1001&&in8==4'b1001)in4<=4'b0000;
			default:if(in5==4'b1001&&in6==4'b1001&&in7==4'b1001&&in8==4'b1001)in4<=in4+1'b1;
			endcase
			case(in3)
			4'b1001:if(in4==4'b0110&&in5==4'b1001&&in6==4'b1001&&in7==4'b1001&&in8==4'b1001)in3<=4'b0000;
			default:if(in4==4'b0110&&in5==4'b1001&&in6==4'b1001&&in7==4'b1001&&in8==4'b1001)in3<=in3+1'b1;
			endcase
			case(in2)
			4'b0110:if(in3==4'b1001&&in4==4'b0110&&in5==4'b1001&&in6==4'b1001&&in7==4'b1001&&in8==4'b1001)in2<=4'b0000;
			default:if(in3==4'b1001&&in4==4'b0110&&in5==4'b1001&&in6==4'b1001&&in7==4'b1001&&in8==4'b1001)in2<=in2+1'b1;
			endcase
			case(in1)
			4'b1001:if(in2==4'b0110&&in3==4'b1001&&in4==4'b0110&&in5==4'b1001&&in6==4'b1001&&in7==4'b1001&&in8==4'b100)in1<=4'b0000;
			default:if(in2==4'b0110&&in3==4'b1001&&in4==4'b0110&&in5==4'b1001&&in6==4'b1001&&in7==4'b1001&&in8==4'b100)in1<=in1+1'b1;
			endcase
		end
	end
	else 
	begin
		{in8,in7,in6,in5,in4,in3,in2,in1}=32'b0;
	end
end	
always@(en or sel or in1 or in2)
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
		else out=4'b1111;
	end
endmodule

				