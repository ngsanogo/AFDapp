## code to prepare `credentials` dataset goes here
credentials <- data.frame(
  user = c("user", "admin"), # mandatory
  password = c("user", "admin"), # mandatory
  start = c("2021-01-01"), # optinal (all others)
  expire = NA,
  admin = c(FALSE, TRUE),
  comment = NA,
  stringsAsFactors = FALSE
)
usethis::use_data(credentials, overwrite = TRUE)
