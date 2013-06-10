#' Render a Rickshaw graph
#' 
#' @param outputId output variable which will be used in addressing update
#' messages.
#' @param width Graph width. Must be a valid CSS unit (like "100%", "400px", 
#' "auto") or a number, which will be coerced to a string and have "px" 
#' appended.
#' @param height Graph height Must be a valid CSS unit (like "100%", "400px", 
#' "auto") or a number, which will be coerced to a string and have "px" 
#' appended.
#' @param axisType The type of X-axis to use for the graph. \code{time} assumes
#' the data will be provided as a number of seconds since the epoch (see 
#' \code{\link{Sys.time}}) and will render them accordingly. \code{numeric} will 
#' not manipulate the provided numeric values.
#' @param legend If \code{TRUE}, an interactive legend of all series of data
#' displayed in the graph will be visible.
#' @param toolTip If \code{TRUE}, a tooltip providing additional information
#' about the values in the graph will be available when the user points the
#' mouse at the graph.
#' @param type The renderer to use when displaying the graph.
#' @seealso \code{\link{lineGraphOutput}}
#' @author Jeff Allen <jeff.allen@@trestletechnology.net>
graphOutput <- function(outputId, width, height, 
                            axisType=c("numeric", "time"),
                            legend = TRUE,
                            toolTip = TRUE, 
                            type=c("line", "scatterplot", "area", "bar")) {
  
  graphType <- match.arg(type)
  
  legendDiv <- ""
  if (legend){
      legendDiv <- tags$div(id= paste0(outputId, "-legend"), class="rickshaw_legend",
           style=paste0("float: left; margin-left: 50px; margin-top: -",shiny:::validateCssUnit(height), ";"))
  }
  
  axisType <- match.arg(axisType)
  axisType <- switch(axisType, 
                     time = "Time",
                     numeric = "X")
  
  tagList(
    singleton(tags$head(
      tags$script(src = 'shinyDash/rickshaw/d3.v3.min.js'),
      tags$script(src = 'shinyDash/rickshaw/rickshaw.min.js'),
      tags$script(src = 'shinyDash/rickshaw/initRickshaw.js'),
      tags$link(rel = 'stylesheet',
                type = 'text/css',
                href = 'shinyDash/rickshaw/rickshaw.min.css')
    )),
    tags$div(id = outputId, class = "rickshaw_output", style = 
               paste("width:", shiny:::validateCssUnit(width), ";", "height:", 
                     shiny:::validateCssUnit(height), ";")),
    
    #include the legend element if 'legend' is true.
    legendDiv,
    
    tags$script(paste("new ShinyRickshawDOM('",outputId,"',
                       '",as.integer(width),"',
                       '",as.integer(height),"',
                       '",type,"',
                       '",axisType,"',
                       '",legend,"',
                       '",toolTip,"')", sep=""))
)
}