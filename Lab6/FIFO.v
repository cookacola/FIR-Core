module FIFO#(parameter DEPTH=64, DWIDTH=16)
(
	input			clk, 
				wr_en, 
				rd_en, 
				rst;
	input [DWIDTH-1:0]	din;
	output [DWIDTH-1:0]	dout;
);
	always @ (posedge clk) begin
		if(!rst) begin
			wptr <= 0;
		end else begin
			if (wr_en & !full) begin
				fifo[wptr] <= din;
				wptr <= wptr + 1;
			end
		end
	end

	initial begin


