module FIFO#(parameter DEPTH=64, DWIDTH=16)
(
	input			clk,		// clock	
				wr_en, 		// write enable
				rd_en, 		// read enable
				rst,		// high reset
	input [DWIDTH-1:0]	din,		// data written into fifo
	output reg [DWIDTH-1:0]	dout,		// data read from fifo
	output			full,		// full signal
				empty		// empty signal
);
	localparam PTR_WIDTH = $clog2(DEPTH);

	reg [PTR_WIDTH-1:0] wptr = 0;
	reg [PTR_WIDTH-1:0] rptr = 0;
	reg [DWIDTH-1:0] fifo [0:DEPTH-1];

	// write
	always @ (posedge clk) begin
		if(rst) begin
			wptr <= 0;
		end else begin
			if (wr_en & !full) begin
				fifo[wptr] <= din;
				wptr <= wptr + 1;
			end
		end
	end

	// read
	always @ (posedge clk) begin
		if(rst) begin
			rptr <= 0;
			dout <= 0;
		end else begin
			if (rd_en && !empty) begin
				dout <= fifo[rptr[PTR_WIDTH-1:0]];
				rptr <= rptr + 1;
			end
		end
	end

	// full and empty
	assign full = (wptr[PTR_WIDTH-1:0] == rptr[PTR_WIDTH-1:0]) && (wptr[PTR_WIDTH] != rptr[PTR_WIDTH]);
	assign empty = (wtpr == rptr);

endmodule


