function parseRickshawData(data){
  var keys = Object.keys(data);
  var series = new Array(keys.length-2);
  
  var i = 0;
  keys.forEach(function(k){
    if (k != "name" && k != "x"){
        series[i] = new Object();
        series[i]['y'] = data[k];
        series[i]['name'] = k;
        series[i]['x'] = data['x'];
        i++;
    }
  })
  
  return series;
}

function _spliceSeries(args, maxLength) {
    	var data = args.data;
  		var series = args.series;
  
  		if (!args.series) return data;

			data.forEach( function(d) {

				var dataKey = d.key || d.name;
				if (!dataKey) throw "data needs a key or a name";


        var dataPt = new Object();
        dataPt['x'] = Number(d['x']);
        dataPt['y'] = Number(d['y']);
  
        var seriesFound = false;
      	series.forEach( function(s) {
    
    			var seriesKey = s.key || s.name;
    			if (!seriesKey) throw "series needs a key or a name";

  				if (seriesKey == dataKey) {
            seriesFound = true;
            
            s.data.push(dataPt);
            if (s.data.length >= maxLength){
              s.data.shift();
            }
  				}
  			} );
        
        if (!seriesFound){
          var palette = new Rickshaw.Color.Palette( { scheme: 'colorwheel' } );
          
          //this series wasn't found in the existing graph's data. Add it.
          series.push(
            {name: dataKey,
             data: [dataPt],
             color: palette.color(series.length)
          });
        }
        
  		} );

		return series;
	}  
  
//maintain the list of callbacks associated with ShinyDash's Rickshaw integration
function ShinyRickshaw (){  
  var callbacks = this.callbacks = Array();
  var self = this;
  
  //Add a new callback handler
  this.addRickshawHandler = function(callback){
    callbacks[callbacks.length] = callback;
  }
  
  //fire the message to all callbacks
  this.fireMessage = function(message){
    callbacks.forEach( function(s){
      s(message);
    });
  }
}

//instantiate a new callback handler.
var ShinyRickshawCallback = new ShinyRickshaw();

//broadcast the message to all subscribed callbacks.
Shiny.addCustomMessageHandler("updateRickshaw",
  function(message){
    ShinyRickshawCallback.fireMessage(message);
  }
);


function ISODateString(d){
  function pad(n){return n<10 ? '0'+n : n}
  return d.getUTCFullYear()+'-'
      + pad(d.getUTCMonth()+1)+'-'
      + pad(d.getUTCDate())+'T'
      + pad(d.getUTCHours())+':'
      + pad(d.getUTCMinutes())+':'
      + pad(d.getUTCSeconds())+'Z'
}


function ShinyRickshawDOM(outputId, width, height, graphType, axisType, showLegend, toolTip){
  $(document).ready(function() { 
    // Handle messages from server - update graph
    var graph;
    ShinyRickshawCallback.addRickshawHandler(function(message) {
        var data = parseRickshawData(message);
        var palette = new Rickshaw.Color.Palette( { scheme: 'colorwheel' } );
        var dataSer = data.map( function(s){
          return ({name : s.name, color: palette.color(), 
                  data: [{x: Number(s.x), y:Number(s.y)}]});
        });
        var legend;

        //only subscribe to events associated with this graph.
        if (message.name == outputId){
          if (!graph){
            graph = new Rickshaw.Graph({
              element: document.querySelector('#' + outputId),
              width: width,
              height: height,
              renderer: graphType,
              series: dataSer
            });
            var xAxis;
            
            if (axisType == "Time"){
              xAxis = new Rickshaw.Graph.Axis.Time({
                  graph: graph
              });
            } else{
              xAxis = new Rickshaw.Graph.Axis.X({
                  graph: graph
              });
            }
            
            xAxis.render();
          
            var yAxis = new Rickshaw.Graph.Axis.Y({
                graph: graph
            });
            yAxis.render();

            if(showLegend){
              legend = new Rickshaw.Graph.Legend({
                graph: graph,
                element: document.getElementById(outputId + '-legend')
              });
            
              var shelving = new Rickshaw.Graph.Behavior.Series.Toggle({
                graph: graph,
                legend: legend
              });
            
              var highlighter = new Rickshaw.Graph.Behavior.Series.Highlight({
                graph: graph,
                legend: legend
              });

            }

            if (toolTip){
                            
              var hoverDetail = new Rickshaw.Graph.HoverDetail( {
                  graph: graph,
                  xFormatter: function(x) {
                    if(axisType=="Time"){
                      return ISODateString(new Date(x*1000))
                    } else{
                      return Math.floor(x)  
                    }
                    
                  },
                  yFormatter: function(y) { return Math.floor(y) }
              } );
            }
            
          }

          graph.series = _spliceSeries({ data: data, series: graph.series }, 100);
      
          graph.render();
        }
      }
  
    );
  });
}
