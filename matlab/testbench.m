% FIR_testbench.m - Testbench for FIR_filter function with 64 taps

% Example input signal with 16-bit integer values
input_file = fopen('input.txt','r');
coefficients_file = fopen('coefficients.txt','r');
out_file = fopen('output.results', 'w');

% Check if files are opened successfully
if input_file == -1
    error('Error opening input.txt');
end
if coefficients_file == -1
    error('Error opening coefficients.txt');
end

% Read data from the files
input = fscanf(input_file, '%d');
coefficients = fscanf(coefficients_file, '%d');

% Close the files after reading
fclose(input_file);
fclose(coefficients_file);

% Display number of coefficients
disp(['Number of coefficients: ', num2str(length(coefficients))]);

% Apply the FIR filter
output = FIR_Filter(input, coefficients);

% Write output to the .results file
fprintf(out_file, '%d\n', output);
fclose(out_file);  % Close the file after writing
disp('Output file saved successfully.');
