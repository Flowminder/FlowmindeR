.onAttach <- function(libname, pkgname) {
  #packageStartupMessage("Welcome to my package")

  # Checks to see if the fonts are installed
  install_merriweather(message = F)

  # Set the penalty to not display scientific notation
  options(scipen = 999)
}



#' Install the Merriweather Fonts
#'
#' This function checks whether the Merriweather font is installed, and if not will
#'  install the package
#'
install_merriweather <- function(message = F, force = F){

  if(nrow(extrafont::fonttable()) == 0){
    extrafont::font_import(system.file("fonts", package = "FlowmindeR"), prompt = F)
  }

  if(!("Merriweather Bold" %in% extrafont::fonttable()[,4])){
    extrafont::font_import(system.file("fonts", package = "FlowmindeR"), prompt = F)
  } else{
    if(message) message("Fonts already installed")
  }
}
