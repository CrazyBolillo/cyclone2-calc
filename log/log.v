module log(input clk, rst, input[6:0] a, output reg[6:0] result);
	reg[6:0] buffer, count;
	reg finish;
	always @(posedge clk) begin
		if (rst) begin
			finish <= 0;
			result <= 0;
			buffer <= 0;
			count <= 0;
		end
		else if (finish == 0) begin
			if (a <= 1) begin
				result <= 0;
				finish <= 1;
			end
			if (count == 0) begin
				buffer <= a;
				count <= count + 1;
			end
			else if (buffer >= 2) begin
				buffer <= buffer / 2;
				count <= count + 1;
			end
			else begin
				result <= count - 1;
				finish <= 1;
			end
		end
	end
endmodule
