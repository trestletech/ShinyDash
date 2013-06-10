\name{weatherWidgetOutput}
\alias{weatherWidgetOutput}
\title{Create an arbitrary HTML widget}
\usage{
  weatherWidgetOutput(outputId, width, height)
}
\arguments{
  \item{outputId}{output variable which will be used in
  addressing from the server}

  \item{width}{Graph width. Must be a valid CSS unit (like
  "100\%", "400px", "auto") or a number, which will be
  coerced to a string and have "px" appended.}

  \item{height}{Graph height Must be a valid CSS unit (like
  "100\%", "400px", "auto") or a number, which will be
  coerced to a string and have "px" appended.}
}
\description{
  A port of David Underwood's weather widget for Dashing:
  \url{https://gist.github.com/davefp/4990174}
}
\author{
  Jeff Allen <jeff.allen@trestletechnology.net>
}
\seealso{
  \code{\link{renderWeather}}
}

