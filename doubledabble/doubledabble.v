module doubledabble(input[13:0] num, output reg[3:0] thou, hund, tens, uni);
	integer i;
	always @(num) begin
		thou = 0;
		hund = 0;
		tens = 0;
		uni = 0;
		for (i = 13; i >= 0; i = i - 1) begin
			if (thou >= 5)
				thou = thou + 3;
			if (hund >= 5)
				hund = hund + 3;
			if (tens >= 5)
				tens = tens + 3;
			if (uni >= 5)
				uni = uni + 3;
				
			thou = thou << 1;
			thou[0] = hund[3];
			hund = hund << 1;
			hund[0] = tens[3];
			tens = tens << 1;
			tens[0] = uni[3];
			uni = uni << 1;
			uni[0] = num[i];
 		end
	end
endmodule
