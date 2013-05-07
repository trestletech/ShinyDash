#' Create a gridster frame on a Shiny web page
#'
#' 
#' @examples
#'
#'
#'
#' @export
gridster <- function(..., marginx = 16, marginy = 16, width = 140, height = 140) {
  addResourcePath(
    prefix = 'gridster',
    directoryPath = system.file('gridster', package='shinyGridster'))

  tagList(
    singleton(tags$head(
      tags$script(src = 'gridster/jquery.gridster.min.js'),
      tags$link(rel = 'stylesheet',
                type = 'text/css',
                href = 'gridster/jquery.gridster.min.css'),
      tags$script(src = 'gridster/shiny-gridster-init.js'),
      tags$link(rel = 'stylesheet',
                type = 'text/css',
                href = 'gridster/shiny-gridster.css')
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


#' @export
gridsterItem <- function(..., col = NULL, row = NULL, sizex = NULL, sizey = NULL) {
  tags$li(`data-col` = col,
          `data-row` = row,
          `data-sizex` = sizex,
          `data-sizey` = sizey,
          ...
         )
}
