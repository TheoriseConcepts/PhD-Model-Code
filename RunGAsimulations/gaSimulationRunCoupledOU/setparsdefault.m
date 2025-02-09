function [paramsvec,paramDefCell,lb,ub] = setparsdefault(ParamsTest,paramstoest,npars_est)

params = struct('A', [ParamsTest{1,1}(1,1), ParamsTest{1,1}(2,1)], ...
                'a', [ParamsTest{1,1}(1,2), ParamsTest{1,1}(2,2)], ...
                'B', [ParamsTest{1,1}(1,3), ParamsTest{1,1}(2,3)], ...
                'b', [ParamsTest{1,1}(1,4), ParamsTest{1,1}(2,4)], ...
                'G', [ParamsTest{1,1}(1,5), ParamsTest{1,1}(2,5)], ...
                'g', [ParamsTest{1,1}(1,6), ParamsTest{1,1}(2,6)], ...
                'Cvec', [ParamsTest{1,1}(1,7), ParamsTest{1,1}(2,7)], ...
                'P', [ParamsTest{1,1}(1,8), ParamsTest{1,1}(2,8)], ...
                'r', [ParamsTest{1,1}(1,9), ParamsTest{1,1}(2,9)], ...
                'v0', [ParamsTest{1,1}(1,10), ParamsTest{1,1}(2,10)], ...
                'e0', [ParamsTest{1,1}(1,11), ParamsTest{1,1}(2,11)], ...
                'ss', [ParamsTest{1,1}(1,12), ParamsTest{1,1}(2,12)], ...
                'K', [ParamsTest{1,1}(1,13), ParamsTest{1,1}(2,13)]);


if size(ParamsTest{1,1},2) == 23
y0 = struct('y0', [ParamsTest{1,1}(1,14:end); ParamsTest{1,1}(2,14:end)]);
fnames = fieldnames(y0);
params.(fnames{1}) = y0.(fnames{1});


lb = [ParamsTest{2,1}]; lb = reshape(lb(:,1:13)', 1, []); 
% A a B b G g C P r v0 e0 ss K
ub = [ParamsTest{3,1}]; ub = reshape(ub(:,1:13)', 1, []); 

% vector form
paramsvec = NaN(1,26);
fieldNames = fieldnames(params);
for i = 1:numel(fieldNames)-1
    paramsvec(i) = params.(fieldNames{i})(1);
    paramsvec(i+13) = params.(fieldNames{i})(2);
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

elseif size(ParamsTest{1,1},2) == 26
tau = struct('tau', [ParamsTest{1,1}(1,14), ParamsTest{1,1}(2,14)]);
D = struct('D', [ParamsTest{1,1}(1,15), ParamsTest{1,1}(2,15)]);
y0 = struct('y0', [ParamsTest{1,1}(1,16:end); ParamsTest{1,1}(2,16:end)]);


fnames = {'tau', 'D', 'y0'};
for i = 1:numel(fnames)
    params.(fnames{i}) = eval(sprintf('%s.%s', fnames{i}, fnames{i}));
end


lb = [ParamsTest{2,1}]; lb = reshape(lb(:,1:15)', 1, []);    
% A a B b G g C P r v0 e0 ss K1 tau D
ub = [ParamsTest{3,1}]; ub = reshape(ub(:,1:15)', 1, []); 

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
end

