data {
    int<lower = 1> N;
    real<lower = 1> report_delay[N];
}
parameters {
  real<lower = 0> sd_delay; 
  real<lower = 0> param1_weibull; 
  simplex[3] weight; 
}


transformed parameters {
  vector<lower = 0>[3] param1_delay;
  vector<lower = 0>[3] param2_delay; 
  real<lower = 0.1> mean_delay = sd_delay / sqrt(tgamma(1 + 2 / param1_weibull) - square(tgamma(1.0 + 1.0 / param1_weibull))) * tgamma(1 + 1 / param1_weibull); 
  vector[3] lps = log(weight);


  // Weibull distribution
  param1_delay[2] = param1_weibull;
  param2_delay[2] = sd_delay / sqrt(tgamma(1 + 2 / param1_weibull) - square(tgamma(1.0 + 1.0 / param1_weibull)));

  // Gamma distribution
  param1_delay[1] = square(mean_delay) / square(sd_delay);
  param2_delay[1] = mean_delay / square(sd_delay);
  
  // Lognormal distribution
  param2_delay[3] = sqrt(log((square(sd_delay)/mean_delay) * exp(-2) + 1)); 
  param1_delay[3] = log(mean_delay) - square(param2_delay[3]) / 2;
  

  lps[1] += gamma_lpdf(report_delay| param1_delay[1], param2_delay[1]);  
  lps[2] += weibull_lpdf(report_delay| param1_delay[2], param2_delay[2]); 
  lps[3] += lognormal_lpdf(report_delay| param1_delay[3], param2_delay[3]); 
}

model {
  sd_delay ~ uniform(0, 100);
  param1_weibull ~ uniform(0, 100);
  target += log_sum_exp(lps);
}