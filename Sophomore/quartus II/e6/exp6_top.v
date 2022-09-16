module exp6_top(CLRN,LDN,ENP,ENT,CLK,A1,B1,C1,D1,RCO,a,b,c,d,e,f,g,sel);
input	CLRN,LDN,ENP,ENT,CLK,A1,B1,C1,D1;
output RCO;
wire QA,QB,QC,QD;
output a,b,c,d,e,f,g;
output sel;
nambscld({QD,QC,QB,QA},a,b,c,d,e,f,g,sel);
exp6(CLRN,LDN,ENP,ENT,CLK,A1,B1,C1,D1,RCO,QA,QB,QC,QD);
endmodule