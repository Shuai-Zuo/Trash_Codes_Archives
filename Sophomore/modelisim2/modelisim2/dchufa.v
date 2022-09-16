module Dchufa(state_in,clk,reset,state_out);
  input [3:0] state_in;
  input clk,reset;
  output reg[3:0] state_out;
  always@(posedge clk)
  begin
    if(reset) state_out=4'b0000;
    else state_out=state_in;
  end
endmodule
