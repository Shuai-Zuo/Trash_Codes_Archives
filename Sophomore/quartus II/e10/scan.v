module scan(CLK,QH,QG,QF,QE,QD,QC,QB,QA,SEL);
input CLK;
output QH,QG,QF,QE,QD,QC,QB,QA;
output [2:0]SEL;
reg [2:0]SEL;
always@(posedge CLK)
begin
	case({QH,QG,QF,QE,QD,QC,QB,QA})
		8'b01111111:SEL<=3'b001;
		8'b10111111:SEL<=3'b010;
		8'b11011111:SEL<=3'b011;
		8'b11101111:SEL<=3'b100;
		8'b11110111:SEL<=3'b101;
		8'b11111011:SEL<=3'b110;
		8'b11111101:SEL<=3'b111;
		8'b11111110:SEL<=3'b000;
		default:SEL<=3'b000;
	endcase
end
_8bit_scan(CLK,1'b1,1'b1,1'b1,{~QA,1'b1},1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,QH,QG,QF,QE,QD,QC,QB,QA);
endmodule