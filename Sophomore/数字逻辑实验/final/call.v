module call(set_call,rst,cur_Floor,ce,get_call);
input [5:0] set_call;
input [1:0] cur_Floor;
input rst,ce;
output [5:0] get_call;
reg [5:0] get_call;
always @ (rst or ce or set_call[0] or cur_Floor)
begin
if(rst==1)
get_call[0]=0;
else if(set_call[0]==0)
begin
if(ce==0||cur_Floor!=0)
get_call[0]=1;
else
get_call[0]=0;
end
else
begin
if(ce==1&&cur_Floor==0)
get_call[0]=0;
end
end
always @ (rst or ce or set_call[1] or cur_Floor)
begin
if(rst==1)
get_call[1]=0;
else if(set_call[1]==0)
begin
if(ce==0||cur_Floor!=1)
get_call[1]=1;
else
get_call[1]=0;
end
else
begin
if(ce==1&&cur_Floor==1)
get_call[1]=0;
end
end
always @ (rst or ce or set_call[2] or cur_Floor)
begin
if(rst==1)
get_call[2]=0;
else if(set_call[2]==0)
begin
if(ce==0||cur_Floor!=1)
get_call[2]=1;
else
get_call[2]=0;
end
else
begin
if(ce==1&&cur_Floor==1)
get_call[2]=0;
end
end
always @ ( rst or  ce or  set_call[3] or cur_Floor)
begin
if(rst==1)
get_call[3]=0;
else if(set_call[3]==0)
begin
if(ce==0||cur_Floor!=2)
get_call[3]=1;
else
get_call[3]=0;
end
else
begin
if(ce==1&&cur_Floor==2)
get_call[3]=0;
end
end 
always @ ( rst or  ce or set_call[4] or cur_Floor)
begin
if(rst==1)
get_call[4]=0;
else if(set_call[4]==0)
begin
if(ce==0||cur_Floor!=2)
get_call[4]=1;
else
get_call[4]=0;
end
else
begin
if(ce==1&&cur_Floor==2)
get_call[4]=0;
end
end   
always @ ( rst or ce or set_call[5] or cur_Floor)
begin
if(rst==1)
get_call[5]=0;
else if(set_call[5]==0)
begin
if(ce==0||cur_Floor!=3)
get_call[5]=1;
else
get_call[5]=0;
end
else
begin
if(ce==1&&cur_Floor==3)
get_call[5]=0;
end
end         
endmodule