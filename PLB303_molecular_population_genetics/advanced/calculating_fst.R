# Function to calculate Fst
calc.Fst <- function(af){
  # determine length of allele frequency vector
  n<-length(af)
  
  # calculate H_s
  # need to calculate expected heterozygosity for each subpopulation
  # which is 2pq for each given allele frequency
  H_s <- sum(2*af*(1-af))/n
  
  # calculate H_t
  p_hat <- sum(af)/n
  H_t <- 2*p_hat*(1-p_hat)
  
  # calculate F_st
  F_st <- (H_t - H_s)/H_t
  
  # print and return the answer
  print(paste0("your F_st is: ", F_st))
  #return(F_st) # include if you need this number
}

# Population 1
pop1_mouse <- c(0,0,0,0,0,1,1,1,1,1)

# Population 2
pop2_flower <- c(0.573, 0.504, 0.717, 0.657, 0.302, 0.339,
                 0.032, 0.007, 0.008, 0.005, 0.009, 0, 0, 0, 0, 0.005, 0.010, 0, 0, 0.004, 0.126, 0.068, 0.002, 0, 0, 0,
                 0.106, 0.224, 0.411, 0.014)
# Population 3
pop3_allsame_freq <- c(0.453, 0.453, 0.453, 0.453, 0.453, 0.453, 0.453, 0.453, 
                       0.453, 0.453, 0.453, 0.453, 0.453, 0.453, 0.453, 0.453, 
                       0.453, 0.453, 0.453, 0.453, 0.453, 0.453, 0.453, 0.453)

purrr::walk(list(pop1_mouse, pop2_flower, pop3_allsame_freq), calc.Fst)

# # The F_st statistic compares the heterozygosity of subpopulations to the heterozygosity of the total population. 
#
# * In the mouse example, the mice of AA and aa are kept separate. Thus there is 0 heterozygosity, so H_s is 0, making the F_st statistic H_t / H_t = 1. A F_st of 1 means that the heterozygosity in the subpopulation is super small, and in this example there is no possibility of heterozygosity, so an F_st of 1 is expected.  
# * In the flower example, there are a couple different substructures, so we expect the F_st to be somewhere between 0 and 1. Also note there are quite a few subpopulations with 0 heterozygosity, so we expect the F_st to be closer to 0 than 1. The resulting .399 fulfills this.  
# * In the same frequency example, every subpopulation has the same heterozygosity as the total population, so H_s munus H_t will result in a 0 numerator. 0 means there is 'little to no population substructure,' and in this example there are no substructures (the subpop are the same as the large pop), so 0 is what we'd expect. 