library(shiny)

ui <- fluidPage(
  uiOutput("intro")
)

server <- function(input, output, session){

  # serve the response
  path <- session$registerDataObj(
    name = "hello",
    data = "<h1>Hello there!</h1>",
    function(data, req) {
      shiny:::httpResponse(
        content = data 
      )
    }
  )

  # print path
  output$intro <- renderUI({
    
    # print so we can see the path clearly
    print(path) 

    # print it big so we can see it
    h1(
      tags$a(path, href = path)
    )
  })

}

shinyApp(ui, server)
