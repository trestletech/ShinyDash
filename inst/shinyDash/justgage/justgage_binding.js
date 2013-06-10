function GageOutput(outputId, title, min, max, units, width, height, initialValue){
  $(document).ready(function() {
    var $el = $('#' + outputId); 
    if (!$el.data('gauge')) {
       // If we haven't initialized this gauge yet, do it
         $el.data('gauge', new JustGage({
           id: outputId,
           value: initialValue,
           min: min,
           max: max,
           title: title,
           label: units
         }));
       }
  });
}


// This output binding handles statusOutputBindings
var justgageOutputBinding = new Shiny.OutputBinding();
$.extend(justgageOutputBinding, {
  find: function(scope) {
    return scope.find('.justgage_output');
  },
  renderValue: function(el, data) {
    
    var $el = $(el);
    
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
