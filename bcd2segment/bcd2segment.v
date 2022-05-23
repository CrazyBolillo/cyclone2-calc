module bcd2segment(input[3:0] bcd, output[6:0] segment);
	assign segment = 	(bcd == 1)? 	7'b0000110: 
							(bcd == 2)?		7'b1011011:
							(bcd == 3)?		7'b1001111:
							(bcd == 4)?		7'b1100110:
							(bcd == 5)?		7'b1101101:
							(bcd == 6)?		7'b1111101:
							(bcd == 7)?		7'b0100111:
							(bcd == 8)?		7'b1111111:
							(bcd == 9)?		7'b1101111:
												7'b0111111;
endmodule
