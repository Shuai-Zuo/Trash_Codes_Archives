module floor(inc_Floor,red_Floor,rst,cur_Floor);
input inc_Floor,red_Floor,rst;
output [1:0] cur_Floor;
reg [1:0] cur_Floor;
reg floor_clk,inc,red;
/*
always @ (posedge rst or posedge inc_Floor)
begin
if(rst)
cur_Floor<=2'b00;
else
begin
if(inc_Floor)
	cur_Floor<=cur_Floor+1;
end
end


always @ (posedge rst or posedge red_Floor)
 begin
if(rst)
cur_Floor<=2'b00;
else
begin
if(red_Floor)
	cur_Floor<=cur_Floor-1;
end
end
*/

always @ (rst or inc_Floor or red_Floor)
begin
	if(rst)
		floor_clk=0;
	else
	begin
		if(inc_Floor || red_Floor)
		begin
			floor_clk=1;
		if(inc_Floor)
		begin
			inc<=1;
			red<=0;
		end
		else
		begin
			inc<=0;
			red<=1;
		end
	end
		else
begin
floor_clk=0;
	inc<=0;
	red<=0;
end
end
end

always@(posedge floor_clk or posedge rst)
begin
if(rst==1)
cur_Floor<=2'b00;
else
begin 
if(inc)
cur_Floor<=cur_Floor+1;
else    
begin
	if(red)
	cur_Floor<=cur_Floor-1;
end
end
end
endmodule