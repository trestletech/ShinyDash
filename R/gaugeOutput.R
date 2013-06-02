#' Render a gauge widget within an application page.
#' 
#' @param outputId output variable from which to read the gauge variable
#' @param width Gauge width. Must be a valid CSS unit (like "100%", "400px", 
#' "auto") or a number, which will be coerced to a string and have "px" 
#' appended.
#' @param height Gauge height Must be a valid CSS unit (like "100%", "400px", 
#' "auto") or a number, which will be coerced to a string and have "px" 
#' appended.
#' @examples
#' \dontrun{
#' #in ui.R
#' shinyUI(bootstrapPage(#'
#'  gridster(tile.width = 200, tile.height = 200,
#'    gridsterItem(col = 1, row = 1, size.x = 1, size.y = 1,
#'      gaugeOutput("myGauge", "150px", "150px")
#'    ),
#'    gridsterItem(col = 2, row = 1, size.x = 1, size.y = 1,
#'      textOutput("myText")
#'    ),
#'    gridsterItem(col = 1, row = 2, size.x = 2, size.y = 1,
#'      plotOutput("myPlot", height = 200)
#'    )
#'  )
#' )
#' 
#' #The corresponding server.R
#' shinyServer(function(input, output, session) {
#'  output$myGauge <- reactive({
#'    abs(rnorm(1) * 100)
#'  })
#' } 
#' }
#' @seealso \code{\link{reactive}}
#' @author Jeff Allen <jeff.allen@@trestletechnology.net>
#' @export
gaugeOutput <- function(outputId, width, height) {
  tagList(
    singleton(tags$head(
      tags$script(src = 'shinyDash/justgage/justgage.1.0.1.min.js'),
      tags$script(src = 'shinyDash/justgage/raphael.2.1.0.min.js'),      
      tags$script(src = 'shinyDash/justgage/justgage_binding.js')
    )),
    tags$div(id = outputId, class = "justgage_output", style = 
               paste("width:", shiny:::validateCssUnit(width), ";", "height:", 
                     shiny:::validateCssUnit(height), ";"))
  )
}