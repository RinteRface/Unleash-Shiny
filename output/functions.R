source("utils.R")

############# box #############
box <- function(data, title, value, session = shiny::getDefaultReactiveDomain()){

  # checks
  if(missing(title)) stop("missing title")
  if(missing(value)) stop("missing value")

  # select the columns
  data <- dplyr::select(data, title = {{title}}, value = {{value}})

  structure(data, class = c("box", class(data)))
}

print.box <- function(x, ...){
  barplot(x$value, names.arg = x$title,  main = "Boxes!")
}

############# boxOuput #############
boxOutput <- function(id){
  # TODO
}

############# renderBox #############
renderBox <- function(expr) {
  # TODO
}
