module testbench;
  reg clk,rst;
  mips MIPS(clk,rst);
  
  initial
    begin
       clk = 0;
       rst = 1;
       #30 rst = 0;
    end
  always 
    #20 clk = ~clk;
endmodule

