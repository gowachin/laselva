# Run all tests
# Needed to clean the files and cassette from vcr for tests to run.
# Also need to set error in english !
Sys.setenv("LANGUAGE" = "EN")
rm(list = ls())
devtools::load_all('.')
devtools::document('.')
# attachment::att_amend_desc()
devtools::test(stop_on_failure = FALSE)
devtools::check()

# This skip all tests...
testthat::test_dir("tests/testthat/" )

# precompute vignette
knitr::knit("vignettes/laselva.Rmd.og",
            output = "vignettes/laselva.Rmd")


devtools::test_active_file()


# installing {rFIA}
# require to install libudunits2-dev
