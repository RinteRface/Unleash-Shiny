library(shiny)

ui <- fluidPage(
  actionButton("unbind", "Unbind inputs", onclick = "Shiny.unbindAll();"),
  actionButton("bind", "Bind inputs", onclick = "Shiny.bindAll();"),
  lapply(1:3, function(i) {
    textInput(paste0("text_", i), paste("Text", i))
  }),
  lapply(1:3, function(i) {
    uiOutput(paste0("val_", i))
  })
)

server <- function(input, output, session) {
  lapply(1:3, function(i) {
    output[[paste0("val_", i)]] <- renderPrint(input[[paste0("text_", i)]])
  })
}

shinyApp(ui, server)
