function filtered_signal = bestmovingaverage(signal)

% Define a range of window sizes to try
% window_sizes = 1858.5:1858.5:18585/2;
window_sizes = 500:185:7400;

% Preallocate a vector to store the filtered signal for each window size
filtered_signals = zeros(length(window_sizes), length(signal));

% Loop over the window sizes and apply the moving average filter to the signal
for i = 1:length(window_sizes)
    % Apply the moving average filter
    filtered_signal = movmean(signal, window_sizes(i));
    
    % Store the filtered signal for this window size
    filtered_signals(i, :) = filtered_signal;
end

% Calculate the mean squared error (MSE) between the original signal and each filtered signal
MSEs = zeros(length(window_sizes), 1);
for i = 1:length(window_sizes)
    MSEs(i) = mean((signal - filtered_signals(i, :)).^2);
end

% Find the index of the window size that yields the smallest MSE
[~, best_window_idx] = min(MSEs);

% Apply the moving average filter with the best window size to the signal
best_window_size = window_sizes(best_window_idx);
filtered_signal = movmean(signal, best_window_size);
