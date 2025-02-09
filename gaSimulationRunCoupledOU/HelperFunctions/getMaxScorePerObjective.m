
function m = getMaxScorePerObjective(scores)
%GETMAXSCOREPEROBJECTIVE Calculates and returns the maximum value for each 
%objective for a number of individuals.
%
%   GETMAXSCOREPEROBJECTIVE(scores) Calculates and returns the maximum
%   value for each objective for a number of individuals.
%
% Syntax:  getMaxScorePerObjective(scores)
%
% Inputs:
%    scores        - Matrix with the scores for each objective for a number
%                    of individuals.
%
% Outputs:
%    m             - Maximum score for each objective.
%
% Example:
%    m = getMaxScorePerObjective([1,2,3,4;3,1,4,6])
%    This example returns the maximum value of each objective and stores it
%    in the return variable m.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: E. Avramidis & O.E. Akman. Optimisation of an exemplar oculomotor model
% using multi-objective genetic algorithms executed on a GPU-CPU combination.
% BMC Syst. Biol., 11: 40 (2017)
%
% @author: Eleftherios Avramidis $
% @email: el.avramidis@gmail.com $
% @date: 10/12/2017 $
% @version: 1.0 $
% Copyright: Not specified

[~, c]=size(scores);
m = zeros(c,1);
for i=1:c
    m(i)=max(scores(:,i));
end

end
