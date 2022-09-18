module npc(PC,IMM,nPC_sel,rs,NPC,DPC,imm,busA);
  input[2:0]nPC_sel;
  input[29:0]PC;
  input[25:0]IMM;
  input[29:0]rs;
  input[31:0]busA;
  input[15:0]imm;
  output [29:0]NPC;
  output [31:0]DPC;
  reg [29:0]NPC;
  reg [31:0]DPC;
  reg [29:0]nPC;
  always@(PC or IMM or nPC_sel or imm or busA)// rs or zero
  begin
    DPC = {PC+1,2'b00};
    case(nPC_sel)
      3'b000:NPC = PC+1'b1;
      3'b001:begin nPC = PC+1'b1;NPC=nPC+{{16{IMM[15]}},IMM[15:0]}; end//beq
      3'b010:begin nPC = PC+1'b1;NPC={nPC[29:26],IMM[25:0]};end//jal+j 
      3'b011:NPC = busA[31:2];
      default:NPC=PC;
    endcase
  end
endmodule
