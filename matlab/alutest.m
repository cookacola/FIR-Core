% Read the input files
output = dlmread('input.txt');          % Read output.txt into a vector
coefficients = dlmread('coefficients.txt'); % Read coefficients.txt into a vector

% Ensure the files have the same length
if length(output) ~= length(coefficients)
    error('The input files must have the same length.');
end

% Perform element-wise addition and multiplication
sum_result = output + coefficients;         % Element-wise addition
product_result = output .* coefficients;    % Element-wise multiplication

% Write the results to separate output files
dlmwrite('sum_output.txt', sum_result, 'precision', '%.6f');
dlmwrite('product_output.txt', product_result, 'precision', '%.6f');

% Display completion message
disp('Addition and multiplication operations completed. Results saved to files.');
