function fit1 = ObjFitOU(A1, paramsvec, Data_z, paramstoest, T, bb, aa, Objectives)

paramsinput = [paramsvec, 10*randn(1,11)];
paramsinput(paramstoest) = A1;

objectivesDatOut = ObjectivesSetup(Data_z,Objectives);
num_empty = (isempty(objectivesDatOut{1}) + isempty(objectivesDatOut{2}) + isempty(objectivesDatOut{3}));

fitvec = [];
parfor RunIter = 1:5 % run 5 times for stability: - take the mean value for the fitness func
% run current params. 
sim_z=gamultiobjWendlingOU_mg(T,paramsinput,bb,aa);

objectivesSimOut = ObjectivesSetup(sim_z,Objectives);

if num_empty == 2
PSDobj = sum(((objectivesDatOut{1}-objectivesSimOut{1}).^2));

 if sum(isnan(PSDobj))>0
        fitvec = [fitvec; 100];
 else

fitvec = [fitvec;PSDobj];

 end

elseif num_empty == 1
PSDobj = sum(((objectivesDatOut{1}-objectivesSimOut{1}).^2));

[~, ~, HVGobj] = kstest2(objectivesDatOut{2},objectivesSimOut{2});

 if sum(isnan([PSDobj, HVGobj]))>0
        fitvec = [fitvec; [100 100]];
 else

fitvec = [fitvec;[PSDobj, HVGobj]];

 end


elseif num_empty == 0
PSDobj = sum(((objectivesDatOut{1}-objectivesSimOut{1}).^2));

[~, ~, HVGobj] = kstest2(objectivesDatOut{2},objectivesSimOut{2});

[~, ~, CCobj] = kstest2(objectivesDatOut{3},objectivesSimOut{3});

 if sum(isnan([PSDobj, HVGobj, CCobj]))>0
        fitvec = [fitvec; [100 100 100]];
 else

fitvec = [fitvec;[PSDobj, HVGobj, CCobj]];
 end
 end
end

fit1 = mean(fitvec, 1);
