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
#' @param axisType The type of X-axis to use for the graph. \code{time} assumes
#' the data will be provided as a number of seconds since the epoch (see 
#' \code{\link{Sys.time}}) and will render them accordingly. \code{numeric} will 
#' not manipulate the provided numeric values.
#' @param legend If \code{TRUE}, an interactive legend of all series of data
#' displayed in the graph will be visible.
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
lineGraphOutput <- function(outputId, width, height, 
                            axisType=c("numeric", "time"),
                            legend = TRUE) {
  
  axisType <- match.arg(axisType)
  axisType <- switch(axisType, 
         time = "Time",
         numeric = "X")
  
  legendDiv <- ""
  if (legend){
      legendDiv <- tags$div(id= paste0(outputId, "-legend"), class="rickshaw_legend",
           style=paste0("float: left; margin-left: 50px; margin-top: -",shiny:::validateCssUnit(height), ";"))
  }
  
  legendStr <- ""
  if (legend){
    legendStr <- paste0('
  var legend = new Rickshaw.Graph.Legend({
    graph: graph,
    element: document.querySelector(\'#',outputId,'-legend\')
  });

  var highlighter = new Rickshaw.Graph.Behavior.Series.Highlight({
      graph: graph,
      legend: legend
  });

  var shelving = new Rickshaw.Graph.Behavior.Series.Toggle({
    graph: graph,
    legend: legend
  });
')
  }
  
  tagList(
    singleton(tags$head(
      tags$script(src = 'shinyDash/rickshaw/d3.v3.min.js'),
      tags$script(src = 'shinyDash/rickshaw/rickshaw.min.js'),
      tags$script(src = 'shinyDash/rickshaw/initRickshaw.js'),
      tags$script(src = 'shinyDash/rickshaw/jquery-ui-1.10.3.custom.min.js'),
      tags$link(rel = 'stylesheet',
                type = 'text/css',
                href = 'shinyDash/rickshaw/rickshaw.min.css')
    )),
    tags$div(id = outputId, class = "rickshaw_output", style = 
               paste("width:", shiny:::validateCssUnit(width), ";", "height:", 
                     shiny:::validateCssUnit(height), ";")),
    
    #include the legend element if 'legend' is true.
    legendDiv,
    tags$script(paste0('

$(document).ready(function() { 
  var graph = new Rickshaw.Graph({
    element: document.querySelector("#',outputId,'"),
    width: \'', (width),'\',
    height: \'', (height),'\',
    renderer: \'area\',
    series: [{
       name: \'__rickshaw-init\',
       color: \'steelblue\',
       data: [ {x:0,y:0} ]
    } 
    ]
  });

  
  // Handle messages from server - update graph
  Shiny.addCustomMessageHandler("updateRickshaw",
                       function(message) {
                       //only subscribe to events associated with this graph.
                       if (message.name == "',outputId,'"){
                       var data = parseRickshawData(message);
                       graph.series = _spliceSeries({ data: data, series: graph.series }, 100);
                       
                       
                       ',
                       #if 'legend' is present, update it.
                       ifelse(legend,'
                 //refresh legend
                 legend.lines = [];
                 while(legend.list.firstChild){
                 legend.list.removeChild(legend.list.firstChild);
                 }
                 
                 legend.series = graph.series;
                 legend.series.forEach( function(s) {
                 legend.addLine(s);
                 } );', ''),
                       '
                       graph.render();
                       }
                       }
    );


  var xAxis = new Rickshaw.Graph.Axis.',axisType,'({
      graph: graph
  });
  
  xAxis.render();


  var yAxis = new Rickshaw.Graph.Axis.Y({
      graph: graph
  });
  yAxis.render();

  graph.render();

  ',legendStr,
'
                       

});'))
)
}