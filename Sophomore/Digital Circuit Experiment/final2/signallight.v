module signal_light(clk,rst,count,light1,red,yel,gre,in1,in2);
input clk,rst;
input [7:0]count;
input[5:0]red,yel,gre;
output[2:0]light1;
output[3:0]in1,in2;
reg[3:0]in1,in2;
reg[2:0] light1;
reg[2:0]state;

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
light1<=3'b100;
end

S1:
begin
in1<=(red-count)/4'd10;
in2<=(red-count)%4'd10;
if(count==red)
begin
state<=S2;
light1<=3'b010;
end
end
S2:
begin
in1<=(red+yel-count)/4'd10;
in2<=(red+yel-count)%4'd10;
if(count==red+yel)
begin
state<=S3;
light1<=3'b001;
end
end
S3:
begin
in1<=(red+yel+gre-count)/4'd10;
in2<=(red+yel+gre-count)%4'd10;
if(count==red+yel+gre)
begin
state<=S1;
light1<=3'b100;
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