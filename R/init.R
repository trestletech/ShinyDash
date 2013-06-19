.global <- new.env()

initResourcePaths <- function() {
  if (is.null(.global$loaded)) {
    shiny::addResourcePath(
      prefix = 'shinyDash',
      directoryPath = system.file('shinyDash', package='ShinyDash'))
    .global$loaded <- TRUE
  }
  HTML("")
}