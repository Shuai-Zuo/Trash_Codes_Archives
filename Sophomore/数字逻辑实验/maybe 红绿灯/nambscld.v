module nambscld(data,a,b,c,d,e,f,g,h);
input[3:0] data;
output a,b,c,d,e,f,g,h;
reg a,b,c,d,e,f,g,h;
always@(data)
begin
	case(data)
	4'b0000:{a,b,c,d,e,f,g,h}=8'b11111100;
	4'b0001:{a,b,c,d,e,f,g,h}=8'b01100000;
	4'b0010:{a,b,c,d,e,f,g,h}=8'b11011010;
	4'b0011:{a,b,c,d,e,f,g,h}=8'b11110010;
	4'b0100:{a,b,c,d,e,f,g,h}=8'b01100110;
	4'b0101:{a,b,c,d,e,f,g,h}=8'b10110110;
	4'b0110:{a,b,c,d,e,f,g,h}=8'b10111110;
	4'b0111:{a,b,c,d,e,f,g,h}=8'b11100000;
	4'b1000:{a,b,c,d,e,f,g,h}=8'b11111110;
	4'b1001:{a,b,c,d,e,f,g,h}=8'b11110110;
	4'b1110:{a,b,c,d,e,f,g,h}=8'b10110110;
	default:{a,b,c,d,e,f,g,h}=8'b10011110;
	endcase
end
endmodule
