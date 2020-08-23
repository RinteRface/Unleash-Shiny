library(shiny)

#function show({ html='', action='', deps=[], duration=5000,
#id=null, closeButton=true, type=null } = {})

# see notifications.js

ui <- fluidPage(
  actionButton(
  "reconnect",
  "Show reconnect",
  onclick = "Shiny.notifications.show({
      html: '<strong>Oups</strong>',
      type: 'error',
      duration: 2000
    });"
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
