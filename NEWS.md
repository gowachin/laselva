# laselva 0.0.10.0

* Added a `NEWS.md` file to track changes to the package.

* Fixed `ls_fetch_jpn()` because the url moved from http to https. (#14)

* Deprecated `ls_fetch_fra()` and `ls_fetch_fra_revisit()` in favor of `ls_fetch_fra_raw()` because the previous way was using url loophole to access old dataset. The new dataset is composed of row data between 2005 and 2021.

# laselva 0.0.9.91

* Previous development from Scott Chamberlain.
