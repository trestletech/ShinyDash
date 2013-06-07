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
