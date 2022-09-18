module destination(set_dest,rst,ce,cur_Floor,get_dest);
input [3:0] set_dest;
input [1:0] cur_Floor;
input rst,ce;
output [3:0] get_dest;
reg [3:0] get_dest;
always @ (rst or ce or set_dest[0] or cur_Floor)
begin
if(rst==1)
get_dest[0]=0;
else
begin
if(set_dest[0]==0)
begin
if(ce==0||cur_Floor!=0)
get_dest[0]=1;        
else
get_dest[0]=0;        
end
else
begin
if(ce==1&&cur_Floor==0)
get_dest[0]=0;
end
end
end
always @ (rst or ce or set_dest[1] or cur_Floor)
begin
if(rst==1)
get_dest[1]=0;
else if(set_dest[1]==0)            
begin
if(ce==0||cur_Floor!=1)
get_dest[1]=1;
else
get_dest[1]=0;
end
else
begin
if(ce==1&&cur_Floor==1)
get_dest[1]=0;
end
end   
always @ (rst or ce or set_dest[2] or cur_Floor)
begin
if(rst==1)
get_dest[2]=0;
else if(set_dest[2]==0)
begin
if(ce==0||cur_Floor!=2)
get_dest[2]=1;
else
get_dest[2]=0;
end
else
begin
if(ce==1&&cur_Floor==2)
get_dest[2]=0;
end
end
always @ (rst or ce or set_dest[3] or cur_Floor)
begin
if(rst==1)
get_dest[3]=0;
else if(set_dest[3]==0)
begin
if(ce==0||cur_Floor!=3)
get_dest[3]=1;
else
get_dest[3]=0;
end
else
begin
if(ce==1&&cur_Floor==3)
get_dest[3]=0;
end
end
endmodule