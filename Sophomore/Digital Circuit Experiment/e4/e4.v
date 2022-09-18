module e4(a,b,c,co);
input[3:0] a,b;
output[3:0] c;
output co;
reg[3:0] c;
reg co;
reg[4:0] sum;
always @(a or b)
begin
	sum=a+b;
	if(a>4'b1001|b>4'b1001)
		{co,c}=5'b11111;
	else if(sum>5'b01001)
		{co,c}=sum-5'b01010;
		else {co,c}=sum+5'b10000;
end
endmodule