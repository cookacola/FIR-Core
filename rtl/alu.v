// alu.v - ALU module with integrated adder and multiplier logic
module alu (
    input wire clk,
    input wire rst,
    input wire [1:0] op_sel,           // Operation selector: 00 = Add, 01 = Multiply
    input wire [15:0] a,              // 16-bit input operand a
    input wire [15:0] b,              // 16-bit input operand b
    output reg [31:0] result          // 32-bit ALU result
);

    // Internal signals
    reg [31:0] mult_out;  // Multiplier output
    reg [31:0] add_out;   // Adder output

    // Multiplier logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mult_out <= 32'b0;    // Reset multiplier output
        end else begin
            mult_out <= a * b;    // Perform multiplication
        end
    end

    // Adder logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            add_out <= 32'b0;    // Reset adder output
        end else begin
            add_out <= a + b;   // Perform addition
        end
    end

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





