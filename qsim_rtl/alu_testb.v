`timescale 1ns/1ps
`define MATLAB_OUT_FN "../matlab/alutestoutput.txt"
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
    reg [1:0] select;           // Selects the operation

    // Outputs from ALU
    wire [31:0] alu_out;        // 32-bit adder result

    // File handles
    integer qsim_out_file;
    integer matlab_out_file;
    integer coefficient_file;
    integer input_file;

    // Temporary variables for reading data
    integer ret_read;
    integer temp_a, temp_b, temp_select;
    integer i;

    // Instantiate the ALU
    alu alu_0 (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .select(select),
        .result(alu_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever `HALF_CLOCK_PERIOD clk = ~clk;
    end

    initial begin
        // Open output file for QSIM
        qsim_out_file = $fopen(`QSIM_OUT_FN, "w");
        if (qsim_out_file == 0) begin
            $display("Couldn't create the QSIM output file.");
            $finish;
        end

        // Open MATLAB output file for reading
        matlab_out_file = $fopen(`MATLAB_OUT_FN, "r");
        if (matlab_out_file == 0) begin
            $display("Couldn't read the MATLAB output file.");
            $finish;
        end

        // Open coefficient input file
        coefficient_file = $fopen(`COEFFICIENT_INPUT_FN, "r");
        if (coefficient_file == 0) begin
            $display("Couldn't read the coefficient input file.");
            $finish;
        end

        // Open input file
        input_file = $fopen(`INPUT_FN, "r");
        if (input_file == 0) begin
            $display("Couldn't read the input file.");
            $finish;
        end

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

        // Loop to apply test vectors
        for (i = 0; i < 64; i = i + 1) begin
            // Read input operands
            ret_read = $fscanf(input_file, "%d\n", temp_a);
            if (ret_read != 1) begin
                $display("Error: Reading input file at iteration %d", i);
                $finish;
            end
            a = temp_a;

            ret_read = $fscanf(coefficient_file, "%d\n", temp_b);
            if (ret_read != 1) begin
                $display("Error: Reading coefficient file at iteration %d", i);
                $finish;
            end
            b = temp_b;

            // Select operation
            // Example: 2'b00 for add, 2'b01 for multiply
            select = 2'b00; // Add operation
            @(posedge clk);

            $fwrite(qsim_out_file, "%d\n", alu_out);
            @(posedge clk);

            select = 2'b01; // Multiply operation
            @(posedge clk);

            // Capture ALU output after operations
            @(posedge clk);
            $fwrite(qsim_out_file, "%d\n", alu_out);
        end

        // Close all files
        $fclose(qsim_out_file);
        $fclose(matlab_out_file);
        $fclose(coefficient_file);
        $fclose(input_file);

        // Finish simulation
        $display("Testbench completed successfully.");
        $finish;
    end

endmodule
