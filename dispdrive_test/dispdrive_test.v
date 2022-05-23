/*
 * Physical implementation to test the 4 digit 7 segment display driver.
 * Counts from 0 to 9999 and loops over.
*/

module dispdrive_test(input clk, input rst, output[6:0] disp, output[3:0] seldig);
	reg[3:0] uni, tens, hundrs, thsnds;
	reg[19:0] count;
	reg count_clk;
	
	dispdrive displaydriver(clk, rst, thsnds, hundrs, tens, uni, seldig, disp);
	
	always @(posedge clk)
	begin
		if (rst)
		begin
			count = 0;
			count_clk = 0;
		end
		else if (count == 1048575)
		begin
			count = 0;
			count_clk = !count_clk;
		end
		else
			count = count + 1;
	end
	
	always @(posedge count_clk)
	begin
		if (rst)
		begin
			uni = 0;
			tens = 0;
			hundrs = 0;
			thsnds = 0;
		end
		else
		begin
			if (uni == 9)
			begin
				uni = 0;
				if (tens == 9)
				begin
					tens = 0;
					if (hundrs == 9)
					begin
						hundrs = 0;
						if (thsnds == 9)
							thsnds = 0;
						else
							thsnds = thsnds + 1;
					end
					else
						hundrs = hundrs + 1;
				end
				else
					tens = tens + 1;
			end
			else
				uni = uni + 1;
		end
	end
	
endmodule
