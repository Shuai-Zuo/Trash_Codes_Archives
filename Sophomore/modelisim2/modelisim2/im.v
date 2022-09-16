module im_1k(addr,dout);
  input [9:0]addr;
  output[31:0]dout;
  reg [31:0] dout;
  reg [7:0] im[1023:0];
  reg [9:0]address;
  initial $readmemh("p2-test.txt",im);
  always@(addr)
  begin
    address={addr[7:0],2'b00};
    dout={im[address],im[address+1],im[address+2],im[address+3]};
  end
endmodule
