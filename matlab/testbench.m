% FIR_testbench.m - Testbench for FIR_filter function with 64 taps

% Example input signal with 16-bit integer values
input = int16(randi([-32768, 32767], 1, 100));  % 100 random 16-bit integers
coefficients = int16(rand(1, 64) * 32767);  % 64 random coefficients (16-bit integers)

% Apply the FIR filter
output = FIR_Filter(input, coefficients);

% Save input and output to .mat files
save('input.mat', 'input');
save('output.mat', 'output');
disp('Input and output files saved successfully.');
