paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r', 'ss'};
paramstoest=1:12;
npars_est = length(paramstoest);
setparsdefault;
T = 315.85;
paramsinput = [paramsvec, 10*randn(1,10)];
y=gamultiobjWendlingWhite(T,paramsinput);
