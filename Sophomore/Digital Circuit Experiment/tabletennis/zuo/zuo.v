module zuo(A,takeA,B,reset,Q,score,clk);
input A,takeA,B,reset,clk;
output score;
output [15:0]Q;//[3:0]
reg score;
reg [15:0]Q;
reg [1:0]state;
reg [3:0]state1;
parameter taking=2'b00,pause=2'b01,move=2'b10,judge=2'b11;
always@ (A or takeA or B)
begin
	if(state==judge && takeA==1 && A==0 && B==0)
		state<=taking;
	else if(state==taking && A==1)
				begin state<=move;
						score=0; 
				end
			else if(state==move && B==1)
			         state<=judge;
					else 
					   state<=state;       //?????
end

always@ (state)
begin
	case(state)
	judge://judge状态直接进入pause
	begin
		if(Q==16'b1111111111111101)//(q=4'b1110)
				score=1;
	end
	
	taking:
	begin
		Q=16'b1011111111111111;
		state<=move;
	end
	
   pause:
	Q=1111111111111111;//q=q1
	endcase
end
		
always@(posedge clk)
begin
	if(state==move)
		//if(reset)
		case(state1)
		0:begin Q=16'b1011111111111111;state1<=1;end
		1:begin Q=16'b1101111111111111;state1<=2;end
		2:begin Q=16'b1110111111111111;state1<=3;end
		3:begin Q=16'b1111011111111111;state1<=4;end
		4:begin Q=16'b1111101111111111;state1<=5;end
		5:begin Q=16'b1111110111111111;state1<=6;end
		6:begin Q=16'b1111111011111111;state1<=7;end
		7:begin Q=16'b1111111101111111;state1<=8;end
		8:begin Q=16'b1111111110111111;state1<=9;end
		9:begin Q=16'b1111111111011111;state1<=10;end
	   10:begin Q=16'b1111111111101111;state1<=11;end
		11:begin Q=16'b1111111111110111;state1<=12;end
		12:begin Q=16'b1111111111111011;state1<=13;end
		13:begin Q=16'b1111111111111101;state1<=14;end
		14:begin Q=16'b1111111111111110;state1<=15;end
		endcase
end
endmodule

	
	
