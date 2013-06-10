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

/* Create an animation that scrolls from the startValue to the stopValue in 
 * `steps` steps and with an interval of `rate` millisenconds on the given 
 * element.
 */
function NumericTicker (startVal, stopVal, $el, rate, steps){
  //The interval object returned from setInterval()
  var intId;
  
  // The current value of the ticker. Saves us from having to traverse the DOM
  //  each time.
  var currentVal = parseFloat($el.text());
  
  var stepSize = (stopVal - startVal)/steps;
  
  function clear(){
    clearInterval(intId);
  }  
  
  function setVal(val){
    currentVal = val;
    $el.text(val);
  }
  
  function step(){
    if (Math.abs(currentVal - stopVal) < Math.abs(stepSize)){
      //last step. Set to equals and exit
      setVal(stopVal);
      clear();
    } else{
      setVal(currentVal + stepSize);
    }
  }
  
  this.start = function(){
    intId = setInterval(step, rate);
  };
  
}

var htmlWidgetOutputBinding = new Shiny.OutputBinding();
$.extend(htmlWidgetOutputBinding, {
  find: function(scope) {
    return scope.find('.html_widget_output');
  },
  renderValue: function(el, data) {
    var $el = $(el);
    
    for (var name in data){
      var $childEl = $el.children('#' + name)
      if ($childEl.text().match("^[\\d\\.]+$") && data[name].toString().match("^[\\d\\.]+$")){
        //old and new are both numeric
        var nt = new NumericTicker(parseFloat($childEl.text()), 
            parseFloat(data[name]), $childEl, 55, 3);
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
    
    $el.children('#temp').text(data["temp"] + "°F" || '');
    $el.children('#title').text(data["title"] || '');
    $el.children('#condition').text(data["condition"] || '');
    
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
