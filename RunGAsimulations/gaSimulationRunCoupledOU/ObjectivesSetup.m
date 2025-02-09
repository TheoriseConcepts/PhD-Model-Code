function objectivesOut = ObjectivesSetup(x,Objectives)

PSDout=[]; HVGout=[]; CCout=[];

%% PSD

found_psd = false;  % Initialize a flag variable to track whether "PSD" is found

% Loop over each element in the cell array and compare with "PSD"
for i = 1:numel(Objectives)
    if strcmp(Objectives{i}, 'PSD')
        found_psd = true;  % Update the flag variable if "PSD" is found
        break;  % Exit the loop early since we found "PSD"
    end
end
% Check the flag variable and calculate PSD if "PSD" is found
if found_psd
fhz = 20;   %frequency 20hz
[pxx,f] = pwelch(x,[],[],[],fhz);
idx_10Hz_ds=find(f>=0.5,1,'first');
pxx = pxx(1:idx_10Hz_ds,1);
PSDout = pxx/sum(pxx);  %normalise
end


%% HVG

found_hvg = false;  % Initialize a flag variable to track whether "HVG" is found

% Loop over each element in the cell array and compare with "HVG"
for i = 1:numel(Objectives)
    if strcmp(Objectives{i}, 'HVG')
        found_hvg = true;  % Update the flag variable if "HVG" is found
        break;  % Exit the loop early since we found "HVG"
    end
end
% Check the flag variable and calculate HVG if "HVG" is found
if found_hvg
TDat=1:length(x); % x axis
vgDat= fast_HVG(x, TDat, 'w'); %wHVG
vg2Dat=full(vgDat); % convert to full matrix
HVGout=sum(vg2Dat);
end

%% CCb

found_ccb = false;  % Initialize a flag variable to track whether "CCb" is found

% Loop over each element in the cell array and compare with "CCb"
for i = 1:numel(Objectives)
    if strcmp(Objectives{i}, 'CCb')
        found_ccb = true;  % Update the flag variable if "CCb" is found
        break;  % Exit the loop early since we found "CCb"
    end
end
% Check the flag variable and calculate CCb if "CCb" is found
if found_ccb
vgDat2= fast_HVG(x, TDat, 'u'); %HVG
vg2Dat2=full(vgDat2); % convert to full matrix
CCout = clustering_coef_bu(vg2Dat2);
end


objectivesOut = {PSDout;HVGout;CCout};

end
