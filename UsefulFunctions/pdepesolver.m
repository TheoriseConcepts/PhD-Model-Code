x = linspace(0,50,5000);
t = linspace(0,50,50000);

m = 1;
sol = (pdepe(m,@purediff,@pureic,@purediffbc,x,t));

u = sol(:,:,1);
p1 = (sol(:,4500));

% surf(x,t,u)
% xlabel('x')
% ylabel('t')
% % zlabel('u(x,t)')
% view([150 25])
figure(1)
plot(t,p1)
xlabel('Time')
%ylabel('Temperature u(0,t)')
%title('Temperature change at center of disc')

function [c,f,s] = purediff(x,t,u,dudx)
D = 1;
c = 1/D;
f = dudx;
s = 0;
end

function u0 = pureic(x)
u0 = 50;
end

function [pl,ql,pr,qr] = purediffbc(xl,ul,xr,ur,t)

pL = 500; %bound receptor density [/um]
E = 15; %ligand-receptor binding energy [-]
B = 20; %bending modulus [-]
R = 2; %target radius [um]

p_plus = fzero(@(p_plus)p_plus/pL-log(p_plus/pL)-E+2*B/(pL*R^2)-1, [1e-10 pL]);

pl = 0; %ignored by solver since m=1
ql = 0; %ignored by solver since m=1
pr = ur - p_plus;
qr = 0; 
end
