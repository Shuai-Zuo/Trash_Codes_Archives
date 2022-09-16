 module exp7(rst,clk_50MHz,clk_1Hz,clk_10Hz,clk_100Hz,clk_1KHz);
input rst,clk_50MHz;
output clk_1Hz,clk_10Hz,clk_100Hz,clk_1KHz;
reg clk_1Hz,clk_10Hz,clk_100Hz,clk_1KHz;
reg [31:0] cnt1,cnt10,cnt100,cnt1000;

//parameter N1=32'd25000000;//1hz
parameter N1=32'd25000000;//1hz
parameter N10=32'd2500000;//10hz
parameter N100=32'd250000;//100hz
parameter N1000=32'd25000;//1Khz

/*
parameter N1=32'd16;//1hz
parameter N10=32'd8;//10hz
parameter N100=32'd4;//100hz
parameter N1000=32'd2;//1Khz
*/
always@(posedge clk_50MHz)
	if(!rst)
		if(cnt1==N1)
		begin
			cnt1<=1'b0;
			clk_1Hz<=~clk_1Hz;
		end
		else
		begin
			cnt1<=cnt1+1'b1;
		end
	else
		begin
			cnt1<=0;
			clk_1Hz<=1'b0;
	end
always@(posedge clk_50MHz)
	if(!rst)
		if(cnt10==N10)
		begin
			cnt10<=1'b0;
			clk_10Hz<=~clk_10Hz;
		end
		else
		begin
			cnt10<=cnt10+1'b1;
		end
	else
		begin	
			cnt10<=0;
			clk_10Hz<=1'b0;
	end
always@(posedge clk_50MHz)
	if(!rst)
		if(cnt100==N100)
		begin
			cnt100<=1'b0;
			clk_100Hz<=~clk_100Hz;
		end
		else
		begin
			cnt100<=cnt100+1'b1;
		end
	else
		begin
			cnt100<=0;
			clk_100Hz<=1'b0;
	end
always@(posedge clk_50MHz)
	if(!rst)
		if(cnt1000==N1000)
		begin
			cnt1000<=1'b0;
			clk_1KHz<=~clk_1KHz;
		end
		else
		begin
			cnt1000<=cnt1000+1'b1;
		end
	else
		begin
			cnt1000<=0;
			clk_1KHz<=1'b0;
		end
endmodule