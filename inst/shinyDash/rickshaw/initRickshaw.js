// Initialiation for dynamic Highchart

$(document).ready(function() {
 
  // Handle messages from server - update graph
  Shiny.addCustomMessageHandler("updateRickshaw",
    function(message) {
      // Find the chart with the specified name
      var chart = $("#" + message.name).highcharts();
      var series = chart.series;

      // Add a new point
      series[0].addPoint([Number(message.x), Number(message.y0)], false, true);
      series[1].addPoint([Number(message.x), Number(message.y1)], false, true);
      chart.redraw();
    }
  );
});
