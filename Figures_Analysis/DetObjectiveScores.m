NumTS = 8;

Det1Control = importdata('Det1objObjectiveScoresControlExtended.mat');
Det1PTZ = importdata('Det1objObjectiveScoresPTZExtended.mat');
Det2Control = importdata('Det2objObjectiveScoresControlExtended.mat');
Det2PTZ = importdata('Det2objObjectiveScoresPTZExtended.mat');
Det3Control = importdata('Det3objObjectiveScoresControlExtended.mat');
Det3PTZ = importdata('Det3objObjectiveScoresPTZExtended.mat');

DetIndex = importdata('DetBestFitInd.mat');

for i = 1:8
Det1ControlBest{i} = Det1Control{i}(DetIndex{1,1}(i),:);
Det1PTZBest{i} = Det1PTZ{i}(DetIndex{2,1}(i),:);
Det2ControlBest{i} = Det2Control{i}(DetIndex{3,1}(i),:);
Det2PTZBest{i} = Det2PTZ{i}(DetIndex{4,1}(i),:);
Det3ControlBest{i} = Det3Control{i}(DetIndex{5,1}(i),:);
Det3PTZBest{i} = Det3PTZ{i}(DetIndex{6,1}(i),:);
end

Det1Control = RefinePercentileAll(Det1Control(1:NumTS),1,80,NumTS);
Det1PTZ = RefinePercentileAll(Det1PTZ(1:NumTS),1,80,NumTS);
Det2Control = RefinePercentileAll(Det2Control(1:NumTS),2,80,NumTS);
Det2PTZ = RefinePercentileAll(Det2PTZ(1:NumTS),2,80,NumTS);
Det3Control = RefinePercentileAll(Det3Control(1:NumTS),3,80,NumTS);
Det3PTZ = RefinePercentileAll(Det3PTZ(1:NumTS),3,80,NumTS);

% Find index of ReducedBestObj1/ReducedBestObj2 using best fit for normalised objective scores
rI1 = nan(1,8); rI2 = nan(1,8); rI3 = nan(1,8); rI4 = nan(1,8);
rI5 = nan(1,8); rI6 = nan(1,8); 
for r = 1:8
[~, rI1(r)] = ismember(Det1ControlBest{r}, Det1Control{r}, 'rows');
[~, rI2(r)] = ismember(Det1PTZBest{r}, Det1PTZ{r}, 'rows');
[~, rI3(r)] = ismember(Det2ControlBest{r}, Det2Control{r}, 'rows');
[~, rI4(r)] = ismember(Det2PTZBest{r}, Det2PTZ{r}, 'rows');
[~, rI5(r)] = ismember(Det3ControlBest{r}, Det3Control{r}, 'rows');
[~, rI6(r)] = ismember(Det3PTZBest{r}, Det3PTZ{r}, 'rows');
end

DetIndexReduced = {rI1, 'Det1Control'; rI2, 'Det1PTZ'; rI3, 'Det2Control'; rI4, 'Det2PTZ'; rI5, 'Det3Control'; rI6, 'Det3PTZ'};

ObjectiveData = [Det1Control(:); Det1PTZ(:); Det2Control(:); Det2PTZ(:); Det3Control(:); Det3PTZ(:)];

ObjectiveDataTwo = [Det1Control; Det1PTZ; Det2Control; Det2PTZ; Det3Control; Det3PTZ];

ObjectiveDataDouble = vertcat(ObjectiveData{:});
ObjectivesAllNorm = [normalize(ObjectiveDataDouble(:,1),'range') normalize(ObjectiveDataDouble(:,2),'range') normalize(ObjectiveDataDouble(:,3),'range')];  

