module experimentIII (en,in1,in2,sel,out);
input en;
input [2:0] sel;
input [3:0] in1,in2;
output [3:0] out;
parameter in8=4'b0001;
parameter in7=4'b1000;
parameter in6=4'b0000;
parameter in5=4'b0111;
parameter in4=4'b0100;
parameter in3=4'b0001;
reg [0:3]out;
always @(en or sel or in1 or in2)
	begin
		if(en)
			case(sel)
				3'b000:out=~in1;
				3'b001:out=~in2;
				3'b010:out=~in3;
				3'b011:out=~in4;
				3'b100:out=~in5;
				3'b101:out=~in6;
				3'b110:out=~in7;
				3'b111:out=~in8;
			endcase
		else out=4'b1111;
	end
endmodule

				