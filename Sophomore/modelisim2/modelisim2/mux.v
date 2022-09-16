module mux_ALUsrc(ReadData2,extOut,out,ALUsrc);
  input [31:0]ReadData2,extOut;
  input ALUsrc;
  output [31:0]out;
  reg [31:0]out;
  always@(ReadData2 or extOut or ALUsrc)
  begin
    case(ALUsrc)
      1'b0:out=ReadData2;
      1'b1:out=extOut;
    endcase
  end
endmodule

module mux_RegDst(rt,rd,RegDst,out);
  input [4:0]rt,rd;
  input [1:0]RegDst;
  output [4:0]out;
  reg [4:0]out;
  always@(rt or rd or RegDst)
  begin
    case(RegDst)
      2'b00:out=rt;
      2'b01:out=rd;
      2'b10:out=5'd31;
    endcase
  end
endmodule

module mux_MemtoReg(ALUout,DMout,DPC,MemtoReg,out);
  input [31:0]ALUout,DMout,DPC;
  input [1:0]MemtoReg;
  output [31:0]out;
  reg [31:0]out;
  always@(ALUout or DMout or DPC or MemtoReg)
  begin
    case(MemtoReg)
      2'b00: out=ALUout;
      2'b01: out=DMout;
      2'b10: out=DPC;
    endcase
  end
endmodule

