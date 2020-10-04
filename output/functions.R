source("utils.R")

############# box #############
box <- function(data, title, value){

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
  el <- shiny::tags$nav(id = id, class = "box level")

  path <- normalizePath("assets")

  deps <- list(
    htmltools::htmlDependency(
      name = "box",
      version = "1.0.0",
      src = c(file = path),
      script = c("binding.js")
    )
  )

  htmltools::attachDependencies(el, deps)
}

############# renderBox #############
renderBox <- function(expr, session = shiny::getDefaultReactiveDomain()) {
  func <- shiny::exprToFunction(expr)

  function(){
    data <- func()

    # generate random endpoint name
    endpoint <- paste0(sample(letters, 26), collapse = "")

    uri <- session$registerDataObj(
      endpoint, 
      data, 
      function(data, req){
        response <- jsonlite::toJSON(data)
        shiny:::httpResponse(200, "application/json", response)
      }
    )

    return(uri)
  }
}
