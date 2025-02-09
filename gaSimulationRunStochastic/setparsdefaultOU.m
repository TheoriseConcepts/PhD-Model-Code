params.A = 5;
params.a = 100;
params.B = 22.0;
params.b = 50.0;
params.G = 20.0;
params.g = 500.0;
params.Cvec=135.0;
params.P = 90.0;
params.r = 0.56;
params.v0 = 6.0;
params.e0 = 2.5;
params.ss = 1;
params.tau = 10^(-0.5);
params.D = 100;
params.y0= 10*rand(1,11);

% bounds from Lauric's paper, padded with zeros for the initial conditions
lb = [0 25 0 6.5 0 350 0 0 0.3 2 0.5 0.1 0 0 (-500)*ones(1, 11)];
% A a B b G g C P r v0 e0 ss tau D
ub = [10 140 50 110 50 650 1350 2000 0.8 9 7.5 30 0.4 150 ones(1, 11)*500];

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