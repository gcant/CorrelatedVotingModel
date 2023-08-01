source("fitting_fns.r")
set.seed(42)

S = read.csv('data/Rehnquist.csv', header=FALSE)
fit_all_models(S, "rehn")

S = read.csv('data/Roberts.csv', header=FALSE)
fit_all_models(S, "rob")

