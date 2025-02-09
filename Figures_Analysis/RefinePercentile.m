function [ReducedBestObj1, ReducedBestObj2] = RefinePercentile(ObjectiveScores1,ObjectiveScores2,ObjNum,j,jj,Percentile)

for m = 1:8

if ObjNum(j) == 1
    ScoresAll = ObjectiveScores1{m}(:,1:3);
    Scores1 = ObjectiveScores1{m}(:,1);
ObjScoresNorm = normalize(Scores1,'range'); 
ED = ObjScoresNorm';
indx = [ED; [1:size(ObjScoresNorm,1)]]';

X = prctile(indx(:,1),Percentile);
numX = length(indx);
for mm = numX:-1:1
    if X < indx(mm,1)
        indx(mm,:)=[];
    end
end
ReducedBestObj1{m} = ScoresAll(indx(:,2),:);
elseif ObjNum(j) == 2
    ScoresAll = ObjectiveScores1{m}(:,1:3);
    Scores1 = ObjectiveScores1{m}(:,1:2);
ObjScoresNorm = [normalize(Scores1(:,1),'range') normalize(Scores1(:,2),'range')]'; 
ED = sqrt(sum(ObjScoresNorm.^2));
indx = [ED; [1:size(ObjScoresNorm,2)]]';

X = prctile(indx(:,1),Percentile);
numX = length(indx);
for mm = numX:-1:1
    if X < indx(mm,1)
        indx(mm,:)=[];
    end
end
ReducedBestObj1{m} = ScoresAll(indx(:,2),:);
elseif ObjNum(j) == 3
    ScoresAll = ObjectiveScores1{m}(:,1:3);
    Scores1 = ObjectiveScores1{m}(:,1:3);
ObjScoresNorm = [normalize(Scores1(:,1),'range') normalize(Scores1(:,2),'range') normalize(Scores1(:,3),'range')]'; 
ED = sqrt(sum(ObjScoresNorm.^2));
indx = [ED; [1:size(ObjScoresNorm,2)]]';

X = prctile(indx(:,1),Percentile);
numX = length(indx);
for mm = numX:-1:1
    if X < indx(mm,1)
        indx(mm,:)=[];
    end
end
ReducedBestObj1{m} = ScoresAll(indx(:,2),:);
end

%%

if ObjNum(jj) == 1
    ScoresAll = ObjectiveScores2{m}(:,1:3);
    Scores2 = ObjectiveScores2{m}(:,1);
ObjScoresNorm = normalize(Scores2,'range'); 
ED = ObjScoresNorm';
indx = [ED; [1:size(ObjScoresNorm,1)]]';

X = prctile(indx(:,1),Percentile);
numX = length(indx);
for mm = numX:-1:1
    if X < indx(mm,1)
        indx(mm,:)=[];
    end
end
ReducedBestObj2{m} = ScoresAll(indx(:,2),:);
elseif ObjNum(jj) == 2
    ScoresAll = ObjectiveScores2{m}(:,1:3);
    Scores2 = ObjectiveScores2{m}(:,1:2);
ObjScoresNorm = [normalize(Scores2(:,1),'range') normalize(Scores2(:,2),'range')]'; 
ED = sqrt(sum(ObjScoresNorm.^2));
indx = [ED; [1:size(ObjScoresNorm,2)]]';

X = prctile(indx(:,1),Percentile);
numX = length(indx);
for mm = numX:-1:1
    if X < indx(mm,1)
        indx(mm,:)=[];
    end
end
ReducedBestObj2{m} = ScoresAll(indx(:,2),:);
elseif ObjNum(jj) == 3
    ScoresAll = ObjectiveScores2{m}(:,1:3);
    Scores2 = ObjectiveScores2{m}(:,1:3);
ObjScoresNorm = [normalize(Scores2(:,1),'range') normalize(Scores2(:,2),'range') normalize(Scores2(:,3),'range')]'; 
ED = sqrt(sum(ObjScoresNorm.^2));
indx = [ED; [1:size(ObjScoresNorm,2)]]';

X = prctile(indx(:,1),Percentile);
numX = length(indx);
for mm = numX:-1:1
    if X < indx(mm,1)
        indx(mm,:)=[];
    end
end
ReducedBestObj2{m} = ScoresAll(indx(:,2),:);
end

end