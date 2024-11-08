function y = FIR_Filter(x)
    % 64-tap FIR filter with a linear buffer implementation
    %
    % Input:
    %   x : signal to be filtered
    %   
    % Output:
    %   y : filtered signal
    %
    % num_taps : number of taps
    % Wn : cutoff frequency

    num_taps = 64;
    Wn = 0.4;
    
    % Calculate filter coefficients
    b = Wn * sinc(Wn * (-num_taps/2:num_taps/2));
    bw = b .* hamming(num_taps + 1)';  % Apply Hamming window

    % Initialize output and buffer
    y = zeros(size(x));
    z = zeros(num_taps + 1, 1);  % Buffer to store recent samples with the same length as bw
    
    % Filtering process
    for i = 1:length(x)
        % Update buffer with new sample
        z = [x(i); z(1:end-1)];
        
        % Compute filtered output as dot product of coefficients and buffer
        y(i) = dot(bw, z);
    end
end
