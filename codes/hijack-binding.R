library(shiny)
library(shinyjs)
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
                  var idx = $(el).attr('id').split('-')[1];
                  var icon;
                  if (idx == 1) {
                    icon = 'car-side';
                  } else if (idx == 2) {
                    icon = 'truck-moving';
                  }

                  var val = $el.data('val') || 0;
                  $el.data('val', val + 2);

                  $('<i class=\"fa fa-' + icon + '\"></i>')
                    .insertAfter($(el))
                    .css('color', 'pink');

                  callback();
                });
              }
          });
          alert('Button is hijacked!');
          Shiny.bindAll();
        });

        function isOverlap(idOne,idTwo){
          var objOne=$(idOne),
            objTwo=$(idTwo),
            offsetOne = objOne.offset(),
            offsetTwo = objTwo.offset(),
            topOne=offsetOne.top,
            topTwo=offsetTwo.top,
            leftOne=offsetOne.left,
            leftTwo=offsetTwo.left,
            widthOne = objOne.width(),
            widthTwo = objTwo.width(),
            heightOne = objOne.height(),
            heightTwo = objTwo.height();
          var leftTop = leftTwo > leftOne && leftTwo < leftOne+widthOne                  && topTwo > topOne && topTwo < topOne+heightOne,             rightTop = leftTwo+widthTwo > leftOne && leftTwo+widthTwo < leftOne+widthOne                  && topTwo > topOne && topTwo < topOne+heightOne,             leftBottom = leftTwo > leftOne && leftTwo < leftOne+widthOne                  && topTwo+heightTwo > topOne && topTwo+heightTwo < topOne+heightOne,             rightBottom = leftTwo+widthTwo > leftOne && leftTwo+widthTwo < leftOne+widthOne                  && topTwo+heightTwo > topOne && topTwo+heightTwo < topOne+heightOne;
          return leftTop || rightTop || leftBottom || rightBottom;
        }

        $('#test1, #test2').on('click', function() {
          //console.log(isOverlap('#test1','.fa-heart:last'));
        });
      });
      "
      ))
  ),
  useShinyjs(),
  actionButton("test-1", icon("plus")),
  br(),
  actionButton("test-2", icon("minus")),
  div(
    style = "
      border-left: 6px solid green;
      height: 500px;
      position: absolute;
      left: 50%;
      margin-left: -3px;
      top: 0;"
  )
)

server <- function(input, output, session) {
  observe({
    invalidateLater(500)
    rand <- sample(1:2, 1)
    click(sprintf("test-%s", rand))
  })
}

shinyApp(ui, server)
