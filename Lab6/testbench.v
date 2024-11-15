`timescale 1ns / 1ps

module testbench;

    // Clock and Reset
    reg clk;
    reg rst;

    // Converter Inputs and Outputs
    reg [15:0] fixed_in;
    wire [15:0] float_out;

    // Multiplier Inputs and Outputs
    reg [15:0] mult_a;
    reg [15:0] mult_b;
    wire [31:0] mult_result;

    // Adder Inputs and Outputs
    reg [31:0] add_acc_in;
    reg [31:0] add_multiplier_out;
    wire [31:0] add_acc_out;

    // Instantiate Converter
    converter uut_converter (
        .clk(clk),
        .fixed_in(fixed_in),
        .float_out(float_out)
    );

    // Instantiate Multiplier
    multiplier uut_multiplier (
        .clk(clk),
        .rst(rst),
        .a(mult_a),
        .b(mult_b),
        .result(mult_result)
    );

    // Instantiate Adder
    adder uut_adder (
        .clk(clk),
        .rst(rst),
        .acc_in(add_acc_in),
        .multiplier_out(add_multiplier_out),
        .acc_out(add_acc_out)
    );

    // Clock Generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle every 5ns
    end

    // Initial Block for Reset and Stimulus
    initial begin
        // Initialize Inputs
        rst = 1;
        fixed_in = 16'd0;
        mult_a = 16'd0;
        mult_b = 16'd0;
        add_acc_in = 32'd0;
        add_multiplier_out = 32'd0;

        // Apply Reset
        #10;
        rst = 0;

        // Wait for converter to stabilize
        #10;

        // Test Case 1: Zero Inputs
        fixed_in = 16'd0;
        mult_a = 16'd0;
        mult_b = 16'd0;
        add_acc_in = 32'd0;
        add_multiplier_out = mult_result;
        #10;

        // Test Case 2: Positive Numbers
        fixed_in = 16'd25;    // Example fixed-point number
        mult_a = 16'd25;
        mult_b = 16'd10;
        add_acc_in = 32'd100;
        add_multiplier_out = mult_result;
        #10;

        // Test Case 3: Maximum Values
        fixed_in = 16'd65535;
        mult_a = 16'd65535;
        mult_b = 16'd65535;
        add_acc_in = 32'd65535;
        add_multiplier_out = mult_result;
        #10;

        // Test Case 4: Powers of Two
        fixed_in = 16'd8;     // 2^3
        mult_a = 16'd8;
        mult_b = 16'd16;     // 2^4
        add_acc_in = 32'd256;
        add_multiplier_out = mult_result;
        #10;

        // Test Case 5: Random Values
        fixed_in = 16'd12345;
        mult_a = 16'd12345;
        mult_b = 16'd54321;
        add_acc_in = 32'd30000;
        add_multiplier_out = mult_result;
        #10;

        // Test Case 6: Small Values
        fixed_in = 16'd1;
        mult_a = 16'd1;
        mult_b = 16'd2;
        add_acc_in = 32'd3;
        add_multiplier_out = mult_result;
        #10;

        // Test Case 7: Sequential Values
        fixed_in = 16'd100;
        mult_a = 16'd100;
        mult_b = 16'd200;
        add_acc_in = 32'd1000;
        add_multiplier_out = mult_result;
        #10;

        // Finish Simulation
        #20;
        $finish;
    end

    // Monitor Outputs
    initial begin
        $monitor("Time=%0t | Reset=%b | Fixed_in=%d | Float_out=0x%h | Mult_A=%d | Mult_B=%d | Mult_Result=%d | Add_Acc_In=%d | Add_Mult_Out=%d | Add_Acc_Out=%d",
                 $time, rst, fixed_in, float_out, mult_a, mult_b, mult_result, add_acc_in, add_multiplier_out, add_acc_out);
    end

endmodule
