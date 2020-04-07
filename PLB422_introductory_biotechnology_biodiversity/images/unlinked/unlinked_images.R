require(tidyverse)

pdftools::pdf_convert("./../../../literatures/textbooks/[D._Peter_Snustad,_Michael_J._Simmons]_Principles of Genetics.pdf", dpi = 250,
                      pages = c(483, 482, 451, 399, 392, 366, 351, 
                                339, 240, 239, 229, 219, 194, 678,
                                639, 640), 
                      format = "png", c("transgenic_mice_es_cell_tech.png", 
                                        "transgenic_mice_injection_implantation.png",
                                        "comparative_genome_map_of_cereals.png", 
                                        "DNA_sequencing_tech.png",
                                        "xgal_to_identify_ecoli.png",
                                        "test_for_mutagenicity.png",
                                        "Delicious_apple.png",
                                        "xeroderma_pigmentosum.png",
                                        "semi_conservative_model.png",
                                        "twin_types.png",
                                        "metaphase_chromosome.png",
                                        "major_players.png",
                                        "ecoli_conjugation.png",
                                        "natural_variation.png",
                                        "variation_in_shape_size_color.png",
                                        "tomato_cross.png"
                      ))
