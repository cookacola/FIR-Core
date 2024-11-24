`timescale 1ns/1ps
`define HALF_CLK_PERIOD 	#10.000
`define QRTR_CLK_PERIOD		#5.000
`define ON 				1'b0
`define OFF 			1'b1
`define ITER 			64
`define BLKS			8

module cmem_tb;
	integer					i, writing;
	reg						clk, WEN, CEN;
	wire			[15:0]	Q7, Q6, Q5, Q4;
	wire			[15:0]	Q3, Q2, Q1, Q0;
	reg				[15:0]	D;
	reg	unsigned	[5:0]	A7, A6, A5, A4;
	reg	unsigned	[5:0]	A3, A2, A1, A0;

	/* Instantiate DUT */
	cmem	DUT(
				.Q7 (Q7), .Q6(Q6), .Q5(Q5), .Q4(Q4),
				.Q3 (Q3), .Q2(Q2), .Q1(Q1), .Q0(Q0),
				.A7 (A7), .A6 (A6), .A5 (A5), .A4 (A4),
				.A3 (A3), .A2 (A2), .A1 (A1), .A0 (A0),
				.D	(D),
				.clk	(clk),
				.WEN	(WEN),
				.CEN	(CEN)
	);

	/* Clock generation */
	always	begin
		`HALF_CLK_PERIOD
		clk	= ~clk;
	end

	always	@(negedge clk) begin
		`QRTR_CLK_PERIOD
		if (writing == 1) begin
		/* Load random input data */
			CEN		= `ON;
			WEN		= `ON;
			D		= $urandom%65536;
		end 
		else if (writing == 0) begin
		/* Prepare to read from random addresses */
			WEN	= `OFF;
			CEN	= `ON;
			A7	= $urandom%64;
			A6	= $urandom%64;
			A5	= $urandom%64;
			A4	= $urandom%64;
			A3	= $urandom%64;
			A2	= $urandom%64;
			A1	= $urandom%64;
			A0	= $urandom%64;
		end
		else begin
		end
	end

	initial	begin
		clk	= 0;
		writing = 1;
		@(posedge clk);
		for (i = 0; i < (`BLKS * `ITER); i = i + 1) begin
			@(posedge clk);
		end
		writing	= 0;
		@(posedge clk);
		for (i = 0; i < `ITER; i = i + 1) begin
			@(posedge clk);
		end
		@(posedge clk);
		$finish;
	end
endmodule /* testbench */
