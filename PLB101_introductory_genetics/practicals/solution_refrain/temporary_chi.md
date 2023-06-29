<!-- ## Solution 2 -->

<!-- If there is _no_ linkage, that is, the genes assort independently, we have seen that the following phenotypic proportions are expected in progeny: -->

<!-- ```{r} -->
<!-- require(infer) -->
<!-- bf_df <- tribble(~"Phenotype", ~"Proportion",  -->
<!--         "BF", 230, -->
<!--         "Bf", 210, -->
<!--         "bF", 240, -->
<!--         "bf", 250) -->

<!-- bf_df_chi <- chisq.test(set_names(bf_df$Proportion, nm = bf_df$Phenotype),  -->
<!--            correct = FALSE,  -->
<!--            p = c(0.25, 0.25, 0.25, 0.25)) -->

<!-- bf_df_chi %>%  -->
<!--   broom::tidy() %>%  -->
<!--   knitr::kable(booktabs = TRUE, longtable = TRUE) %>%  -->
<!--   kableExtra::kable_styling(position = "center", font_size = 8) -->

<!-- observed_statistic <- bf_df %>%  -->
<!--   transmute(sim_category = map2(Proportion, Phenotype, ~rep(.y, .x))) %>%  -->
<!--   unnest(sim_category) %>%  -->
<!--   specify(response = sim_category)  %>%  -->
<!--   hypothesize(null = "point",  -->
<!--               p = c("BF" = 1/4, -->
<!--                     "Bf" = 1/4, -->
<!--                     "bF" = 1/4, -->
<!--                     "bf" = 1/4)) %>%  -->
<!--   calculate(stat = "Chisq") -->

<!-- observed_pvalue <- bf_df %>%  -->
<!--   transmute(sim_category = map2(Proportion, Phenotype, ~rep(.y, .x))) %>%  -->
<!--   unnest(sim_category) %>%  -->
<!--   specify(response = sim_category)  %>%  -->
<!--   hypothesize(null = "point",  -->
<!--               p = c("BF" = 1/4, -->
<!--                     "Bf" = 1/4, -->
<!--                     "bF" = 1/4, -->
<!--                     "bf" = 1/4)) %>%  -->
<!--   generate(reps = 100, type = "simulate") %>% -->
<!--   calculate(stat = "Chisq") %>% -->
<!--   # visualise() %>%  -->
<!--   get_p_value(obs_stat = observed_statistic, direction = "greater") -->

<!-- ``` -->

<!-- There is clearly a deviation from the absolute expected proportion, which is the case of having no linkage between genes. -->

<!-- However, we know that chance deviations can provide results that resemble those produced by genetic processes; hence we, need the $\chi^2$ test to help calculate the probability of a chance deviation of this magnitude form a 1:1:1:1 ratio. If that hypothesis is rejected, we can infer linkage. -->

<!-- The test statisic $\chi^2$ is obtained by: -->

<!-- $$ -->
<!-- \chi^2 = \frac{\left[\sum|observed-expected|-\frac{1}{2}\right]^2}{expected} -->
<!-- $$ -->


<!-- ```{r chi-sqrt-linkage, message=FALSE, warning=FALSE, echo=FALSE} -->
<!-- chi_sqrt_linkage <- tribble(~"Phenotype", ~"Proportion",  -->
<!--         "BF", 0.25, -->
<!--         "Bf", 0.25, -->
<!--         "bF", 0.25, -->
<!--         "bf", 0.25) -->

<!-- chi_sqrt_linkage %>%  -->
<!--   kable(booktabs = TRUE, escape = FALSE,  -->
<!--       caption = "Chi-square calculations for the hypothesis that the observations of four phenotypic classes is obtained due to no linkage between loci B and F.", longtable = TRUE) %>%  -->
<!--   kableExtra::kable_styling(latex_options = "striped", font_size = 8) -->
<!-- ``` -->


<!-- ```{r chi-sqrt-values, echo=FALSE, message=FALSE} -->
<!-- # Set p-values -->
<!-- p <- c(0.995, 0.99, 0.975, 0.95, 0.90, 0.10, 0.05, 0.025, 0.01, 0.005) -->
<!-- # Set degrees of freedom -->
<!-- df <- c(seq(1,20),25,30,35,40,50,100) -->
<!-- # Calculate a matrix of chisq statistics -->
<!-- m <- outer(p, df, function(x,y) qchisq(x,y)) -->
<!-- # Transpose for a better view -->
<!-- m <- t(m) -->
<!-- # Set column and row names -->
<!-- colnames(m) <- rev(p) -->
<!-- rownames(m) <- df -->
<!-- kable(m, format = "latex", booktabs = TRUE, escape = TRUE,  -->
<!--       caption = "The probabilities of exceeding different chi-square values for degrees of freedom from 1 to 50 when the expected hypothesis is true") %>%  -->
<!--   kableExtra::kable_styling(latex_options = "striped", font_size = 5) %>%  -->
<!--   kableExtra::column_spec(6, border_left = TRUE) -->
<!-- ``` -->

<!-- Since there are four genotypic classes, we must use 4-1 = 3 degrees of freedom. Consulting the $\chi^2$ table, we see our values of `r observed_statistic[[1]]` and 3 df give a p value of `r observed_pvalue[[1]]`. This is more than the standard cut-off value of 5 %, so we cannot reject the hypothesis of no linkage. -->

<!-- Hence, we are left with the conclusion that the genes are not linked. -->
