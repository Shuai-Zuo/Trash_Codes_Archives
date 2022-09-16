module exp6(CLRN,LDN,ENP,ENT,CLK,A,B,C,D,RCO,QA,QB,QC,QD);
input	CLRN,LDN,ENP,ENT,CLK,A,B,C,D;
output RCO,QA,QB,QC,QD;
reg QA,QB,QC,QD;
reg CLK_1hz;
reg[31:0] cnt;
always@(posedge CLK)
		if(cnt==32'd25000000)
			begin
				CLK_1hz<=~CLK_1hz;
				cnt<='b0;
			end
		else
			begin
				cnt<=cnt+'b1;
			end
always @ (posedge CLK_1hz)
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