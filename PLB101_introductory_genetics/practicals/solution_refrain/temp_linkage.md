<!-- ## Solution 5 -->

<!-- ```{r} -->
<!-- colnames <- c("A", "B", "C", "D") %>% combn(2) %>%  -->
<!--   as_tibble() %>%  -->
<!--   summarise_all(function(x)paste0(x, collapse = "_")) %>%  -->
<!--   unlist() %>%  -->
<!--   unname() -->

<!-- progenies <- progenies %>%  -->
<!--   mutate(combinations = map(`Progeny type`, function(x)unlist(str_extract_all(x, "")))) %>%  -->
<!--   mutate(combinations = map(combinations, ~combn(.x, 2))) %>%  -->
<!--   # pull(combinations) %>%  -->
<!--   mutate(combinations = map(combinations, ~.x %>%  -->
<!--                               as_tibble() %>%  -->
<!--                               summarise_all(function(x)paste0(x, collapse = "_")) %>%  -->
<!--                               unlist())) %>%  -->
<!--   unnest() %>%  -->
<!--   group_by(`Progeny type`) %>%  -->
<!--   mutate(row_num_id = seq_along(`Progeny type`)) %>%  -->
<!--   spread(key = `row_num_id`, value = combinations) %>%  -->
<!--   magrittr::set_colnames(c("Progeny type", "Numbers", colnames)) %>%  -->
<!--   ungroup() -->

<!-- progenies_recomb <- progenies %>%  -->
<!--   mutate_at(vars(`A_B`:`C_D`), list(~case_when( -->
<!--     str_detect(., c("A\\_B|a\\_b")) ~ FALSE, # parental type specification -->
<!--     str_detect(., c("A\\_c|a\\_C")) ~ FALSE, -->
<!--     str_detect(., c("A\\_d|a\\_D")) ~ FALSE, -->
<!--     str_detect(., c("B\\_c|b\\_C")) ~ FALSE, -->
<!--     str_detect(., c("B\\_d|b\\_D")) ~ FALSE, -->
<!--     str_detect(., c("C\\_d|C\\_D")) ~ FALSE -->
<!--   ))) %>%  -->
<!--   gather(key = recomb_loci, value = recomb_status, -Numbers, -`Progeny type`) %>%  -->
<!--   filter(is.na(recomb_status)) %>%  -->
<!--   group_by(recomb_loci) %>%  -->
<!--   summarise(recombinants = sum(Numbers)) -->

<!-- progenies_total <- progenies %>%  -->
<!--   summarise(Numbers = sum(Numbers)) -->

<!-- progenies_recomb %>%  -->
<!--   mutate(recombinants = recombinants/1000) %>%  -->
<!--   kable(booktabs = TRUE, col.names = c("Recombinant loci", "Recombinants"), longtable = TRUE) %>%  -->
<!--   kableExtra::kable_styling(font_size = 8, latex_options = "HOLD_position") -->
<!-- ``` -->

<!-- Here, since no recombinant types of A_D are observed, we can conclude that these two genes are completely linked. In a situation like this, we can assume that the combination of two genes inherit as a single entity. Note here the recombination frequencies here is misleading, if taken into consideration for mapping the gene distances. Let us assume "E" represents the entity (combination of A and D) -- E for aD and e for Ad. -->

<!-- We can rewrite the progeny phenotypes again as: -->

<!-- ```{r} -->
<!-- progenies <- tribble(~"Progeny type", ~"Numbers",  -->
<!--        "EBC", 42, -->
<!--        "ebc", 43,  -->
<!--        "eBC", 140,  -->
<!--        "Ebc", 145,  -->
<!--        "EBc", 6,  -->
<!--        "ebC", 9,  -->
<!--        "eBc", 305,  -->
<!--        "EbC", 310) -->
<!-- progenies %>%  -->
<!--   kable(booktabs = TRUE, longtable = TRUE) %>%  -->
<!--   kableExtra::kable_styling(font_size = 8) -->
<!-- ``` -->

<!-- Now repeating the process of identifying recombinants again. -->

