/*module selection(key,pressed,sel_num,sel_bit);
input[3:0]key;
input pressed;
output[3:0]sel_num;
reg[3:0]sel_num;
output[2:0]sel_bit;
reg[2:0]sel_bit;
always@(posedge pressed)
begin
	sel_num<=key;
	sel_bit<=sel_bit+1'b1;
end
endmodule*/