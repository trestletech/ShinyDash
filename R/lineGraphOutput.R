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
#'  output$myGraph <- {}#TODO
#' } 
#' }
#' @seealso \code{\link{observe}}
#' @author Jeff Allen <jeff.allen@@trestletechnology.net>
#' @export
lineGraphOutput <- function(outputId, width, height) {
  tagList(
    singleton(tags$head(
      tags$script(src = 'shinyDash/rickshaw/d3.v3.min.js'),
      tags$script(src = 'shinyDash/rickshaw/rickshaw.min.js'),
      tags$script(src = 'shinyDash/rickshaw/initRickshaw.js')  
    )),
    tags$div(id = outputId, class = "rickshaw_output", style = 
               paste("width:", shiny:::validateCssUnit(width), ";", "height:", 
                     shiny:::validateCssUnit(height), ";")),
    tags$script(paste0('

$(document).ready(function() { 
  var graph = new Rickshaw.Graph({
    element: document.querySelector("#',outputId,'"),
    width: \'', (width),'\',
    height: \'', (height),'\',
    series: [{
       name: \'y0\',
       color: \'steelblue\',
       data: [
        { x: 1370229148791, y: 40 },
        { x: 1370229148796, y: 49 },
        { x: 1370229148801, y: 38 },
        { x: 1370229148806, y: 30 },
        { x: 1370229148811, y: 32 } ]
    }]
    
  });
  
    


  // Handle messages from server - update graph
  Shiny.addCustomMessageHandler("updateRickshaw",
    function(message) {
      //only subscribe to events associated with this graph.
      if (message.name == "',outputId,'"){
        var data = parseRickshawData(message);
        graph.series = _spliceSeries({ data: data, series: graph.series });

        graph.render();
      }
    }
  );

  graph.render();
});'))
)
}