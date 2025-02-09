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


Det1Control = RefinePercentileAll(Det1Control,1,80);
Det1PTZ = RefinePercentileAll(Det1PTZ,1,80);
Det2Control = RefinePercentileAll(Det2Control,2,80);
Det2PTZ = RefinePercentileAll(Det2PTZ,2,80);
Det3Control = RefinePercentileAll(Det3Control,3,80);
Det3PTZ = RefinePercentileAll(Det3PTZ,3,80);
OU2Control = RefinePercentileAll(OU2Control,2,80);
OU2PTZ = RefinePercentileAll(OU2PTZ,2,80);
OU3Control = RefinePercentileAll(OU3Control,3,80);
OU3PTZ = RefinePercentileAll(OU3PTZ,3,80);
WN1Control = RefinePercentileAll(WN1Control,1,80);
WN1PTZ = RefinePercentileAll(WN1PTZ,1,80);
WN2Control = RefinePercentileAll(WN2Control,2,80);
WN2PTZ = RefinePercentileAll(WN2PTZ,2,80);
WN3Control = RefinePercentileAll(WN3Control,3,80);
WN3PTZ = RefinePercentileAll(WN3PTZ,3,80);

%%

n = 1;

% ObjectiveData = [Det1Control(:); Det1PTZ(:); Det2Control(:); Det2PTZ(:); Det3Control(:); Det3PTZ(:); ...
%                  OU2Control(:); OU2PTZ(:); OU3Control(:); OU3PTZ(:)];
ObjectiveData = [Det1Control(n); Det1PTZ(n); Det2Control(n); Det2PTZ(n); Det3Control(n); Det3PTZ(n); ...
                 OU2Control(n); OU2PTZ(n); OU3Control(n); OU3PTZ(n); ...
                 WN1Control(n); WN1PTZ(n); WN2Control(n); WN2PTZ(n); WN3Control(n); WN3PTZ(n)];
ObjectiveDataDouble = vertcat(ObjectiveData{:});
%ObjectivesAllNorm = normc(ObjectiveDataDouble);
ObjectivesAllNorm = [normalize(ObjectiveDataDouble(:,1),'range') normalize(ObjectiveDataDouble(:,2),'range') normalize(ObjectiveDataDouble(:,3),'range')];  

startIndex(1) = 1;
for j = 1:size(ObjectiveData,1)
    % [rows, ~] = size(vertcat(ObjectiveData{(8*j)-7:(8*j)}));
    [rows, ~] = size(vertcat(ObjectiveData{j}));
    endIndex(j) = startIndex(j) + rows - 1;
    startIndex(j+1) = endIndex(j) + 1;
end

Det1ControlNorm = ObjectivesAllNorm(startIndex(1):endIndex(1),:);
Det1PTZNorm = ObjectivesAllNorm(startIndex(2):endIndex(2),:);
Det2ControlNorm = ObjectivesAllNorm(startIndex(3):endIndex(3),:);
Det2PTZNorm = ObjectivesAllNorm(startIndex(4):endIndex(4),:);
Det3ControlNorm = ObjectivesAllNorm(startIndex(5):endIndex(5),:);
Det3PTZNorm = ObjectivesAllNorm(startIndex(6):endIndex(6),:);
OU2ControlNorm = ObjectivesAllNorm(startIndex(7):endIndex(7),:);
OU2PTZNorm = ObjectivesAllNorm(startIndex(8):endIndex(8),:);
OU3ControlNorm = ObjectivesAllNorm(startIndex(9):endIndex(9),:);
OU3PTZNorm = ObjectivesAllNorm(startIndex(10):endIndex(10),:);
WN1ControlNorm = ObjectivesAllNorm(startIndex(11):endIndex(11),:);
WN1PTZNorm = ObjectivesAllNorm(startIndex(12):endIndex(12),:);
WN2ControlNorm = ObjectivesAllNorm(startIndex(13):endIndex(13),:);
WN2PTZNorm = ObjectivesAllNorm(startIndex(14):endIndex(14),:);
WN3ControlNorm = ObjectivesAllNorm(startIndex(15):endIndex(15),:);
WN3PTZNorm = ObjectivesAllNorm(startIndex(16):endIndex(16),:);


%% Boxplot

% Group the data by method and condition (control or PTZ)
data = {Det1ControlNorm, Det1PTZNorm, Det2ControlNorm, Det2PTZNorm, Det3ControlNorm, Det3PTZNorm, ...
        OU2ControlNorm, OU2PTZNorm, OU3ControlNorm, OU3PTZNorm, ...
        WN1ControlNorm, WN1PTZNorm, WN2ControlNorm, WN2PTZNorm, WN3ControlNorm, WN3PTZNorm};
methods = {'Det1', 'Det1', 'Det2', 'Det2', 'Det3', 'Det3', 'OU2', 'OU2', 'OU3', 'OU3', ...
           'WN1', 'WN1', 'WN2', 'WN2', 'WN3', 'WN3'};
conditions = {'Control', 'PTZ', 'Control', 'PTZ', 'Control', 'PTZ', 'Control', 'PTZ', 'Control', 'PTZ', ...
              'Control', 'PTZ', 'Control', 'PTZ', 'Control', 'PTZ'};

numMethods = numel(unique(methods));
numConditions = numel(unique(conditions));

% Plot box plots for each method and condition
figure;
for m = 1:numMethods
    for c = 1:numConditions
        subplot(numConditions, numMethods, (c-1)*numMethods + m);
        boxplot(data{(m-1)*numConditions + c},'Notch','on');
        title([methods{(m-1)*numConditions + c}, ' ', conditions{(m-1)*numConditions + c}]);
        xlabel('Objectives');
        ylim([0 1])
        
         if c == 1 && m == 1
            ylabel('Normalized Value');
            yticks(0:0.1:1);
         elseif c == 2 && m == 1
            ylabel('Normalized Value');
            yticks(0:0.1:1);
        else
            set(gca, 'Yticklabel', []);
         end
        
    end
end



%% Violin

% Group the data by method and condition (control or PTZ)
data = {Det1ControlNorm, Det1PTZNorm, Det2ControlNorm, Det2PTZNorm, Det3ControlNorm, Det3PTZNorm, ...
        OU2ControlNorm, OU2PTZNorm, OU3ControlNorm, OU3PTZNorm};
methods = {'Det1', 'Det1', 'Det2', 'Det2', 'Det3', 'Det3', 'OU2', 'OU2', 'OU3', 'OU3'};
conditions = {'Control', 'PTZ', 'Control', 'PTZ', 'Control', 'PTZ', 'Control', 'PTZ', 'Control', 'PTZ'};

numMethods = numel(unique(methods));
numConditions = numel(unique(conditions));

% Plot violin plots for each method and condition
figure;
for m = 1:numMethods
    for c = 1:numConditions
        subplot(numConditions, numMethods, (c-1)*numMethods + m);
        violinplot(data{(m-1)*numConditions + c});
        title([methods{(m-1)*numConditions + c}, ' ', conditions{(m-1)*numConditions + c}]);
        xlabel('Objectives');
        ylabel('Normalized Value');
        ylim([0 1])
    end
end

