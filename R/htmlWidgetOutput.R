#' Create an arbitrary HTML widget
#' @export
htmlWidgetOutput <- function(outputId, ...) {
  tagList(
    singleton(tags$head(
      tags$script(src = 'shinyDash/html_widget_binding.js')
    )),
  
    tags$div(id=outputId, class="html_widget_output",
             ...
    )
  )
}