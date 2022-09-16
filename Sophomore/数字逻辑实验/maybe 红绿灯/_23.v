module _23(s1,s2,y1,y2,y3,y4);
input s1,s2;
output y1,y2,y3,y4;
reg y1,y2,y3,y4;
always@(s1 or s2)
if(s1==0&&s2==0)
begin
y1=1'b1;
y2=1'b0;
y3=1'b0;
y4=1'b0;
end
else if(s1==0&&s2==1)
begin
y1=1'b0;
y2=1'b1;
y3=1'b0;
y4=1'b0;
end
else if(s1==1&&s2==0)
begin
y1=1'b0;
y2=1'b0;
y3=1'b1;
y4=1'b0;
end
else
begin
y1=1'b0;
y2=1'b0;
y3=1'b0;
y4=1'b1;
end
endmodule