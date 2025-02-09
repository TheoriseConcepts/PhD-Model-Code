params = struct('A', [3.25, 3.25], ...
                'a', [100, 100], ...
                'B', [22.0, 22.0], ...
                'b', [50.0, 50.0], ...
                'G', [20.0, 20.0], ...
                'g', [500.0, 500.0], ...
                'Cvec', [135.0, 135.0], ...
                'P', [220.0, 220.0], ...
                'r', [0.56, 0.56], ...
                'v0', [6.0, 6.0], ...
                'e0', [2.5, 2.5], ...
                'ss', [1, 1], ...
                'K', [1000, 1000], ...
                'tau', [10^(-0.5), 10^(-0.5)], ...
                'D', [100, 100], ...
                'y0', [10*rand(1,11), 10*rand(1,11)]);

% bounds from Lauric's paper, padded with zeros for the initial conditions
% lb = [0 25 0 6.5 0 350 0 0 0.3 2 0.5 0.1 0 0 0 0 (-500)*ones(1, 22)];
lb = [0 25 0 6.5 0 350 0 0 0.3 2 0.5 0.1 0 0 0 0 ...
      0 25 0 6.5 0 350 0 0 0.3 2 0.5 0.1 0 0 0 0];
% A a B b G g C P r v0 e0 ss K1 K2 tau D
% ub = [10 140 50 110 50 650 1350 2000 0.8 9 7.5 30 2000 2000 0.4 150 ones(1, 22)*500];
ub = [10 140 50 110 50 650 1350 2000 0.8 9 7.5 30 2000 2000 0.4 150 ...
      10 140 50 110 50 650 1350 2000 0.8 9 7.5 30 2000 2000 0.4 150];

% vector form
paramsvec = NaN(1,30);
fieldNames = fieldnames(params);
for i = 1:numel(fieldNames)-1
    paramsvec(i) = params.(fieldNames{i})(1);
    paramsvec(i+15) = params.(fieldNames{i})(2);
end

temp=cell(npars_est, 3);
for i=1:npars_est
    temp1=['p',int2str(i)];
    bnds=[lb(paramstoest(i)) ub(paramstoest(i))];
    res1=0.01;
    temp{i,1}=temp1;
    temp{i,2}=bnds;
    temp{i,3}=res1;
end

paramDefCell = temp;