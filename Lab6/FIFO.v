module SYNC_FIFO(clk, rst, wr_en, rd_en, din, dout);
	input clk, wr_en, rd_en, din, rst;
	output reg dout;

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


