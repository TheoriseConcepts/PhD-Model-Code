function p1 = create_lhc_theo(ParamsTest,paramstoest,npars_est)

npop = 500;

params.A = ParamsTest{1,1}(1);
params.a = ParamsTest{1,1}(2);
params.B = ParamsTest{1,1}(3);
params.b = ParamsTest{1,1}(4);
params.G = ParamsTest{1,1}(5);
params.g = ParamsTest{1,1}(6);
params.Cvec = ParamsTest{1,1}(7);
params.P = ParamsTest{1,1}(8);
params.r = ParamsTest{1,1}(9);
params.v0 = ParamsTest{1,1}(10);
params.e0 = ParamsTest{1,1}(11);
params.y0 = ParamsTest{1,1}(12:end);

lb = [ParamsTest{2,1}];    
% A a B b G g C P r v0 e0 ss
ub = [ParamsTest{3,1}];

p1 = lhsdesign_scale_theo(npop, npars_est, [lb(paramstoest);ub(paramstoest)]);


