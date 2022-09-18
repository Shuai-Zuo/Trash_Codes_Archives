module exp9(clk,x,reset,z,current_state,next_state);
input clk,x,reset;
output z;
reg z;
parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,s7=7;
output[2:0]current_state,next_state;
reg[2:0]current_state,next_state;
always@(posedge clk)
begin
	if(!reset)
	begin
		current_state<=s0;
	end
	else
	begin
		current_state<=next_state;
	end
end
always@(current_state or x)
begin
	case(current_state)
		s0:if(!x) next_state<=s1; else next_state<=s0;
		s1:if(!x) next_state<=s2; else next_state<=s0;
		s2:if(x) next_state<=s3; else next_state<=s2;
		s3:if(!x) next_state<=s4; else next_state<=s0;
		s4:if(!x) next_state<=s5; else next_state<=s0;
		s5:if(!x) next_state<=s6; else next_state<=s3;
		s6:if(x) next_state<=s7; else next_state<=s1;
		s7:if(x) next_state<=s0; else next_state<=s1;
		default:next_state<=s0;
	endcase
end
always@(posedge clk)
begin
	case(current_state)
		s7:if(x) z=1'b1; else z=1'b0;
		default:z=1'b0;
	endcase
end
endmodule