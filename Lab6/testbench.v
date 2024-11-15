module testbench;
	reg clock;

	reg [15:0] fixed_input_a;
	reg [15:0] fixed_input_b;

	wire [15:0] float_a;
	wire [15:0] float_b;

	wire [15:0] float_sum;

	wire [15:0] float_product;

	converter converter_a {
		.clk(clk),
		.fixed_in(fixed_input_a),
		.float_out(float_a)
	};

		
