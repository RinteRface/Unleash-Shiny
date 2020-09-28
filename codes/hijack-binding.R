library(shiny)
ui <- fluidPage(
  tags$head(
    tags$script(
      HTML("$(function() {
        $(document).on('shiny:connected', function(event) {
          Shiny.unbindAll();
          $.extend(Shiny
            .inputBindings
            .bindingNames['shiny.actionButtonInput']
            .binding, {
              subscribe: function(el, callback) {
                $(el).on('click.actionButtonInputBinding', function(e) {
                  var $el = $(this);
                  var val = $el.data('val') || 0;
                  $el.data('val', val + 2);
                  $('<i class=\"fa fa-heart\"></i>')
                    .insertAfter($(el))
                    .css('color', 'pink');
                  callback();
                });
              }
          });
          alert('Button is hijacked!');
          Shiny.bindAll();
        });
      });
      "
      ))
  ),
  actionButton("test", icon("plus"))
)

server <- function(input, output, session) {
  observe(print(input$test))
}

shinyApp(ui, server)
