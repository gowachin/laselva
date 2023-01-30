#' Finland and Sweden Forest inventory
#'
#' Fetch Finnish and Swedish National Forest Inventories.
#'
#' @export
#' @param ... curl options passed on to [crul::verb-GET]
#' @references https://datadryad.org/stash/dataset/doi:10.5061/dryad.wm37pvmkw
#' @return a list of tibbles
#'
#' Trees
#' - trees_finland_and_sweden.csv
#'
#' Plots information
#' - plots_finland_and_sweden.csv
#'
#' Climate information
#' - climate_wai_sgdd.csv
#'
#'
#' @examples \dontrun{
#' res = ls_fetch_fin_swe()
#' res
#' }
#'
ls_fetch_fin_swe <- function(...) {

    csv_files <- rdryad::dryad_download(dois = "10.5061/dryad.wm37pvmkw", ...)
    csv_files <- unlist(csv_files, use.names = FALSE)
    bb <- suppressMessages(lapply(csv_files, f_read, sep = ","))
    stats::setNames(bb, basename(csv_files))
}
