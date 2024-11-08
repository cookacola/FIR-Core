function B_q15 = quantize_to_q15(B)
    % Quantize filter coefficients to 16-bit Q15 format
    %
    % Inputs:
    %   B - Original filter coefficients (floating-point)
    %
    % Output:
    %   B_q15 - Quantized filter coefficients (fixed-point Q15)
    
    % Define scaling factor for Q15
    scalingFactor = 2^15;
    
    % Scale and round the coefficients
    B_scaled = round(B * scalingFactor);
    
    % Saturate to prevent overflow
    B_scaled(B_scaled > 32767) = 32767;
    B_scaled(B_scaled < -32768) = -32768;
    
    % Convert to fixed-point Q15 by dividing back
    B_q15 = B_scaled / scalingFactor;
end