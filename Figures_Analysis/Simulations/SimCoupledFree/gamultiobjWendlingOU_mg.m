function [y Xemburn] = gamultiobjWendlingOU_mg(T, paramsinput,bb,aa)
[Xemburn,ca,t,t3,Nn_conv,fs_conv]=gamultiobjWendlingOU(T,paramsinput); 
if any(isnan(Xemburn(:)))
y = NaN;    
else

% zXemburn = zscore(Xemburn);
% % Perform linear regression
% Z = [ones(size(zXemburn,2), 1), t(150000:end-1)'];
% [b, ~, ~, ~, ~] = regress(zXemburn', Z);
% 
% threshold = 0.01;
% 
% % Check the regression coefficient using threshold
% if b(2) > threshold
%     y = NaN;
% elseif b(2) < -threshold
%     y = NaN;
% else
     y = gamultiobjWendling_post(Xemburn,ca,t,t3,bb,aa,Nn_conv,fs_conv);
% end
    
end