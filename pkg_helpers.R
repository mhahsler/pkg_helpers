### these functions help with creating markup files to present package information
### on GitHub

pkg_title <- function(pkg) {
  title <- gsub("[\r\n]", " ", packageDescription(pkg)$Title)

  options(digits = 2)
  knitr::opts_chunk$set(tidy = TRUE, message = FALSE, fig.path = 'inst/README_files/')

  library(stringr)

  if (file.exists("man/figures/logo.svg"))
    cat(str_interp('# <img src="man/figures/logo.svg" align="right" height="139" /> R package ${pkg} - ${title}\n\n'))
  else
    cat(str_interp('# R package ${pkg} - ${title}\n\n'))

  cat(str_interp("[![CRAN version](http://www.r-pkg.org/badges/version/${pkg})](https://CRAN.R-project.org/package=${pkg})\n"))
  cat(str_interp("[![stream r-universe status](https://mhahsler.r-universe.dev/badges/${pkg})](https://mhahsler.r-universe.dev/${pkg})\n"))
  cat(str_interp("[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/${pkg})](https://CRAN.R-project.org/package=${pkg})\n"))
}

pkg_install <- function(pkg) {
  cat('\n## Installation\n\n')
  cat('__Stable CRAN version:__ Install from within R with\n')
  cat(str_interp('```r\ninstall.packages("${pkg}")\n```\n'))
  cat('__Current development version:__\n')
  cat(str_interp('Install from [r-universe.](https://mhahsler.r-universe.dev/${pkg})\n'))
  cat(str_interp('```r\ninstall.packages("${pkg}", repos = "https://mhahsler.r-universe.dev")\n```'))
}

pkg_usage <- function(pkg, which = c("Depends", "Imports", "Suggests")) {
  rev_deps <- tools::package_dependencies(pkg, recursive = FALSE, reverse = TRUE,
                                          which = which)[[1L]]

  format_cran_links <- function(pkgs) {
    paste0("[", pkgs,"]","(https://CRAN.R-project.org/package=", pkgs, ")")
  }

  cat("The following R packages use `", pkg, "`:\n",
      paste(format_cran_links(rev_deps), collapse = ", \n"), sep = "")
}
