skip_on_cran()

# set cache path to a temp dir
laselva_cache$cache_path_set(full_path = "../files")

test_that("ls_fetch_fra_raw", {
  vcr::use_cassette("ls_fetch_fra_raw", {
    x <- ls_fetch_fra_raw()
  })
  for (i in names(x)) expect_match(i, "csv")
  for (i in x) expect_is(i, "data.frame")
  for (i in x) expect_is(i, "tbl")
  for (i in x) expect_gt(NROW(i), 8)
})

test_that("ls_fetch_fra fails well", {
    warn <- "\'ls_fetch_fra\' is deprecated."
  expect_warning(x <- ls_fetch_fra(), warn)
})

test_that("ls_fetch_fra_revisit fails well", {
    warn <- "\'ls_fetch_fra_revisit\' is deprecated."
    expect_warning(x <- ls_fetch_fra_revisit(), warn)
})
