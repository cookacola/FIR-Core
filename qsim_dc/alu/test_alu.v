`timescale 1ns/1ps
`define MATLAB_OUT_SUM_FN "../../matlab/sum_output.txt"
`define MATLAB_OUT_PROD_FN "../../matlab/product_output.txt"
`define QSIM_OUT_FN "./qsim.out"
`define HALF_CLOCK_PERIOD #0.90
`define COEFFICIENT_INPUT_FN "../../matlab/coefficients.txt"
`define INPUT_FN "../../matlab/input.txt"

module tb_alu;

// Clock and Reset
reg clk;
reg rst;

// Inputs for ALU (multiplier + adder)
reg signed [15:0] a, b;            // 16-bit signed operands
reg [1:0] select;                   // Selects the operation

// Outputs from ALU
wire signed [31:0] alu_out;        // 32-bit signed ALU result

// Instantiate the ALU
alu alu_0 (
    .clk(clk),
    .rst(rst),
    .op_sel(select),
    .a(a),
    .b(b),
    .result(alu_out)
);

// Clock generation
always begin
    clk = 0;
    forever `HALF_CLOCK_PERIOD clk = ~clk;
end

initial begin
    // Initialize signals
    rst = 1;
    a = 0;
    b = 0;
    select = 0;

    // Apply reset
    @(posedge clk);
    @(negedge clk);
    rst = 0;

    // Wait for a clock cycle after reset
    @(posedge clk);

    // Generate random values for a and b
    repeat (64) begin
        a = $random % 65536; // 16-bit range
        b = $random % 65536; // 16-bit range
        select = $random % 3; // 3 valid operations (00, 01, 10)

        // Wait for a clock cycle
        @(posedge clk);
    end

    // Finish simulation
    $display("Testbench completed successfully.");
    $finish;
end

endmodule
