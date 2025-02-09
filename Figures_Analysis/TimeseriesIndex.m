%% Analysis Options

% Objectives = {'PSD'};
% Objectives = {'PSD','HVG'};
Objectives = {'PSD','HVG','CCb'};
SimOptions = {'Control',Objectives};
% SimOptions = {'PTZ',Objectives};

%% Control
if strcmp('Control',SimOptions{1})
    
SimControlAll = cell(1, 8);

for i = 1:8  
   try 
        SimControlAll{i} = importdata(['SimControl' num2str(i) 'All.mat']);
   catch
       continue; % do nothing and continue with the loop
   end
end

Index = [];
Value = 0;
for ii = 1:8
    disp(ii)
Value = Value + 1;
    
% Setup data
DataSignals = importdata('InterpenSignalsControlPTZ.mat');
t = 50*1.875 : 1.875 : 149*1.875; 
tt=t(1):(1/20):t(end);
Control = DataSignals.ControlPTZ(ii,50:149);
DataControl = interp1(t,Control,tt, 'spline');

DataControl = DataControl - mean(DataControl);
DataControl = zscore(DataControl);

% Calculate Objectives Data
objectivesDatOut = ObjectivesSetup(DataControl,Objectives);
num_empty = (isempty(objectivesDatOut{1}) + isempty(objectivesDatOut{2}) + isempty(objectivesDatOut{3}));

% Calculate Objective Simulation
fitvecAll = [];
ED = [];
for j = 1:size(SimControlAll{ii},1)
    
    objectivesSimOut = ObjectivesSetup(SimControlAll{ii}(j,:),Objectives);
    
    [distances,fitvec] = ObjectiveFitvec(objectivesDatOut,objectivesSimOut,num_empty);
    
    fitvecAll = [fitvecAll;fitvec];
    % ED = [ED;distances];
    
end

fitvecnorm = normc(fitvecAll);
distancesnew = sqrt(sum(fitvecnorm.^2, 2))';
[M,I] = min(distancesnew);
Index = [Index;I];

%[M,I] = min(ED);
%Index = [Index;I];  % Need to save Index. Find best fitting parameters, sim, and ud

figure; 
subplot(2,1,1)
plot(SimControlAll{ii}(Index(Value),:))
title('Best Fit Control')
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
ylabel('Fluorescence Intensity (A.U.)')
subplot(2,1,2)
plot(DataControl)
title('Data Control')
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
ylabel('Fluorescence Intensity (A.U.)')

end


%% PTZ
elseif strcmp('PTZ',SimOptions{1})
    
    SimPTZAll = cell(1, 8);

for i = 1:8  
   try 
        SimPTZAll{i} = importdata(['SimPTZ' num2str(i+8) 'All.mat']);
   catch
       continue; % do nothing and continue with the loop
   end
end

Index = [];
Value = 0;
for ii = 1:8
    disp(ii)
Value = Value + 1;

% Setup data
DataSignals = importdata('InterpenSignalsControlPTZ.mat');
t = 50*1.875 : 1.875 : 149*1.875; 
tt=t(1):(1/20):t(end);
PTZ = DataSignals.PTZ(ii,50:149);
DataPTZ = interp1(t,PTZ,tt, 'spline');

DataPTZ = DataPTZ - mean(DataPTZ);
DataPTZ = zscore(DataPTZ);

% Calculate Objectives Data
objectivesDatOut = ObjectivesSetup(DataPTZ,Objectives);
num_empty = (isempty(objectivesDatOut{1}) + isempty(objectivesDatOut{2}) + isempty(objectivesDatOut{3}));

% Calculate Objective Simulation
fitvecAll = [];
ED = [];
for j = 1:size(SimPTZAll{ii},1)
    
    objectivesSimOut = ObjectivesSetup(SimPTZAll{ii}(j,:),Objectives);
    
    [distances,fitvec] = ObjectiveFitvec(objectivesDatOut,objectivesSimOut,num_empty);
    
    fitvecAll = [fitvecAll;fitvec];
    % ED = [ED;distances];
    
end

fitvecnorm = normc(fitvecAll);
distancesnew = sqrt(sum(fitvecnorm.^2, 2))';
[M,I] = min(distancesnew);
Index = [Index;I];

%[M,I] = min(ED);
%Index = [Index;I];  % Need to save Index. Find best fitting parameters, sim, and ud

figure; 
subplot(2,1,1)
plot(SimPTZAll{ii}(Index(Value),:))
title('Best Fit PTZ')
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
ylabel('Fluorescence Intensity (A.U.)')
subplot(2,1,2)
plot(DataPTZ)
title('Data PTZ')
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
ylabel('Fluorescence Intensity (A.U.)')

end
    
end