module mips(clk,rst);
  input clk,rst;
  wire [29:0]NPC,PC;
  wire [31:0]order,DPC;
  wire ALUsrc,RegWr,MemWr,Extop,zero,OF,PCWr,IRWr;
  wire [1:0] MemtoReg,RegDst;
  wire [2:0] nPC_sel,ALUctr;
  wire [31:0] busA,busB,busAout,busBout;
  wire [31:0] ALU_busB,Rin,ALUout,ReadData,imm_out;
  wire [31:0] ALUout2,LBout,DMDout;
  wire [4:0] rs,rt,rd,WriteReg;
  wire [5:0] opcode,funct;
  wire [15:0] imm;
  wire [25:0] IMM;
  wire [9:0] im_addr;
  wire [9:0] dm_addr;
  wire [1:0] lb_addr;
  wire [3:0] state_in,state_out;
  wire [29:0] npc_in;
  
  assign im_addr = PC[9:0];
  assign dm_addr = ALUout2[9:0];
  assign lb_addr = ALUout[1:0];//???
  assign npc_in = busA[31:2];
  
  npc np(PC,IMM,nPC_sel,npc_in,NPC,DPC,imm,busA);
  pc p(clk,NPC,PCWr,PC,rst);
  im_1k i1(im_addr,order);
  IR I(clk,IRWr,order,opcode,rs,rt,rd,imm,funct,IMM);
  control co(clk,rst,zero,PCWr,IRWr,RegDst,MemtoReg,RegWr,ALUctr,ALUsrc,nPC_sel,MemWr,Extop,opcode,funct,sbsel,lbsel,state_in,state_out);
  mux_ALUsrc mA(busBout,imm_out,ALU_busB,ALUsrc);
  mux_RegDst mR(rt,rd,RegDst,WriteReg);
  mux_MemtoReg mM(ALUout2,LBout,DPC,MemtoReg,Rin);
  gpr gp(rs,rt,WriteReg,Rin,busA,busB,RegWr,rst,OF);
  ADR AD(busA,clk,busAout);
  BDR BD(busB,clk,busBout);
  Extender Ex(Extop,imm,imm_out);
  alu AL(busAout,ALU_busB,ALUout,zero,ALUctr,OF);
  ALUDR ALDR(ALUout,clk,ALUout2);
  dm_1k d1(dm_addr,busBout,ReadData,MemWr,sbsel);
  LB L(lb_addr,DMDout,lbsel,LBout);
  DMDR DM(ReadData,clk,DMDout);

endmodule