module exp_5(clk,reset,out);
	input clk,reset;
	output[15:0] out;
	reg[15:0] out;
	reg[3:0] state;
	//reg clk_1hz;
	reg[31:0] cnt;
	parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6,S7=7,S8=8,S9=9,S10=10,S11=11,S12=12,S13=13,S14=14,S15=15;
	/*
	always@(posedge clk)
		if(cnt==32'd25000000)
			begin
				clk_1hz<=~clk_1hz;
				cnt<='b0;
			end
		else
			begin
				cnt<=cnt+'b1;
			end
*/			
	always@(state)
		begin
			case(state)
				S0:out=16'b0111111111111111;
				S1:out=16'b1011111111111111;
				S2:out=16'b1101111111111111;
				S3:out=16'b1110111111111111;
				S4:out=16'b1111011111111111;
				S5:out=16'b1111101111111111;
				S6:out=16'b1111110111111111;
				S7:out=16'b1111111011111111;
				S8:out=16'b1111111101111111;
				S9:out=16'b1111111110111111;
				S10:out=16'b1111111111011111;
			   S11:out=16'b1111111111101111;
				S12:out=16'b1111111111110111;
			   S13:out=16'b1111111111111011;
			   S14:out=16'b1111111111111101;
			   S15:out=16'b1111111111111110;
			default:out=16'b1111111111111111;
		endcase
	end
	always@(posedge clk/*_1hz*/ or posedge reset)
		begin
			if(reset)
				state<=S0;
			else
				case(state)
					S0:state<=S1;
					S1:state<=S2; 
					S2:state<=S3; 
					S3:state<=S4; 
					S4:state<=S5;
					S5:state<=S6;
					S6:state<=S7;
					S7:state<=S8;
					S8:state<=S9;
					S9:state<=S10;
					S10:state<=S11; 
	  		      S11:state<=S12; 
					S12:state<=S13;
					S13:state<=S14;
					S14:state<=S15;
					S15:state<=S0;
					default:state<=S0;
				endcase
			end
endmodule
