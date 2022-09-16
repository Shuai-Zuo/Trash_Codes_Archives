module outdoor_request(request_out_up,request_out_down,rst,opnd,current_floor,request_out_seq);
input [2:0] request_out_up;
input [2:0] request_out_down;
input [1:0] current_floor;
input rst,opnd;
output [5:0] request_out_seq;
reg [5:0] request_out_seq;
always @ (rst or opnd or request_out_up or request_out_down or current_floor)
begin
	if(rst)
		request_out_seq=6'b000000;
	else 
	begin
		case({request_out_up,request_out_down})
		6'b001000:
		if(current_floor==2'b00)
		begin
			if(opnd)
				request_out_seq[3]=1'b0;
		end
		else
			request_out_seq[3]=1'b1;
		6'b000001:
		if(current_floor==2'b01)
		begin
			if(opnd)
				request_out_seq[0]=1'b0;
		end
		else
			request_out_seq[0]=1'b1;
		6'b010000:
		if(current_floor==2'b01)
		begin
			if(opnd)
				request_out_seq[4]=1'b0;
		end
		else
			request_out_seq[4]=1'b1;
		6'b000010:
		if(current_floor==2'b10)
		begin
			if(opnd)
				request_out_seq[1]=1'b0;
		end
		else
			request_out_seq[1]=1'b1;
		6'b100000:
		if(current_floor==2'b10)
		begin
			if(opnd)
				request_out_seq[5]=1'b0;
		end
		else
			request_out_seq[5]=1'b1;
		6'b000100:
		if(current_floor==2'b11)
		begin
			if(opnd)
				request_out_seq[2]=1'b0;
		end
		else
			request_out_seq[2]=1'b1;
		endcase
	end
end
endmodule