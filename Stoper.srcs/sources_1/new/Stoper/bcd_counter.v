module bcd_counter(clock, reset, bcd, next);

	input clock, reset;
	output bcd, next;
	reg [3:0] bcd;
	reg next;
	wire not_reset;
	not(not_reset, reset);
	
	parameter count_to = 9;
	
	always @(posedge clock or posedge not_reset)
		begin
			if (not_reset == 1)
				bcd <= 0;
			else
			begin
				bcd <= bcd + 1;
				next <= 0;
				if (bcd > count_to-1)
					begin
						bcd <= 0;
						next <= 1;
					end
			end
		end
endmodule