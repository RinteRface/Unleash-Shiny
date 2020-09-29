library(shiny)
library(shinybulma)

# import functions
source("utils.R")
source("functions.R")

# data to test
boxes <- data.frame(
  name = c("Beans", "Potatoes", "Cakes", "Flowers", "More cakes"),
  val = sample(1:1000, 5)
)

ui <- bulmaPage(
  bulmaContainer(
    boxOutput("test")
  )
)

server <- function(input, output){
  output$test <- renderBox({
    box(boxes, name, val)
  })
}

shinyApp(ui, server)
