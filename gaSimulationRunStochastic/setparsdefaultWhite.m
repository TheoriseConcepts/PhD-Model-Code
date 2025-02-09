params.A = 3.25;
params.a = 100;
params.B = 22.0;
params.b = 50.0;
params.G = 20.0;
params.g = 500.0;
params.Cvec = 135.0;
params.P = 220.0;
params.r = 0.56;
params.v0 = 6.0;
params.e0 = 2.5;
params.ss = 1;
params.y0= 10*rand(1,11);

% bounds from Lauric's paper, padded with zeros for the initial conditions
lb = [0 60 0 1 0 200 0 0 0.1 0.1 0.1 0.1 (-500)*ones(1, 10)];    
% A a B b G g C P r v0 e0 ss 
ub = [100 800 100 199 100 800 5000 5000 0.8 9 7.5 30 ones(1, 10)*500];

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