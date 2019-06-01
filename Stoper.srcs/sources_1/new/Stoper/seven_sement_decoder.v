module seven_segment_decoder(bcd[3:0], HEX[0:6]);

	input [3:0] bcd;
	output [0:6] HEX;
	reg [0:6] HEX;
	
	// gœ - góra œrodek         gœ
	// gl - góra lewy         gp  gl
	// dl - dó³ lewy            œœ
	// œœ - œrodek œrodek     dp  dl
	// gp - góra prawy          dœ
	// dp - dó³ prawy
	// dœ - dó³ œrodek
	
	always @ (bcd)
		case(bcd) 
			4'b0000:HEX[0:6] = 7'b0000001; // 0 (gœ, gp, dp, dœ, dl, gl, œœ) 
			4'b0001:HEX[0:6] = 7'b1001111; // 1
			4'b0010:HEX[0:6] = 7'b0010010; // 2
			4'b0011:HEX[0:6] = 7'b0000110; // 3
			4'b0100:HEX[0:6] = 7'b1001100; // 4
			4'b0101:HEX[0:6] = 7'b0100100; // 5
			4'b0110:HEX[0:6] = 7'b0100000; // 6
			4'b0111:HEX[0:6] = 7'b0001111; // 7
			4'b1000:HEX[0:6] = 7'b0000000; // 8
			4'b1001:HEX[0:6] = 7'b0000100; // 9
			default: HEX[0:6] = 7'b1111111; // wszystko zgaszone
		endcase
endmodule