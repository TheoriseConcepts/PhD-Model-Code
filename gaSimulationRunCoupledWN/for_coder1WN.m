paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r', 'ss', 'K'};
paramstoest=1:26;
npars_est = length(paramstoest);
setparsdefaultWhite;
T = 315.85;
paramsinput = [paramsvec, 10*randn(1,20)];
y=gamultiobjWendlingWhite(T,paramsinput);
