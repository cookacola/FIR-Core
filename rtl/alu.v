// alu.v - ALU module integrating adder and multiplier
module alu (
    input wire clk,
    input wire rst,
    input wire [1:0] op_sel,           // Operation selector: 00 = Add, 01 = Multiply
    input wire [15:0] a,              // 16-bit input operand a
    input wire [15:0] b,              // 16-bit input operand b
    input wire [31:0] acc_in,         // 32-bit input accumulator value
    output reg [31:0] result          // 32-bit ALU result
);

    // Internal signals
    wire [31:0] mult_out;  // Multiplier output
    wire [31:0] add_out;   // Adder output

    // Instantiate multiplier
    multiplier u_multiplier (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .result(mult_out)
    );

    // Instantiate adder
    adder u_adder (
        .clk(clk),
        .rst(rst),
        .acc_in(acc_in),
        .multiplier_out(mult_out),
        .acc_out(add_out)
    );

    // Selector logic for result
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result <= 32'b0;    // Reset result to 0
        end else begin
            case (op_sel)
                2'b00: result <= add_out;  // Select addition
                2'b01: result <= mult_out; // Select multiplication
                default: result <= 32'b0;  // Default case
            endcase
        end
    end

endmodule

