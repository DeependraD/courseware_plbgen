# simulating gain from recurrent selection
# https://www.youtube.com/watch?v=_QpHdKOXA6g
# A practical guide to genetic gain. Advances in Agronomy, Jessica Rutkoski

require(tidyverse)

simusel <- function(nsim = 10, ngen = 3, n = 100, h2 = 0.5, Vg = 1, nsel = 30) {
  r <- sqrt(h2)
  p <- nsel/n
  
  i <- dnorm(qnorm(p))/p
  Ve <- Vg/h2 - Vg
  stdG <- sqrt(Vg)
  stdE <- sqrt(Ve)
  succ_all <- c()
  for(j in 1:nsim){
    mn <- 0
    g <- rnorm(n, sd = stdG)
    e <- rnorm(n, sd = stdE)
    p <- g + e
    val0 <- g[which.max(p)]
    succ <- c()
    for(i in 1:c(ngen-1)){
      mn <- mn + c(stdG*i*r)
      g <- rnorm(n, mean = mn, sd = stdG)
      e <- rnorm(n, sd = stdE)
      p <- g + e
      val <- g[which.max(p)]
      suc <- val>val0
      if(suc){
        val0 <- val
      }
      succ <- append(succ, suc)
    }
    succ_all <- append(succ_all, !FALSE %in% succ)
  }
  prob_success <- sum(succ_all)/nsim
  return(prob_success)
}

number_of_cycles <- set_names(c(2, 3, 4, 5, 7, 10, 15, 25),
                              paste0("C", c(2, 3, 4, 5, 7, 10, 15, 25)))
heritability_values <- c(0.00001, 0.1, 0.2, 0.25, 0.4, 0.5, 0.65, 0.8, 0.95)


map_dfr(number_of_cycles, function(x){
  map_dbl(heritability_values, function(y){
    simusel(h2 = y, nsim = 200, ngen = x)
    })}) %>% 
  add_column(.before = 1, heritability = heritability_values)
