/*\
|*|
|*|  IE-specific polyfill which enables the passage of arbitrary arguments to the
|*|  callback functions of javascript timers (HTML5 standard syntax).
|*|
|*|  https://developer.mozilla.org/en-US/docs/Web/API/window.setInterval
|*|
|*|  Syntax:
|*|  var timeoutID = window.setTimeout(func, delay, [param1, param2, ...]);
|*|  var timeoutID = window.setTimeout(code, delay);
|*|  var intervalID = window.setInterval(func, delay[, param1, param2, ...]);
|*|  var intervalID = window.setInterval(code, delay);
|*|
\*/
 
if (document.all && !window.setTimeout.isPolyfill) {
  var __nativeST__ = window.setTimeout;
  window.setTimeout = function (vCallback, nDelay /*, argumentToPass1, argumentToPass2, etc. */) {
    var aArgs = Array.prototype.slice.call(arguments, 2);
    return __nativeST__(vCallback instanceof Function ? function () {
      vCallback.apply(null, aArgs);
    } : vCallback, nDelay);
  };
  window.setTimeout.isPolyfill = true;
}
 
if (document.all && !window.setInterval.isPolyfill) {
  var __nativeSI__ = window.setInterval;
  window.setInterval = function (vCallback, nDelay /*, argumentToPass1, argumentToPass2, etc. */) {
    var aArgs = Array.prototype.slice.call(arguments, 2);
    return __nativeSI__(vCallback instanceof Function ? function () {
      vCallback.apply(null, aArgs);
    } : vCallback, nDelay);
  };
  window.setInterval.isPolyfill = true;
}

function Filter (filterStr){
  function applyFilter(filter, target){
    filter = filter.trim();
    if (filter.match("^round\\s*(\\d+)")){
      var match = filter.match("^round\\s*(\\d+)");
      var precision = 0;
      if (match.length> 1){
        //user specified an amount
        precision = match[1];
      }
      
      return (parseFloat(target).toFixed(precision));
      
    } else if(filter.match("^prepend '(.*)'$")){
      var match = filter.match("^prepend '(.*)'$");
      return (match[1] + target);
    } else if(filter.match("^append '(.*)'$")){
      var match = filter.match("^append '(.*)'$");
      return (target + match[1]);
    } else{
      throw "Unrecognized filter: " + filter;
    }
  }
  
  this.process = function(str){
    var filters = filterStr.toString().split(" | ");
    filters.forEach(function(f){
      str = applyFilter(f, str)
    });
    return(str);
  }
}

//extend the $.text() function to include filters.
var jqText = jQuery.fn.text;
jQuery.fn.text = function(){
  var filterStr = this.data("filter");
  if (filterStr && arguments.length == 1){
    var filter = new Filter(filterStr);
    var filtered = filter.process(arguments[0]);
    
    //set `data-value` so we'll know what the underlying data was before the filter.
    this.data("value", arguments[0]);
    
    return(jqText.apply(this, [filtered])); 
  } else{
    return(jqText.apply(this, arguments));  
  }
}


/* Create an animation that scrolls from the startValue to the stopValue in 
 * `steps` steps and with an interval of `rate` millisenconds on the given 
 * element.
 */
function NumericTicker (startVal, stopVal, $el, rate, steps){
  //The interval object returned from setInterval()
  var intId;
  
  // The current value of the ticker. Saves us from having to traverse the DOM
  //  each time.
  var currentVal = parseFloat($el.data("value"));
  
  var stepSize = (stopVal - startVal)/steps;
  
  var stepCounter = 0;
  
  function clear(){
    clearInterval(intId);
  }  
  
  function setVal(val){
    currentVal = val;
    $el.text(val);
  }
  
  function step(){
    if (stepCounter >= steps){
      //last step. Set to equals and exit
      setVal(stopVal);
      clear();
    } else{
      setVal(currentVal + stepSize);
    }
    stepCounter++;
  }
  
  this.start = function(){
    intId = setInterval(step, rate);
  };
  
}

function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

var htmlWidgetOutputBinding = new Shiny.OutputBinding();
$.extend(htmlWidgetOutputBinding, {
  find: function(scope) {
    return scope.find('.html_widget_output');
  },
  renderValue: function(el, data) {
    var $el = $(el);
    
    for (var name in data){
      var $childEl = $el.find('#' + name);
      var childVal = $childEl.text();
      if ($childEl.data("value")){
        //value data element is set. Possible that the text() value itself has been manipulated with a filter, so use data-value.
        childVal = $childEl.data("value").toString();
      }
      
      if (isNumber(childVal) && isNumber(data[name].toString()) && $childEl.hasClass("numeric")){
        //old and new are both numeric
        var nt = new NumericTicker(parseFloat(childVal), 
            parseFloat(data[name]), $childEl, 45, 5);
        nt.start();
      } else{
        $childEl.text(data[name] || '');
      }
    }
    
    var $grid = $el.parent('li.gs_w');
    
    // Remove the previously set grid class
    var lastGridClass = $el.data('widgetState');
    if (lastGridClass)
      $grid.removeClass(lastGridClass);
    
    $el.data('widgetState', data.widgetState);
    
    if (data.widgetState) {
      $grid.addClass(data.widgetState);
    }
  }
});
Shiny.outputBindings.register(htmlWidgetOutputBinding, 'ShinyDash.htmlWidgetOutput');


var weatherWidgetOutputBinding = new Shiny.OutputBinding();
$.extend(weatherWidgetOutputBinding, {
  find: function(scope) {
    return scope.find('.weather_widget_output');
  },
  renderValue: function(el, data) {
    var $el = $(el);
    
    $el.children('.weather-temp').text(data["temp"] || '');
    $el.children('.weather-title').text(data["title"] || '');
    $el.children('.weather-condition').text(data["condition"] || '');
    
    if (data["climacon"]){
       var climac = $el.children('i.climacon');
       climac.removeClass();
       climac.addClass("climacon icon-background " + data["climacon"]);
    }
    
    var $grid = $el.parent('li.gs_w');
    
    // Remove the previously set grid class
    var lastGridClass = $el.data('widgetState');
    if (lastGridClass)
      $grid.removeClass(lastGridClass);
    
    $el.data('widgetState', data.widgetState);
    
    if (data.widgetState) {
      $grid.addClass(data.widgetState);
    }
  }
});
Shiny.outputBindings.register(weatherWidgetOutputBinding, 'ShinyDash.weatherWidgetOutput');
