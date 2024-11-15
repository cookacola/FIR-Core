module converter(
    input           clk,
    input wire [15:0] fixed_in,
    output reg [15:0] float_out
);
    reg [4:0] i;
    reg [15:0] store;
    reg [9:0] mantissa;
    reg [4:0] exponent;

    always @ (posedge clk) begin
        if (fixed_in != 16'd0) begin
            i = 5'd15;
            // Find the position of the first '1' from MSB
            while (i > 0 && fixed_in[i] == 1'b0) begin
                i = i - 1'b1;
            end
            store = i;
            exponent = store + 5'd15; // Bias of 15 for half-precision

            // Align mantissa to 10 bits
            if (store >= 10) begin
                mantissa = fixed_in >> (store - 10);
            end else begin
                mantissa = fixed_in << (10 - store);
            end

            // Assemble the floating-point number: [Sign][Exponent][Mantissa]
            float_out <= {1'b0, exponent, mantissa[9:0]};
        end else begin
            // Floating-point representation of zero
            float_out <= 16'd0;
        end
    end
endmodule
