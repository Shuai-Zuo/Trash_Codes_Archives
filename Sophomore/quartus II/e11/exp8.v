module exp8(CLRN,S,DSL,DSR,CLK,D,C,B,A,QD,QC,QB,QA);
input [1:0]S;
input DSL,DSR,CLK,CLRN;
input D,C,B,A;
output QD,QC,QB,QA;
reg QD,QC,QB,QA;
always@(posedge CLK or negedge CLRN)
begin
	if(!CLRN)
	begin
		{QD,QC,QB,QA}<=4'b0000;
	end
	else
	begin
		if(S==2'b01)
		begin
			{QD,QC,QB,QA}<=({QD,QC,QB,QA}>>1)+{DSR,1'b0,1'b0,1'b0};
		end
		else if(S==2'b10)
		begin
			{QD,QC,QB,QA}<=({QD,QC,QB,QA}<<1)+DSL;
		end
		else if(S==2'b11)
		begin
			{QD,QC,QB,QA}<={D,C,B,A};
		end
		else
		begin
			{QD,QC,QB,QA}<={QD,QC,QB,QA};
		end
	end
end
endmodule
			