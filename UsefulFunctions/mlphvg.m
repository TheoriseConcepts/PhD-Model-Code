function [MG, vis] = mlphvg(x, W, p)
% Compute the multiscale limited penetrable horizontal visibility graph of a time series x.
% The time series x is divided into non-overlapping windows of length W.
% The parameter p determines the degree of penetration allowed between consecutive windows.

% x: the time series, as a column vector.
% W: the length of the non-overlapping windows used for the coarsest scale.
% p: the degree of penetration allowed between consecutive windows, as a scalar between 0 and 1.
% The output arguments are:
% 
% MG: the adjacency matrix of the multiscale limited penetrable horizontal visibility graph.
% vis: a list of triplets (i,j,m) of indices of windows that are mutually visible at scale m.

n = length(x);
M = floor(log2(n/W))+1;
MG = cell(M, 1);
vis = [];

for m = 1:M
    w = W * 2^(m-1);
    k = floor(n/w);
    MG{m} = sparse(k, k);
    for i = 1:k-1
        for j = i+1:k
            if x((i-1)*w+1) > x((j-1)*w+1) || x(i*w) < x(j*w)
                continue;
            end
            visij = true;
            for l = i+1:j-1
                if x(l*w) >= x(i*w) && x(l*w) >= x(j*w)
                    visij = false;
                    break;
                end
                if x(l*w) < x(i*w) && x((l+1)*w) > x(i*w)+p*(x(j*w)-x(i*w))
                    visij = false;
                    break;
                end
                if x(l*w) > x(i*w) && x(l*w) < x(j*w) && x((l+1)*w) > x(j*w)
                    visij = false;
                    break;
                end
            end
            if visij
                MG{m}(i,j) = 1;
                MG{m}(j,i) = 1;
                vis = [vis; i, j, m];
            end
        end
    end
end

% Construct the final multiscale LP-HVG by merging the individual graphs
MG = MG{1};
for m = 2:M
    k1 = size(MG, 1);
    k2 = size(MG, 2);
    MG = blkdiag(MG, sparse(k1, k1), sparse(k2, k2));
    MG(end-k2+1:end, 1:k1) = MG(m);
    MG(1:k1, end-k2+1:end) = MG(m)';
end
