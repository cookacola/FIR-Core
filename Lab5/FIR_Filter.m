function y = FIR_Filter(x)
    % 64-tap FIR filter with a linear buffer implementation
    %
    % Input:
    %   x : signal to be filtered
    %   
    % Output:
    %   y : filtered signal

    % Save input signal to file
    save('input_signal.mat', 'x');  % Save as .mat file)

    num_taps = 64;
    Wn = 0.4;
    
    % Calculate filter coefficients
    % n = -num_taps/2:num_taps/2;
    % b = Wn * sinc(Wn * n); 
    % bw = b .* hamming(length(b))'; % Apply Hamming window
    bw = fir1(num_taps, Wn);
    bw = bw / sum(bw); % Normalize coefficients

    % Initialize output and buffer
    y = zeros(size(x));
    z = zeros(length(bw), 1); % Adjust buffer size

    % Filtering process
    for i = 1:length(x)
        % Update buffer with new sample
        z(2:end) = z(1:end-1);
        z(1) = x(i);

        % Compute filtered output
        y(i) = bw * z; % Dot product of coefficients and buffer
    end

    % Save output signal to file
    save('output_signal.mat', 'y');  % Save as .mat file
end
