# Figure Analysis
Listed here are the various function used to create the figures presented. These are by no means optimised and require some manual input and checks to ensure the desired outcomes. Can be used as a starting point for further analysis.

# Housekeeping
##### TimeseriesIndex:
This function is used to find the indices for the best fitting simulation based on minimum Euclidean distance using the outputs saved from outputReSim. The BestFitIndex needs to be manually saved to the desired location.

##### ObjectiveScores:
Here the selected control or PTZ simulations from the saved re-simulations are loaded in and the objective scores are calculated and saved for ease of use in future analysis. Current saved scores can be found in ObjectiveScoresAll.

# Figure Plotting
##### TimeseriesPlots:
A function to plot the data, simulated timeseries, and underlying dynamics.

##### TimeseriesPlotsWaveletThreshold:
A function to plot the data, simulated timeseries, underlying dynamics, and wavelet threshold. This function makes use of code which attempts to independently select the best moving average for each timeseries. It is also possible to try and incorporate the best lambda value for each timeseries in an attempt to automatically choose values which produce the most informative plots. 

##### objAllDistribution:
Here, based on the selected options, we plot the histograms, power spectra, and cumulative distribution clustering plots. As we are exploring the stochastic distribution of the best fitting parameters, simulations are re-run here using the folder files found in the simulation folders. Hence a relevant path will need to be edited to include these files. 

##### DetObjectiveScores:
An example of calculating and normalising a specific combination of methods. In this case, we are calculating the objectives and normalising them against all other deterministic approaches. 

##### EDPlots:
This function normalises the saved objective scores against each other and then plots the heatmaps, ED boxplots, and hypervolume indicator plots to compare the included methods.

##### Boxplots:
Another example of boxplots and also violin plots for the objectives.

##### EDmethodComp:
Another example of comparing the ED boxplots and hypervolume indicators for the objectives.

##### HypervolumeIndicator:
Another example of hypervolume indicator boxplots.

##### RefinePercentile:
An approach to refine the percentile group of two objective score methods. This is done to remove any outliers for better visualisation of plots. For example, we can reduce the number of points from 250 to 200 and then normalise these scores appropriately. 

##### RefinePercentileAll:
This function builds on the RefinePercentile code and allows for any number of objectives score files to be used, reduced, and normalised appropriately for removing outliers and improved visualisation. 

##### BestFitPoint:
This function ensures that after the refine percentile process is accomplished, we maintain the index of the best fitting point. 
