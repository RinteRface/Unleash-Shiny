library(shiny)

ui <- fluidPage(
  tags$head(
    tags$script(
      "$(function() {
        $('#test').on('click', function() {
          var $obj = $('#button');
          var inputBinding = $obj.data('shiny-input-binding');
          var val = $obj.data('val') || 0;
          inputBinding.setValue($obj, val + 10);
          $obj.trigger('click');
        });
        $('#test').on('shiny:inputchanged', function(event) {
          event.value *= 2;
        });
      });
      "
    )
  ),
  actionButton("test", icon("plus")),
  actionButton("button", textOutput("val"))
)

server <- function(input, output) {
  output$val <- renderText(input$button)
  observe(print(input$test))
}

shinyApp(ui, server)
