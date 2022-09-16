module LB(addr,ReadData,lbsel,LBout);
  input[1:0]addr;
  input[31:0]ReadData;
  input lbsel;
  output [31:0] LBout;
  reg[31:0]LBout;
  always@(ReadData or addr or lbsel)
  begin
    if(lbsel==0)
      LBout=ReadData;
    else
      begin
        case(addr)
          2'b11:LBout={{24{ReadData[7]}},ReadData[7:0]};
          2'b10:LBout={{24{ReadData[7]}},ReadData[15:8]};
          2'b01:LBout={{24{ReadData[7]}},ReadData[23:16]};
          2'b00:LBout={{24{ReadData[7]}},ReadData[31:24]};
        endcase
      end
  end
endmodule
