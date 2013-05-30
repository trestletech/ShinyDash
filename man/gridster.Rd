\name{gridster}
\alias{gridster}
\title{Create a Gridster frame on a Shiny web page}
\usage{
  gridster(..., margin.x = 16, margin.y = 16,
    tile.width = 140, tile.height = 140)
}
\arguments{
  \item{margin.x}{Horizontal margin between each grid item,
  in pixels.}

  \item{margin.y}{Vertical margin between each grid item,
  in pixels.}

  \item{tile.width}{Width of each tile, in pixels.}

  \item{tile.height}{Height of each tile, in pixels.}

  \item{...}{Other properties or elements to include.}
}
\description{
  Create a Gridster frame on a Shiny web page
}
\examples{
\dontrun{
shinyUI(bootstrapPage(

 gridster(tile.width = 200, tile.height = 200,
   gridsterItem(col = 1, row = 1, size.x = 1, size.y = 1,
     sliderInput("n", "Input value:", min = 0, max = 50, value = 10)
   ),
   gridsterItem(col = 2, row = 1, size.x = 1, size.y = 1,
     textOutput("myText")
   ),
   gridsterItem(col = 1, row = 2, size.x = 2, size.y = 1,
     plotOutput("myPlot", height = 200)
   )
 )
)
}
}
\author{
  Winston Chang
}
\seealso{
  \code{\link{gridsterItem}}
}

