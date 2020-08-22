library(DT)
library(shiny)

ui <- fluidPage(
  br(),
  DTOutput("table"),
  strong("Clicked Model:"),
  verbatimTextOutput("model")
)

server <- function(input, output) {

  output$table <- renderDT({
    onclick <- paste0("Shiny.setInputValue('click', '", rownames(mtcars), "')")
    button <- paste0("<a class='btn btn-primary' onClick=\"", onclick, "\">Click me</a>")
    mtcars$button <- button
    datatable(
      mtcars, 
      escape = FALSE, 
      selection = "none", 
      rownames = FALSE, 
      style = "bootstrap"
    )
  })

  output$model <- renderPrint({
    print(input$click)
  })
}

shinyApp(ui, server)
