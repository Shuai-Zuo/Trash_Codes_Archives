module _8bit_scan(CLK,CLRN,DSL,DSR,S,H,G,F,E,D,C,B,A,QH,QG,QF,QE,QD,QC,QB,QA);
input CLK,CLRN,DSL,DSR,H,G,F,E,D,C,B,A;
input[1:0]S;
output QH,QG,QF,QE,QD,QC,QB,QA;
exp8(CLRN,S,QD,DSR,CLK,H,G,F,E,QH,QG,QF,QE);
exp8(CLRN,S,DSL,QE,CLK,D,C,B,A,QD,QC,QB,QA);
endmodule