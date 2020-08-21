library(shiny)

ui <- fluidPage(
  tags$head(
    tags$script(
      "$(function() {
        // crash the socket
        $(document).one('shiny:sessioninitialized', function(event) {
          Shiny.shinyapp.$sendMsg('plop');
        });
      });
      "
    )
  ),
  tags$button(
    class = "btn-sm",
    onclick = "Shiny.shinyapp.reconnect();",
    "Reconnect"
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
