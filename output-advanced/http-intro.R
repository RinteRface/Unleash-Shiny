library(shiny)

ui <- fluidPage(
  verbatimTextOutput("intro")
)

server <- function(input, output, session){

  path <- session$registerDataObj(
    "test", cars, function(data, req){
      print(parseQueryString(req$QUERY_STRING))
      shiny:::httpResponse(200L, "application/json", "hello")
    }
  )

  output$intro <- renderPrint(path)

}

shinyApp(ui, server)
