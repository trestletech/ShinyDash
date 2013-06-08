#' Gauge Output
#' 
#' Makes a reactive version of the given expression and sends the data to the
#' gauge.
#' @param expr An expression that returns an R object that can be used as an
#' argument to \code{cat}.
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#' is useful if you want to save an expression in a variable.
#' @author Jeff Allen <jeff.allen@@trestletechnology.net>
#' @export
renderGauge <- function (expr, env = parent.frame(), quoted = FALSE) 
{
  func <- exprToFunction(expr, env, quoted)
  
  function() {
    value <- func()
    
    if (is.numeric(value)){
      value <- list(value=value)
    }
    
    return(value)
  }
}