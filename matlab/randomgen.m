% Example to generate 'input.txt' and 'coefficients.txt'

% Generate example input signal (e.g., 64 samples)
input_signal = int16(randi([0, 32767], 1, 64));  % 16-bit integers

% Generate example coefficients (64 taps)
fir_coefficients = int16(randi([0, 32767], 1, 64));  % 16-bit integers

% Save to 'input.txt'
fid_input = fopen('input.txt', 'w');
fprintf(fid_input, '%d\n', input_signal);
fclose(fid_input);

% Save to 'coefficients.txt'
fid_coeff = fopen('coefficients.txt', 'w');
fprintf(fid_coeff, '%d\n', fir_coefficients);
fclose(fid_coeff);