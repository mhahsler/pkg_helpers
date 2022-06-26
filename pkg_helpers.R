pkg_title <- function(pkg) {
  title <- gsub("[\r\n]", " ", packageDescription(pkg)$Title)
  
  options(digits = 2)
  knitr::opts_chunk$set(tidy = TRUE, message = FALSE, fig.path = 'inst/README_files/')
  
  library(stringr)
  
  cat(str_interp('# <img src="man/figures/logo.svg" align="right" height="139" /> R package ${pkg} - ${title}\n\n'))
  
  cat(str_interp("[![CRAN version](http://www.r-pkg.org/badges/version/${pkg})](https://CRAN.R-project.org/package=${pkg})\n"))
  cat(str_interp("[![stream r-universe status](https://mhahsler.r-universe.dev/badges/${pkg})](https://mhahsler.r-universe.dev/ui#package:${pkg})\n"))
  cat(str_interp("[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/${pkg})](https://CRAN.R-project.org/package=${pkg})\n"))
}

pkg_install <- function(pkg) {
  cat('## Installation\n\n')
  cat('__Stable CRAN version:__ Install from within R with\n')
  cat(str_interp('```r\ninstall.packages("${pkg}")\n```\n'))
  cat('__Current development version:__\n') 
  cat(str_interp('Install from [r-universe.](https://mhahsler.r-universe.dev/ui#package:${pkg})\n'))
  cat(str_interp('```r\ninstall.packages("${pkg}", repos = "https://mhahsler.r-universe.dev")\n```'))
}
