\name{graphOutput}
\alias{graphOutput}
\title{Render a Rickshaw graph}
\usage{
  graphOutput(outputId, width, height,
    axisType = c("numeric", "time"),
    legend = c("topleft", "topright", "bottomleft", "bottomright"),
    toolTip = TRUE,
    type = c("line", "scatterplot", "area", "bar"))
}
\arguments{
  \item{outputId}{output variable which will be used in
  addressing update messages.}

  \item{width}{Graph width. Must be a valid CSS unit (like
  "100\%", "400px", "auto") or a number, which will be
  coerced to a string and have "px" appended.}

  \item{height}{Graph height Must be a valid CSS unit (like
  "100\%", "400px", "auto") or a number, which will be
  coerced to a string and have "px" appended.}

  \item{axisType}{The type of X-axis to use for the graph.
  \code{time} assumes the data will be provided as a number
  of seconds since the epoch (see \code{\link{Sys.time}})
  and will render them accordingly. \code{numeric} will not
  manipulate the provided numeric values.}

  \item{legend}{If specified, an interactive legend of all
  series of data displayed in the graph will be visible at
  the location given. If unspecified, the legend will not
  be visible.}

  \item{toolTip}{If \code{TRUE}, a tooltip providing
  additional information about the values in the graph will
  be available when the user points the mouse at the
  graph.}

  \item{type}{The renderer to use when displaying the
  graph.}
}
\description{
  Render a Rickshaw graph
}
\author{
  Jeff Allen <jeff.allen@trestletechnology.net>
}
\seealso{
  \code{\link{lineGraphOutput}}
}

