#' Create a Gridster frame on a Shiny web page
#'
#' @param marginx Horizontal margin between each grid item, in pixels.
#' @param marginy Vertical margin between each grid item, in pixels.
#' @param width Width of each tile, in pixels.
#' @param height Height of each tile, in pixels.
#' @param ... Other properties or elements to include.
#'
#' @seealso \code{\link{gridsterItem}}
#'
#' @examples
#' \dontrun{
#' shinyUI(bootstrapPage(
#'
#'  gridster(width = 200, height = 200,
#'    gridsterItem(col = 1, row = 1, sizex = 1, sizey = 1,
#'      sliderInput("n", "Input value:", min = 0, max = 50, value = 10)
#'    ),
#'    gridsterItem(col = 2, row = 1, sizex = 1, sizey = 1,
#'      textOutput("myText")
#'    ),
#'    gridsterItem(col = 1, row = 2, sizex = 2, sizey = 1,
#'      plotOutput("myPlot", height = 200)
#'    )
#'  )
#' )
#' }
#' @export
#' @author Winston Chang
gridster <- function(..., marginx = 16, marginy = 16, width = 140, height = 140) {
  addResourcePath(
    prefix = 'shinyDash',
    directoryPath = system.file('shinyDash', package='ShinyDash'))

  tagList(
    singleton(tags$head(
      tags$script(src = 'shinyDash/gridster/jquery.gridster.min.js'),
      tags$link(rel = 'stylesheet',
                type = 'text/css',
                href = 'shinyDash/gridster/jquery.gridster.min.css'),
      tags$script(src = 'shinyDash/gridster/shiny-dash-init.js'),
      tags$link(rel = 'stylesheet',
                type = 'text/css',
                href = 'shinyDash/gridster/shiny-dash.css'),
      tags$script(src = 'shinyDash/highcharts/highcharts.js'),
      tags$script(src = 'shinyDash/highcharts/initchart.js'),
      tags$script(src = 'shinyDash/justgage/justgage.1.0.1.min.js'),
      tags$script(src = 'shinyDash/justgage/raphael.2.1.0.min.js'),      
      tags$script(src = 'shinyDash/justgage/justgage_binding.js'),
      tags$script(src = 'shinyDash/shiny_status_binding.js'),
      tags$link(rel = 'stylesheet',
                type = 'text/css',
                href = 'shinyDash/styles.css')
      
      
    )),

    tags$div(class = "gridster",
      tags$ul(
        `data-marginx` = marginx,
        `data-marginy` = marginy,
        `data-width`   = width,
        `data-height`  = height,
        ...
      )
    )
  )
}

#' Add a Gridster item within a Gridster frame to a Shiny web page
#'
#' @param col The column in which to put the item.
#' @param row The row in which to put the item.
#' @param sizex Width, in number of tiles.
#' @param sizey Height, in number of tiles.
#' @param ... Other properties or elements to include.
#'
#' @seealso \code{\link{gridster}}
#'
#' @export
#' @author Winston Chang
gridsterItem <- function(..., col = NULL, row = NULL, sizex = NULL, sizey = NULL) {
  tags$li(`data-col` = col,
          `data-row` = row,
          `data-sizex` = sizex,
          `data-sizey` = sizey,
          ...
         )
}
