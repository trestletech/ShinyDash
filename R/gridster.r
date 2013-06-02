#' Create a Gridster frame on a Shiny web page
#'
#' @param margin.x Horizontal margin between each grid item, in pixels.
#' @param margin.y Vertical margin between each grid item, in pixels.
#' @param tile.width Width of each tile, in pixels.
#' @param tile.height Height of each tile, in pixels.
#' @param ... Other properties or elements to include.
#'
#' @seealso \code{\link{gridsterItem}}
#'
#' @examples
#' \dontrun{
#' shinyUI(bootstrapPage(
#'
#'  gridster(tile.width = 200, tile.height = 200,
#'    gridsterItem(col = 1, row = 1, size.x = 1, size.y = 1,
#'      sliderInput("n", "Input value:", min = 0, max = 50, value = 10)
#'    ),
#'    gridsterItem(col = 2, row = 1, size.x = 1, size.y = 1,
#'      textOutput("myText")
#'    ),
#'    gridsterItem(col = 1, row = 2, size.x = 2, size.y = 1,
#'      plotOutput("myPlot", height = 200)
#'    )
#'  )
#' )
#' }
#' @export
#' @author Winston Chang
gridster <- function(..., margin.x = 16, margin.y = 16, tile.width = 140, tile.height = 140) {
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
      tags$script(src = 'shinyDash/shiny_status_binding.js'),
      tags$link(rel = 'stylesheet',
                type = 'text/css',
                href = 'shinyDash/styles.css')
      
      
    )),

    tags$div(class = "gridster",
      tags$ul(
        `data-marginx` = margin.x,
        `data-marginy` = margin.y,
        `data-width`   = tile.width,
        `data-height`  = tile.height,
        ...
      )
    )
  )
}

#' Add a Gridster item within a Gridster frame to a Shiny web page
#'
#' @param col The column in which to put the item.
#' @param row The row in which to put the item.
#' @param size.x Width, in number of tiles.
#' @param size.y Height, in number of tiles.
#' @param ... Other properties or elements to include.
#'
#' @seealso \code{\link{gridster}}
#'
#' @export
#' @author Winston Chang
gridsterItem <- function(..., col = NULL, row = NULL, size.x = NULL, size.y = NULL) {
  tags$li(`data-col` = col,
          `data-row` = row,
          `data-sizex` = size.x,
          `data-sizey` = size.y,
          ...
         )
}
