% Example to generate 'input.txt' and 'coefficients.txt'

% Generate example input signal (e.g., 64 samples)
input_signal = int16(randi([-32768, 32767], 1, 64));  % 16-bit integers

% Generate example coefficients (64 taps)
fir_coefficients = int16(randi([-32768, 32767], 1, 64));  % 16-bit integers

% Save to 'input.txt'
fid_input = fopen('input.txt', 'w');
fprintf(input.txt, '%d\n', input_signal);
fclose(input.txt);

% Save to 'coefficients.txt'
fid_coeff = fopen('coefficients.txt', 'w');
fprintf(coefficients.txt, '%d\n', fir_coefficients);
fclose(coefficients.txt);
