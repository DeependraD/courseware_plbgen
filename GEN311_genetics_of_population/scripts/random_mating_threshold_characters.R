# Suppose there are parental types with differences in each of the two allele pairs

# A cross between such parents produces heterozygous individuals with alleles differing in both the homologue of a pair, 
# The sole genotype resultant of such cross, when produces gametes following types are possible:

gamete_types <- expand.grid(c("A", "a"), 
                            c("B", "b"), 
                            c("C", "c"), 
                            c("D", "d")) %>% 
  unite(col = "gamete_types", sep = "") %>% 
  pull("gamete_types")

# When random mating of gametes occurs following combinations are observed
combination_genotypes <- crossing(gamete_types, gamete_types) %>% 
  # group_by(gamete_types)
  unite(col = "genotype", remove = FALSE, sep = "") %>% 
  spread(key = gamete_types1, value = genotype)

genotype_orderer <- function(x){
  map_chr(x, function(y){
    str_extract_all(y, "") %>% 
      unlist() %>% 
      str_sort(decreasing = FALSE) %>% 
      paste0(collapse = "")
  })
}

combination_genotypes <- combination_genotypes %>% 
  mutate_all(list(~genotype_orderer(.)))

# However, unique genotypes discoverable in F2 are:
ca <- c("AA", "Aa", "aa")
cb <- c("BB", "Bb", "bb")
cc <- c("CC", "Cc", "cc")
cd <- c("DD", "Dd", "dd")
unique_genotypes <- expand.grid(ca, cb, cc, cd) %>%
  unite(col = "all_gametes", sep = "") %>%
  pull(all_gametes) %>%
  unique()

# To visualize all such possible gametic combinations in F2 and addressing that the characters expressed are threshold, 
# we parametrize the 2 phenotypes as two colors
# manually specify colors
two_colors <- c("#802acc", "#a8a035")

# Specify function to count the number of alleles (based on dominance action of such threshold character)
# small case = recessive threshold character
# capital case = dominant threshold character
fanta <- function(x)(stringi::stri_extract_all_regex(x, ".") %>%
                       map(unlist) %>%
                       map_int(~str_detect(.x, "[a-z]") %>%
                                 sum()))

# A case when more than or equal to 6 alleles would produce threshold character
combination_genotypes %>%
  rename("Gamete types" = gamete_types) %>% 
  mutate_at(2:17, list(~case_when(
    fanta(.) < 6 ~ 0, # less than six
    fanta(.) > 6 | fanta(.) == 6 ~ 1, # six or more
    TRUE ~ NA_real_
  ))) %>% 
  gather(key = "Gamete types2", value = "threshold_positive", -`Gamete types`) %>% 
  group_by(threshold_positive) %>%
  # summarise(n = n())
  count(threshold_positive) # this is alternative to above

# What if the original parental genotypes composition were otherwise
# suppose threshold characters are expressed when at least 5 alleles are present in the genotype
# suppose genotype_f = AABBCCdd, and genotype_m = aabbccDD
# don't use heterozygote in a parent, because parental types are always assumed to be pure breeding types
# still then, F1 is normal with less alleles in the heterozygote than required to express threshold character
gamete_types_m <- expand.grid(c("A", "a"), 
                              c("B", "b"), 
                              c("C", "c"), 
                              c("D", "d")) %>% 
  unite(col = "gamete_types", sep = "") %>% 
  pull("gamete_types")

gamete_types_f <- expand.grid(c("A", "a"), 
                              c("B", "b"), 
                              c("C", "c"), 
                              c("D", "d")) %>% 
  unite(col = "gamete_types", sep = "") %>% 
  pull("gamete_types")

# When random mating of gametes occurs following combinations are observed
combination_genotypes <- crossing(gamete_types_f, gamete_types_m) %>% 
  # group_by(gamete_types)
  unite(col = "genotype", remove = FALSE, sep = "") %>% 
  spread(key = gamete_types_m, value = genotype)

## these genotypes are essentially the same as that when parental types were differing for all allele composition

# However, what is the consequence of test cross instead of selfing of F1 here?

# To visualize all such possible gametic combinations in a test cross 
# and addressing that the characters expressed are threshold, 
# we parametrize the 2 phenotypes as two colors
# manually specify colors
two_colors <- c("#802acc", "#a8a035")

# Now, random union of gametes in the test above can be simulated as (suppose male parent is the tester):
gamete_types_f <- expand.grid(c("A", "a"), 
                              c("B", "b"), 
                              c("C", "c"), 
                              c("D", "d")) %>% 
  unite(col = "gamete_types", sep = "") %>% 
  group_by(gamete_types) %>% 
  count() %>% 
  ungroup()

gamete_types_m <- expand.grid(c("a", "a"), 
                              c("b", "b"), 
                              c("c", "c"), 
                              c("D", "D")) %>% 
  unite(col = "gamete_types", sep = "") %>%
  group_by(gamete_types) %>% 
  count() %>% 
  ungroup()

## only one gametic type is possible for male tester parent

## Simulating the cross:

# When random mating of gametes occurs following combinations are observed
combination_genotypes <- crossing(gamete1 = gamete_types_f$gamete_types, 
                                  gamete2 = gamete_types_m$gamete_types) %>% 
  # group_by(gamete_types)
  unite(col = "genotype", remove = FALSE, sep = "") %>% 
  spread(key = gamete1, value = genotype)

genotype_orderer <- function(x){
  map_chr(x, function(y){
    str_extract_all(y, "") %>% 
      unlist() %>% 
      str_sort(decreasing = FALSE) %>% 
      paste0(collapse = "")
  })
}

combination_genotypes <- combination_genotypes %>% 
  mutate_all(list(~genotype_orderer(.)))

# Specify function to count the number of alleles (based on dominance action of such threshold character)
# small case = recessive threshold character
# capital case = dominant threshold character
fanta <- function(x)(stringi::stri_extract_all_regex(x, ".") %>%
                       map(unlist) %>%
                       map_int(~str_detect(.x, "[a-z]") %>%
                                 sum()))

# A case when more than or equal to 6 alleles would produce threshold character
combination_genotypes %>%
  rename("Gamete types" = gamete2) %>% 
  mutate_at(2:17, list(~case_when(
    fanta(.) < 5 ~ 0, # less than six
    fanta(.) > 5 | fanta(.) == 5 ~ 1, # five or more
    TRUE ~ NA_real_
  ))) %>% 
  gather(key = "Gamete types2", value = "threshold_positive", -`Gamete types`) %>% 
  group_by(threshold_positive) %>%
  # summarise(n = n())
  count(threshold_positive)
