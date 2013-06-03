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

function _spliceSeries(args) {
  
    	var data = args.data;
  		var series = args.series;
  
  		if (!args.series) return data;
  
  		series.forEach( function(s) {
  
  			var seriesKey = s.key || s.name;
  			if (!seriesKey) throw "series needs a key or a name";
  
  			data.forEach( function(d) {
  
  				var dataKey = d.key || d.name;
  				if (!dataKey) throw "data needs a key or a name";
  
  				if (seriesKey == dataKey) {
  					//append data to the current data.
            var dataPt = new Object();
            dataPt['x'] = d['x'];
            dataPt['y'] = d['y'];
            s.data.push(dataPt);
  				}
  			} );
  		} );

		return series;
	}