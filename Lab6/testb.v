`timescale 1ns/1ps
`define SD #0.010
`define HALF_CLOCK_PERIOD #5    // Adjusted to create a 10ns period (half period = 5ns)
`define QSIM_OUT_FN "./qsim.out"
`define MATLAB_OUT_FN "./matlab_results.txt"

module testb();

    // Clock and Reset
    reg clk;
    reg resetn;

    // Input Registers
    reg [15:0] fixed_in;
    reg [15:0] mult_a;  // Declare mult_a as reg
    reg [15:0] mult_b;  // Declare mult_b as reg
    reg [31:0] add_acc_in;
    reg [31:0] add_multiplier_out;

    // Outputs from Modules
    wire [15:0] float_out;
    wire [31:0] mult_result;
    wire [31:0] add_acc_out;

    // File Handles
    integer qsim_out_file;
    integer matlab_out_file;

    // Expected Values
    integer expected_fixed_in;
    integer expected_float_out;
    integer expected_mult_a;
    integer expected_mult_b;
    integer expected_mult_result;
    integer expected_add_acc_in;
    integer expected_add_mult_out;
    integer expected_add_acc_out;

    // Simulation Outputs
    integer sim_fixed_in;
    integer sim_float_out;
    integer sim_mult_a;
    integer sim_mult_b;
    integer sim_mult_result;
    integer sim_add_acc_in;
    integer sim_add_mult_out;
    integer sim_add_acc_out;

    // Error Counting
    integer error_count = 0;
    integer total_tests = 0;

    // Declare ret_read to capture the result of fscanf
    integer ret_read;

    // Instantiate Modules
    converter uut_converter (
        .clk(clk),
        .fixed_in(fixed_in),
        .float_out(float_out)
    );

    multiplier uut_multiplier (
        .clk(clk),
        .rst(resetn),
        .a(mult_a),
        .b(mult_b),
        .result(mult_result)
    );

    adder uut_adder (
        .clk(clk),
        .rst(resetn),
        .acc_in(add_acc_in),
        .multiplier_out(add_multiplier_out),
        .acc_out(add_acc_out)
    );

    // Clock Generation: 10ns period
    initial begin
        clk = 0;
        forever begin
            `HALF_CLOCK_PERIOD;
            clk = ~clk;
        end
    end

    // Initial Block for Reset and Stimulus
    initial begin
        // Initialize Inputs
        resetn = 0;
        fixed_in = 16'd0;
        mult_a = 16'd0;  // Initialize mult_a
        mult_b = 16'd0;  // Initialize mult_b
        add_acc_in = 32'd0;
        add_multiplier_out = 32'd0;

        // File IO
        qsim_out_file = $fopen(`QSIM_OUT_FN, "w");
        if (!qsim_out_file) begin
            $display("Error: Couldn't create the QSIM output file.");
            $finish;
        end

        matlab_out_file = $fopen(`MATLAB_OUT_FN, "r");
        if (!matlab_out_file) begin
            $display("Error: Couldn't open the MATLAB expected results file.");
            $finish;
        end

        // Apply Reset
        @(posedge clk);
        @(negedge clk);
        resetn = 1;  // Release reset

        // Wait for reset to propagate
        @(posedge clk);

        // Begin Test Cases
        while (!$feof(matlab_out_file)) begin
            // Read Expected Values from MATLAB Output File
            // Assuming the file has the following order per line:
            // fixed_in float_out_expected mult_a mult_b mult_result_expected add_acc_in add_multiplier_out_expected add_acc_out_expected
            ret_read = $fscanf(matlab_out_file, "%d %h %d %d %d %d %d %d\n",
                               expected_fixed_in,
                               expected_float_out,
                               expected_mult_a,
                               expected_mult_b,
                               expected_mult_result,
                               expected_add_acc_in,
                               expected_add_mult_out,
                               expected_add_acc_out);

            // Apply Inputs
            fixed_in = expected_fixed_in;
            mult_a = expected_mult_a;  // Apply mult_a
            mult_b = expected_mult_b;  // Apply mult_b
            add_acc_in = expected_add_acc_in;
            add_multiplier_out = expected_add_mult_out;

            // Wait for outputs to stabilize
            @(posedge clk);

            // Capture Simulation Outputs
            sim_fixed_in = fixed_in;
            sim_float_out = float_out;
            sim_mult_a = mult_a;
            sim_mult_b = mult_b;
            sim_mult_result = mult_result;
            sim_add_acc_in = add_acc_in;
            sim_add_mult_out = add_multiplier_out;
            sim_add_acc_out = add_acc_out;

            // Write Simulation Outputs to QSIM Output File
            // Format: fixed_in float_out mult_a mult_b mult_result add_acc_in add_mult_out add_acc_out
            $fwrite(qsim_out_file, "%d %h %d %d %d %d %d %d\n",
                    sim_fixed_in,
                    sim_float_out,
                    sim_mult_a,
                    sim_mult_b,
                    sim_mult_result,
                    sim_add_acc_in,
                    sim_add_mult_out,
                    sim_add_acc_out);

            // Compare Simulation Outputs with Expected Values
            if ((sim_fixed_in !== expected_fixed_in) ||
                (sim_float_out !== expected_float_out) ||
                (sim_mult_a !== expected_mult_a) ||
                (sim_mult_b !== expected_mult_b) ||
                (sim_mult_result !== expected_mult_result) ||
                (sim_add_acc_in !== expected_add_acc_in) ||
                (sim_add_mult_out !== expected_add_mult_out) ||
                (sim_add_acc_out !== expected_add_acc_out)) begin
                error_count = error_count + 1;
                $display("Mismatch Detected at Test Case %0d:", total_tests + 1);
                $display("Expected: fixed_in=%d, float_out=0x%h, mult_a=%d, mult_b=%d, mult_result=%d, add_acc_in=%d, add_mult_out=%d, add_acc_out=%d",
                         expected_fixed_in,
                         expected_float_out,
                         expected_mult_a,
                         expected_mult_b,
                         expected_mult_result,
                         expected_add_acc_in,
                         expected_add_mult_out,
                         expected_add_acc_out);
                $display("Got:      fixed_in=%d, float_out=0x%h, mult_a=%d, mult_b=%d, mult_result=%d, add_acc_in=%d, add_mult_out=%d, add_acc_out=%d",
                         sim_fixed_in,
                         sim_float_out,
                         sim_mult_a,
                         sim_mult_b,
                         sim_mult_result,
                         sim_add_acc_in,
                         sim_add_mult_out,
                         sim_add_acc_out);
            end

            total_tests = total_tests + 1;
        end

        // Final Results
        if (error_count > 0) begin
            $display("\nTestbench Completed with %0d Mismatches out of %0d Test Cases.", error_count, total_tests);
            $display("The results DO NOT match with those from MATLAB :(");
        end else begin
            $display("\nAll %0d Test Cases Passed Successfully!", total_tests);
            $display("The results DO match with those from MATLAB :)");
        end

        // Close Files and Finish
        $fclose(qsim_out_file);
        $fclose(matlab_out_file);
        $finish;
    end

endmodule // testbench

