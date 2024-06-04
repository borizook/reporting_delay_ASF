# Stan Model for Report Delay
This repository contains a Stan model for analyzing report delay data using a mixture of distributions: Weibull, Gamma, and Lognormal. The model aims to estimate the parameters of these distributions and their weights in the mixture.

## Data
The model requires the following data:

N: Integer, the number of observations.
report_delay[N]: Real array, the observed report delays.

## Parameters
The model estimates the following parameters:

sd_delay: Standard deviation of the delay (positive real).
param1_weibull: Shape parameter for the Weibull distribution (positive real).
weight: Simplex of length 3, representing the weights of the three distributions in the mixture.

## Transformed Parameters
The model computes several transformed parameters:

param1_delay[3]: Shape parameters for the Gamma, Weibull, and Lognormal distributions.
param2_delay[3]: Scale parameters for the Gamma, Weibull, and Lognormal distributions.
mean_delay: Mean of the delay, computed from sd_delay and param1_weibull.
lps[3]: Log probabilities for each distribution in the mixture.
