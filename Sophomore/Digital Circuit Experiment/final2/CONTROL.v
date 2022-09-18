// Quartus II Verilog Template
// 4-State Moore state machine

// A Moore machine's outputs are dependent only on the current state.
// The output is written only when the state changes.  (State
// transitions are synchronous.)

module control
(
clk, in, reset,out,cors
);

	input	clk, in, reset;
	output [1:0] out;
	reg [1:0] out;
	output reg cors;
	// Declare state register
	reg		[2:0]state;

	// Declare states
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7;

	// Output depends only on the state
	always @ (state) begin
		case (state)
			S0:begin
				cors=1'b0;
				out = 2'b00;
				end
			S1:begin
				cors=1'b0;
				out = 2'b01;
				end
			S2:begin
				cors=1'b0;
				out = 2'b10;
				end
			S3:begin
				cors<=1'b0;
				out = 2'b11;
				end
			S4:cors=1'b1;
			S5:cors=1'b1;
			S6:cors=1'b1;//
			S7:cors=1'b1;
			
		endcase
	end

	// Determine the next state
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			case (state)
				S0:
					if (in)
						state <= S4;
					else
						state <= S0;
				S1:
					if (in)
						state <= S5;
					else
						state <= S1;
				S2:
					if (in)
						state <= S6;//
					else
						state <= S2;
				S3:
					if (in)
						state <= S7;
					else
						state <= S3;
				S4:state<=S1;
				S5:state<=S2;
				S6:state<=S0;//
				S7:state<=S0;
			endcase
	end

endmodule
