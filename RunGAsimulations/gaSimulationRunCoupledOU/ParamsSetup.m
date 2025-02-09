function [ParamsTest,paramnames] = ParamsSetup(NoiseType,Range,n)
%% White
if strcmp('White',NoiseType) && strcmp('Extended',Range)
paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r', 'ss', 'K'};

%                A    a   B    b    G    g     C     P     r    v0  e0  ss K initial             
NominalValues = [3.25 100 22.0 50.0 20.0 500.0 135.0 220.0 0.56 6.0 2.5 1 0];
randMatrix1 = 10*rand(n,10);
NominalValues = [repmat(NominalValues(1:size(paramnames,2)), n, 1) reshape(randMatrix1, n, [])]; 

lb = [0 0 0 1 0 200 0 0 0.1 0.1 0.1 0.1 0]; 
randMatrix2 = (-500)*ones(n,10);
lb = [repmat(lb(1:size(paramnames,2)), n, 1) reshape(randMatrix2, n, [])];
  
ub = [100 800 100 199 100 800 5000 5000 0.8 9 7.5 30 2000];
randMatrix3 = (500)*ones(n,10);
ub = [repmat(ub(1:size(paramnames,2)), n, 1) reshape(randMatrix3, n, [])];

ParamsTest = {NominalValues;lb;ub};
    
%% OU
elseif strcmp('OU',NoiseType) && strcmp('Extended',Range)
paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r', 'ss', 'K', 'tau', 'D'};

%                A    a   B    b    G    g     C     P     r    v0  e0  ss K tau      D   initial 
NominalValues = [3.25 100 22.0 50.0 20.0 500.0 135.0 220.0 0.56 6.0 2.5 1 0 10^(-0.5) 100];
randMatrix1 = 10*rand(n,11);
NominalValues = [repmat(NominalValues(1:size(paramnames,2)), n, 1) reshape(randMatrix1, n, [])];

lb = [0 0 0 1 0 200 0 0 0.1 0.1 0.1 0.1 0 0 0]; 
randMatrix2 = (-500)*ones(n,11);
lb = [repmat(lb(1:size(paramnames,2)), n, 1) reshape(randMatrix2, n, [])];
  
ub = [100 800 100 199 100 800 5000 5000 0.8 9 7.5 30 2000 0.4 150];
randMatrix3 = (500)*ones(n,11);
ub = [repmat(ub(1:size(paramnames,2)), n, 1) reshape(randMatrix3, n, [])];

ParamsTest = {NominalValues;lb;ub};


%% White Lauric
elseif strcmp('White',NoiseType) && strcmp('Lauric',Range)
paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r', 'ss', 'K'};

%                A    a   B    b    G    g     C     P     r    v0  e0  ss K initial             
NominalValues = [3.25 100 22.0 50.0 20.0 500.0 135.0 220.0 0.56 6.0 2.5 1 0];
randMatrix1 = 10*rand(n,10);
NominalValues = [repmat(NominalValues(1:size(paramnames,2)), n, 1) reshape(randMatrix1, n, [])]; 

lb = [0 25 0 6.5 0 350 0 0 0.3 2 0.5 0.1 0];
randMatrix2 = (-500)*ones(n,10);
lb = [repmat(lb(1:size(paramnames,2)), n, 1) reshape(randMatrix2, n, [])];
  
ub = [10 140 50 110 50 650 1350 2000 0.8 9 7.5 30 2000];
randMatrix3 = (500)*ones(n,10);
ub = [repmat(ub(1:size(paramnames,2)), n, 1) reshape(randMatrix3, n, [])];

ParamsTest = {NominalValues;lb;ub};
    
%% OU Lauric
elseif strcmp('OU',NoiseType) && strcmp('Lauric',Range)
paramnames= {'A', 'a', 'B', 'b', 'G', 'g', 'P', 'C', 'v0', 'e0', 'r', 'ss', 'K', 'tau', 'D'};

%                A    a   B    b    G    g     C     P     r    v0  e0  ss K tau      D   initial 
NominalValues = [3.25 100 22.0 50.0 20.0 500.0 135.0 220.0 0.56 6.0 2.5 1 0 10^(-0.5) 100];
randMatrix1 = 10*rand(n,11);
NominalValues = [repmat(NominalValues(1:size(paramnames,2)), n, 1) reshape(randMatrix1, n, [])];

lb = [0 25 0 6.5 0 350 0 0 0.3 2 0.5 0.1 0 0 0]; 
randMatrix2 = (-500)*ones(n,11);
lb = [repmat(lb(1:size(paramnames,2)), n, 1) reshape(randMatrix2, n, [])];
  
ub = [10 140 50 110 50 650 1350 2000 0.8 9 7.5 30 2000 0.4 150];
randMatrix3 = (500)*ones(n,11);
ub = [repmat(ub(1:size(paramnames,2)), n, 1) reshape(randMatrix3, n, [])];

ParamsTest = {NominalValues;lb;ub};
    
end