`timescale 1ns/1ps
`define MATLAB_OUT_FN "../matlab/output.results"
`define QSIM_OUT_FN "./qsim.out"
`define SD #0.010
`define HALF_CLOCK_PERIOD #0.90
`define COEFFICIENT_INPUT_FN "../matlab/coefficients.txt"
`define INPUT_FN "../matlab/input.txt"

module tb_alu;

    // Clock and Reset
    reg clk;
    reg rst;

    // Inputs for ALU (multiplier + adder)
    reg [15:0] a, b;            // Operands for multiplication
    reg [31:0] acc_in;          // Input to the adder's accumulator

    // Outputs from ALU
    wire [31:0] mult_result;    // 32-bit multiplier result
    wire [15:0] mult_result_16; // 16-bit truncated multiplier result
    wire [31:0] acc_out;        // 32-bit adder result
    wire [15:0] acc_out_16;     // 16-bit truncated adder result

    initial begin
	    qsim_out_file = $fopen(`QSIM_OUT_FN, "w");
	    if (!qsim_out_file) begin
		    $display("Couldn't create the output file.")
		    $finish;
	    end

            matlab_out_file = $fopen(`MATLAB_OUT_FN, "r");
            if (!matlab_out_file) begin
                    $display("Couldn't read the MATLAB file.")
                    $finish;
            end

	    coefficient_input_file = $fopen(`COEFFICIENT_INPUT_FN, "r");
	    if (!coefficient_input_file) begin
		    $display("Couldn't read the coefficient input.")
		    $finish;
	    end

	    input_file = $fopen(`INPUT_FN, "r");
	    if (!input_file) begin
		    $display("Couldn't read the input file")
		    $finish
	    end
	clk = 0
	rst = 1
	@(posedge clk);

	@(negedge clk);
	rst = 0;
	
	@(posedge clk);
	for (i = 0 ; i < 64 ; i = i + 1) begin
		ret_read = $fscanf(matlab_out_file, "%d", 

	    

    // Instantiate the multiplier
    multiplier uut_multiplier (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .result(mult_result),
        .result_16(mult_result_16)
    );

    // Instantiate the adder
    adder uut_adder (
        .clk(clk),
        .rst(rst),
        .acc_in(acc_in),
        .multiplier_out(mult_result),
        .acc_out(acc_out),
        .acc_out_16(acc_out_16)
    );

    // Clock Generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle every 5ns (10ns period)
    end

    // Stimulus (Initial Block)
    initial begin
        // Initialize Inputs
        rst = 0;
        a = 16'd0;
        b = 16'd0;
        acc_in = 32'd0;

        // Apply Reset
        #10 rst = 1; // Apply reset
        #10 rst = 0; // Release reset

        // Test Case 1: Multiplication of two numbers
        #10 a = 16'd10; b = 16'd5; // a = 10, b = 5
        #10; // Wait for one clock cycle

        // Test Case 2: Accumulation with result from multiplier
        #10 acc_in = 32'd0; // Reset accumulator to 0
        #10 acc_in = acc_out + mult_result; // Add previous result to accumulator

        // Test Case 3: More Multiplication and Accumulation
        #10 a = 16'd7; b = 16'd3; // a = 7, b = 3 (New multiplication)
        #10 acc_in = acc_out + mult_result; // Accumulate the new result

        // Test Case 4: Large multiplication and accumulation
        #10 a = 16'd1024; b = 16'd2048; // Large multiplication test
        #10 acc_in = acc_out + mult_result; // Accumulate the new result

        // End the simulation after a few cycles
        #20;
        $finish;
    end

    // Display the results for each test case
    always @(posedge clk) begin
        // Monitor outputs for all test cases
        $display("Time: %0t | a: %d, b: %d | mult_result: %d, mult_result_16: %d | acc_in: %d | acc_out: %d, acc_out_16: %d", 
                 $time, a, b, mult_result, mult_result_16, acc_in, acc_out, acc_out_16);
    end

endmodule
