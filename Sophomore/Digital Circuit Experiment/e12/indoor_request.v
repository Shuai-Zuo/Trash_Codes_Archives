module indoor_request(request_in,rst,opnd,current_floor,request_in_seq);
input [3:0] request_in;
input [1:0] current_floor;
input rst,opnd;
output [3:0] request_in_seq;
reg [3:0] request_in_seq;
always @ (rst or opnd or request_in or current_floor)
begin
	if(rst)
		request_in_seq=4'b0000;
	else 
	begin
		case(request_in)
		4'b0001:
		if(current_floor==2'b00)
		begin
			if(opnd)
				request_in_seq[0]=1'b0;
		end
		else
			request_in_seq[0]=1'b1;
		4'b0010:
		if(current_floor==2'b01)
		begin
			if(opnd)
				request_in_seq[1]=1'b0;
		end
		else
			request_in_seq[1]=1'b1;
		4'b0100:		
		if(current_floor==2'b10)
		begin
			if(opnd)
				request_in_seq[2]=1'b0;
		end
		else
			request_in_seq[2]=1'b1;
		4'b1000:		
		if(current_floor==2'b11)
		begin
			if(opnd)
				request_in_seq[3]=1'b0;
		end
		else
			request_in_seq[3]=1'b1;
		endcase
	end
end
endmodule