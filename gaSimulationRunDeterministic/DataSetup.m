function [data,T,indx,h] = DataSetup(DataType,nn)

%% Control
if strcmp('Control',DataType)

DataSignals = importdata('InterpenSignalsControlPTZ.mat');  % Matt Winter Control and PTZ Data
                                                            % 200 points = 375 seconds                                                            
t = 50*1.875 : 1.875 : 149*1.875; % Use middle section of data and adjust time for 1.875hz sampling frequency
tt=t(1):(1/20):t(end); % Adjusting to 20hz sampling frequncy to increase data points for analysis and matched 
                       % caclium convolution sampling frequecny

h = ceil(nn/50); % nn is the job number input, 1:50 = Control1, 51:100 = Control2, etc.
Control = DataSignals.ControlPTZ(h,50:149); % Sets PTZ as the data number to be simulated
Control = interp1(t,Control,tt, 'spline'); % Interpolates the data to increase number of points for analysis

data = Control - mean(Control); % mean centre data
T = 315.85; % set time used in simulation
indx = mod(nn,50); % index value of data run, 1:50
indx(indx == 0) = 50;


%% PTZ
elseif strcmp('PTZ',DataType)
    
DataSignals = importdata('InterpenSignalsControlPTZ.mat');  % Matt Winter Control and PTZ Data
                                                            % 200 points = 375 seconds                                                            
t = 50*1.875 : 1.875 : 149*1.875; % Use middle section of data and adjust time for 1.875hz sampling frequency
tt=t(1):(1/20):t(end); % Adjusting to 20hz sampling frequncy to increase data points for analysis and matched 
                       % caclium convolution sampling frequecny

h = ceil(nn/50); % nn is the job number input, 401:450 = PTZ1, 451:500 = PTZ2, etc.
PTZ = DataSignals.PTZ(h-8,50:149); % Sets PTZ as the data number to be simulated
PTZ = interp1(t,PTZ,tt, 'spline'); % Interpolates the data to increase number of points for analysis

data = PTZ - mean(PTZ); % mean centre data
T = 315.85; % set time used in simulation
indx = mod(nn-400,50); % index value of data run, 1:50
indx(indx == 0) = 50;

end