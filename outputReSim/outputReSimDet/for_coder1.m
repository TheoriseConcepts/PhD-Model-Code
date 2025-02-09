paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r'};
paramstoest=1:11;
npars_est = length(paramstoest);
setparsdefault;
paramsinput = [paramsvec, 10*randn(1,10)];
X3=SimulationRunDet(paramsinput);
