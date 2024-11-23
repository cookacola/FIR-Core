
`define ON 1'b0
`define OFF 1'b1
`define HIZ {20{1'bZ}}

module cmem(
	output	wire	[15:0]	Q5, Q4, Q3,
	output	wire	[15:0]	Q2, Q1, Q0,
	input	wire	[15:0]	D,		/* Limited by Upstream Spec. */
	input	wire	[5:0]	A5, A4, A3,
	input	wire	[5:0]	A2, A1, A0,
	input	wire		WEN, CEN,
	input	wire		clk
);

	genvar		i;
	wire		clk_bar;
	reg	[5:0]	AI [5:0];
	reg	[15:0]	DI;
	wire	[15:0]	QI [5:0];

	assign	clk_bar	= ~clk;

	always	@(posedge clk) begin
		DI	<= D;
		AI[5]	<= A5;
		AI[4]	<= A4;
		AI[3]	<= A3;
		AI[2]	<= A2;
		AI[1]	<= A1;
		AI[0]	<= A0;
	end

	assign	Q5	= QI[5];
	assign	Q4	= QI[4];
	assign	Q3	= QI[3];
	assign	Q2	= QI[2];
	assign	Q1	= QI[1];
	assign	Q0	= QI[0];

endmodule /* sram */
