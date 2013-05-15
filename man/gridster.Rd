\name{gridster}
\alias{gridster}
\title{Create a Gridster frame on a Shiny web page}
\usage{
  gridster(..., marginx = 16, marginy = 16, width = 140,
    height = 140)
}
\arguments{
  \item{marginx}{Horizontal margin between each grid item,
  in pixels.}

  \item{marginy}{Vertical margin between each grid item, in
  pixels.}

  \item{width}{Width of each tile, in pixels.}

  \item{height}{Height of each tile, in pixels.}

  \item{...}{Other properties or elements to include.}
}
\description{
  Create a Gridster frame on a Shiny web page
}
\examples{
\dontrun{
shinyUI(bootstrapPage(

 gridster(width = 200, height = 200,
   gridsterItem(col = 1, row = 1, sizex = 1, sizey = 1,
     sliderInput("n", "Input value:", min = 0, max = 50, value = 10)
   ),
   gridsterItem(col = 2, row = 1, sizex = 1, sizey = 1,
     textOutput("myText")
   ),
   gridsterItem(col = 1, row = 2, sizex = 2, sizey = 1,
     plotOutput("myPlot", height = 200)
   )
 )
)
}
}
\seealso{
  \code{\link{gridsterItem}}
}

