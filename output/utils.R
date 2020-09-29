########################## Convenience Functions ##########################

# data
boxes <- data.frame(
  name = c("Beans", "Potatoes", "Cakes", "Flowers", "More cakes"),
  val = sample(1:1000, 5)
)

# convenience function to attach dependencies
attach_binding <- function(el){
  path <- here::here("output-advanced", "assets")

  deps <- list(
    htmltools::htmlDependency(
      name = "box",
      version = "1.0.0",
      src = c(file = path),
      script = c("binding.js")
    )
  )

  htmltools::attachDependencies(el, deps)
}
