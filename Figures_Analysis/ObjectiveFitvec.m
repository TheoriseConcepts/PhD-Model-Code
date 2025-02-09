function [distances, fitvec] = ObjectiveFitvec(objectivesDatOut,objectivesSimOut,num_empty)

fitvec = [];

if num_empty == 2
PSDobj = sum(((objectivesDatOut{1}-objectivesSimOut{1}).^2));

 if sum(isnan(PSDobj))>0
        fitvec = [fitvec; 100];
 else

fitvec = [fitvec;PSDobj];

distances = sqrt(fitvec(1).^2)'; 

 end

elseif num_empty == 1
PSDobj = sum(((objectivesDatOut{1}-objectivesSimOut{1}).^2));

[~, ~, HVGobj] = kstest2(objectivesDatOut{2},objectivesSimOut{2});

 if sum(isnan([PSDobj, HVGobj]))>0
        fitvec = [fitvec; [100 100]];
 else

fitvec = [fitvec;[PSDobj, HVGobj]];

distances = sqrt(fitvec(1).^2 + fitvec(2).^2)'; 

 end


elseif num_empty == 0
PSDobj = sum(((objectivesDatOut{1}-objectivesSimOut{1}).^2));

[~, ~, HVGobj] = kstest2(objectivesDatOut{2},objectivesSimOut{2});

[~, ~, CCobj] = kstest2(objectivesDatOut{3},objectivesSimOut{3});

 if sum(isnan([PSDobj, HVGobj, CCobj]))>0
        fitvec = [fitvec; [100 100 100]];
 else

fitvec = [fitvec;[PSDobj, HVGobj, CCobj]];

distances = sqrt(fitvec(1).^2 + fitvec(2).^2 + fitvec(3).^2)'; 

 end
 end