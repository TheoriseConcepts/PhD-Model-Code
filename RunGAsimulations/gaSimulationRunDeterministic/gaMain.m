function gaMain(nn,SLURM_JOB_ID)

%% SimulationOptions

% Objectives = {'PSD'};
Objectives = {'PSD','HVG'};
% Objectives = {'PSD','HVG','CCb'};
if any(nn==1:400)
SimOptions = {'Control','Det','Extended',Objectives}; % nn = 1:400
elseif any(nn==401:800)
SimOptions = {'PTZ','Det','Extended',Objectives}; % nn = 401:800
end

%% load in data and fit - prepare dat
[data,T,indx,h] = DataSetup(SimOptions{1},nn);

Data_z = zscore(data);

rng(SLURM_JOB_ID)

% Setup Bandpass Filter
cutoff = 0.01;
sample_rate = 20;
high_or_low = 'high';
order = 4;
ny=sample_rate/2;
cutoff=cutoff/ny;
[bb,aa] = butter(order, cutoff, high_or_low);

%%
[ParamsTest,paramnames]= ParamsSetup(SimOptions{3});

paramstoest=1:size(paramnames,2);
npars_est = length(paramstoest);

[paramsvec,paramDefCell,lb,ub] = setparsdefault(ParamsTest,paramstoest,npars_est);


ff = @(x) ObjFit(x, paramsvec, Data_z, paramstoest, T, bb, aa, SimOptions{4});
resetparsdefault;

%%

p1 = create_lhc_theo(ParamsTest,paramstoest,npars_est);
pop=p1;
scores1 = [];
% reevaluate the scores based on the new fitness function: 
for i=1:size(pop,1)
    scores1(i, :) = ff(pop(i,:));
end
%% set ga options    

if size(Objectives,2) == 1
    
options1 = optimoptions('ga','UseParallel', true, ...
    'PopulationSize', size(pop,1));
options2 = options1;
%options2.MaxTime = 60*60*24;% set max time to 24 hours - using a wallclock of 24hrs on isca
%options2.Display = 'none'; 
options2.InitialPopulationMatrix=pop;
options2.InitialScoresMatrix=scores1;
options2.MaxStallGenerations=300;
options2.MaxGenerations=300;
options2.Display = 'iter';
options2.CrossoverFcn={'crossoverscattered'};
%options2.OutputFcn  = str2func(['outputFun_te_' num2str(nn)]);  

[x,fval,exitflag,output,population,scores] = ga(ff, npars_est, [],[],[],[], lb(paramstoest),ub(paramstoest),[], options2);

elseif size(Objectives,2) > 1
    
options1 = optimoptions('gamultiobj','UseParallel', true, ...
    'PopulationSize', size(pop,1));
options2 = options1;
%options2.MaxTime = 60*60*24;% set max time to 24 hours - using a wallclock of 24hrs on isca
%options2.Display = 'none'; 
options2.InitialPopulationMatrix=pop;
options2.InitialScoresMatrix=scores1;
options2.MaxStallGenerations=300;
options2.MaxGenerations=300;
options2.Display = 'iter';
options2.CrossoverFcn={'crossoverscattered'};
%options2.OutputFcn  = str2func(['outputFun_te_' num2str(nn)]);  
    
[x,fval,exitflag,output,population,scores] = gamultiobj(ff, npars_est, [],[],[],[], lb(paramstoest),ub(paramstoest),[], options2);
 
end
out = {x,fval,exitflag,output,population,scores};
% save(['Data_' num2str(nn) '_gaOutput_' num2str(h) '.mat'],'out');
save([num2str(indx) '_out_300_' SimOptions{2} num2str(h) '.mat'],'out');
