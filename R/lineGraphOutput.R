#' Render a line graph widget within an application page.
#' 
#' @param outputId output variable which will be used in addressing update
#' messages.
#' @param width Graph width. Must be a valid CSS unit (like "100%", "400px", 
#' "auto") or a number, which will be coerced to a string and have "px" 
#' appended.
#' @param height Graph height Must be a valid CSS unit (like "100%", "400px", 
#' "auto") or a number, which will be coerced to a string and have "px" 
#' appended.
#' @param ... Additional arguments to be passed to \code{\link{graphOutput}}.
#' @examples
#' \dontrun{
#' #in ui.R
#' shinyUI(bootstrapPage(#'
#'  gridster(tile.width = 200, tile.height = 200,
#'    gridsterItem(col = 1, row = 1, size.x = 1, size.y = 1,
#'      lineGraphOutput("myGraph", "150px", "150px")
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
#'  sendGraphData("myGraph", {
#'    list(
#'      y0 = 13,
#'      y1 = 15.3
#'    )
#'  })
#' } 
#' }
#' @seealso \code{\link{observe}} \code{\link{graphOutput}}
#' @author Jeff Allen <jeff.allen@@trestletechnology.net>
#' @export
lineGraphOutput <- function(outputId, width, height, ...) {
  graphOutput(outputId = outputId,
              width = width, 
              height = height, 
              type = "line",
              ...
  )
  
  
  
}