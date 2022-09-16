module nambscld(data,a,b,c,d,e,f,g,sel);
input[3:0] data;
output a,b,c,d,e,f,g;
output sel;
reg a,b,c,d,e,f,g;
assign sel=1'b0;
always@(data)
begin
	case(data)
	4'b0000:{a,b,c,d,e,f,g}=7'b1111110;
	4'b0001:{a,b,c,d,e,f,g}=7'b0110000;
	4'b0010:{a,b,c,d,e,f,g}=7'b1101101;
	4'b0011:{a,b,c,d,e,f,g}=7'b1111001;
	4'b0100:{a,b,c,d,e,f,g}=7'b0110011;
	4'b0101:{a,b,c,d,e,f,g}=7'b1011011;
	4'b0110:{a,b,c,d,e,f,g}=7'b1011111;
	4'b0111:{a,b,c,d,e,f,g}=7'b1110000;
	4'b1000:{a,b,c,d,e,f,g}=7'b1111111;
	4'b1001:{a,b,c,d,e,f,g}=7'b1111011;
	default:{a,b,c,d,e,f,g}=7'b1001111;
	endcase
end
endmodule
