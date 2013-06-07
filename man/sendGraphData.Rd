\name{sendGraphData}
\alias{sendGraphData}
\title{Push data to a ShinyDash graph.}
\usage{
  sendGraphData(outputId, expr, env = parent.frame(),
    quoted = FALSE, session = get("session", envir = env))
}
\arguments{
  \item{outputId}{The name of the output element to
  update.}

  \item{expr}{An expression that returns an R list with
  named elements corresponding to the series of data to be
  included in the graph. The default x variable will be the
  current time; this behavior can be overridden by
  providing a list element named \code{x}. Note that
  \code{name} is a reserved keyword which may not be used.}

  \item{env}{The environment in which to evaluate
  \code{expr}.}

  \item{quoted}{Is \code{expr} a quoted expression (with
  \code{quote()})? This is useful if you want to save an
  expression in a variable.}

  \item{session}{The current Shiny session into which we
  should send the messages to update the graph.}
}
\description{
  Push data to a ShinyDash graph.
}
\examples{
\dontrun{
sendGraphData("my_graph", {
   list(
     y0 = 15.3,
     y1 = 13.2
   )
})
}
}
\author{
  Jeff Allen <jeff.allen@trestletechnology.net>
}

