library(shiny)
library(shinybulma)

box <- function(data, title, value, session = shiny::getDefaultReactiveDomain()){

  if(missing(title)) stop("missing title")
  if(missing(value)) stop("missing value")

  # select the rows
  dplyr::select(data, title = {{title}}, value = {{value}})

}

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

# must return a function
renderBox <- function(expr, env = parent.frame(), quoted = FALSE) {
  # Convert the expression + environment into a function
  func <- shiny::exprToFunction(expr, env, quoted)

  function(){
    data <- func()

    # generate random endpoint name
    endpoint <- paste0(sample(letters, 26), collapse = "")

    session <- getDefaultReactiveDomain()

    uri <- session$registerDataObj(
      endpoint, 
      data, 
      function(data, req){
        response <- jsonlite::toJSON(data)
        shiny:::httpResponse(200, "application/json", enc2utf8(response))
      }
    )

    return(uri)
  }
}

ui <- bulmaPage(
  bulmaContainer(
    boxOutput("test")
  )
)

server <- function(input, output){

  boxes <- data.frame(
    titles = c("Beans", "Potatoes", "Cakes", "Flowers", "More cakes"),
    values = sample(1:1000, 5)
  )

  output$test <- renderBox({
    box(boxes, titles, values)
  })
}

shinyApp(ui, server)
