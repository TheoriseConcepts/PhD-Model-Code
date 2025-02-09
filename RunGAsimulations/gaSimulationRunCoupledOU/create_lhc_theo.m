function p1 = create_lhc_theo(ParamsTest,paramstoest,npars_est)

npop = 500;

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

elseif size(ParamsTest{1,1},2) == 26
tau = struct('tau', [ParamsTest{1,1}(1,14), ParamsTest{1,1}(2,14)]);
D = struct('D', [ParamsTest{1,1}(1,15), ParamsTest{1,1}(2,15)]);
y0 = struct('y0', [ParamsTest{1,1}(1,16:end); ParamsTest{1,1}(2,16:end)]);

lb = [ParamsTest{2,1}]; lb = reshape(lb(:,1:15)', 1, []);    
% A a B b G g C P r v0 e0 ss K1 tau D
ub = [ParamsTest{3,1}]; ub = reshape(ub(:,1:15)', 1, []); 

end

p1 = lhsdesign_scale_theo(npop, npars_est, [lb(1,paramstoest);ub(1,paramstoest)]);


