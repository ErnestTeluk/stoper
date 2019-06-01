module stopwatch(CLOCK_50, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input CLOCK_50;
	input [1:0] KEY;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire CLOCK_SW, CLOCK_100;
	wire tenths_in, ones_in, tens_in, mins_in, tmins_in;
	wire [3:0] hundredths_bcd, tenths_bcd, ones_bcd, tens_bcd, mins_bcd, tmins_bcd;
	
	parameter speed_up = 500000;
	
	ms_clock #(speed_up) ms_clock1(CLOCK_50, CLOCK_100);
	
	ms_clock_switched ms_clock_switched1(CLOCK_100, KEY[0], CLOCK_SW);
	
	bcd_counter bcd_counter_hundredths(CLOCK_SW, KEY[1], hundredths_bcd[3:0], tenths_in);
	bcd_counter bcd_counter_tenths(tenths_in, KEY[1], tenths_bcd[3:0], ones_in);
	bcd_counter bcd_counter_ones(ones_in, KEY[1], ones_bcd[3:0], tens_in);
	bcd_counter #(5) bcd_counter_tens(tens_in, KEY[1], tens_bcd[3:0], mins_in);
	bcd_counter bcd_counter_mins(mins_in, KEY[1], mins_bcd[3:0], tmins_in);
	bcd_counter bcd_counter_tmins(tmins_in, KEY[1], tmins_bcd[3:0]); 
	
	seven_segment_decoder seven_segment_decoder_hundredths(hundredths_bcd[3:0], HEX5[0:6]);
	seven_segment_decoder seven_segment_decoder_tenths(tenths_bcd[3:0], HEX4[0:6]);
	seven_segment_decoder seven_segment_decoder_ones(ones_bcd[3:0], HEX3[0:6]);
	seven_segment_decoder seven_segment_decoder_tens(tens_bcd[3:0], HEX2[0:6]);
	seven_segment_decoder seven_segment_decoder_mins(mins_bcd[3:0], HEX1[0:6]);
	seven_segment_decoder seven_segment_decoder_tmins(tmins_bcd[3:0], HEX0[0:6]);
	
endmodule