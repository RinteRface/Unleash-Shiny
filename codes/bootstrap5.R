library(shiny)
library(htmltools)
library(magrittr)

bootstrap_5_deps <- htmltools::htmlDependency(
  name = "Bootstrap",
  version = "5.0.0",
  src = c(href = "https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/"),
  script = "js/bootstrap.min.js",
  stylesheet = "css/bootstrap.min.css"
)

popper_deps <- htmltools::htmlDependency(
  name = "popper",
  version = "1.16.0",
  src = c(href = "https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/"),
  script = "popper.min.js"
)

add_bs5_deps <- function(tag) {
  deps <- list(popper_deps, bootstrap_5_deps)
  htmltools::attachDependencies(tag, deps, append = TRUE)
}

bs5_page <- function(..., title = NULL) {
  tagList(
    tags$head(
      tags$meta(charset = "utf-8"),
      tags$meta(
        name = "viewport",
        content = "
        width=device-width,
        initial-scale=1"
      ),
      tags$title(title)
    ),
    tags$body(
      tags$div(class = "container", ...)
    ) %>% add_bs5_deps()
  )
}

ui <- bs5_page(
  tags$div(
    class = "card",
    style = "width: 18rem;",
    tags$img(
      src = "...",
      class = "card-img-top",
      alt = "..."
    ),
    tags$div(
      class = "card-body",
      tags$h5(class = "card-title", "Card title"),
      tags$p(class = "card-text",
             "Some quick example text to build on the card title and make up the bulk of the card's content."),
      tags$a(href = "#", class = "btn btn-primary", "Go somewhere")
    )
  ),
  sliderInput("obs", "Number of observations", 0, 1000, 500),
  actionButton("goButton", "Go!"),
  plotOutput("distPlot")
)

  server <- function(input, output, session) {
    output$distPlot <- renderPlot({
      # Take a dependency on input$goButton. This will run once initially,
      # because the value changes from NULL to 0.
      input$goButton

      # Use isolate() to avoid dependency on input$obs
      dist <- isolate(rnorm(input$obs))
      hist(dist)
    })
  }

  shinyApp(ui, server)