newstartIndex = [];
newendIndex = [];
newstartIndex{1,1} = 1;
for j = 1:size(ObjectiveData,1)/NumTS
    for k = 1:NumTS  
    [rows, ~] = size(ObjectiveDataTwo{j,k});
    newendIndex{j,k} = newstartIndex{j,k} + rows - 1;
    newstartIndex{j,k+1} = newendIndex{j,k} + 1;
    if k == NumTS
    newstartIndex{j+1,k-(NumTS-1)} = newendIndex{j,k} + 1;
    end
    
    end
end

for n = 1:size(ObjectiveData,1)/NumTS
    for m = 1:NumTS
ObjectivesDataTwoNorm{n,m} = ObjectivesAllNorm(newstartIndex{n,m}:newendIndex{n,m},:);
    end
end


% DetIndex = {D1, 'Det1Control'; D12, 'Det1PTZ'; D2, 'Det2Control'; D22, 'Det2PTZ'; D3, 'Det3Control'; D32, 'Det3PTZ'};
% DetIndex = importdata('DetBestFitInd.mat');

ObjBestFitScores = [];
for ii = 1:8
    for jj = 1:6       
        ObjBestFitScores{jj,ii} = ObjectivesDataTwoNorm{jj,ii}(DetIndexReduced{jj}(ii),:);   
    end
end




%%

dataControlAll = [];
dataPTZAll = [];
for DatNum = 1:NumTS
dataControl = {ObjectivesDataTwoNorm{1,DatNum}, ObjectivesDataTwoNorm{3,DatNum}, ObjectivesDataTwoNorm{5,DatNum}};
dataControlAll = [dataControlAll;dataControl];
dataPTZ = {ObjectivesDataTwoNorm{2,DatNum}, ObjectivesDataTwoNorm{4,DatNum}, ObjectivesDataTwoNorm{6,DatNum}};
dataPTZAll = [dataPTZAll;dataPTZ];
end

dataControlS = {'Det1Control', 'Det2Control', 'Det3Control'}; 
dataPTZS = {'Det1PTZ', 'Det2PTZ', 'Det3PTZ'};

Control = {'Control1','Control2','Control3','Control4','Control5','Control6','Control7','Control8'};
PTZ = {'PTZ1','PTZ2','PTZ3','PTZ4','PTZ5','PTZ6','PTZ7','PTZ8'};

%%

EDControl = NaN(NumTS,size(dataControl,2));

for j = 1:NumTS
for i = 1:size(dataControlAll,2)
    
EDControl(j,i) = mean(sqrt(sum(dataControlAll{j,i}.^2, 2)));

end
end

EDPTZ = NaN(NumTS,size(dataPTZ,2));

for j = 1:NumTS
for i = 1:size(dataPTZAll,2)
    
EDPTZ(j,i) = mean(sqrt(sum(dataPTZAll{j,i}.^2, 2)));

end
end

%% Boxplot of ED

figure;
subplot(1,2,1)
boxplot(EDControl,'labels',dataControlS,'Notch','on')
title('Mean ED Control')
ylim([0.1,0.8])
xtickangle(45)

subplot(1,2,2)
boxplot(EDPTZ,'labels',dataPTZS,'Notch','on')
title('Mean ED PTZ')
ylim([0.1,0.8])
xtickangle(45)

%% p-values/interquartile ranges

AA = cell2mat(dataControlAll(:,1));
BB = cell2mat(dataControlAll(:,2));
CC = cell2mat(dataControlAll(:,3));

AAA = sqrt(sum(AA.^2,2));
BBB = sqrt(sum(BB.^2,2));
CCC = sqrt(sum(CC.^2,2));

% p = ranksum(BBB,CCC);

%%

% r1 = iqr(EDControl(:,1))
% r2 = iqr(EDControl(:,2))
% r3 = iqr(EDControl(:,3))

r1 = iqr(EDPTZ(:,1))
r2 = iqr(EDPTZ(:,2))
r3 = iqr(EDPTZ(:,3))

%[h,p] = ttest(EDControl(:,1),EDControl(:,3))
[h,p] = ttest(EDPTZ(:,1),EDPTZ(:,3))


