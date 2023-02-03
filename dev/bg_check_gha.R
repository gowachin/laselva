library(crul)
cat("\014")
cat("Script launched \n\n")


# get_status <- function(){
    do <- TRUE
    t <- TRUE
    start <- Sys.time()
    while(do){
        Sys.sleep(30)
        if(t){
            t <- !t
            beepr::beep()
        } else {
            beepr::beep()
            beepr::beep()
        }
        # Sys.sleep(60)
        con <- HttpClient$new(
            url = "https://api.github.com/repos/gowachin/laselva/actions/workflows",
            headers = list(Accept = "application/vnd.github+json",
                           Authorization = paste("Bearer", Sys.getenv("GITHUB_PAT")),
                           `X-GitHub-Api-Version` = "2022-11-28"),
        )
        res <- con$get()
        con$url <- file.path(con$url,
                             jsonlite::fromJSON(res$parse("UTF-8"))$workflows["id"],
                             "runs")
        res <- con$get()
        x <- jsonlite::fromJSON(res$parse("UTF-8"))$workflow_runs

        n <- 1
        end <- data.frame(
            name = x$name[n],
            head_commit.message = x$head_commit$message[n],
            repository.full_name = x$repository$full_name[n],
            status = x$status[n],
            conclusion = x$conclusion[n]
        )
        end

        tmp <- Sys.time() - start
        message("\nTime difference of ", format(unclass(tmp), digits = 3),
                " ", attr(tmp, "units"))

        print(end)

        if(end$status == "completed"){
            do <- FALSE
            beepr::beep(3)
        } else {
            beepr::beep(9)
        }
    }
# }
#
# while(TRUE){
#     get_status()
# }


