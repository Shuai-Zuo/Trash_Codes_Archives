module IR(clk,IRWr,IR_in,opcode,rs,rt,rd,imm,funct,IMM);
  input clk,IRWr;
  input [31:0]IR_in;
  output[5:0] opcode,funct;
  output [4:0] rs,rt,rd;
  output [15:0]imm;
  output [25:0]IMM;
  reg [5:0]opcode,funct;
  reg [4:0]rs,rt,rd;
  reg [15:0] imm;
  reg [25:0]  IMM;
  initial
  begin
    opcode=0;
    funct=0;
    rs=0;
    rd=0;
    imm=0;
    IMM=0;
  end
  always@(negedge clk)
  begin
    if(IRWr)
      begin
        opcode=IR_in[31:26];
        rs=IR_in[25:21];
        rt=IR_in[25:16];
        rd=IR_in[15:11];
        funct=IR_in[5:0];
        imm=IR_in[15:0];
        IMM=IR_in[25:0];
      end
  end
endmodule