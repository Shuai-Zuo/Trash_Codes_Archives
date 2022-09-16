module alu(ReadData1,ReadData2,ALUout,zero,ALUctr,OF);
  input [31:0] ReadData1,ReadData2;
  input [2:0] ALUctr;
  output zero;
  output [31:0]ALUout;
  output OF;
  reg zero;
  reg [31:0] ALUout;
  reg [32:0] judge;
  reg OF;
  always@(ReadData1 or ReadData2 or ALUctr)
  begin
    case(ALUctr)
      3'b000:begin ALUout=ReadData1+ReadData2;OF=1'b0;zero=1'b0;
             judge={ReadData1[31],ReadData1}+{ReadData2[31]+ReadData2};
             if(judge[32]^judge[31])
               begin 
               OF=1'b1;ALUout=ReadData1+ReadData2; 
               end
             else 
               begin 
               OF =1'b0; ALUout=ReadData1+ReadData2;
               end
             end
      3'b001:begin ALUout=ReadData1-ReadData2;OF=1'b0;
             if(ALUout==32'b00000000)zero=1'b1;else zero=1'b0; end
      3'b010:begin ALUout=ReadData1 | ReadData2;OF=1'b0;zero=1'b0;end
      3'b011:begin ALUout={ReadData2[15:0],16'h0000};end
      3'b100:begin OF=1'b0;zero=1'b0;
             if((ReadData1[31]==1&&ReadData2[31]==0||ReadData1<ReadData2)&&!(ReadData1[31]==0&&ReadData2[31]==1)) ALUout=32'h00000001;
             else ALUout=32'b00000000; end
      default:begin OF=1'b0;zero=1'b0;end
    endcase
  end
endmodule