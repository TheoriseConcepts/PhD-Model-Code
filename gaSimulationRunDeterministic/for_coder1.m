paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r'};
paramstoest=1:11;
npars_est = length(paramstoest);
setparsdefault;
T = 315.85;
paramsinput = [paramsvec, 10*randn(1,10)];
y=gamultiobjWendling(T,paramsinput);
