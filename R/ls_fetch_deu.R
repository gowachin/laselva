#' Germany's Second and Third National Forest Inventory data.
#'
#' Note: command line tool mdbtools required to use this function
#'
#' @export
#' @param ... curl options passed on to [crul::verb-GET]
#' @section Command line tool required:
#' mdbtools is required to run this function. installation for most systems:
#' - macos: brew install mdbtools
#' - deb: apt-get install mdbtools
#' - fedora: yum install mdbtools
#' - windows: not sure, anyone?
#' @references https://bwi.info/Download/de/BWI-Basisdaten/ACCESS2003
#' @return a list of tibbles
#' @examples \dontrun{
#' res = ls_fetch_deu()
#' names(res)
#' }
#'
#' @details
#' a list of tibbles :
#' - shapefile : tibble with plot informations. Loaded with {sf} package.
#' - daten2002 : list of tibbles for the 2002 inventory.
#' - daten2012 : list of tibbles for the 2012 inventory.
#' - daten2002-2012 : list of tibbles for 2012 revisit.
#'
#'
#' Code first version was written by [Lukas Heiland](https://demographicecology.com/team/lukas-heiland/)
#' Second version was written by Julien Barrere
#'
#' @importFrom sf read_sf
#'
ls_fetch_deu <- function(...) {

    stats::setNames(lapply(de_files, function(w, url, ...){
        xx <- cache_GET(file.path(url, w), path = "germany", ...)
        der <- just_un_zip(xx)

        if(grepl("ShapeFile", w)){
            file <- list.files(der, pattern = ".shp",
                               full.names = TRUE)
            sf::read_sf(dsn = file)
        } else {
            file <- list.files(der, pattern = ".accdb|.mdb",
                               full.names = TRUE)
            extract_ma(file)
        }

    }, url = de_base, ...), names(de_files))
}

de_base <- "https://bwi.info/Download/de/BWI-Basisdaten/ACCESS2003"
de_files <- list(
    shapefile = "ShapeFile_Tnr_INSPIRE_Poly1000.zip",
    daten2002 = "bwi20150320_alle_daten2002.zip",
    daten2012 = "bwi20150320_alle_daten2012.zip",
    daten2002_2012 = "bwi20150320_alle_daten2002-2012.zip"
)
