function output = FIR_Filter(input, coefficients)
    % Behavioral model for a FIR_filter applies FIR filtering on the 
    % input signal with 64-tap 16-bit precision
    % Parameters:
    %   input - Array of input signal samples (16-bit integers)
    %   coefficients - Array of 64 FIR filter coefficients (16-bit integers)
    % Returns:
    %   output - Array of filtered signal samples (16-bit integers)

    % Ensure coefficients array has exactly 64 taps
    assert(length(coefficients) == 64, 'This FIR filter requires exactly 64 coefficients.');

    % Preallocate the output array
    output = zeros(1, length(input), 'int16');  % 16-bit output precision
    
    % FIR filter implementation
    for n = 1:length(input)
        acc = int32(0);  % Use 32-bit accumulator to avoid overflow
        for k = 1:64
            if n >= k
                acc = acc + int32(coefficients(k)) * int32(input(n - k + 1));
            end
        end
        % Convert the accumulated result back to 16-bit integer with saturation
        output(n) = int16(max(min(acc, 32767), -32768));
    end
end
