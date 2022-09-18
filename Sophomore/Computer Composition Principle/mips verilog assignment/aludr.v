module ALUDR(data_in,clk,data_out);
  input clk;
  input [31:0] data_in;
  output [31:0] data_out;
  reg [31:0] data_out;
  always@(posedge clk)
  begin
    data_out=data_in;
  end
endmodule

