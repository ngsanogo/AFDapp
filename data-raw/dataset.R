## code to prepare `dataset` dataset goes here

library(tidyverse)
library(janitor)
dataset <- read_delim(
  file = "https://www.data.gouv.fr/fr/datasets/r/ae187b6d-d06f-45b7-8234-b5c2844ee143",
  delim = ";",
  locale = locale(decimal_mark = "."),
  trim_ws = TRUE,
  skip_empty_rows = TRUE,
  na = ""
  ) %>%
  remove_empty(
    which = c("rows", "cols")
  )
str(dataset)
usethis::use_data(dataset, overwrite = TRUE)
