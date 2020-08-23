library(shiny)

updateObsVal <- function(value) {
  sprintf(
    "Shiny.shinyapp.$sendMsg(JSON.stringify({
      method: 'update',
      data: {obs: %s}
    }));",
    value
  )
}

# below we shunt the slider input by sending message
# directly through the websocket

ui <- fluidPage(
  tags$button(
    "Update obs value",
    onclick = updateObsVal(4)
  ),
  sliderInput("obs", "Number of observations:",
              min = 0, max = 1000, value = 500
  ),
  plotOutput("distPlot")
)

server <- function(input, output, session) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

shinyApp(ui, server)
