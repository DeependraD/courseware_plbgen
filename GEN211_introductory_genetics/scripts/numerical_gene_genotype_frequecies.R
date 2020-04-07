# Given, in a population of 10000 individuals, there is only 1 recessive phenotype
N <- 10000
freq_aa <- 1/N

# Now, frequency of non recessive types
freq_non_aa <- 1-freq_aa

# Now, gene frequency of "a"
freq_a <- sqrt(freq_aa)
freq_A <- 1 - freq_a

# Frequency of heterozygote Aa
freq_Aa <- 2 * freq_a * freq_A
freq_AA <- freq_A^2

# Frequency of AA and Aa, added
freq_AA + freq_Aa

# Alternative scheme of calculating gene frequency
# suppose the population is composed of mendel's monhybrid crosses
# in that case, gene frequency of the homozygous recessive can be derived as:

# Out of total population dominant phenotypes are
N_rec_phen <- 1
N_dom_phen <- N - 1

# Now, since the population genptype frequency is expected to have mendelian segregation,
# freq_dom_phen is composed of 1/3rd homozygous dominant and 2/3rd heterozygous dominant.
# This leads to following
freq_Aa <- (2/3 * N_dom_phen)/10000

# Here we assume, though the menden's genotypic ratios are valid for 
# Normal phenotypes, it doesn't hold for recessive phenotype. This could be assumed 
# to be the case if the recessive phenotype is lethal or sublethal in it's expression
# which is not always the case (especially, if single gene conditions body color 
# i.e. albino over normal phenotype) as these genes have weak effects on vitality.

# Since each heterozygote individual has single recessive allele out of 2
# following relation can be used to derive gene frequency of recessive allele
freq_a <- (2 * freq_aa + 1 * freq_Aa)/2
