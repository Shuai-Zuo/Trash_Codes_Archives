module nextstate(state_in,opcode,funct,state_next);
  input[3:0] state_in;
  input[5:0] opcode,funct;
  output reg[3:0] state_next;
  parameter [3:0] IF = 4'b0000,
                  ID = 4'b0001,
                  MA = 4'b0010,
                  MR = 4'b0011,
                  MemWB = 4'b0100,
                  MW = 4'b0101,
                  Exe = 4'b0110,
                  WB = 4'b0111,
                  Branch = 4'b1000,
                  Jump = 4'b1001;
  always@(state_in or opcode or funct)
  begin
    case(state_in)
      IF:state_next=ID;
      ID:
      begin
        case(opcode)
          6'b000000:
          begin
            if(funct==6'b001000) state_next=Jump;
            else if(funct==6'b001001) state_next=Jump;
            else state_next=Exe;
          end
          6'b001101:state_next=Exe;
          6'b001111:state_next=Exe;
          6'b001001:state_next=Exe;
          6'b001000:state_next=Exe;
          6'b000100:state_next=Branch;
          6'b101011:state_next=MA;
          6'b100011:state_next=MA;
          6'b101000:state_next=MA;
          6'b100000:state_next=MA;
          6'b000010:state_next=Jump;
          6'b000011:state_next=Jump;
          6'b001001:state_next=Jump;
        endcase
      end
  
    MA:
    begin
      if(opcode==6'b100011 || opcode==6'b100000) state_next=MR;
      else state_next=MW;
    end
    MR:state_next=MemWB;
    MemWB:state_next=IF;
    Exe:state_next=WB;
    MW:state_next=IF;
    WB:state_next=IF;
    Branch:state_next=IF;
    Jump:state_next=IF;
    default:state_next=IF;
    endcase
  end
endmodule
    