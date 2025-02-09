paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r', 'ss', 'K', 'tau', 'D'};
paramstoest=1:30;
npars_est = length(paramstoest);
setparsdefaultOU;
T = 315.85;
paramsinput = [paramsvec, 10*randn(1,22)];
y=gamultiobjWendlingOU(T,paramsinput);
