module _4reg(ldn,num,outn);
input ldn;
input[5:0]num;
output reg [5:0]outn=6'd30;
always@(posedge ldn)
begin
	outn<=num;
end
endmodule