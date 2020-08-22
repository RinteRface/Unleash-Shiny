library(shiny)
library(shinyWidgets)
library(shinydashboard)

if (!requireNamespace(package = "OSUICode")) {
  remotes::install_github("DivadNojnarg/outstanding-shiny-ui-code")
  library(OSUICode)
}


ui <- fluidPage(
  # import shinydashboard deps without the need of the dashboard template
  useShinydashboard(),

  tags$style("body { background-color: ghostwhite};"),

  br(),
  box2(
    title = textOutput("box_state"),
    "Box body",
    inputId = "mybox",
    collapsible = TRUE,
    plotOutput("plot")
  ),
  actionButton("toggle_box", "Toggle Box", class = "bg-success")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    req(!input$mybox$collapsed)
    plot(rnorm(200))
  })

  output$box_state <- renderText({
    state <- if (input$mybox$collapsed) "collapsed" else "uncollapsed"
    paste("My box is", state)
  })

  observeEvent(input$toggle_box, {
    updateBox2("mybox")
  })

}

shinyApp(ui, server)
