module stop_run (rst,stop_r,out_state_run);
//stop--0,run--1
input rst,stop_r;
output out_state_run;
reg out_state_run;
always @(stop_r or rst)
begin
if(rst==1||stop_r==0)
out_state_run=0;
else
out_state_run=1;
end
endmodule