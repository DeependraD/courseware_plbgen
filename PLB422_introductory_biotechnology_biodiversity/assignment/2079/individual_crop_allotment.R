require(tidyverse)
all_crops <- tibble(Crop = c("Rice",
                 "Wheat",
                 "Maize",
                 "Fingermillet",
                 "Minor millets",
                 "Buckwheat",
                 "Barley",
                 "Soybean",
                 "Blackgram",
                 "Lentil",
                 "Groundnut",
                 "Pea",
                 "Chickpea",
                 "Pigeonpea",
                 "Potato",
                 "Sugarcane",
                 "Jute",
                 "Cotton",
                 "Brassica (with focus on rapeseed, broad leaf mustard and radish)",
                 "Sunflower",
                 "Sesame",
                 "Tea",
                 "Coffee",
                 "Chilly/pepper",
                 "Tomato",
                 "Garlic",
                 "Onion",
                 "Taro",
                 "Mango",
                 "Apple",
                 "Banana",
                 "Grape",
                 "Pear",
                 "Citruses",
                 "Pomegranate",
                 "Chestnut",
                 "Strawberry",
                 "Raspberries and blueberries",
                 "Guava",
                 "Pumpkin",
                 "Carrot",
                 "Cucumber",
                 "Gourds (Bottlegourd, spongegourd, bittergourd, pointedgourd, snakegourd)",
                 "Amaranthus",
                 "Oat"))

student_crop <- all_crops %>% 
  mutate(Crop = sample(Crop, 45, replace = FALSE)) %>%
  bind_cols(readxl::read_xlsx("../../../../courseware_evalutation/afu/2079/internal-assessment_introductory-resistance-breeding_6th-sem/6th_sem_PLB304_internal_assessment_submitt.xlsx") %>% 
              select(4))

student_crop %>% 
  write_csv("./individual_crop_allotment.csv", "")
