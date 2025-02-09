function x_reconstructed = bestlambda(signal,signal2)

% t_orig = linspace(0, 1, length(signal2));
% t_interp = linspace(0, 1, 185850);
% signal_interp = interp1(t_orig, signal2, t_interp);

% Perform wavelet decomposition of level 7 using the sym4 wavelet
[c, l] = wavedec(signal, 7, 'sym4');

% Define a range of lambda scaling values to try
lambdascale = linspace(0.2, 0.6, 50);

% Preallocate a vector to store the reconstructed signal for each lambda
% scale value
x_reconstructed = zeros(length(lambdascale), length(signal));

% Loop over the lambda scale values and apply wavlet transform to the
% signal
for i = 1:length(lambdascale)
% Apply soft thresholding to the wavelet coefficients
lambda = lambdascale(i)*max(abs(c));
cT = sign(c) .* max(abs(c) - lambda, 0);
% Apply hard thresholding to the wavelet coefficients
% cT = c .* (abs(c) > lambda);

% Reconstruct the signal using the thresholded coefficients
x_reconstructed = waverec(cT, l, 'sym4');
% Store the reconstructed signal for this lambda scale value
x_reconstructed(i, :) = x_reconstructed;

end


BC = zeros(length(lambdascale), 1);
for i = 1:length(lambdascale)
resampled_signal = resample(x_reconstructed(i,:), 2, 100);  
resampled_signal = resampled_signal(1,3:3715);
TS=1:length(resampled_signal); % x axis
vgS= fast_HVG(resampled_signal, TS, 'w'); %wHVG
vg2S=full(vgS); % convert to full matrix

TS2=1:length(signal2); % x axis
vgS2= fast_HVG(signal2, TS2, 'w'); %wHVG
vg2S2=full(vgS2); % convert to full matrix

CS = centrality(graph(vg2S),'betweenness');
CS2 = centrality(graph(vg2S2),'betweenness');

[~, ~, BC(i)] = kstest2(CS,CS2);

end

% % Calculate the mean squared error (MSE) between the original signal and each reconstructed signal
% MSEs = zeros(length(lambdascale), 1);
% for i = 1:length(lambdascale)
%     MSEs(i) = mean((signal_interp - x_reconstructed(i, :)).^2);
% end

% Find the index of the scale value that yields the smallest MSE
[~, best_scale_idx] = min(BC);

best_scale_values = lambdascale(best_scale_idx);

% Apply soft thresholding to the wavelet coefficients
lambda = best_scale_values*max(abs(c));
% cT = sign(c) .* max(abs(c) - lambda, 0);
% Apply hard thresholding to the wavelet coefficients
cT = c .* (abs(c) > lambda);

% Reconstruct the signal using the thresholded coefficients
x_reconstructed = waverec(cT, l, 'sym4');