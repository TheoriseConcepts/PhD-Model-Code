function [SimPTZAll, Sim2PTZAll, udAll, ud2All] = ObjFitPTZ(BestFitParams, DataPTZ, bb, aa, ObjNum)

%Begin Simulation

SimPTZAll = zeros(size(BestFitParams,1),3713);
Sim2PTZAll = zeros(size(BestFitParams,1),3713);
udAll = zeros(size(BestFitParams,1),185850);
ud2All = zeros(size(BestFitParams,1),185850);

for kk = 1:size(BestFitParams,1)
    disp(kk)
H1 = BestFitParams(kk,:);
  
H = H1(1,:);

% A function to simulate a network of neuron populations following the model of Wendling

% othersparameters1=bsxfun(@times,H(:,7),[0.8 0.25 0.25 0.3 0.1 0.8]);  % Connectivity parameters added to list
% othersparameters2=bsxfun(@times,H(:,22),[0.8 0.25 0.25 0.3 0.1 0.8]);  % Connectivity parameters added to list
%     H=[H(:,1:7) othersparameters1 H(:,8:22) othersparameters2 H(:,23:end)];

XemburnSaveAll = zeros(50,185850);
XemburnSaveAll2 = zeros(50,185850);
X3Rep = zeros(50,3713);
X4Rep = zeros(50,3713);
parfor RunIter = 1:50 % run 50 times for stability
    [XemburnSave,XemburnSave2,X3,X4] = SimulationRunOU(H,bb,aa)
    XemburnSaveAll(RunIter,:) = XemburnSave;
    X3Rep(RunIter,:) = X3;
    XemburnSaveAll2(RunIter,:) = XemburnSave2;
    X4Rep(RunIter,:) = X4;
end


% Initialize a flag variable to execute PSD
PSD_flag = true;
HVG_flag = false;
CC_flag = false;

% Check the value of ObjNum and update the flag variable accordingly
if ObjNum == 1
  % Do nothing, PSD is already flagged
elseif ObjNum == 2
  % Flag HVG in addition to PSD
  HVG_flag = true;
elseif ObjNum == 3
  % Flag HVG and CC in addition to PSD
  HVG_flag = true;
  CC_flag = true;
end

% Execute the flagged tasks
if PSD_flag
% PSD
fhz = 20;   %frequency 20hz
[Pxx2,Fxx2] = pwelch(DataPTZ,[],[],[],fhz);
idx_10Hz_ds=find(Fxx2>=0.5,1,'first');
Pxx2 = Pxx2(1:idx_10Hz_ds,1);
pxxDat = Pxx2/sum(Pxx2);  %normalise
end
if HVG_flag
% HVG
TDat=1:length(DataPTZ); % x axis
vgDat= fast_HVG(DataPTZ, TDat, 'w'); %wHVG
vg2Dat=full(vgDat); % convert to full matrix
obj1Dat=sum(vg2Dat);
end
if CC_flag
% Clustering Coefficient
vgDat2= fast_HVG(DataPTZ, TDat, 'u'); %HVG
vg2Dat2=full(vgDat2); % convert to full matrix
CCdat = clustering_coef_bu(vg2Dat2);
end


EDrep = [];
for jj = 1:50
% Initialize a flag variable to execute PSD
PSD_flag = true;

% Check the value of ObjNum and update the flag variable accordingly
if ObjNum == 1
  % Do nothing, PSD is already flagged
elseif ObjNum == 2
  % Flag HVG in addition to PSD
  HVG_flag = true;
elseif ObjNum == 3
  % Flag HVG and CC in addition to PSD
  HVG_flag = true;
  CC_flag = true;
end

% Execute the flagged tasks
if PSD_flag
% PSD
fhz = 20;   %frequency 20hz
[PxxSim,FxxSim] = pwelch(X3Rep(jj,:),[],[],[],fhz);
idx_10Hz_ds=find(FxxSim>=0.5,1,'first');
PxxSim = PxxSim(1:idx_10Hz_ds,1); 
pxxSim = PxxSim/sum(PxxSim);  %normalise
PSDobj = sum(((pxxDat-pxxSim).^2));
if ObjNum == 1
ObjRerun = PSDobj;
ObjRerunNorm = normalize(ObjRerun(:,1),'range'); 
else
end
end
if HVG_flag
% HVG
TSim=1:length(X3Rep(jj,:)); % x axis
vgSim= fast_HVG(X3Rep(jj,:), TSim, 'w'); %wHVG
vg2Sim=full(vgSim); % convert to full matrix
obj1Sim=sum(vg2Sim);
[~, ~, HVGobj] = kstest2(obj1Dat,obj1Sim);
if ObjNum == 2
ObjRerun = [PSDobj, HVGobj];
ObjRerunNorm = [normalize(ObjRerun(:,1),'range') normalize(ObjRerun(:,2),'range')];
else
end
end
if CC_flag
% Clustering Coefficient
vgSim2= fast_HVG(X3Rep(jj,:), TSim, 'u'); %HVG
vg2Sim2=full(vgSim2); % convert to full matrix
CCsim = clustering_coef_bu(vg2Sim2);
[~, ~, CCobj] = kstest2(CCdat,CCsim);
if ObjNum == 3
ObjRerun = [PSDobj, HVGobj, CCobj];
ObjRerunNorm = [normalize(ObjRerun(:,1),'range') normalize(ObjRerun(:,2),'range') normalize(ObjRerun(:,3),'range')];
else
end
end

% Find minimum

ED = sqrt(sum(ObjRerunNorm.^2))';
EDrep = [EDrep;ED];

end

% Minimim ED sim

[~,Indx] = min(EDrep);

% Indx out

SimPTZ = X3Rep(Indx,:);
SimPTZAll(kk,:) = SimPTZ;

ud = XemburnSaveAll(Indx,:);
udAll(kk,:) = ud;

Sim2PTZ = X4Rep(Indx,:);
Sim2PTZAll(kk,:) = Sim2PTZ;

ud2 = XemburnSaveAll2(Indx,:);
ud2All(kk,:) = ud2;

end
