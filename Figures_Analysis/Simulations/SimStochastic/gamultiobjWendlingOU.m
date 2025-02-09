function [Xemburn,ca,t,t3,Nn_conv,fs_conv] = gamultiobjWendlingOU(T, params1)

%%%simulation%%%

%A function to simulate a network of neuron populations following the model of
%Wendling

fs_sim = 1000; %convolution sampling frequency
dt = 1/fs_sim; % seconds per sample 
N=T*fs_sim; %PS this is time measured in points
t=linspace(0,T,N);

X = params1(16:end);
OU = params1(15);

%Set up calcium convolution kernel

fs_conv = 1000; %convolution sampling frequency
T2=T-50; % Convolution time seconds.
Nn_conv = (T2)*fs_conv;
k = 1/fs_conv;    % Inverse time constant
mH = 1;        % Maximum height
latency = 1.875*0.25*fs_conv; % PS see that in zf_calciumsim they are using 250 ms (0.25 sec) with 1000Hz sampling frequency

ms = 1:Nn_conv; % PS removed loop and used the Nn_conv
ca = mH * exp(-0.5*k*ms);

[val, ~]   = max(ca);
uprise      = flip( (latency-1)^2 - [0:latency-1].^2 );
uprise      = uprise / max(uprise) * val;
cal = [uprise, ca];
ca  = cal(1:length(ca));

% Set up gaussian filtering

T3=T-110;
N3=T3/dt;
t3=linspace(0,T3,N3);
    
%Begin Model Simulation

    dW = sqrt(dt)*randn(1,N);
    
A = params1(1); a = params1(2); B = params1(3); b = params1(4); 
G = params1(5); g = params1(6); Cvec = params1(7); 
P = params1(8); r = params1(9); v0 = params1(10);
e0 = params1(11); ss = params1(12); tau = params1(13); D = params1(14);
params.A = A;
params.a=  a;
params.B = B;
params.b = b;
params.G = G;
params.g = g;
params.Cvec = Cvec;
params.P = P;
params.r = r;
params.v0 = v0;
params.e0 = e0;
params.ss = ss;
params.tau = tau;
params.D = D;

C1=params.Cvec;
C2=0.8*params.Cvec;
C3=0.25*params.Cvec;
C4=0.25*params.Cvec;
C5=0.3*params.Cvec;
C6=0.1*params.Cvec;
C7=0.8*params.Cvec;

a2 = params.a^2;
Aa = params.a*params.A;
Bb = params.b*params.B;
b2 = params.b^2;
g2 = params.g^2;
Gg = params.G*params.g;
    
    Xem1 = NaN(1,length(t));
    
    for j = 1:length(t) 
        
    OU(:,1) = OU(:,1) - (OU(:,1)/params.tau)*dt + (sqrt(2*params.D)/params.tau)*dW(:,j); 

    X(:,1) = X(:,1) + X(:,6)*dt;
    X(:,2) = X(:,2) + X(:,7)*dt;
    X(:,3) = X(:,3) + X(:,8)*dt;
    X(:,4) = X(:,4) + X(:,9)*dt;
    X(:,5) = X(:,5) + X(:,10)*dt;
    X(:,6) = X(:,6) + (Aa*(2*params.e0./(1+exp(params.r*(params.v0-(X(:,2)-X(:,3)-X(:,4)))))) - 2*params.a*X(:,6) - X(:,1)*a2)*dt;
    X(:,7) = X(:,7) + (Aa*(params.P+C2*2*params.e0./(1+exp(params.r*(params.v0-(C1*X(:,1)))))) - 2*params.a*X(:,7) - X(:,2)*a2)*dt + Aa*params.ss*OU(:,1);
    ev = 2*params.e0./(1+exp(params.r*(params.v0-(C3*X(:,1)))));
    X(:,8) = X(:,8) + (Bb*(C4*ev) - 2*params.b*X(:,8) - X(:,3)*b2)*dt;
    X(:,9) = X(:,9) + (Gg*C7*(2*params.e0./(1+exp(params.r*(params.v0-(C5*X(:,1)-X(:,5)))))) - 2*params.g*X(:,9) - X(:,4)*g2)*dt;
    X(:,10) = X(:,10) + (Bb*(C6*ev) - 2*params.b*X(:,10) - X(:,5)*b2)*dt;
    
     Xem1(:,j) = X(:,2) - X(:,3) - X(:,4);    
 %   Xem1(:,j) = 2*e0./(1+exp(r*(v0-(X(:,2)-X(:,3)-X(:,4)))));
    end

 Xemburn = Xem1(:,(50*fs_sim):N-1);  % Remove transient
 Xemburn = resample(Xemburn,fs_conv,fs_sim); % resamples has an antialiasing filtering 

end
