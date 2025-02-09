function [ParamsTest,paramnames] = ParamsSetup(Range)

%% Extended
if strcmp('Extended',Range)
paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r'};

%                A    a   B    b    G    g     C     P     r    v0  e0   initial 
NominalValues = [3.25 100 22.0 50.0 20.0 500.0 135.0 220.0 0.56 6.0 2.5 10*rand(1,10)];
lb = [0 0 0 1 0 200 0 0 0.1 0.1 0.1 (-500)*ones(1, 10)];    
ub = [100 800 100 199 100 800 5000 5000 0.8 9 7.5 ones(1, 10)*500];

ParamsTest = {NominalValues;lb;ub};
    
%% Lauric
elseif strcmp('Lauric',Range)
paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r'};
 
%                A    a   B    b    G    g     C     P     r    v0  e0     initial 
NominalValues = [3.25 100 22.0 50.0 20.0 500.0 135.0 220.0 0.56 6.0 2.5 10*rand(1,10)];
lb = [0 0 0 1 0 200 0 0 0.1 0.1 0.1 (-500)*ones(1, 10)];    
ub = [100 800 100 199 100 800 5000 5000 0.8 9 7.5 ones(1, 10)*500];

ParamsTest = {NominalValues;lb;ub};
    
end