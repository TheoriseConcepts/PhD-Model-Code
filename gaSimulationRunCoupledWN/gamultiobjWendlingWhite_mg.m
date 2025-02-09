function [y Xemburn] = gamultiobjWendlingWhite_mg(T, paramsinput,bb,aa)
[Xemburn,ca,t,t3,Nn_conv,fs_conv]=gamultiobjWendlingWhite_mex(T,paramsinput); 
if any(isnan(Xemburn(:)))
y = NaN;    
else

zXemburn = zscore(Xemburn);
% Perform linear regression
Z = [ones(size(zXemburn,2), 1), t(50000:end-1)'];
[bq, ~, ~, ~, ~] = regress(zXemburn', Z);

threshold = 0.01;

% Check the regression coefficient using threshold
if bq(2) > threshold
    y = NaN;
elseif bq(2) < -threshold
    y = NaN;
elseif bq(2) == 0
    y = NaN;
else
    y = gamultiobjWendling_post(Xemburn,ca,t,t3,bb,aa,Nn_conv,fs_conv);
end
    
end