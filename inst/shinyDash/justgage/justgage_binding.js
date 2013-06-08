// This output binding handles statusOutputBindings
var justgageOutputBinding = new Shiny.OutputBinding();
$.extend(justgageOutputBinding, {
  find: function(scope) {
    return scope.find('.justgage_output');
  },
  renderValue: function(el, data) {
    
    var $el = $(el);
    
    if (!$el.data('gauge')) {
      // If we haven't initialized this gauge yet, do it
      $el.data('gauge', new JustGage({
        id: this.getId(el),
        value: 0,
        min: 0,
        max: 200,
        title: "Mean of last 10",
        label: "units"
      }));
    }
    $el.data('gauge').refresh(data.value);
    
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
Shiny.outputBindings.register(justgageOutputBinding, 'dashboard.justgageOutputBinding');
