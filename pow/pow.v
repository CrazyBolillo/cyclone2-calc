/**
 * Antonio Aguilar
 * Power of a number. a ^ b
*/
module pow(input clk, rst, input[6:0] a, b, output reg[13:0] result);
	reg[6:0] count;
	reg finish;
	always @(posedge clk) begin
		if (rst) begin
			finish <= 0;
			result <= 0;
			count <= 0;
		end
		else if (finish == 0) begin
			if (b == 0)
				result <= 1;
			else if (b == 1)
				result <= a;
			else if (count < b) begin
				if (count == 0) begin
					result <= a;
					count <= count + 1;
				end
				else begin
					result <= result * a;
					count <= count + 1;
				end
			end
			else
				finish <= 1;
		end
	end
endmodule
