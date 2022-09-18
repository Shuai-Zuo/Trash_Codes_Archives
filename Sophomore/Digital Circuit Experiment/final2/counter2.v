module counter2(clk,rst,count,red,yel,gre);
output count;
input clk,rst;
input[5:0]red,yel,gre;
reg[7:0] count;
always@(posedge clk or negedge rst)
begin
	if(!rst)
		count<=7'd0;
	else if(count<red+yel+gre)
		count<=count+1;
	else
		count<=7'd1;
end
endmodule