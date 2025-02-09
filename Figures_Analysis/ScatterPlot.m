% Setup Objective Scores to compare

i=1; ii=3; DataMethod = {'Det' 'WN' 'OU' 'WNCoupled' 'OUCoupled'}; 
j=3; jj=3; ObjNum = [1,2,3]; 
k=2; kk=2; DataType = {'Control','PTZ'}; 
n=1; nn=1; ParamRange = {'Extended','Lauric'}; 

ObjectiveScores1 = importdata([DataMethod{i} num2str(ObjNum(j)) 'objObjectiveScores' DataType{k} ParamRange{n} '.mat']);
ObjectiveScores2 = importdata([DataMethod{ii} num2str(ObjNum(jj)) 'objObjectiveScores' DataType{kk} ParamRange{nn} '.mat']);

% Change the percentile for points plotted on scatter plot
Percentile = 80;
[ReducedBestObj1, ReducedBestObj2] = RefinePercentile(ObjectiveScores1,ObjectiveScores2,ObjNum,j,jj,Percentile);

opt = {[0.01 0.025], [0.1 0.1], [0.075 0.075]};
subplot = @(m,n,p) subtightplot(m,n,p,opt{:});

%% Best Fit Point

[BestFitControlIndex,BestFitPTZIndex] = BestFitPoint(DataMethod,ObjNum,i,j,[],[]);

BestFitObjectiveScores1 = cell(1,8);
if strcmp('Control',DataType{k})
for q = 1:8
BestFitObjectiveScores1{q} = ObjectiveScores1{q}(BestFitControlIndex(q),:);
end
elseif strcmp('PTZ',DataType{k})
for q = 1:8
BestFitObjectiveScores1{q} = ObjectiveScores1{q}(BestFitPTZIndex(q),:);
end
end


[BestFitControlIndex,BestFitPTZIndex] = BestFitPoint(DataMethod,ObjNum,[],[],ii,jj);

BestFitObjectiveScores2 = cell(1,8);
if strcmp('Control',DataType{k})
for q = 1:8
BestFitObjectiveScores2{q} = ObjectiveScores2{q}(BestFitControlIndex(q),:);
end
elseif strcmp('PTZ',DataType{k})
for q = 1:8
BestFitObjectiveScores2{q} = ObjectiveScores2{q}(BestFitPTZIndex(q),:);
end
end

% Find index of ReducedBestObj1/ReducedBestObj2 using best fit for normalised objective scores
rowIndex1 = nan(1,8);
rowIndex2 = nan(1,8);
for r = 1:8
[~, rowIndex1(r)] = ismember(BestFitObjectiveScores1{r}, ReducedBestObj1{r}, 'rows');
[~, rowIndex2(r)] = ismember(BestFitObjectiveScores2{r}, ReducedBestObj2{r}, 'rows');
end


%% Scatter Plot

for p = 1:8

ObjComp1 = ReducedBestObj1{p};
ObjComp2 = ReducedBestObj2{p};

ObjPSDNorm = normalize([ObjComp1(:,1);ObjComp2(:,1)],'range'); 
ObjHVGNorm = normalize([ObjComp1(:,2);ObjComp2(:,2)],'range'); 
ObjCCNorm = normalize([ObjComp1(:,3);ObjComp2(:,3)],'range'); 

ObjPSDNormComp1 = ObjPSDNorm(1:numel(ObjComp1(:,1)));
ObjPSDNormComp2 = ObjPSDNorm(numel(ObjComp1(:,1))+1:end);
ObjHVGNormComp1 = ObjHVGNorm(1:numel(ObjComp1(:,1)));
ObjHVGNormComp2 = ObjHVGNorm(numel(ObjComp1(:,1))+1:end);
ObjCCNormComp1 = ObjCCNorm(1:numel(ObjComp1(:,1)));
ObjCCNormComp2 = ObjCCNorm(numel(ObjComp1(:,1))+1:end);

figure(100) 
subplot(3,8,p)
scatter(ObjPSDNormComp1,ObjHVGNormComp1,2,'b','filled'), hold on, scatter(ObjPSDNormComp2,ObjHVGNormComp2,2,'r','filled')
hold on, scatter(ObjPSDNormComp1(rowIndex1(p)),ObjHVGNormComp1(rowIndex1(p)),20,'m','filled') 
hold on, scatter(ObjPSDNormComp2(rowIndex2(p)),ObjHVGNormComp2(rowIndex2(p)),20,'g','filled')
xlabel('PSD Obj Score')
axis('square')
subplot(3,8,p+8)
scatter(ObjCCNormComp1,ObjPSDNormComp1,2,'b','filled'), hold on, scatter(ObjCCNormComp2,ObjPSDNormComp2,2,'r','filled')
hold on, scatter(ObjCCNormComp1(rowIndex1(p)),ObjPSDNormComp1(rowIndex1(p)),20,'m','filled') 
hold on, scatter(ObjCCNormComp2(rowIndex2(p)),ObjPSDNormComp2(rowIndex2(p)),20,'g','filled')
xlabel('CC Obj Score')
axis('square')
subplot(3,8,p+16)
scatter(ObjCCNormComp1,ObjHVGNormComp1,2,'b','filled'), hold on, scatter(ObjCCNormComp2,ObjHVGNormComp2,2,'r','filled')
hold on, scatter(ObjCCNormComp1(rowIndex1(p)),ObjHVGNormComp1(rowIndex1(p)),20,'m','filled') 
hold on, scatter(ObjCCNormComp2(rowIndex2(p)),ObjHVGNormComp2(rowIndex2(p)),20,'g','filled')
xlabel('CC Obj Score')
axis('square')

subplot(3,8,1)
ylabel('HVG Obj Score')
subplot(3,8,9)
ylabel('PSD Obj Score')
subplot(3,8,17)
ylabel('HVG Obj Score')

subplot(3,8,p)
title([DataType{k} ' ' num2str(p)])
end
sgtitle(['Comparison of Objective Scores for ' DataType{k} ' ' num2str(ObjNum(j)) ' Obj ' DataMethod{i} ...
    ' (Blue, Magenta Best Fit) and ' newline num2str(ObjNum(jj)) ' Obj ' DataMethod{ii} ' (Red, Green Best Fit) GA Simulations'])

