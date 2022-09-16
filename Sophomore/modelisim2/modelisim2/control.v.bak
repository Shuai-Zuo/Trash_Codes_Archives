module control(clk,reset,zero,PCWr,IRWr,RegDst,MemtoReg,RegWr,ALUctr,ALUsrc,npc_sel,MemWr,Extop,opcode,funct,sbsel,lbsel,state_in,state_out);
  input[5:0] opcode,funct;
  input zero,clk,reset;
  output wire PCWr,IRWr,ALUsrc,MemWr,Extop,RegWr,sbsel,lbsel;
  output wire[1:0]RegDst,MemtoReg;
  output wire[2:0]ALUctr,npc_sel;
  output wire[3:0]state_in,state_out;
  
  Dchufa Dc(state_in,clk,reset,state_out);
  nextstate ne(state_out,opcode,funct,state_in);
  functout fu(state_out,opcode,funct,zero,PCWr,IRWr,MemtoReg,RegWr,ALUsrc,MemWr,Extop,RegDst,npc_sel,ALUctr,sbsel,lbsel);
endmodule
