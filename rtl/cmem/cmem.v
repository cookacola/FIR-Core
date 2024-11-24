
`define ON 1'b0 /* ON is low */
`define OFF 1'b1 /* OFF is high */
`define HIZ {20{1'bZ}}

module cmem(
	output	wire	[15:0]	Q7, Q6, Q5, Q4,		/* Outputs */
	output	wire	[15:0]	Q3, Q2, Q1, Q0,
	input	wire	[15:0]	D,					/* Data Inputs */
	input	wire	[5:0]	A7, A6, A5, A4,		/* Input Addresses */
	input	wire	[5:0]	A3, A2, A1, A0,
	input	wire		WEN, CEN,				/* Write enable, Chip enable */
	input	wire		clk
);

	genvar		i;
	wire		clk_bar;
	reg	[5:0]	AI [7:0];
	reg	[15:0]	DI;
	wire	[15:0]	QI [7:0];

	assign	clk_bar	= ~clk;

	always	@(posedge clk) begin
		DI	<= D;
		AI[7]	<= A7;
		AI[6]	<= A6;
		AI[5]	<= A5;
		AI[4]	<= A4;
		AI[3]	<= A3;
		AI[2]	<= A2;
		AI[1]	<= A1;
		AI[0]	<= A0;
	end

	assign	Q7	= QI[7];
	assign	Q6	= QI[6];
	assign	Q5	= QI[5];
	assign	Q4	= QI[4];
	assign	Q3	= QI[3];
	assign	Q2	= QI[2];
	assign	Q1	= QI[1];
	assign	Q0	= QI[0];

	generate
		for (i = 0; i < 8; i = i + 1) begin
			cmem_core CMEM_CORE (
				.Q   (QI[i]),
				.A   (AI[i]),
				.D   (DI),
				.WEN (WEN),
				.CEN (CEN),
				.CLK (clk_bar)
			);
		end
	endgenerate

endmodule /* cmem */
