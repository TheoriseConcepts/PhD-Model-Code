%% Timeseries Options

SimOptions = {'Control','Deterministic','Single'};
% SimOptions = {'PTZ','Deterministic','Single'};
% SimOptions = {'Control','OU','Single'};
% SimOptions = {'PTZ','OU','Single'};
% SimOptions = {'Control','WN','Single'};
% SimOptions = {'PTZ','WN','Single'};
% SimOptions = {'Control','OU','Coupled'};
% SimOptions = {'PTZ','OU','Coupled'};
% SimOptions = {'Control','WN','Coupled'};
% SimOptions = {'PTZ','WN','Coupled'};

% Data Setup
DataSignals = importdata('InterpenSignalsControlPTZ.mat');
t = 50*1.875 : 1.875 : 149*1.875; 
tt=t(1):(1/20):t(end);

%% Control Single
if strcmp('Control',SimOptions{1}) && strcmp('Single',SimOptions{3})
    
n = 8; % Number of timeseries to be plotted
    
Value = 0;
    
figure;
for i = 1:8 % Timeseries to plot
Value = Value + 1;
    
Control = DataSignals.ControlPTZ(i,50:149);
DataControl = interp1(t,Control,tt, 'spline');
DataControl = DataControl - mean(DataControl);
DataControl = zscore(DataControl);
  
    SimControlAll = importdata(['SimControl' num2str(i) 'All.mat']);
    udControlAll = importdata(['udControl' num2str(i) 'All.mat']);
    
    idxControl = importdata('BestFitIndexControl.mat');
    
    SimPlot = SimControlAll(idxControl(Value),:);
    udPlot = udControlAll(idxControl(Value),:);
    
subplot(n,3,3*Value-2)
plot(DataControl,'r')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
%ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value-1)
plot(SimPlot,'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
%ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value)
plot(zscore(udPlot),'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 185850])
%ylabel('Membrane Potential (A.U.)')

subplot(n,3,1)
title('Control Data')
subplot(n,3,2)
title('Best Fit Sim Control')
subplot(n,3,3)
title('Underlying Dynamics Control')
subplot(n,3,n+2)
ylabel('Fluorescence Intensity (A.U.)')
subplot(n,3,n+3)
ylabel('Fluorescence Intensity (A.U.)')
subplot(n,3,n+4)
ylabel('Membrane Potential (A.U)')
subplot(n,3,3*n-2)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n-1)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/1000)
xlabel('Time (s)')
end
sgtitle([SimOptions{2} ' ' SimOptions{3} ' Simulation Plots'])
    
%% PTZ Single
elseif strcmp('PTZ',SimOptions{1}) && strcmp('Single',SimOptions{3})

    n = 8; % Number of timeseries to be plotted
    
Value = 0;
    
figure;
for i = 1:8 % Timeseries to plot
Value = Value + 1;
    
PTZ = DataSignals.PTZ(i,50:149);
DataPTZ = interp1(t,PTZ,tt, 'spline');
DataPTZ = DataPTZ - mean(DataPTZ);
DataPTZ = zscore(DataPTZ);
  
    SimPTZAll = importdata(['SimPTZ' num2str(i+8) 'All.mat']);
    udPTZAll = importdata(['udPTZ' num2str(i+8) 'All.mat']);
    
    idxPTZ = importdata('BestFitIndexPTZ.mat');
    
    SimPlot = SimPTZAll(idxPTZ(Value),:);
    udPlot = udPTZAll(idxPTZ(Value),:);
    
subplot(n,3,3*Value-2)
plot(DataPTZ,'r')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
%ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value-1)
plot(SimPlot,'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
%ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value)
plot(zscore(udPlot),'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 185850])
%ylabel('Membrane Potential (A.U.)')

subplot(n,3,1)
title('PTZ Data')
subplot(n,3,2)
title('Best Fit Sim PTZ')
subplot(n,3,3)
title('Underlying Dynamics PTZ')
subplot(n,3,n+2)
ylabel('Fluorescence Intensity (A.U.)')
subplot(n,3,n+3)
ylabel('Fluorescence Intensity (A.U.)')
subplot(n,3,n+4)
ylabel('Membrane Potential (A.U)')
subplot(n,3,3*n-2)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n-1)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/1000)
xlabel('Time (s)')
end
sgtitle([SimOptions{2} ' ' SimOptions{3} ' Simulation Plots'])

%% Control Coupled
elseif strcmp('Control',SimOptions{1}) && strcmp('Coupled',SimOptions{3})
    
n = 8; % Number of timeseries to be plotted
    
Value = 0;
    
for i = 1:8 % Timeseries to plot
Value = Value + 1;
    
Control = DataSignals.ControlPTZ(i,50:149);
DataControl = interp1(t,Control,tt, 'spline');
DataControl = DataControl - mean(DataControl);
DataControl = zscore(DataControl);
  
    SimControlAll = importdata(['SimControl' num2str(i) 'All.mat']);
    udControlAll = importdata(['udControl' num2str(i) 'All.mat']);
    Sim2ControlAll = importdata(['Sim2Control' num2str(i) 'All.mat']);
    ud2ControlAll = importdata(['ud2Control' num2str(i) 'All.mat']);
    
    idxControl = importdata('BestFitIndexControl.mat');
    
    SimPlot = SimControlAll(idxControl(Value),:);
    udPlot = udControlAll(idxControl(Value),:);
    Sim2Plot = Sim2ControlAll(idxControl(Value),:);
    ud2Plot = ud2ControlAll(idxControl(Value),:);
    
