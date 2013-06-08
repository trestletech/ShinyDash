\name{renderGauge}
\alias{renderGauge}
\title{Gauge Output}
\usage{
  renderGauge(expr, env = parent.frame(), quoted = FALSE)
}
\arguments{
  \item{expr}{An expression that returns an R object that
  can be used as an argument to \code{cat}.}

  \item{env}{The environment in which to evaluate
  \code{expr}.}

  \item{quoted}{Is \code{expr} a quoted expression (with
  \code{quote()})? This is useful if you want to save an
  expression in a variable.}
}
\description{
  Makes a reactive version of the given expression and
  sends the data to the gauge.
}
\author{
  Jeff Allen <jeff.allen@trestletechnology.net>
}

