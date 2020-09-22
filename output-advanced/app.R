library(shiny)
library(shinybulma)

boxxy <- function(data, title, value, session = shiny::getDefaultReactiveDomain()){

  if(missing(title)) stop("missing title")
  if(missing(value)) stop("missing value")

  data <- dplyr::select(data, title = {{title}}, value = {{value}})
  data <- apply(data, 1, as.list)

  # generate random endpoint name
  endpoint <- paste0(sample(letters, 26), collapse = "")

  uri <- session$registerDataObj(
    endpoint, 
    data, 
    function(data, req){
      response <- jsonlite::toJSON(data)
      shiny:::httpResponse(200, "application/json", enc2utf8(response))
    }
  )

  list(uri = uri)
}

boxxyOutput <- function(id){
  el <- shiny::tags$div(id = id, class = "boxxy level")

  path <- normalizePath("assets")

  deps <- list(
    htmltools::htmlDependency(
      name = "boxxy",
      version = "1.0.0",
      src = c(file = path),
      script = c("binding.js")
    )
  )

  htmltools::attachDependencies(el, deps)
}

renderBoxxy <- function(expr, env = parent.frame(), quoted = FALSE) {
  # Convert the expression + environment into a function
  func <- shiny::exprToFunction(expr, env, quoted)

  function(){
    func()
  }
}

ui <- bulmaPage(
  bulmaContainer(
    boxxyOutput("test")
  )
)

server <- function(input, output){

  boxes <- data.frame(
    titles = c("Beans", "Potatoes", "Cakes", "Flowers"),
    values = sample(1:1000, 4)
  )

  output$test <- renderBoxxy({
    boxxy(boxes, titles, values)
  })
}

shinyApp(ui, server)
