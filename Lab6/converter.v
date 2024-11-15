module converter(
	input wire [31:0] fixed_in,
	output wire [15:0] float_out
);

	assign float_out = fixed_in[31:16];
endmodule
