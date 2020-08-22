library(shiny)

ui <- fluidPage(
  tags$script("
    Shiny.addCustomMessageHandler('get-data', function(msg){
      // query
      const queryString = window.location.search;
      const urlParams = new URLSearchParams(queryString);
      // construct url
      var uri = new URL(msg)
      uri.searchParams.append('name', urlParams.get('name'));
      // fetch
      fetch(uri.href)
        .then(function(response){
          if(response.ok){
            return response.json();
          }
        })
        .then(function(data){
          document.getElementById('data').innerText = JSON.stringify(data, null, 2);
        });
    })
  "),
  pre(code(id = "data"))
)

server <- function(input, output, session){
  uri <- session$registerDataObj(
    "testing", 
    list(cars = cars, mtcars = mtcars), 
    function(data, req){
      query <- parseQueryString(req$QUERY_STRING)
      name <- query$name

      dat <- data[[name]]

      response <- jsonlite::toJSON(dat)
      shiny:::httpResponse(200, "application/json", enc2utf8(response))
    }
  )

  session$sendCustomMessage("get-data", sprintf("http://127.0.0.1:3000/%s", uri))

}

shinyApp(ui, server, options = list(port = 3000))
