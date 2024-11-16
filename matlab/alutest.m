% Read the input files
output = dlmread('input.txt');          % Read output.txt into a vector
coefficients = dlmread('coefficients.txt'); % Read coefficients.txt into a vector

% Ensure the files have the same length
if length(output) ~= length(coefficients)
    error('The input files must have the same length.');
end

% Initialize the result array
combined_result = zeros(2 * length(output), 1);

% Perform operations (add and multiply pairs)
for i = 1:length(output)
    combined_result(2 * i - 1) = output(i) + coefficients(i); % Addition
    combined_result(2 * i) = output(i) * coefficients(i);     % Multiplication
end

% Write the results to a single output file
dlmwrite('alutestoutput.txt', combined_result, 'precision', '%.6f');

% Display completion message
disp('Combined addition and multiplication completed. Results saved to alutestoutput.txt');
