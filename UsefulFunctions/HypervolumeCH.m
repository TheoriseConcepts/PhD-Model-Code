function v=HypervolumeCH(Scores, r)
%HYPERVOLUMECH Calculates the hypervolume metric for a pareto front and a point.
%
%   HYPERVOLUMECH(scores ,r) Calculates the hypervolume metric for a pareto
%   front and point r.
%
% Syntax:  v=HypervolumeCH(Scores, r)
%
% Inputs:
%    Scores        - Parero front
%    r             - Point for the calculation of the hypervolume against
%                    the Pareto front Score.
%
% Outputs:
%    v             - Hypervolume.
%
% Example:
%    v = HypervolumeCH([1,2,3,4;3,1,4,6], [4,5])
%    This example calculates the Pareto front [1,2,3,4;3,1,4,6] against the
%    point [4,5].
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

ind=find(Scores(:,1)>r(1));
Scores(ind,:)=[];
ind=find(Scores(:,2)>r(2));
Scores(ind,:)=[];

Scores=[Scores; r];

r2=[r(1) min(Scores(:,2))];
r3=[min(Scores(:,1)) r(2)];
Scores=[Scores; r2];
Scores=[Scores; r3];

x = Scores(:,1);
y = Scores(:,2);
% [x,y] = pol2cart(xx,yy);
[k, v] = convhull(x,y);
% plot(x(k),y(k),'r-',x,y,'b*')

vbox=r(1)*r(2);
v=v/vbox;
end