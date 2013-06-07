var htmlWidgetOutputBinding = new Shiny.OutputBinding();
$.extend(htmlWidgetOutputBinding, {
  find: function(scope) {
    return scope.find('.html_widget_output');
  },
  renderValue: function(el, data) {
    var $el = $(el);
    
    for (var name in data){
      $el.children('#' + name).text(data[name] || '');
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
