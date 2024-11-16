module mac (
	input wire clk,		//input clock signal
	input wire rst,			//input reset signal
	input wire [15:0] a,		//multiplicand
	input wire [15:0] b,		//multiplier
	input wire [31:0] acc_in,	//accumulator input
	output reg [31:0] acc_out	//accumulator output
);

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			acc_out <= 32'b0;
		end else begin
			acc_out <= acc_in + (a * b);
		end
	end
endmodule	
