library(shiny)
library(shinybulma)

# select columns
box <- function(data, title, value, session = shiny::getDefaultReactiveDomain()){

  # checks
  if(missing(title)) stop("missing title")
  if(missing(value)) stop("missing value")

  # select the columns
  dplyr::select(data, title = {{title}}, value = {{value}})

}

# create the <nav>
boxOutput <- function(id){
  # TODO
}

# must return a function
renderBox <- function(expr, env = parent.frame(), quoted = FALSE) {
  # TODO
}

########################## App to test

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
