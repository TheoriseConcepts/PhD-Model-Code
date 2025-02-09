function outAnalysisPTZ(nn,SLURM_JOB_ID)

rng(SLURM_JOB_ID)

%Percentile best fit for each ga run
PTZNum = nn;
disp(PTZNum)

H = [];
Obj = [];
for i = 1:50
    
   try 
   state = importdata([num2str(i) '_out_300_Det' num2str(PTZNum) '.mat']);
   catch
       continue;
   end

GAParameters = state{1,5};
H = [H; GAParameters];

Objectives = state{1,6};
Obj = [Obj; Objectives];

end

% Clean up vectors to remove any extreme bad fits
A = 100;
rows_to_remove = all(Obj == A, 2);
Obj(rows_to_remove, :) = [];
H(rows_to_remove, :) = [];

ObjNum = size(Obj,2);

% Normalise Objectives
if ObjNum == 1    
    ObjNorm = normalize(Obj(:,1),'range');  
elseif ObjNum == 2   
    ObjNorm = [normalize(Obj(:,1),'range') normalize(Obj(:,2),'range')];   
else    
    ObjNorm = [normalize(Obj(:,1),'range') normalize(Obj(:,2),'range') normalize(Obj(:,3),'range')];    
end

% Pareto Front of all objectives normalised

indx = [];
X = [];
mm = [];

M = ObjNorm;

Mm = ((M-min(M))./(max(M)-min(M)))';

if ObjNum == 1 
distances = Mm';
else
distances = sqrt(sum(Mm.^2))';
end

indx = [distances, [1:size(H,1)]'];

X = prctile(indx(:,1),1);
numX = length(indx);
for mm = numX:-1:1
    if X < indx(mm,1)
        indx(mm,:)=[];
    end
end

BestFitParams = [];
BestFitParams = [BestFitParams;H(indx(:,2),:)];

BestFitObj = [];
BestFitObj = [BestFitObj;ObjNorm(indx(:,2),:)];


%%%%

cutoff = 0.01;
sample_rate = 20;
high_or_low = 'high';
order = 4;

ny=sample_rate/2;
cutoff=cutoff/ny;

[bb,aa] = butter(order, cutoff, high_or_low);

DataSignals = importdata('InterpenSignalsControlPTZ.mat');
t = 50*1.875 : 1.875 : 149*1.875; 
tt=t(1):(1/20):t(end);
PTZ = DataSignals.PTZ(PTZNum-8,50:149);
DataPTZ = interp1(t,PTZ,tt, 'spline');

DataPTZ = DataPTZ - mean(DataPTZ);
DataPTZ = zscore(DataPTZ);


[SimPTZAll,udAll] = ObjFitPTZ(BestFitParams,DataPTZ,bb,aa,ObjNum);


%%%%

save(['PTZ' num2str(PTZNum) 'FitParams.mat'],'BestFitParams', '-v7.3');
save(['SimPTZ' num2str(PTZNum) 'All.mat'],'SimPTZAll', '-v7.3');
save(['udPTZ' num2str(PTZNum) 'All.mat'],'udAll', '-v7.3');
