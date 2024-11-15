module converter(
	input 			clk,
	input wire [15:0] 	fixed_in,
	output wire [15:0] 	float_out
);
	reg [4:0] i = 5'd15;
	reg [15:0] store;
	reg [9:0] mantissa;
	reg [4:0] exponent;

	always @ (posedge clk) begin
		if(operand != 16'd0) begin
			i = 5'd15;
			while (i > 0 && operand[i] == 1'b0) begin
				i = i - 1'b1;
			end
			store = i;
			exponent = store + 5'd15;
			if (store >= 10) begin
				mantissa = operand >> (store - 10);
			end else begin
				mantissa = operand >> (store - 10);
			end

			result <= {1'b0, exponent, mantissa[9,0]};
		end else begin
			result <= 16'd0;
		end
	end
endmodule
