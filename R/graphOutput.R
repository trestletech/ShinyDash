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
  
  toolTipStr <- ""
  if (toolTip){
    toolTipStr <- paste0('
var hoverDetail = new Rickshaw.Graph.HoverDetail( {
    graph: graph,
    xFormatter: function(x) { ', 
      ifelse(axisType=="time",
        'return ISODateString(new Date(x*1000))',
        'return Math.floor(x)'
      ),'},
    yFormatter: function(y) { return Math.floor(y) }
} );
')
  }
  
  axisType <- match.arg(axisType)
  axisType <- switch(axisType, 
                     time = "Time",
                     numeric = "X")
  
  legendStr <- ""
  if (legend){
    legendStr <- paste0('
  legend = new Rickshaw.Graph.Legend({
    graph: graph,
    element: document.getElementById(\'',outputId,'-legend\')
  });

  var shelving = new Rickshaw.Graph.Behavior.Series.Toggle({
    graph: graph,
    legend: legend
  });

  var highlighter = new Rickshaw.Graph.Behavior.Series.Highlight({
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
  // Handle messages from server - update graph
  var graph;
  ShinyRickshawCallback.addRickshawHandler(
     function(message) {
       
        var data = parseRickshawData(message);
        var palette = new Rickshaw.Color.Palette( { scheme: \'colorwheel\' } );
        var dataSer = data.map( function(s){
          return ({name : s.name, color: palette.color(), 
                  data: [{x: Number(s.x), y:Number(s.y)}]});
        });
        var legend;

        //only subscribe to events associated with this graph.
        if (message.name == "',outputId,'"){
          if (!graph){
            graph = new Rickshaw.Graph({
              element: document.querySelector("#',outputId,'"),
              width: \'', (width),'\',
              height: \'', (height),'\',
              renderer: \'',graphType,'\',
              series: dataSer
            });
            var xAxis = new Rickshaw.Graph.Axis.',axisType,'({
                graph: graph
            });
            
            xAxis.render();
          
          
            var yAxis = new Rickshaw.Graph.Axis.Y({
                graph: graph
            });
            yAxis.render();


            ',legendStr,'
            ',toolTipStr,'

          }

      graph.series = _spliceSeries({ data: data, series: graph.series }, 100);
  
      graph.render();
    }
  }
  );

});'))
)
}