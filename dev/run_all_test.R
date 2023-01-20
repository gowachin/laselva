# Run all tests
rm(list = ls())
devtools::load_all('.')
devtools::document('.')
# attachment::att_amend_desc()
devtools::test()
devtools::check()

# precompute vignette
knitr::knit("vignettes/laselva.Rmd.og",
            output = "vignettes/laselva.Rmd")


devtools::test_active_file()

