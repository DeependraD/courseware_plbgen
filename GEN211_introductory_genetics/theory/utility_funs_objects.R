# set directory
setwd("~/Desktop/BSc_Ag_lectures/GEN211_introductory_genetics/theory/")

require(tidyverse)

# list files

file_txt <- list.files(pattern = ".txt$", full.names = TRUE)

file_rmd <- str_replace(file_txt, pattern = ".txt$", ".Rmd")

file.rename(file_txt, file_rmd)
