module signal_light2(clk,rst,count,light1,red,yel,gre,in4,in5);
input clk,rst;
input [7:0]count;
input[5:0]red,yel,gre;
output[2:0]light1;
reg[2:0] light1;
reg[2:0]state;
output reg[3:0]in4,in5;

parameter S0=3'b000,
S1=3'b001,
S2=3'b010,
S3=3'b011,
S4=3'b100;


always@(posedge clk)
begin
if(!rst)
 begin
state<=S0;
light1<=3'b010;
end
else
case(state)
S0: if(rst)
begin
state<=S1;
light1<=3'b001;
end

S1:
begin
in4<=(gre-count)/4'd10;
in5<=(gre-count)%4'd10;
if(count==gre)
begin
state<=S2;
light1<=3'b010;
end
end
S2:
begin
in4<=(gre+yel-count)/4'd10;
in5<=(gre+yel-count)%4'd10;
if(count==gre+yel)
begin
state<=S3;
light1<=3'b100;
end
end
S3:
begin
in4<=(red+yel+gre-count)/4'd10;
in5<=(red+yel+gre-count)%4'd10;
if(count==red+yel+gre)
begin
state<=S1;
light1<=3'b001;
end
end
/*S4: if(count=='d60)
begin
state<=S1;
light1<=3'b100;
end*/
default:state<=S0;
endcase
end
endmodule