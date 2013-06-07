#' Push data to a ShinyDash graph.
#' @param outputId The name of the output element to update.
#' @param expr An expression that returns an R list with named elements
#' corresponding to the series of data to be included in the graph. The default 
#' x variable will be the current time; this behavior can be overridden by 
#' providing a list element named \code{x}. Note that \code{name} is a reserved 
#' keyword which may not be used.
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#' is useful if you want to save an expression in a variable.
#' @param session The current Shiny session into which we should send the 
#' messages to update the graph.
#' @examples
#' \dontrun{
#' sendGraphData("my_graph", {
#'    list(
#'      y0 = 15.3,
#'      y1 = 13.2
#'    )
#' })
#' }
#' @author Jeff Allen <jeff.allen@@trestletechnology.net>
#' @export
sendGraphData <- function(outputId,
                          expr, 
                          env = parent.frame(),
                          quoted = FALSE,
                          session = get("session", envir=env)) {
  
  func <- exprToFunction(expr, env, quoted)
  
  # Update the latest value on the graph
  # Send custom message (as JSON) to a handler on the client
  observe({
    value <- func()
    
    message <- list(
      # Name of chart to update
      name = outputId,
      # Send UTC timestamp as a string so we can specify arbitrary precision
      # (large numbers get converted to scientific notation and lose precision)
      x = sprintf("%15.3f", as.numeric(Sys.time())) 
    )
    
    # Append and/or override any values provided by the default message with the 
    # values provided in the function.
    message[names(value)] <- value
    
    session$sendCustomMessage(
      type = "updateRickshaw", 
      message = message
    )
  })
}
