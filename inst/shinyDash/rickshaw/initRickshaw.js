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
        dataPt['x'] = d['x'];
        dataPt['y'] = d['y'];
  
        var seriesFound = false;
      	series.forEach( function(s) {
    
    			var seriesKey = s.key || s.name;
    			if (!seriesKey) throw "series needs a key or a name";

          if (seriesKey == "__rickshaw-init"){
            //have to provide an initial series to get past the constructor.
            // trim the placeholder series here.
            series.splice(series.indexOf(s), 1);
          }

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