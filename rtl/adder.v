module adder(
	input wire clk,
	input wire rst,
	input wire [31:0] acc_in,
	input wire [31:0] multiplier_out,
	output reg [31:0] acc_out
);
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			acc_out <= 32'b0;
		end else begin
			acc_out <= acc_in + multiplier_out;
		end
	end
endmodule
