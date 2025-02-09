function [ParamsTest,paramnames] = ParamsSetup(NoiseType,Range)

%% White Extended
if strcmp('White',NoiseType) && strcmp('Extended',Range)
paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r', 'ss'};

%                A    a   B    b    G    g     C     P     r    v0  e0  ss initial 
NominalValues = [3.25 100 22.0 50.0 20.0 500.0 135.0 220.0 0.56 6.0 2.5 1 10*rand(1,10)];
lb = [0 0 0 1 0 200 0 0 0.1 0.1 0.1 0.1 (-500)*ones(1, 10)];    
ub = [100 800 100 199 100 800 5000 5000 0.8 9 7.5 30 ones(1, 10)*500];

ParamsTest = {NominalValues;lb;ub};
    
%% OU Extended
elseif strcmp('OU',NoiseType) && strcmp('Extended',Range)
paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r', 'ss','tau','D'};
 
%                A    a   B    b    G    g     C     P     r    v0  e0  ss tau      D   initial 
NominalValues = [3.25 100 22.0 50.0 20.0 500.0 135.0 220.0 0.56 6.0 2.5 1 10^(-0.5) 100 10*rand(1,11)];
lb = [0 0 0 1 0 200 0 0 0.1 0.1 0.1 0.1 0 0 (-500)*ones(1, 11)];    
ub = [100 800 100 199 100 800 5000 5000 0.8 9 7.5 30 0.4 150 ones(1, 11)*500];

ParamsTest = {NominalValues;lb;ub};

%% White Lauric
elseif strcmp('White',NoiseType) && strcmp('Lauric',Range)
paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r', 'ss'};

%                A    a   B    b    G    g     C     P     r    v0  e0  ss initial 
NominalValues = [3.25 100 22.0 50.0 20.0 500.0 135.0 220.0 0.56 6.0 2.5 1 10*rand(1,10)];
lb = [0 25 0 6.5 0 350 0 0 0.3 2 0.5 0.1 (-500)*ones(1, 10)];    
ub = [10 140 50 110 50 650 1350 2000 0.8 9 7.5 30 ones(1, 10)*500];

ParamsTest = {NominalValues;lb;ub};
    
%% OU Lauric
elseif strcmp('OU',NoiseType) && strcmp('Lauric',Range)
paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r', 'ss','tau','D'};
 
%                A    a   B    b    G    g     C     P     r    v0  e0  ss tau      D   initial 
NominalValues = [3.25 100 22.0 50.0 20.0 500.0 135.0 220.0 0.56 6.0 2.5 1 10^(-0.5) 100 10*rand(1,11)];
lb = [0 25 0 6.5 0 350 0 0 0.3 2 0.5 0.1 0 0 (-500)*ones(1, 11)];    
ub = [10 140 50 110 50 650 1350 2000 0.8 9 7.5 30 0.4 150 ones(1, 11)*500];

ParamsTest = {NominalValues;lb;ub};
    
end