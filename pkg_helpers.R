### These functions help with creating markup files to present package information
### on GitHub
library(stringr)

pkg_title <- function(pkg, CRAN = TRUE, r_universe = TRUE, Bioc = FALSE, anaconda = NULL, stackoverflow = NULL) {
  title <- gsub("[\r\n]", " ", packageDescription(pkg)$Title)

  options(digits = 2)
  knitr::opts_chunk$set(tidy = TRUE, message = FALSE, fig.path = 'inst/README_files/')

  if (file.exists("man/figures/logo.svg"))
    cat(str_interp('# <img src="man/figures/logo.svg" align="right" height="139" /> R package ${pkg} - ${title}\n\n'))
  else
    cat(str_interp('# R package ${pkg} - ${title}\n\n'))
    
  if (CRAN) {
    cat(str_interp("[![Package on CRAN](https://www.r-pkg.org/badges/version/${pkg})](https://CRAN.R-project.org/package=${pkg})\n"))
    cat(str_interp("[![CRAN RStudio mirror downloads](https://cranlogs.r-pkg.org/badges/${pkg})](https://CRAN.R-project.org/package=${pkg})\n"))
    cat(str_interp("![License](https://img.shields.io/cran/l/${pkg})\n"))
  }

  if (Bioc) {
    cat(str_interp("[![Package on Bioc](https://img.shields.io/badge/Bioconductor-blue)](https://bioconductor.org/packages/${pkg})\n"))
  }
  
  if (!is.null(anaconda)) {
    cat(str_interp("[![Anaconda.org](https://anaconda.org/conda-forge/${anaconda}/badges/version.svg)](https://anaconda.org/conda-forge/${anaconda})\n"))
  }

  if (r_universe) {
    cat(str_interp("[![r-universe status](https://mhahsler.r-universe.dev/badges/${pkg})](https://mhahsler.r-universe.dev/${pkg})\n"))
  }
  
  if (!is.null(stackoverflow)) {
    cat(str_interp("[![StackOverflow](https://img.shields.io/badge/stackoverflow-${stackoverflow}-orange.svg)](https://stackoverflow.com/questions/tagged/${stackoverflow})\n"))
  }


}

pkg_install <- function(pkg, CRAN = TRUE) {
  cat('\n\n## Installation\n\n')
  if (CRAN) {
    cat('__Stable CRAN version:__ Install from within R with\n')
    cat(str_interp('```r\ninstall.packages("${pkg}")\n```\n'))
  }
  cat('__Current development version:__\n')
  cat(str_interp('Install from [r-universe.](https://mhahsler.r-universe.dev/${pkg})\n'))
  cat(str_interp('```r\ninstall.packages("${pkg}",\n    repos = c("https://mhahsler.r-universe.dev",\n              "https://cloud.r-project.org/"))\n```'))
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

pkg_citation <- function(pkg, number = 1L,
                         header = paste0("To cite package '", pkg, "' in publications use:")) {
  suppressWarnings(ref <- citation(pkg)[[number]])

  cat("\n\n", header, "\n\n")
  cat("> ")
  print(ref, style = "text", bibtex = FALSE)

  cat("\n```\n")
  print(ref, style = "bibtex")
  cat("```\n")
}
