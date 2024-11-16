module multiplier (
	input wire clk,
	input wire rst,
	input wire [15:0] a,
	input wire [15:0] b,
	output reg [15:0] result
);

	always @(posedge clk or posedge rst) begin
		if(rst) begin
			result <= 16'b0;
		end else begin
			result <= a * b;
		end
	end
endmodule

