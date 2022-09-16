module experiment31 (en,in1,in2,in4,in5,sel,out);
input en;
input [2:0] sel;
input [3:0] in1,in2,in4,in5;
output [3:0] out;
reg [0:3]out;
always @(en or sel or in1 or in2)
	begin
		if(en)
			case(sel)
				3'b000:out=in1;
				3'b001:out=in2;
				3'b010:out=4'b1110;
				3'b011:out=in4;
				3'b100:out=in5;
				3'b101:out=4'b1111;
			endcase
		else out=4'b1111;
	end
endmodule

				