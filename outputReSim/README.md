# outputReSim*

This code is used to find the top nth percentile simulations based on the outputs from 50 runs of the gaSimulationRun* code. All objectives scores acquired from running the genetic algorithm are normalised, then the best fitting objective scores are found based on minimum Euclidean distance and using a quick sort algorithm. We then take the parameter combinations from these best fits and rerun the observation model simulation 50 times to ensure stability. This accounts for any random fits that may have been found due specific initial conditions or noise in the system. The simulation outputs and underlying dynamics are then saved for further analysis.

# outAnalysisControl/PTZ:
This function is used to initiate the re-simulation process. For control data nn = 1:8 and for PTZ data nn = 9:16. The SLURM_JOB_ID can be any random number. The relevant output files are then imported and the objective scores are normalised. The Euclidean distance is then calculated and in the line, “X = prctile(indx(:,1),10);” the percentile number you want to explore can be set, default 10th percentile. The data is then processed in the same format as with the genetic algorithm simulations. ObjFit is then initiated to run the simulations and calculate new fitness scores.  

# ObjFitControl/PTZ:
Here we take the best fitting parameter combinations as determined by the top Euclidean distance percentile. These parameters are then used to run our Wendling simulation 50 times for which the objectives scores are calculated for each output. We then determine the best fitting simulation output from these 50 runs and save the simulation and underlying dynamics. This is done for each parameter combination to determine the stability of the simulation for each set of parameters as well as finding the best fitting simulation. 

# SimulationRun*:
Here we setup the function to simulate our neural mass Wendling model. 

# InterpenSignalsControlPTZ:
Data used for fitting. 8 control and 8 PTZ fluorescence intensity timeseries taken from the interpeduncular nucleus region.
