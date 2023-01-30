skip_on_cran()
# skip_on_ci()

laselva_cache$cache_path_set(full_path = "../files")

test_that("ls_fetch_fin_swe", {
    x <- ls_fetch_fin_swe()
    expect_named(x, c("climate_wai_sgdd.csv", "plots_finland_and_sweden.csv",
                      "trees_finland_and_sweden.csv"))
    expect_is(x$climate_wai_sgdd.csv, "data.frame")
    expect_is(x$plots_finland_and_sweden.csv, "data.frame")
    expect_is(x$trees_finland_and_sweden.csv, "data.frame")
})
