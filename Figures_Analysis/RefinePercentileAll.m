function [ReducedBestObj] = RefinePercentileAll(ObjectiveScores,ObjNum,Percentile,NumTS)

for m = 1:NumTS

if ObjNum == 1
    ScoresAll = ObjectiveScores{m}(:,1:3);
    Scores1 = ObjectiveScores{m}(:,1);
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
ReducedBestObj{m} = ScoresAll(indx(:,2),:);
elseif ObjNum == 2
    ScoresAll = ObjectiveScores{m}(:,1:3);
    Scores1 = ObjectiveScores{m}(:,1:2);
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
ReducedBestObj{m} = ScoresAll(indx(:,2),:);
elseif ObjNum == 3
    ScoresAll = ObjectiveScores{m}(:,1:3);
    Scores1 = ObjectiveScores{m}(:,1:3);
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
ReducedBestObj{m} = ScoresAll(indx(:,2),:);
end

end