module ms_clock(clock, ms_clock);

	input clock;
	output ms_clock;
	reg ms_clock;
	reg [0:17] count;
	
	parameter speed_up = 500000;
	
	//Generate 100 Hz clock from a 50 MHz clock input
	always @ (posedge clock)
		begin
		  if (count[0:0] === 1'bx) // reset
		      begin
		          count = 0;
		          ms_clock = 1'b0;
		      end 
			count <= count + 1;
			if (count == speed_up)
				begin
					ms_clock <= ~ms_clock;
					count <= 0;
				end
		end
endmodule