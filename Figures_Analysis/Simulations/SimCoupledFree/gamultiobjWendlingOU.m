function [Xemburn,ca,t,t3,Nn_conv,fs_conv] = gamultiobjWendlingOU(T, params1)

%%%simulation%%%

%A function to simulate a network of neuron populations following the model of
%Wendling

fs_sim = 1000; %convolution sampling frequency
dt = 1/fs_sim; % seconds per sample 
N=T*fs_sim; %PS this is time measured in points
t=linspace(0,T,N);

X = params1(33:end);
OU1 = params1(31);
OU2 = params1(32);

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

    dW1 = sqrt(dt)*randn(1,N);
    dW2 = sqrt(dt)*randn(1,N);
    
params = struct('A', [params1(1), params1(16)], ...
                'a', [params1(2), params1(17)], ...
                'B', [params1(3), params1(18)], ...
                'b', [params1(4), params1(19)], ...
                'G', [params1(5), params1(20)], ...
                'g', [params1(6), params1(21)], ...
                'Cvec', [params1(7), params1(22)], ...
                'P', [params1(8), params1(23)], ...
                'r', [params1(9), params1(24)], ...
                'v0', [params1(10), params1(25)], ...
                'e0', [params1(11), params1(26)], ...
                'ss', [params1(12), params1(27)], ...
                'K', [params1(13), params1(28)], ...
                'tau', [params1(14), params1(29)], ...
                'D', [params1(15), params1(30)]);

C1=[params.Cvec(1), params.Cvec(2)];
C2=[0.8*params.Cvec(1), 0.8*params.Cvec(2)];
C3=[0.25*params.Cvec(1), 0.25*params.Cvec(2)];
C4=[0.25*params.Cvec(1), 0.25*params.Cvec(2)];
C5=[0.3*params.Cvec(1), 0.3*params.Cvec(2)];
C6=[0.1*params.Cvec(1), 0.1*params.Cvec(2)];
C7=[0.8*params.Cvec(1), 0.8*params.Cvec(2)];

a2 = [params.a(1)^2, params.a(2)^2];
Aa = [params.a(1)*params.A(1), params.a(2)*params.A(2)];
Bb = [params.b(1)*params.B(1), params.b(2)*params.B(2)];
b2 = [params.b(1)^2, params.b(2)^2];
g2 = [params.g(1)^2, params.g(2)^2];
Gg = [params.G(1)*params.g(1), params.G(2)*params.g(2)];
    
    Xem1 = zeros(1,length(t));
    Xem2 = zeros(1,length(t));
    
    for j = 1:length(t) 
        
    Xem1(:,j) = X(:,2) - X(:,3) - X(:,4);  % Membrane potential output
    Xem2(:,j) = X(:,12) - X(:,13) - X(:,14);  % Membrane potential output
        
    OU1(:,1) = OU1(:,1) - (OU1(:,1)/params.tau(1))*dt + (sqrt(2*params.D(1))/params.tau(1))*dW1(:,j); 
    OU2(:,1) = OU2(:,1) - (OU2(:,1)/params.tau(2))*dt + (sqrt(2*params.D(2))/params.tau(2))*dW2(:,j); 
    
    % Column 1
    
    X(:,1) = X(:,1) + X(:,6)*dt;
    X(:,2) = X(:,2) + X(:,7)*dt;
    X(:,3) = X(:,3) + X(:,8)*dt;
    X(:,4) = X(:,4) + X(:,9)*dt;
    X(:,5) = X(:,5) + X(:,10)*dt;
    X(:,6) = X(:,6) + (Aa(1)*(2*params.e0(1)./(1+exp(params.r(1)*(params.v0(1)-(X(:,2)-X(:,3)-X(:,4)))))) - 2*params.a(1)*X(:,6) - X(:,1)*a2(1))*dt;
    X(:,7) = X(:,7) + (Aa(1)*(params.P(1)+C2(1)*2*params.e0(1)./(1+exp(params.r(1)*(params.v0(1)-(C1(1)*X(:,1))))) + params.K(2)*Xem2(:,j)) - 2*params.a(1)*X(:,7) - X(:,2)*a2(1))*dt + Aa(1)*params.ss(1)*OU1(:,1);
    ev = 2*params.e0(1)./(1+exp(params.r(1)*(params.v0(1)-(C3(1)*X(:,1)))));
    X(:,8) = X(:,8) + (Bb(1)*(C4(1)*ev) - 2*params.b(1)*X(:,8) - X(:,3)*b2(1))*dt;
    X(:,9) = X(:,9) + (Gg(1)*C7(1)*(2*params.e0(1)./(1+exp(params.r(1)*(params.v0(1)-(C5(1)*X(:,1)-X(:,5)))))) - 2*params.g(1)*X(:,9) - X(:,4)*g2(1))*dt;
    X(:,10) = X(:,10) + (Bb(1)*(C6(1)*ev) - 2*params.b(1)*X(:,10) - X(:,5)*b2(1))*dt;
    
    % Column 2
    
    X(:,11) = X(:,11) + X(:,16)*dt;
    X(:,12) = X(:,12) + X(:,17)*dt;
    X(:,13) = X(:,13) + X(:,18)*dt;
    X(:,14) = X(:,14) + X(:,19)*dt;
    X(:,15) = X(:,15) + X(:,20)*dt;
    X(:,16) = X(:,16) + (Aa(2)*(2*params.e0(2)./(1+exp(params.r(2)*(params.v0(2)-(X(:,12)-X(:,13)-X(:,14)))))) - 2*params.a(2)*X(:,16) - X(:,11)*a2(2))*dt;
    X(:,17) = X(:,17) + (Aa(2)*(params.P(2)+C2(2)*2*params.e0(2)./(1+exp(params.r(2)*(params.v0(2)-(C1(2)*X(:,11))))) + params.K(1)*Xem1(:,j)) - 2*params.a(2)*X(:,17) - X(:,12)*a2(2))*dt + Aa(2)*params.ss(2)*OU2(:,1);
    ev = 2*params.e0(2)./(1+exp(params.r(2)*(params.v0(2)-(C3(2)*X(:,11)))));
    X(:,18) = X(:,18) + (Bb(2)*(C4(2)*ev) - 2*params.b(2)*X(:,18) - X(:,13)*b2(2))*dt;
    X(:,19) = X(:,19) + (Gg(2)*C7(2)*(2*params.e0(2)./(1+exp(params.r(2)*(params.v0(2)-(C5(2)*X(:,11)-X(:,15)))))) - 2*params.g(2)*X(:,19) - X(:,14)*g2(2))*dt;
    X(:,20) = X(:,20) + (Bb(2)*(C6(2)*ev) - 2*params.b(2)*X(:,20) - X(:,15)*b2(2))*dt;
    
     Xem1(:,j) = X(:,2) - X(:,3) - X(:,4); 
     Xem2(:,j) = X(:,12) - X(:,13) - X(:,14);  % Membrane potential output
     
    end

 Xemburn = Xem1(:,(50*fs_sim):N-1);  % Remove transient
 Xemburn = resample(Xemburn,fs_conv,fs_sim); % resamples has an antialiasing filtering 

end
