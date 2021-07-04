test_that("Etat projet", {
  expect_equal(unique(dataset$etat_du_projet), c("Achev\u00e9", "Ex\u00e9cution"))
})