<!-- ```{r} -->
<!-- colnames <- c("E", "B", "C") %>% combn(2) %>%  -->
<!--   as_tibble() %>%  -->
<!--   summarise_all(function(x)paste0(x, collapse = "_")) %>%  -->
<!--   unlist() %>%  -->
<!--   unname() -->

<!-- progenies <- progenies %>%  -->
<!--   mutate(combinations = map(`Progeny type`, function(x)unlist(str_extract_all(x, "")))) %>%  -->
<!--   mutate(combinations = map(combinations, ~combn(.x, 2))) %>%  -->
<!--   # pull(combinations) %>%  -->
<!--   mutate(combinations = map(combinations, ~.x %>%  -->
<!--                               as_tibble() %>%  -->
<!--                               summarise_all(function(x)paste0(x, collapse = "_")) %>%  -->
<!--                               unlist())) %>%  -->
<!--   unnest() %>%  -->
<!--   group_by(`Progeny type`) %>%  -->
<!--   mutate(row_num_id = seq_along(`Progeny type`)) %>%  -->
<!--   spread(key = `row_num_id`, value = combinations) %>%  -->
<!--   magrittr::set_colnames(c("Progeny type", "Numbers", colnames)) %>%  -->
<!--   ungroup() -->

<!-- progenies_recomb <- progenies %>%  -->
<!--   mutate_at(vars(`E_B`:`B_C`), list(~case_when( -->
<!--     str_detect(., c("e\\_B|E\\_b")) ~ FALSE, # parental type specification -->
<!--     str_detect(., c("e\\_c|E\\_C")) ~ FALSE, -->
<!--     str_detect(., c("B\\_c|b\\_C")) ~ FALSE -->
<!--   ))) %>%  -->
<!--   gather(key = recomb_loci, value = recomb_status, -Numbers, -`Progeny type`) %>%  -->
<!--   filter(is.na(recomb_status)) %>%  -->
<!--   group_by(recomb_loci) %>%  -->
<!--   summarise(recombinants = sum(Numbers)) -->

<!-- progenies_total <- progenies %>%  -->
<!--   summarise(Numbers = sum(Numbers)) -->

<!-- progenies_recomb %>%  -->
<!--   mutate(recombinants = recombinants/1000) %>%  -->
<!--   kable(booktabs = TRUE, col.names = c("Recombinant loci", "Recombinants"), longtable = TRUE) %>%  -->
<!--   kableExtra::kable_styling(font_size = 8) -->
<!-- ``` -->

<!-- From this we can infer the map distances and map order, easily. B and C lie the furthest with, E lying on the middle. -->

<!-- Notice that linear distance between B and C is lesser than the sum of two linear distances. This is because we have not accounted for the possibility of double crossover between these two genes. Let's check whether we can recover the whole map distance accounting for double crossover, by including rarest progeny phenotypes doubly. -->

<!-- ```{r} -->
<!-- progenies %>%  -->
<!--   filter(!`Progeny type` %in% c("EbC", "eBc")) %>%  -->
<!--   top_n(2, -Numbers) %>%  -->
<!--   bind_rows(progenies %>%  -->
<!--   filter(!`Progeny type` %in% c("EbC", "eBc"))) %>%  -->
<!--   summarise(recombination_map_dist = sum(Numbers)) %>%  -->
<!--   kable(booktabs = TRUE, col.names = c("Recombinant map"), longtable = TRUE) %>%  -->
<!--   kableExtra::kable_styling(font_size = 8) -->
<!-- ``` -->

<!-- Here it is evident that double crossover has infact taken place. -->

<!-- We can calculate the expected frequency of double crossover recombinants, were there no interference from the concerned single crossover events. -->

<!-- ```{r} -->
<!-- progenies_dc_exp <- progenies_recomb %>%  -->
<!--   mutate(recombinants = recombinants/1000) %>%  -->
<!--   filter(recomb_loci != "B_C") %>%  -->
<!--   pull(recombinants) %>%  -->
<!--   prod(1000) -->
<!-- ``` -->

<!-- Hence at least `r progenies_dc_exp` double recombinants would be expected in 1000 from the given testcross. However, we can note that from the F1 hybrid undergoing following meiosis event, following double recombinants are possible and their observed frequencies in the testcross is: -->

<!-- $$ -->
<!-- \begin{aligned} -->
<!-- & & bbEECC & \times BBeecc &\\ -->
<!-- & & & \downarrow & \\ -->
<!-- & \mathrm{F_1} & & bEC/Bec & \\ -->
<!-- & & bEC/Bec &\times bec/bec \text{ (testcross) } & \\ -->
<!-- & & & \downarrow & \\ -->
<!-- & \text{Double crossover products} & & beC & (\text{Observed: 9}) \\ -->
<!-- & & & BEc \hspace{1cm} & (\text{Observed: 6}) -->
<!-- \end{aligned} -->
<!-- $$ -->

<!-- Coefficient of coincidence (CoC) = $\frac{\text{Observed double crossover frequency}}{\text{Expected double crossover frequency}}$ -->

<!-- ```{r} -->
<!-- coc <- (9+6)/progenies_dc_exp -->
<!-- ``` -->

<!-- Interference = $1-CoC$ = `r coc`% -->

<!-- ```{r} -->
<!-- Interference <- 1-coc -->
<!-- ``` -->

<!-- Hence the Interference(I) = `r Interference*100`%. Which means that adjacent single crossover event prevents double crossover to occur by 50%. -->

