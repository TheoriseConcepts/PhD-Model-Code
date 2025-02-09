function [paramsvec,paramDefCell,lb,ub] = setparsdefault(ParamsTest,paramstoest,npars_est)

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
params.ss = ParamsTest{1,1}(12);

if size(ParamsTest{1,1},2) == 22
params.y0= ParamsTest{1,1}(13:end);

lb = [ParamsTest{2,1}];    
% A a B b G g C P r v0 e0 ss
ub = [ParamsTest{3,1}];

% vector form
paramsvec = [params.A params.a, params.B, params.b, params.G, params.g params.Cvec, params.P, params.r, params.v0, params.e0, params.ss];

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

elseif size(ParamsTest{1,1},2) == 25
params.tau = ParamsTest{1,1}(13);
params.D = ParamsTest{1,1}(14);
params.y0= ParamsTest{1,1}(15:end);

lb = [ParamsTest{2,1}];    
% A a B b G g C P r v0 e0 ss tau D
ub = [ParamsTest{3,1}];

% vector form
paramsvec = [params.A params.a, params.B, params.b, params.G, params.g params.Cvec, params.P, params.r, params.v0, params.e0, params.ss, params.tau, params.D];

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

