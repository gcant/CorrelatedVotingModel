source("fitting_fns.r")
set.seed(42)

# Run on synthetic data.  Real data yet to be published
S = read.csv('data/synthetic.csv', header=FALSE)
fit_all_models(S, "synth")

