% FIR_testbench.m - Testbench for FIR_filter function with 64 taps

% Example input signal with 16-bit integer values
input_file = fopen('input.txt','r');
coefficients_file = fopen('coefficients.txt','r');

% Check if files are opened successfully
if input_file == -1
    error('Error opening input.txt');
end
if coefficients_file == -1
    error('Error opening coefficients.txt');
end

input = fscanf(input_file, '%d');
coefficients = fscanf(coefficients_file, '%d');

% Close the files after reading
fclose(input_file);
fclose(coefficients_file);

% Apply the FIR filter
output = FIR_Filter(input, coefficients);

% Save output to a .results files
save('output.results', 'output');
disp('Output file saved successfully.'); 