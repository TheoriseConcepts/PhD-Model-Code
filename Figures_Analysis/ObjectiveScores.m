%% Objective Options

Objectives = {'PSD','HVG','CCb'};
ObjNum = 3;


% Data Setup
DataSignals = importdata('InterpenSignalsControlPTZ.mat');
t = 50*1.875 : 1.875 : 149*1.875; 
tt=t(1):(1/20):t(end);


%% Control

objectivesScoreAll = cell(1, 8);
for i = 1:8

% Data
Control = DataSignals.ControlPTZ(i,50:149);
DataControl = interp1(t,Control,tt, 'spline');
DataControl = DataControl - mean(DataControl);
DataControl = zscore(DataControl);
    
objectivesDatOut = ObjectivesSetup(DataControl,Objectives);


% Sim
SimSignals = importdata(['SimControl' num2str(i) 'All.mat']);

PSDobj = nan(size(SimSignals,1),1);
HVGobj = nan(size(SimSignals,1),1);
CCobj = nan(size(SimSignals,1),1);

for j = 1:size(SimSignals,1)
    fprintf('%d %d\n', i, j);

    objectivesSimOut = ObjectivesSetup(SimSignals(j,:),Objectives); 
    
    PSDobj(j) = sum(((objectivesDatOut{1}-objectivesSimOut{1}).^2));

    [~, ~, HVGobj(j)] = kstest2(objectivesDatOut{2},objectivesSimOut{2});

    [~, ~, CCobj(j)] = kstest2(objectivesDatOut{3},objectivesSimOut{3});
    
     
end

objectivesScoreAll{i} = [PSDobj,HVGobj,CCobj];

end


%% PTZ

objectivesScoreAll = cell(1, 8);
for i = 1:8

% Data
PTZ = DataSignals.PTZ(i,50:149);
DataPTZ = interp1(t,PTZ,tt, 'spline');
DataPTZ = DataPTZ - mean(DataPTZ);
DataPTZ = zscore(DataPTZ);
    
objectivesDatOut = ObjectivesSetup(DataPTZ,Objectives);


% Sim
SimSignals = importdata(['SimPTZ' num2str(i+8) 'All.mat']);

PSDobj = nan(size(SimSignals,1),1);
HVGobj = nan(size(SimSignals,1),1);
CCobj = nan(size(SimSignals,1),1);

for j = 1:size(SimSignals,1)
    fprintf('%d %d\n', i, j);

    objectivesSimOut = ObjectivesSetup(SimSignals(j,:),Objectives); 
    
    PSDobj(j) = sum(((objectivesDatOut{1}-objectivesSimOut{1}).^2));

    [~, ~, HVGobj(j)] = kstest2(objectivesDatOut{2},objectivesSimOut{2});

    [~, ~, CCobj(j)] = kstest2(objectivesDatOut{3},objectivesSimOut{3});
    
     
end

objectivesScoreAll{i} = [PSDobj,HVGobj,CCobj];

end


