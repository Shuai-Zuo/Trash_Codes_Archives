module up_down(rst,up_d,out_state_dir);
//up==0,down==1
input rst,up_d;
output out_state_dir;
reg out_state_dir;
always@(rst or up_d)
begin
if(rst==1||up_d==0)
out_state_dir=0;
else
out_state_dir=1;
end
endmodule