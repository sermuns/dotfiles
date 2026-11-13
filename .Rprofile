local({
  r <- getOption("repos")
  r["CRAN"] <- "https://mirror.accum.se/mirror/CRAN/"
  options(repos = r)
})

.First <- function() {
  if (interactive() && file.exists(".Rhistory")) {
    utils::loadhistory(".Rhistory")
  }
}

.Last <- function() {
  if (interactive()) {
    try(utils::savehistory(".Rhistory"), silent = TRUE)
  }
}
