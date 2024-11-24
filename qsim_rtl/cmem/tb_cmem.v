
`timescale 1ns/1ps
`define HALF_CLK_PERIOD 	#10.000
`define QRTR_CLK_PERIOD		#5.000
`define ON 				1'b0
`define OFF 			1'b1
`define HIZ 			{20{1'bZ}}
`define ITER 			64
`define BLKS			8

module testbench();

	integer					i, writing;
	reg						clk, WEN, CEN;
	wire			[15:0]	Q7, Q6, Q5, Q4;
	wire			[15:0]	Q3, Q2, Q1, Q0;
	reg				[15:0]	D;
	reg	unsigned	[7:0]	A7, A6, A5, A4;
	reg	unsigned	[7:0]	A3, A2, A1, A0;

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

	always	begin
		`HALF_CLK_PERIOD
		clk	= ~clk;
	end

	always	@(negedge clk) begin
		`QRTR_CLK_PERIOD
		if (writing == 1) begin
			CEN		= `ON;
			WEN		= `ON;
			D		= $urandom%1048576;
		if (writing == 0) begin
			WEN	= `OFF;
			CEN	= `ON;
			D	= `HIZ;
			A7	= $urandom%2048;
			A6	= $urandom%2048;
			A5	= $urandom%2048;
			A4	= $urandom%2048;
			A3	= $urandom%2048;
			A2	= $urandom%2048;
			A1	= $urandom%2048;
			A0	= $urandom%2048;
		end
		else begin
		end
	end

	always	@(posedge clk) begin
		if (writing == 0) begin
			$fwrite(qsim_out_2, "%d,%d,%d,%d,%d,%d,%d,%d\n",
				Q7, Q6, Q5, Q4, Q3, Q2, Q1, Q0);
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
