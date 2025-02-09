% Load Objective Scores

Det1Control = importdata('Det1objObjectiveScoresControlExtended.mat');
Det1PTZ = importdata('Det1objObjectiveScoresPTZExtended.mat');
Det2Control = importdata('Det2objObjectiveScoresControlExtended.mat');
Det2PTZ = importdata('Det2objObjectiveScoresPTZExtended.mat');
Det3Control = importdata('Det3objObjectiveScoresControlExtended.mat');
Det3PTZ = importdata('Det3objObjectiveScoresPTZExtended.mat');
OU2Control = importdata('OU2objObjectiveScoresControlExtended.mat');
OU2PTZ = importdata('OU2objObjectiveScoresPTZExtended.mat');
OU3Control = importdata('OU3objObjectiveScoresControlExtended.mat');
OU3PTZ = importdata('OU3objObjectiveScoresPTZExtended.mat');
WN1Control = importdata('WN1objObjectiveScoresControlExtended.mat');
WN1PTZ = importdata('WN1objObjectiveScoresPTZExtended.mat');
WN2Control = importdata('WN2objObjectiveScoresControlExtended.mat');
WN2PTZ = importdata('WN2objObjectiveScoresPTZExtended.mat');
WN3Control = importdata('WN3objObjectiveScoresControlExtended.mat');
WN3PTZ = importdata('WN3objObjectiveScoresPTZExtended.mat');


Det1Control = RefinePercentileAll(Det1Control,1,80,8);
Det1PTZ = RefinePercentileAll(Det1PTZ,1,80,8);
Det2Control = RefinePercentileAll(Det2Control,2,80,8);
Det2PTZ = RefinePercentileAll(Det2PTZ,2,80,8);
Det3Control = RefinePercentileAll(Det3Control,3,80,8);
Det3PTZ = RefinePercentileAll(Det3PTZ,3,80,8);
OU2Control = RefinePercentileAll(OU2Control,2,80,8);
OU2PTZ = RefinePercentileAll(OU2PTZ,2,80,8);
OU3Control = RefinePercentileAll(OU3Control,3,80,8);
OU3PTZ = RefinePercentileAll(OU3PTZ,3,80,8);
WN1Control = RefinePercentileAll(WN1Control,1,80,8);
WN1PTZ = RefinePercentileAll(WN1PTZ,1,80,8);
WN2Control = RefinePercentileAll(WN2Control,2,80,8);
WN2PTZ = RefinePercentileAll(WN2PTZ,2,80,8);
WN3Control = RefinePercentileAll(WN3Control,3,80,8);
WN3PTZ = RefinePercentileAll(WN3PTZ,3,80,8);

ObjectiveData = [Det1Control(:); Det1PTZ(:); Det2Control(:); Det2PTZ(:); Det3Control(:); Det3PTZ(:); ...
                 OU2Control(:); OU2PTZ(:); OU3Control(:); OU3PTZ(:); ...
                 WN1Control(:); WN1PTZ(:); WN2Control(:); WN2PTZ(:); WN3Control(:); WN3PTZ(:)];
ObjectiveDataTwo = [Det1Control; Det1PTZ; Det2Control; Det2PTZ; Det3Control; Det3PTZ; ...
                 OU2Control; OU2PTZ; OU3Control; OU3PTZ; ...
                 WN1Control; WN1PTZ; WN2Control; WN2PTZ; WN3Control; WN3PTZ];
ObjectiveDataDouble = vertcat(ObjectiveData{:});
ObjectivesAllNorm = [normalize(ObjectiveDataDouble(:,1),'range') normalize(ObjectiveDataDouble(:,2),'range') normalize(ObjectiveDataDouble(:,3),'range')];  

newstartIndex = [];
newendIndex = [];
newstartIndex{1,1} = 1;
for j = 1:16
    for k = 1:8  
    [rows, ~] = size(ObjectiveDataTwo{j,k});
    newendIndex{j,k} = newstartIndex{j,k} + rows - 1;
    newstartIndex{j,k+1} = newendIndex{j,k} + 1;
    if k == 8
    newstartIndex{j+1,k-7} = newendIndex{j,k} + 1;
    end
    
    end
end

for n = 1:16
    for m = 1:8
ObjectivesDataTwoNorm{n,m} = ObjectivesAllNorm(newstartIndex{n,m}:newendIndex{n,m},:);
    end
end


%%

dataControlAll = [];
dataPTZAll = [];
for DatNum = 1:8
dataControl = {ObjectivesDataTwoNorm{1,DatNum}, ObjectivesDataTwoNorm{3,DatNum}, ObjectivesDataTwoNorm{5,DatNum}, ...
    ObjectivesDataTwoNorm{7,DatNum}, ObjectivesDataTwoNorm{9,DatNum}, ObjectivesDataTwoNorm{11,DatNum}, ...
    ObjectivesDataTwoNorm{13,DatNum}, ObjectivesDataTwoNorm{15,DatNum}};
dataControlAll = [dataControlAll;dataControl];
dataPTZ = {ObjectivesDataTwoNorm{2,DatNum}, ObjectivesDataTwoNorm{4,DatNum}, ObjectivesDataTwoNorm{6,DatNum}, ...
    ObjectivesDataTwoNorm{8,DatNum}, ObjectivesDataTwoNorm{10,DatNum}, ObjectivesDataTwoNorm{12,DatNum}, ...
    ObjectivesDataTwoNorm{14,DatNum}, ObjectivesDataTwoNorm{16,DatNum}};
dataPTZAll = [dataPTZAll;dataPTZ];
end

dataControlS = {'Det1Control', 'Det2Control', 'Det3Control', 'OU2Control', 'OU3Control', 'WN1Control', 'WN2Control', 'WN3Control'};
dataPTZS = {'Det1PTZ', 'Det2PTZ', 'Det3PTZ', 'OU2PTZ', 'OU3PTZ', 'WN1PTZ', 'WN2PTZ', 'WN3PTZ'};

Control = {'Control1','Control2','Control3','Control4','Control5','Control6','Control7','Control8'};
PTZ = {'PTZ1','PTZ2','PTZ3','PTZ4','PTZ5','PTZ6','PTZ7','PTZ8'};

HypervolumeControl = NaN(8,8);

for j = 1:8
for i = 1:size(dataControlAll,2)

m_hyper = m_hyper_value(dataControlAll{j,i});
HypervolumeControl(j,i) = HypervolumeCH4(dataControlAll{j,i},m_hyper);

end
end

figure;
subplot(1,2,1)
heatmap(dataControlS,Control,normr(HypervolumeControl))
colormap(brewermap([],'RdBu'))
title('Hypervolume Indicator Control')

HypervolumePTZ = NaN(8,8);

for j = 1:8
for i = 1:size(dataPTZAll,2)

m_hyper = m_hyper_value(dataPTZAll{j,i});
HypervolumePTZ(j,i) = HypervolumeCH3(dataPTZAll{j,i},m_hyper);

end
end

subplot(1,2,2)
heatmap(dataPTZS,PTZ,normr(HypervolumePTZ))
colormap(brewermap([],'RdBu'))
title('Hypervolume Indicator PTZ')


%% Boxplot of Hypervolume Indicator

figure;
subplot(1,2,1)
boxplot(1-HypervolumeControl,'labels',dataControlS,'Notch','on')
title('Hypervolume Indicator Control')
ylim([0.14,0.6])
xtickangle(45)

subplot(1,2,2)
boxplot(1-HypervolumePTZ,'labels',dataPTZS,'Notch','on')
title('Hypervolume Indicator PTZ')
ylim([0.14,0.6])
xtickangle(45)