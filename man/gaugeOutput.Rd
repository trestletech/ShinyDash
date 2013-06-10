\name{gaugeOutput}
\alias{gaugeOutput}
\title{Render a gauge widget within an application page.}
\usage{
  gaugeOutput(outputId, title = "Title", min = 0, max = 1,
    units = "", width = "200px", height = "200px",
    value = min)
}
\arguments{
  \item{outputId}{output variable from which to read the
  gauge variable}

  \item{width}{Gauge width. Must be a valid CSS unit (like
  "100%", "400px", "auto") or a number, which will be
  coerced to a string and have "px" appended.}

  \item{height}{Gauge height Must be a valid CSS unit (like
  "100%", "400px", "auto") or a number, which will be
  coerced to a string and have "px" appended.}
}
\description{
  Render a gauge widget within an application page.
}
\examples{
\dontrun{
#in ui.R
shinyUI(bootstrapPage(#'
 gridster(tile.width = 200, tile.height = 200,
   gridsterItem(col = 1, row = 1, size.x = 1, size.y = 1,
     gaugeOutput("myGauge", "150px", "150px")
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
 output$myGauge <- reactive({
   abs(rnorm(1) * 100)
 })
}
}
}
\author{
  Jeff Allen <jeff.allen@trestletechnology.net>
}
\seealso{
  \code{\link{reactive}}
}

