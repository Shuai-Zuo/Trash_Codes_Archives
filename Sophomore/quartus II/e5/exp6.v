module exp6(CLRN,LDN,ENP,ENT,CLK,A,B,C,D,RCO,QA,QB,QC,QD);
input	CLRN,LDN,ENP,ENT,CLK,A,B,C,D;
output RCO,QA,QB,QC,QD;
reg QA,QB,QC,QD;
always @ (posedge CLK)
begin
	if(!CLRN)
		{QD,QC,QB,QA}<=4'b0000;
	else if(!LDN)
		{QD,QC,QB,QA}<={D,C,B,A};
	else if(ENP&&ENT)
		{QD,QC,QB,QA}<={QD,QC,QB,QA}+1'b1;
	else
		{QD,QC,QB,QA}<={QD,QC,QB,QA};
end
assign RCO=({QD,QC,QB,QA}==4'b1111&&ENT)?1:0;
endmodule