module keyboard_scan(clk,rst,swc,swr,key,pressed);
input[3:0]swr;
output[3:0]swc;
reg[3:0]swc;
output[3:0]key;
reg[3:0]key;
output pressed;
reg pressed;
reg[1:0]state;
input clk,rst;
always@(posedge clk or negedge rst)
begin
if(!rst)
	swc<=4'b0000;
else
	case(state)
		2'b00:swc<=4'b1110;
		2'b01:swc<=4'b0111;
		2'b10:swc<=4'b1011;
		2'b11:swc<=4'b1101;
	endcase
end
always@(posedge clk)
begin
	pressed=1'b0;
	case(state)
		2'b00:
		begin
			if(!(&swr))
				state<=2'b00;
			else
				state<=2'b01;
			case(swr)
				4'b1110:begin key=4'b0000;pressed=1'b1;end
				4'b1101:begin key=4'b0001;pressed=1'b1;end
				4'b1011:begin key=4'b0010;pressed=1'b1;end
				4'b0111:begin key=4'b0011;pressed=1'b1;end
				default:key=4'b0000;
			endcase
		end
		2'b01:
		begin
			if(!(&swr))
				state<=2'b01;
			else
				state<=2'b10;
			case(swr)
				4'b1110:begin key=4'b0100;pressed=1'b1;end
				4'b1101:begin key=4'b0101;pressed=1'b1;end
				4'b1011:begin key=4'b0110;pressed=1'b1;end
				4'b0111:begin key=4'b0111;pressed=1'b1;end
				default:key=4'b0000;
			endcase
		end
		2'b10:		
		begin
			if(!(&swr))
				state<=2'b10;
			else
				state<=2'b11;
			case(swr)
				4'b1110:begin key=4'b1000;pressed=1'b1;end
				4'b1101:begin key=4'b1001;pressed=1'b1;end
				4'b1011:begin key=4'b1010;pressed=1'b1;end
				4'b0111:begin key=4'b1011;pressed=1'b1;end
				default:key=4'b0000;
			endcase
		end
		2'b11:		
		begin
			if(!(&swr))
				state<=2'b11;
			else
				state<=2'b00;
			case(swr)
				4'b1110:begin key=4'b1100;pressed=1'b1;end
				4'b1101:begin key=4'b1101;pressed=1'b1;end
				4'b1011:begin key=4'b1110;pressed=1'b1;end
				4'b0111:begin key=4'b1111;pressed=1'b1;end
				default:key=4'b0000;
			endcase
		end
	endcase
end
endmodule