// ALU.v - Contains both the multiplier and adder modules

module multiplier (
    input wire clk,
    input wire rst,
    input wire [15:0] a,         // 16-bit input operand a
    input wire [15:0] b,         // 16-bit input operand b
    output reg [31:0] result     // 32-bit multiplication result
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result <= 32'b0;    // Reset result to 0 on reset signal
        end else begin
            result <= a * b;    // Perform multiplication and store 32-bit result
        end
    end
endmodule


module adder (
    input wire clk,
    input wire rst,
    input wire [31:0] acc_in,          // 32-bit input accumulator value
    input wire [31:0] multiplier_out,  // 32-bit multiplier result
    output reg [31:0] acc_out          // 32-bit accumulator output
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            acc_out <= 32'b0;    // Reset accumulator output to 0 on reset signal
        end else begin
            acc_out <= acc_in + multiplier_out;   // Accumulate the sum of input and multiplier output
        end
    end
endmodule

