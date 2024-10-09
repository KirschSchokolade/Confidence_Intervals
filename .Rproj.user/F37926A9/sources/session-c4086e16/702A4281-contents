#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
MyCharts <- function(insertion_type = "PointForecastFirst", chart_data, top_band, bottom_band,labels, width = NULL, height = NULL, elementId = NULL) {
  if (is.null(top_band))
  {
    top_band <- chart_data
  }

  if (is.null(bottom_band))
  {
    bottom_band <- chart_data
  }

  # forward options using x
  x = list(
    insertion_type = insertion_type,
  chart_data = chart_data,
  top_band = top_band,
  bottom_band = bottom_band,
  labels = labels
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'MyCharts',
    x,
    width = width,
    height = height,
    package = 'myCharts',
    elementId = elementId
  )
}

widget_html.MyCharts <- function(id, style, class, ...){
  htmltools::tags$canvas(id = id,
                      class = class,
                      style = style,
  )
}

#' Shiny bindings for MyCharts
#'
#' Output and render functions for using MyCharts within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a MyCharts
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name MyCharts-shiny
#'
#' @export
MyChartsOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'MyCharts', width, height, package = 'myCharts')
}

#' @rdname MyCharts-shiny
#' @export
renderMyCharts <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, MyChartsOutput, env, quoted = TRUE)
}
