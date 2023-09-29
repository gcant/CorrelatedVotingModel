library('rstan')
rstan_options(auto_write = TRUE)

optimize_n_tries <- function(model, data, n) {
  ans <- optimizing(model, data, hessian = TRUE, as_vector = FALSE)
  for (i in 2:n) {
    temp <- optimizing(model, data, hessian = TRUE, as_vector = FALSE)
    if (temp$value > ans$value) {
      ans <- temp
    }
  }
  return(ans)
}

Laplace_approx <- function(MAP) {
  n <- sqrt(length(MAP$hessian))
  logdet <- sum(log(-eigen(MAP$hessian)$values))
  return(MAP$value + n*0.5*log(2*pi) - 0.5*logdet)
}

fit_all_models <- function(S, out_name) {
  data <- list(num_judges=ncol(S), num_cases=nrow(S), S=S)
  map1 <- optimize_n_tries(stan_model(file = "models/model1.stan"), data, 20)
  map2 <- optimize_n_tries(stan_model(file = "models/model2.stan"), data, 20)
  map3 <- optimize_n_tries(stan_model(file = "models/model3.stan"), data, 20)
  map4 <- optimize_n_tries(stan_model(file = "models/model4.stan"), data, 20)
  samples <- extract(stan(file = "models/model3.stan", data = data, chains = 1, iter = 10000))

  params1 <- c(map1$par$H, map1$par$h)
  params2 <- map2$par$j
  params3 <- c(map3$par$H, map3$par$h, map3$par$j)
  params4 <- c(map4$par$H, map4$par$h, map4$par$j, map4$par$f)
  paramsMCMC <- cbind(samples$H, samples$h, samples$j)

  fname <- paste("out/", out_name, sep='')

  write.table(params1,    paste(fname,"MAP1.csv",sep=''), row.names=FALSE, col.names=FALSE, sep=',')
  write.table(params2,    paste(fname,"MAP2.csv",sep=''), row.names=FALSE, col.names=FALSE, sep=',')
  write.table(params3,    paste(fname,"MAP3.csv",sep=''), row.names=FALSE, col.names=FALSE, sep=',')
  write.table(params4,    paste(fname,"MAP4.csv",sep=''), row.names=FALSE, col.names=FALSE, sep=',')
  write.table(paramsMCMC, paste(fname,"MCMC.csv",sep=''), row.names=FALSE, col.names=FALSE, sep=',')

  cat("\n\nModel evidence approximations.\n\n")
  cat(paste("model 1: ", round(Laplace_approx(map1), digits=2), "\n", sep=""))
  cat(paste("model 2: ", round(Laplace_approx(map2), digits=2), "\n", sep=""))
  cat(paste("model 3: ", round(Laplace_approx(map3), digits=2), "\n", sep=""))
  cat(paste("model 4: ", round(Laplace_approx(map4), digits=2), "\n\n", sep=""))
}

