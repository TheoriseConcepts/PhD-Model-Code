# gaSimulationRunDeterministic
This code is used to run a multi-objective genetic algorithm simulation of a single neural mass deterministic Wendling model, fitting to zebrafish fluorescence intensity recordings for control and PTZ exposed data. This is done using a Latin Hypercube to set the parameter priors which are then iteratively tuned through the genetic algorithm fitting procedure. For the multi-objective fitting process, one, two, or three objectives can be considered using the current setup.
The key input required is a data vector containing the time series data that you want to simulate. It is then possible to select the number of objectives used in the multi-objective fitting process. Through this setup it is easy to edit the number of objectives as well as the timeseries objectives being considered. This code is designed to run in parallel on a HPC setup hence the inclusion of SLURM_JOB_ID to ensure randomness in initial conditions or other potential stochastic elements. 
# Housekeeping
##### DataSetup: 
Here we import the data that is being simulated. It is necessary to process the data such that the desired length that we want to simulate is included. It is also import to ensure that the data is at the correct sampling frequency for analysis. Here we match the calcium convolution sampling frequency. 
##### ParamsSetup:
Parameter ranges can be changed as desired. Included are an extended parameter range in order to allow the genetic algorithm and Latin Hypercube search over a large, potentially biologically infeasible space to see what dynamics can be produced and considered a good fit. Additionally, there is a Lauric parameter range which are the ranges determined in literature to produce biologically feasible dynamics in the model. If there is reason to restrict certain parameters in order to see how individual or groups of parameters affect the fit, new ranges or edits can be added or made here.
##### ObjectivesSetup:
This function can be setup to read the desired objectives and calculate the relevant objective scores for the input data or simulation. Additional objectives can be added to this function such that alternative combinations can be used. In the current setup, it is important to note that the order of objectives is vital for future code sections. For example, in the objectiveOut cell below, the PSD objective is always considered to be the first cell value, then wHVG, followed by the CCbu. 
objectivesOut = {PSDout;HVGout;CCout};

##### coder_commands: 
To optimise the run time of the genetic algorithm simulation, we use a MEX function to speed up the computationally expensive simulation. We setup two vectors that account for the simulation inputs, time and initial parameters and conditions. Code is generated for the chosen function. Need to run this function first.
##### make_slurm_jobs:
Edit as required depending on HPC setup to create jobs and run code in parallel. 
##### gaMain:
``` 
% Objectives = {'PSD'};
Objectives = {'PSD','HVG'};
% Objectives = {'PSD','HVG','CCb'};
if any(nn==1:400)
SimOptions = {'Control','Det','Extended',Objectives}; % nn = 1:400
elseif any(nn==401:800)
SimOptions = {'PTZ','Det','Extended',Objectives}; % nn = 401:800
End 
```

Select the objective combination desired. Either 1, 2, or 3 objectives can be used here. Combination are setup as used, but can be edited. Additionally, in the SimOptions line, ‘Extended’ can be changed to ‘Lauric’ to switch between extended parameter ranges or biologically feasible parameter ranges from literature.  

##### create_lhc_theo:
In this file you can assign the size of the Latin Hypercube parameter space to search over. A Latin Hypercube is then generated using the initial lower and upper bounds from ParamsSetup. Each iteration of the genetic algorithm generates a new Latin Hyper, p1. 

# Required Functions
##### for_coder1:
The conditions and output that are being used in the MEX function are found and can be edited here.
##### gamultiobjWendling:
Here we setup the function to simulate our neural mass Wendling model. 
##### gamultiobjWendling_mg:
This function separates the running of our MEX file, taking the required inputs and outputs, then initiating the post processing of the simulated signal.
##### gamultiobjWendling_post:
Post processing is applied to the simulation output in order to match our observation model which follows any necessary procedures to match the data being fit to. In this instance, we apply a calcium convolution, downsample the signal, apply a Gaussian filter, apply a bandpass filter, then zscore the signal. 
##### lhsdesign_scale_theo:
Function used to design Latin Hypercube
##### ObjFit:
Based on the parameters to be tested for each genetic algorithm run, this function is used to calculate the simulation objective score. Taking into account the number of objectives that are used for the fitting process, 1, 2, or 3, this function initiates the simulation run with gamultiobjWendling_mg and then calculates the resultant objective scores using ObjectivesSetup. Any objective scores that contain NaNs are set to be poor fits to the data, and a mean fitness vector is then built with the remaining scores. 
##### setparsdefault:
Here we define the initial parameter vector for testing in the genetic algorithm using the defined lower and upper bounds as well as the nominal values.
##### resetparsdefault:
This function resets the bounds and parameters to default settings. 
##### InterpenSignalsControlPTZ:
Data used for fitting. 8 control and 8 PTZ fluorescence intensity timeseries taken from the interpeduncular nucleus region.

# gaSimulationRunStochastic
Building on the previous code, this is used to run a multi-objective genetic algorithm simulation of a single neural mass stochastic Wendling model for white noise and Ornstein-Uhlenbeck noise. Functions here operate the same as with the deterministic case. Files that contain information that is specific to one type of noise are labelled accordingly. For example, increased numbers of parameters and initial conditions need to be accounted for.

# gaSimlationRunCoupled
In gamultiobjWendling*_mg, we include a check to see if the simulation solution is exponentially increasing or decreasing and set it to a poor fit. This is required since after we apply a calcium convolution and filtering to the signal, the observation model output can sometimes be mistaken as a good fit. 
