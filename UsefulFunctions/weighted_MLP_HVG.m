function [WMLPHVG, scales] = weighted_MLP_HVG(signal_var, coords_var, scale_min, scale_max, scale_step, alpha, beta)
% Implementation of weighted multiscale limited penetrable horizontal visibility graph based on:
% Gao, Z. K., Cao, Y., Yang, Y., Peng, J., & She, L. (2016).
% Multiscale limited penetrable horizontal visibility graph for analyzing nonlinear time series.
% Physica A: Statistical Mechanics and its Applications, 449, 176-186.
% Code based on fast_HVG.m by Giovanni Iacobello
% ===============================================================
% INPUTS:
% signal_var: time series (must be a vector)
% coords_var: time vector (same length as signal_var)
% scale_min: minimum scale to consider (scalar)
% scale_max: maximum scale to consider (scalar)
% scale_step: step size for scales (scalar)
% alpha: parameter for penetrability function (scalar)
% beta: parameter for penetrability function (scalar)
%
% OUTPUTS:
% WMLPHVG: cell array of weighted adjacency matrices for each scale
% scales: vector of scales used
%
%% PRE-PROCESSING CONTROLS
    if isvector(signal_var)==0 || isvector(coords_var)==0
        disp('Error size: series and times must be vectors')
        return;
    end
    if length(signal_var)~=length(coords_var)
        disp('Error size: series and times must have the same length')
        return;
    end
    if iscolumn(signal_var)==0
        signal_var=signal_var';
    end
    if iscolumn(coords_var)==0
        coords_var=coords_var';
    end
    if scale_min <= 0 || scale_max <= 0 || scale_step <= 0
        disp('Error scales: all scales must be positive')
        return;
    end
    if alpha <= 0 || beta <= 0
        disp('Error penetrability parameters: must be positive')
        return;
    end

%% RUNNING
    scales = scale_min:scale_step:scale_max;
    num_scales = length(scales);
    WMLPHVG = cell(1,num_scales);
    for s = 1:num_scales
        shiftvalue = scales(s);
        VG = fast_HVG(signal_var, coords_var, shiftvalue);
        N = size(VG,1);
        W = zeros(N,N);
        for i = 1:N
            for j = i+1:N
                if VG(i,j) == 1 % nodes i and j are connected in VG
                    penetrability = exp(-abs(signal_var(i)-signal_var(j))/(alpha*scales(s)))^beta;
                    W(i,j) = penetrability;
                    W(j,i) = penetrability; % make W symmetrical
                end
            end
        end
        WMLPHVG{s} = W;
    end

end
