`timescale 1ns/1ps
`define MATLAB_OUT_SUM_FN "../../matlab/sum_output.txt"
`define MATLAB_OUT_PROD_FN "../../matlab/product_output.txt"
`define QSIM_OUT_FN "./qsim.out"
`define SD #0.010
`define HALF_CLOCK_PERIOD #50
`define COEFFICIENT_INPUT_FN "../../matlab/coefficients.txt"
`define INPUT_FN "../../matlab/input.txt"

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
integer matlab_out_sum_file;
integer matlab_out_prod_file;
integer coefficient_file;
integer input_file;

// Temporary variables for reading data
integer ret_read;
integer temp_a, temp_b;
integer i;
integer matlab_sum, matlab_prod;

// Instantiate the ALU
alu alu_0 (
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .op_sel(select),
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

    // Open MATLAB output sum file for reading
    matlab_out_sum_file = $fopen(`MATLAB_OUT_SUM_FN, "r");
    if (matlab_out_sum_file == 0) begin
        $display("Couldn't read the MATLAB output sum file.");
        $finish;
    end

    // Open MATLAB output product file for reading
    matlab_out_prod_file = $fopen(`MATLAB_OUT_PROD_FN, "r");
    if (matlab_out_prod_file == 0) begin
        $display("Couldn't read the MATLAB output product file.");
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

    // -------------------------
    // Loop to Test Addition
    // -------------------------
    for (i = 0; i < 64; i = i + 1) begin
        // Read input operands
        ret_read = $fscanf(input_file, "%d\n", temp_a);
        if (ret_read != 1) begin
            $display("Error: Reading input file at addition iteration %d", i);
            $finish;
        end
        a = temp_a;

        ret_read = $fscanf(coefficient_file, "%d\n", temp_b);
        if (ret_read != 1) begin
            $display("Error: Reading coefficient file at addition iteration %d", i);
            $finish;
        end
        b = temp_b;

        $display("Addition Iteration %d: a = %d, b = %d", i, a, b);

        // Select addition operation
        select = 2'b00; // Add operation
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // Capture ALU output
        $fwrite(qsim_out_file, "Sum %d: %d\n", i, alu_out);

        // Read expected sum from MATLAB
        ret_read = $fscanf(matlab_out_sum_file, "%d\n", matlab_sum);
    end

    // -------------------------
    // Rewind Input Files
    // -------------------------
    $rewind(input_file);
    $rewind(coefficient_file);
    // Note: If MATLAB sum and product files are independent, no need to rewind them here

    // -------------------------
    // Loop to Test Multiplication
    // -------------------------
    for (i = 0; i < 64; i = i + 1) begin
        // Read input operands
        ret_read = $fscanf(input_file, "%d\n", temp_a);
        if (ret_read != 1) begin
            $display("Error: Reading input file at multiplication iteration %d", i);
            $finish;
        end
        a = temp_a;

        ret_read = $fscanf(coefficient_file, "%d\n", temp_b);
        if (ret_read != 1) begin
            $display("Error: Reading coefficient file at multiplication iteration %d", i);
            $finish;
        end
        b = temp_b;

        $display("Multiplication Iteration %d: a = %d, b = %d", i, a, b);

        // Select multiplication operation
        select = 2'b01; // Multiply operation
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // Capture ALU output
        $fwrite(qsim_out_file, "Product %d: %d\n", i, alu_out);

        // Read expected product from MATLAB
        ret_read = $fscanf(matlab_out_prod_file, "%d\n", matlab_prod);
    end

    // Close all files
    $fclose(qsim_out_file);
    $fclose(matlab_out_sum_file);
    $fclose(matlab_out_prod_file);
    $fclose(coefficient_file);
    $fclose(input_file);

    // Finish simulation
    $display("Testbench completed successfully.");
    $finish;
end

endmodule
