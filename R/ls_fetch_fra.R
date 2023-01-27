#' French IGN NFI data
#'
#' Fetch French IGN Institut National de L'Information Geographique
#' et Forestiere data
#'
#' @export
#' @param year Deprecated argument from `ls_fetch_fa()` and
#' `ls_fetch_fra_revisit()`.
#' @param ... curl options passed on to [crul::verb-GET]
#' @references https://inventaire-forestier.ign.fr/
#' @return a list of tibbles
#'
#' Trees alive or dead
#' - ARBRE.csv
#'
#' Dead wood
#' - BOIS_MORT.csv
#'
#' Covers
#' - COUVERT.csv
#'
#' Ecology
#' - ECOLOGIE.csv
#'
#' Flora
#' - FLORE.csv
#'
#' Plots information
#' - HABITAT.csv
#' - PLACETTE.csv
#'
#' Species key
#' - espar-cdref13.csv
#'
#' @details
#' metadonnees.csv was not included in the export because of an erroneous format.
#' This file is available for read in the cache, find where
#' files are being cached with `laselva_cache$cache_path_get`. The path is
#' `france-ign/metadonnees.csv` from there.
#'
#' Documentation is available in the same `france-ign/` cache as pdf files.
#' This documentation is written in french.
#'
#' `ls_fetch_fra()` and `ls_fetch_fra_revisit()` have been deprecated due to
#' an IGN download method update.
#'
#' @examples \dontrun{
#' res = ls_fetch_fr_raw()
#' res
#' }
ls_fetch_fra <- function(year, ...) {

    .Deprecated("ls_fetch_fr_raw")
    ls_fetch_fra_raw(...)
}

#' @export
#' @rdname ls_fetch_fra
ls_fetch_fra_revisit <- function(year, ...) {

    .Deprecated("ls_fetch_fr_raw")
    ls_fetch_fra_raw(...)
}

#' @export
#' @rdname ls_fetch_fra
ls_fetch_fra_raw <- function(...){
    url <- "https://inventaire-forestier.ign.fr/dataifn/data/export_dataifn_2005_2021.zip"
    xx <- cache_GET(url, "france-ign", ...)
    csv_files <- suppressMessages(un_zip(xx))
    # FIXME remove the metadata table because of wrong format.
    csv_files <- csv_files[ !grepl("metadonnees", csv_files) ]
    bb <- suppressMessages(lapply(csv_files, f_read, sep = ";"))
    stats::setNames(bb, basename(csv_files))
}

fra_base <- function() "https://inventaire-forestier.ign.fr/IMG/zip"
