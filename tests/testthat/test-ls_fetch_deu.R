skip_on_cran()
skip_on_os('windows')

# set cache path to a temp dir
laselva_cache$cache_path_set(full_path = "../files")

test_that("ls_fetch_fra_raw", {
    vcr::use_cassette("ls_fetch_deu", {
        x <- ls_fetch_deu()
    })
    # for (i in names(x)) expect_match(i, "csv")
    expect_is(x[[1]], "sf")
    for(n in 2:length(x)){
        for (i in x[[n]]) expect_is(i, "data.frame")
        for (i in x[[n]]) expect_is(i, "tbl")
        for (i in x[[n]]) expect_gt(NROW(i), 8)
    }
})
