#' Create an arbitrary HTML widget
#' 
#' @param outputId output variable which will be used in addressing from the
#' server.
#' @param ... Additional elements to be included in the widget.
#' @author Jeff Allen <jeff.allen@@trestletechnology.net>
#' @export
htmlWidgetOutput <- function(outputId, ...) {
  tagList(
    singleton(tags$head(
      initResourcePaths(),
      tags$script(src = 'shinyDash/base_widget_bindings.js')
    )),
  
    tags$div(id=outputId, class="html_widget_output",
             ...
    )
  )
}