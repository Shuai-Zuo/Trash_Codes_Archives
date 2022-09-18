module scan2(CLK,SEL,QA,QB,QC,QD,QE,QF);
input CLK;
output[2:0]SEL;
reg[2:0]SEL;
output QA,QB,QC,QD,QE,QF;
reg QA,QB,QC,QD,QE,QF;
always@(posedge CLK)
begin
	case(SEL)
		3'b000:{QF,QE,QD,QC,QB,QA}<=8'b101111;
		3'b001:{QF,QE,QD,QC,QB,QA}<=8'b110111;
		3'b010:{QF,QE,QD,QC,QB,QA}<=8'b111011;
		3'b011:{QF,QE,QD,QC,QB,QA}<=8'b111101;
		3'b100:{QF,QE,QD,QC,QB,QA}<=8'b111110;
		3'b101:{QF,QE,QD,QC,QB,QA}<=8'b011111;
	endcase
	if(SEL<3'b101)
		SEL<=SEL+1'b1;
	else
		SEL<=3'b0;
end
endmodule