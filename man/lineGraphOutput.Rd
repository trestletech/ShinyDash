\name{lineGraphOutput}
\alias{lineGraphOutput}
\title{Render a line graph widget within an application page.}
\usage{
  lineGraphOutput(outputId, width, height)
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
}
\description{
  Render a line graph widget within an application page.
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
 output$myGraph <- {}#TODO
}
}
}
\author{
  Jeff Allen <jeff.allen@trestletechnology.net>
}
\seealso{
  \code{\link{observe}}
}

