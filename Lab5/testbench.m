% Testbench for FIR_Filter function

% Parameters
Fs = 1000;         % Sampling frequency (Hz)
t = 0:1/Fs:1-1/Fs; % Time vector (1 second duration)
f_signal = 50;     % Frequency of the test signal (Hz)
f_noise = 200;     % Frequency of noise (Hz)

% Generate test signal: a sinusoid at 50 Hz with added 200 Hz noise
signal = sin(2 * pi * f_signal * t) + 0.5 * sin(2 * pi * f_noise * t);

% Apply FIR filter
filtered_signal = FIR_Filter(signal);

% Plot results
figure;
subplot(3,1,1);
plot(t, signal);
title('Original Signal (50 Hz with 200 Hz noise)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t, filtered_signal);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency domain analysis
subplot(3,1,3);
% Compute Fourier Transform of the filtered signal
N = length(t);
f = (0:N-1) * (Fs/N);  % Frequency vector
signal_fft = abs(fft(signal));
filtered_fft = abs(fft(filtered_signal));

plot(f, signal_fft, 'b', f, filtered_fft, 'r');
legend('Original Signal', 'Filtered Signal');
title('Frequency Response');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0, 300]); % Focus on low frequencies