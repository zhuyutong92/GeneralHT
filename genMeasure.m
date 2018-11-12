function [ measure ] = genMeasure( truth, err_std )
    [row, ~] = size(truth);
    measure = truth(1 : ceil(row / 2), :);
    error = randn(size(measure)) .* repmat(err_std, [size(measure,1), 1]);
    measure = measure +  error;
end

