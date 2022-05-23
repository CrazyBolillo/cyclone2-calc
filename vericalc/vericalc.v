/**
 * Antonio Aguilar
 * Calculator - Supports 2 digit operands
*/
module vericalc(input clk, rst, input [3:0] usrin, output [3:0] seldisp, output[6:0] display);
	reg[3:0] pastusrin;
	reg[3:0] a, b, c, d;
	wire[6:0] adec, bdec;
	wire[6:0] anum, bnum;

	reg[2:0] count; // State
	reg[2:0] op;
	parameter 	MUL = 0,
					SUM = 1,
					DIV = 2,
					POW = 3,
					LOG = 4;
	
	wire[13:0] result;
	wire[3:0] rthou, rhund, rten, runi;
	wire[3:0] aout, bout, cout, dout;
	
	doubledabble decomp(result, rthou, rhund, rten, runi);
	assign dout = (count == 0) ? d: (count == 1) ? d: (count == 2) ? d: (count == 3) ? 0: (count == 4) ? b: (count == 5) ? b: runi;
	assign cout = (count == 0) ? c: (count == 1) ? c: (count == 2) ? c: (count == 3) ? 0: (count == 4) ? a: (count == 5) ? a: rten;
	assign bout = (count == 6) ? rhund: 0;
	assign aout = ((count == 6) && (op != DIV)) ? rthou: ((count == 6) && (op == DIV)) ? residue : 0;

	assign adec = a * 10;
	assign bdec = c * 10;
	assign anum = adec + b;
	assign bnum = bdec + d;
	
	wire[7:0] sumres;
	assign sumres = anum + bnum;
	
	wire[13:0] mulres;
	assign mulres = anum * bnum;
	
	wire[6:0] divres;
	wire[3:0] residue;
	assign divres = anum / bnum;
	assign residue = anum % bnum;
	
	wire calcrst;
	assign calcrst = ~(count == 6);
	
	wire[13:0] powres;
	pow power(clk, calcrst, anum, bnum, powres);
	
	wire[6:0] logres;
	log logarithm(clk, calcrst, anum, logres);
	
	/**
	* OP states the operation to be performed
	* 0: Sum
	* 1: Division
	* 2: Multiplication
	* 3: Power
	* 4: Log
	*/
	assign result = (op == MUL) ? mulres: (op == SUM) ? sumres: (op == DIV) ? divres: (op == POW) ? powres : logres;
	
	dispdrive displaydriver(clk, rst, aout, bout, cout, dout, seldisp, display);
	
	always @(posedge clk) begin
		if (rst) begin
			count <= 0;
			a <= 0;
			b <= 0;
			c <= 0;
			d <= 0;
		end
		else if ((usrin != 0) && (pastusrin != usrin) && (usrin < 11) && (count != 2)) begin
				pastusrin <= usrin;
				if (count == 0) begin
					if (usrin == 10)
						c <= 0;
					else
						c <= usrin;
					count <= count + 1;
				end
				else if (count == 1) begin
					if (usrin == 10)
						d <= 0;
					else
						d <= usrin;
					count <= count + 1;
				end
				else if (count == 3) begin
					if (usrin == 10)
						a <= 0;
					else
						a <= usrin;
					count <= count + 1;
				end
				else if (count == 4) begin
					if (usrin == 10)
						b <= 0;
					else
						b <= usrin;
					count <= count + 1;
				end
		end
		else if ((usrin != 0) && (usrin > 10) && (count == 2)) begin
			if (usrin == 11)
				op = MUL;
			else if (usrin == 12)
				op = SUM;
			else if (usrin == 13)
				op = DIV;
			else if (usrin == 14)
				op = POW;
			else if (usrin == 15)
				op = LOG;
			count <= count + 1;
		end
		else if ((usrin == 15) && (count == 5))
			count <= count + 1;
		else if ((usrin == 14) && (count == 6)) begin
			a <= 0;
			b <= 0;
			c <= 0;
			d <= 0;
			count <= 0;
		end
	end	
endmodule
