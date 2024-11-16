function output = FIR_Filter(input, coefficients)
    % FIR_filter applies FIR filtering on the input signal with 64-tap 16-bit precision
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
        for k = 1:64
            if n >= k
                % Accumulate each product as a 16-bit integer
                output(n) = output(n) + int16(coefficients(k)) * int16(input(n - k + 1));
            end
        end
    end
end
