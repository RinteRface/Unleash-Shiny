library(shiny)

ui <- fluidPage(
  verbatimTextOutput("intro")
)

server <- function(input, output, session){

  path <- session$registerDataObj(
    "pharma", list(cars = cars, mtcars = mtcars),
    function(data, req){

      query <- parseQueryString(req$QUERY_STRING)

      df <- data[[query$dataset]]

      res <- jsonlite::toJSON(df)
      shiny:::httpResponse(200L, "application/json", enc2utf8(res))
    }
  )

  output$intro <- renderPrint(path)

}

shinyApp(ui, server)