figure(1)    
subplot(n,3,3*Value-2)
plot(DataControl,'r')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value-1)
plot(SimPlot,'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value)
plot(udPlot,'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 185850])
ylabel('Membrane Potential (A.U.)')

subplot(n,3,1)
title('Control Data')
subplot(n,3,2)
title('Best Fit Sim Control')
subplot(n,3,3)
title('Underlying Dynamics Control')
% subplot(n,3,n)
% ylabel('Fluorescence Intensity (A.U.)')
% subplot(n,3,n+2)
% ylabel('Membrane Potential (mV)')
subplot(n,3,3*n-2)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n-1)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/1000)
xlabel('Time (s)')
sgtitle([SimOptions{2} ' ' SimOptions{3} ' Simulation Plots'])

figure(2)    
subplot(n,3,3*Value-2)
plot(DataControl,'r')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value-1)
plot(Sim2Plot,'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value)
plot(ud2Plot,'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 185850])
ylabel('Membrane Potential (A.U.)')

subplot(n,3,1)
title('Control Data')
subplot(n,3,2)
title('Sim 2')
subplot(n,3,3)
title('Underlying Dynamics 2 Control')
% subplot(n,3,n)
% ylabel('Fluorescence Intensity (A.U.)')
% subplot(n,3,n+2)
% ylabel('Membrane Potential (mV)')
subplot(n,3,3*n-2)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n-1)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/1000)
xlabel('Time (s)')
sgtitle([SimOptions{2} ' ' SimOptions{3} ' Simulation 2 Plots'])
end

    
%% PTZ Coupled
elseif strcmp('PTZ',SimOptions{1}) && strcmp('Coupled',SimOptions{3}) 
    
n = 8; % Number of timeseries to be plotted
    
Value = 0;
    
for i = 1:8 % Timeseries to plot
Value = Value + 1;
    
PTZ = DataSignals.PTZ(i,50:149);
DataPTZ = interp1(t,PTZ,tt, 'spline');
DataPTZ = DataPTZ - mean(DataPTZ);
DataPTZ = zscore(DataPTZ);
  
    SimPTZAll = importdata(['SimPTZ' num2str(i+8) 'All.mat']);
    udPTZAll = importdata(['udPTZ' num2str(i+8) 'All.mat']);
    Sim2PTZAll = importdata(['Sim2PTZ' num2str(i+8) 'All.mat']);
    ud2PTZAll = importdata(['ud2PTZ' num2str(i+8) 'All.mat']);
    
    idxPTZ = importdata('BestFitIndexPTZ.mat');
    
    SimPlot = SimPTZAll(idxPTZ(Value),:);
    udPlot = udPTZAll(idxPTZ(Value),:);
    Sim2Plot = Sim2PTZAll(idxPTZ(Value),:);
    ud2Plot = ud2PTZAll(idxPTZ(Value),:);
    
figure(1)    
subplot(n,3,3*Value-2)
plot(DataPTZ,'r')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value-1)
plot(SimPlot,'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value)
plot(udPlot,'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 185850])
ylabel('Membrane Potential (A.U.)')

subplot(n,3,1)
title('PTZ Data')
subplot(n,3,2)
title('Best Fit Sim PTZ')
subplot(n,3,3)
title('Underlying Dynamics PTZ')
% subplot(n,3,n)
% ylabel('Fluorescence Intensity (A.U.)')
% subplot(n,3,n+2)
% ylabel('Membrane Potential (mV)')
subplot(n,3,3*n-2)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n-1)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/1000)
xlabel('Time (s)')
sgtitle([SimOptions{2} ' ' SimOptions{3} ' Simulation Plots'])

figure(2)    
subplot(n,3,3*Value-2)
plot(DataPTZ,'r')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value-1)
plot(Sim2Plot,'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 3713])
ylabel('Fluorescence Intensity (A.U.)')

subplot(n,3,3*Value)
plot(ud2Plot,'b')
xt = get(gca,'xtick');    
set(gca,'Xticklabel',[])
xlim([0 185850])
ylabel('Membrane Potential (A.U.)')

subplot(n,3,1)
title('PTZ Data')
subplot(n,3,2)
title('Sim 2')
subplot(n,3,3)
title('Underlying Dynamics 2 PTZ')
% subplot(n,3,n)
% ylabel('Fluorescence Intensity (A.U.)')
% subplot(n,3,n+2)
% ylabel('Membrane Potential (mV)')
subplot(n,3,3*n-2)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n-1)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/20)
xlabel('Time (s)')
subplot(n,3,3*n)
xt = get(gca,'xtick');    
set(gca,'XTick',xt, 'xticklabel',xt/1000)
xlabel('Time (s)')
sgtitle([SimOptions{2} ' ' SimOptions{3} ' Simulation 2 Plots'])
end    

end