#' Create an arbitrary HTML widget
#' 
#' A port of David Underwood's weather widget for Dashing: \url{https://gist.github.com/davefp/4990174}
#' @param outputId output variable which will be used in addressing from the
#' server
#' @param width Graph width. Must be a valid CSS unit (like "100\%", "400px", 
#' "auto") or a number, which will be coerced to a string and have "px" 
#' appended.
#' @param height Graph height Must be a valid CSS unit (like "100\%", "400px", 
#' "auto") or a number, which will be coerced to a string and have "px" 
#' appended.
#' @importFrom shiny validateCssUnit
#' @seealso \code{\link{renderWeather}}
#' @author Jeff Allen <jeff.allen@@trestletechnology.net>
#' @export
weatherWidgetOutput <- function(outputId, width, height) {
  tagList(
    singleton(tags$head(
      tags$script(src = 'shinyDash/base_widget_bindings.js')
    )),
    singleton(tags$head(
      tags$link(rel = 'stylesheet',
                type = 'text/css',
                href = 'shinyDash/weather/weather.css')
    )),
  
    tags$div(id = outputId, class = "weather_widget_output", style = 
               paste("width:", validateCssUnit(width), ";", "height:", 
                     validateCssUnit(height), ";"),
             tags$i(class="climacon icon-background"),
             tags$h1(class="weather-title"),
             tags$h2(class="weather-temp"),
             tags$p(class="weather-condition")
          )
    
  )
}
