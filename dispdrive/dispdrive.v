module dispdrive(input clk, rst, input[3:0] a, b, c, d, output[3:0] seldig, output[6:0] disp);
	reg[1:0] digit;
	reg[7:0] count;
	wire[3:0] selnum;
	
	assign selnum = (digit == 0)? d: (digit == 1)? c: (digit == 2)? b: a;
	assign seldig = (digit == 0)? 4'b1110: (digit == 1)? 4'b1101: (digit == 2)? 4'b1011: 4'b0111;
	bcd2segment decoder(selnum, disp);
	
	always @(posedge clk)
	begin
		if (rst)
		begin
			digit = 0;
			count = 0;
		end
		else
		begin
			count = count + 1;
			if (count == 255)
				digit = digit + 1;
		end
	end
endmodule
