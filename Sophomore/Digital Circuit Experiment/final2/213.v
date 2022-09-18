module _213(stop,num,numo);
input stop;
input num;
output numo;
assign numo=(stop)?num:1'b0;
endmodule