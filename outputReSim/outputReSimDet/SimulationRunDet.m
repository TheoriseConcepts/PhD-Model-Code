function [Xemburn,XemburnSave,ca,t,t3,Nn_conv,fs_conv] = SimulationRunDet(H)

Nodes = 1;

initial = 10*randn(Nodes,10);  % Random initial conditions

fs_sim = 1000; %convolution sampling frequency
dt = 1/fs_sim; % seconds per sample 
T = 315.85; % Time (seconds, 20s transient removed)
N=T*fs_sim; %PS this is time measured in points
t=linspace(0,T,N);

%Set up calcium convolution kernel

fs_conv = 1000; % convolution sampling frequency
T2=T-50; % Convolution time seconds.
Nn_conv = (T2)*fs_conv;
k = 1/fs_conv;    % Inverse time constant
mH = 1;        % Maximum height
latency = 1.875*0.25*fs_conv; % 250 ms (0.25 sec) with 1000Hz sampling frequency

ms = 1:Nn_conv; 
ca = mH * exp(-0.5*k*ms);

[val, ~]   = max(ca);
uprise = flip( (latency-1)^2 - [0:latency-1].^2 );
uprise = uprise / max(uprise) * val;
cal = [uprise, ca];
ca  = cal(1:length(ca));

%Set up gaussian filtering

T3=T-110;
N3=T3/dt;
t3=linspace(0,T3,N3);

%Begin Model Simulation

    ii=1;

    A=H(ii,1);
    a=H(ii,2);
    B=H(ii,3);
    b=H(ii,4);
    G=H(ii,5);
    g=H(ii,6);
    C1=H(ii,7);
    C2=H(ii,8);
    C3=H(ii,9);
    C4=H(ii,10);
    C5=H(ii,11);
    C6=H(ii,12);
    C7=H(ii,13);
    P=H(ii,14);
    r=H(ii,15);
    v0=H(ii,16);
    e0=H(ii,17);
    
    a2 = a^2;
    Aa = a*A;
    Bb = b*B;
    b2 = b^2;
    g2 = g^2;
    Gg = G*g;
    
% Solve deterministic model

W_eq=@(X,a,b,g,C1,C2,C3,C4,C5,C6,C7,P,r,v0,e0,a2,Aa,Bb,b2,g2,Gg)...
     [X(6);...
      X(7);...
      X(8);...
      X(9);...
      X(10);...
      (Aa*(2*e0./(1+exp(r*(v0-(X(2)-X(3)-X(4)))))) - 2*a*X(6) - X(1)*a2);...
      (Aa*(P+C2*2*e0./(1+exp(r*(v0-(C1*X(1)))))) - 2*a*X(7) - X(2)*a2);...
      (Bb*(C4*2*e0./(1+exp(r*(v0-(C3*X(1)))))) - 2*b*X(8) - X(3)*b2);
      (Gg*C7*(2*e0./(1+exp(r*(v0-(C5*X(1)-X(5)))))) - 2*g*X(9) - X(4)*g2);
      (Bb*(C6*2*e0./(1+exp(r*(v0-(C3*X(1)))))) - 2*b*X(10) - X(5)*b2)];

rhs_WendlingEquations=@(t,X) W_eq(X,a,b,g,C1,C2,C3,C4,C5,C6,C7,P,r,v0,e0,a2,Aa,Bb,b2,g2,Gg);

[t, Y] = ode45(rhs_WendlingEquations, t, initial);

Xem1 = (Y(:,1) - Y(:,2) - Y(:,3))';

Xemburn = Xem1(:,(50*fs_sim):N-1);  % Remove transient
Xemburn = resample(Xemburn,fs_conv,fs_sim); % resamples has an antialiasing filtering 
    
XemburnSave = Xemburn(:,(40*fs_sim):(N-(90*fs_sim)-1)); % because we remove 10 sec both end from convolution

end