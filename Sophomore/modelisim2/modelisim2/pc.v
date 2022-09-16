module pc(clk,NPC,PCWr,PCout,rst);
  input clk,PCWr,rst;
  input [29:0] NPC;
  output [29:0] PCout;
  reg [29:0] PCout;
  always@(PCWr or rst)
  begin
    if(rst)
      PCout<=30'b0000_0000_0000_0000_0011_0000_0000_00;
    else
      if(PCWr)
        PCout<=NPC;
      else
        PCout=PCout;
    end
  endmodule
