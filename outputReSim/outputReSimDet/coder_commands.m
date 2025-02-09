%vectorType1 = coder.typeof(1); % sets up an input that is a double
vectorType2 = coder.typeof(1, [1 17], [false false]); % sets up an input that is a vector row with fixed size columns
% vectorType2 = coder.typeof(1, [1 inf], [false true]); % sets up an input that is a vector row with variable size columns
% now code up the function 
codegen SimulationRunDet -args {vectorType2}
