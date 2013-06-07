\name{lineGraphOutput}
\alias{lineGraphOutput}
\title{Render a line graph widget within an application page.}
\usage{
  lineGraphOutput(outputId, width, height,
    axisType = c("numeric", "time"), legend = TRUE,
    toolTip = TRUE,
    type = c("line", "scatterplot", "area", "bar"))

  lineGraphOutput(outputId, width, height,
    axisType = c("numeric", "time"), legend = TRUE,
    toolTip = TRUE,
    type = c("line", "scatterplot", "area", "bar"))
}
\arguments{
  \item{outputId}{output variable which will be used in
  addressing update messages.}

  \item{width}{Graph width. Must be a valid CSS unit (like
  "100%", "400px", "auto") or a number, which will be
  coerced to a string and have "px" appended.}

  \item{height}{Graph height Must be a valid CSS unit (like
  "100%", "400px", "auto") or a number, which will be
  coerced to a string and have "px" appended.}

  \item{...}{Additional arguments to be passed to
  \code{\link{graphOutput}}.}

  \item{outputId}{output variable which will be used in
  addressing update messages.}

  \item{width}{Graph width. Must be a valid CSS unit (like
  "100%", "400px", "auto") or a number, which will be
  coerced to a string and have "px" appended.}

  \item{height}{Graph height Must be a valid CSS unit (like
  "100%", "400px", "auto") or a number, which will be
  coerced to a string and have "px" appended.}

  \item{axisType}{The type of X-axis to use for the graph.
  \code{time} assumes the data will be provided as a number
  of seconds since the epoch (see \code{\link{Sys.time}})
  and will render them accordingly. \code{numeric} will not
  manipulate the provided numeric values.}

  \item{legend}{If \code{TRUE}, an interactive legend of
  all series of data displayed in the graph will be
  visible.}

  \item{toolTip}{If \code{TRUE}, a tooltip providing
  additional information about the values in the graph will
  be available when the user points the mouse at the
  graph.}

  \item{type}{The renderer to use when displaying the
  graph.}
}
\description{
  Render a line graph widget within an application page.

  Render a Rickshaw graph
}
\examples{
\dontrun{
#in ui.R
shinyUI(bootstrapPage(#'
 gridster(tile.width = 200, tile.height = 200,
   gridsterItem(col = 1, row = 1, size.x = 1, size.y = 1,
     lineGraphOutput("myGraph", "150px", "150px")
   ),
   gridsterItem(col = 2, row = 1, size.x = 1, size.y = 1,
     textOutput("myText")
   ),
   gridsterItem(col = 1, row = 2, size.x = 2, size.y = 1,
     plotOutput("myPlot", height = 200)
   )
 )
)

#The corresponding server.R
shinyServer(function(input, output, session) {
 sendGraphData("myGraph", {
   list(
     y0 = 13,
     y1 = 15.3
   )
 })
}
}
}
\author{
  Jeff Allen <jeff.allen@trestletechnology.net>

  Jeff Allen <jeff.allen@trestletechnology.net>
}
\seealso{
  \code{\link{observe}} \code{\link{graphOutput}}

  \code{\link{lineGraphOutput}}
}

