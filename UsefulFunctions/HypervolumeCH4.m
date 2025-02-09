function v = HypervolumeCH4(Scores, r)
% HYPERVOLUMECH Calculates the hypervolume metric for a pareto front and a point.
%
%   HYPERVOLUMECH(Scores, r) Calculates the hypervolume metric for a Pareto
%   front and point r.
%
% Syntax: v = HypervolumeCH(Scores, r)
%
% Inputs:
%    Scores - Pareto front
%    r      - Point for the calculation of the hypervolume against
%             the Pareto front Score.
%
% Outputs:
%    v      - Hypervolume.
%
% Example:
%    v = HypervolumeCH([1,2,3,4;3,1,4,6], [4,5,2])
%    This example calculates the Pareto front [1,2,3,4;3,1,4,6] against the
%    point [4,5,2].
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: E. Avramidis & O.E. Akman. Optimisation of an exemplar oculomotor model
% using multi-objective genetic algorithms executed on a GPU-CPU combination.
% BMC Syst. Biol., 11: 40 (2017)
%
% Author: Eleftherios Avramidis
% Email: el.avramidis@gmail.com
% Date: 10/12/2017
% Version: 1.0

ind = find(Scores(:, 1) > r(1));
Scores(ind, :) = [];
ind = find(Scores(:, 2) > r(2));
Scores(ind, :) = [];
ind = find(Scores(:, 3) > r(3));
Scores(ind, :) = [];

Scores = [Scores; r];

r2 = [r(1) min(Scores(:, 2)) r(3)];
r3 = [min(Scores(:, 1)) r(2) r(3)];
r4 = [r(1) r(2) min(Scores(:, 3))];
Scores = [Scores; r2];
Scores = [Scores; r3];
Scores = [Scores; r4];


x = Scores(:, 1);
y = Scores(:, 2);
z = Scores(:, 3);

% Calculate the convex hull
[k, v] = convhulln([x, y, z]);

% Calculate the volume of the convex hull
vbox = (r(1) - min(Scores(:, 1))) * (r(2) - min(Scores(:, 2))) * (r(3) - min(Scores(:, 3)));
v = v / vbox;
end